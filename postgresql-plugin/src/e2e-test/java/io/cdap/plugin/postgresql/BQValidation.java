package io.cdap.plugin.postgresql;

import com.google.cloud.bigquery.TableResult;
import com.google.gson.Gson;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import io.cdap.e2e.utils.BigQueryClient;
import io.cdap.e2e.utils.PluginPropertyUtils;
import io.cdap.plugin.PostgresqlClient;
import org.apache.spark.sql.types.Decimal;
import org.junit.Assert;

import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Time;
import java.sql.Types;
import java.text.ParseException;
import java.time.LocalTime;
import java.time.OffsetTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Base64;
import java.util.List;

/**
 * BQValidation
 */

public class BQValidation {

  private static List<JsonObject> jsonResponse = new ArrayList<>();

  /**
   * Extracts entire data from source and target tables.
   *
   ** @param sourceTable table at the source side
   ** @param targetTable table at the sink side
   *
   * @return true if the values in source and target side are equal
   */

  public static boolean validateDBToBQRecordValues(String schema, String sourceTable, String targetTable)
    throws SQLException, ClassNotFoundException, IOException, InterruptedException {
    String getSourceQuery = "SELECT * FROM " + schema + "." + sourceTable;
    List<Object> bigQueryRows = new ArrayList<>();
    getBigQueryTableData(targetTable, bigQueryRows);
    for (Object rows : bigQueryRows) {
      JsonObject json = new Gson().fromJson(String.valueOf(rows), JsonObject.class);
      jsonResponse.add(json);
    }
    try (Connection connect = PostgresqlClient.getPostgresqlConnection()) {
      connect.setHoldability(ResultSet.HOLD_CURSORS_OVER_COMMIT);
      Statement statement = connect.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE,
                                                    ResultSet.HOLD_CURSORS_OVER_COMMIT);
      ResultSet rsSource = statement.executeQuery(getSourceQuery);
      return compareResultSetWithJsonData(rsSource, jsonResponse);
    }
  }

  public static boolean validateBQToDBRecordValues(String schema,String sourceTable, String targetTable)
    throws SQLException, ClassNotFoundException, IOException, InterruptedException {
   List<JsonObject> jsonResponse = new ArrayList<>();
    List<Object> bigQueryRows = new ArrayList<>();
    getBigQueryTableData(sourceTable, bigQueryRows);
    for (Object rows : bigQueryRows) {
      JsonObject json = new Gson().fromJson(String.valueOf(rows), JsonObject.class);
      jsonResponse.add(json);
    }
    String getTargetQuery = "SELECT * FROM " + schema + "." + targetTable;
    try (Connection connect = PostgresqlClient.getPostgresqlConnection()) {
      connect.setHoldability(ResultSet.HOLD_CURSORS_OVER_COMMIT);
      Statement statement1 = connect.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE,
                                                     ResultSet.HOLD_CURSORS_OVER_COMMIT);
      ResultSet rsTarget = statement1.executeQuery(getTargetQuery);
      return compareResultSetWithJsonData(rsTarget, jsonResponse);
    }
  }

  /**
   * Retrieves the data from a specified BigQuery table and populates it into the provided list of objects.
   *
   * @param table The name of the BigQuery table to fetch data from.
   * @param bigQueryRows The list to store the fetched BigQuery data.
   */

  private static void getBigQueryTableData(String table, List<Object> bigQueryRows)
    throws IOException, InterruptedException {

    String projectId = PluginPropertyUtils.pluginProp("projectId");
    String dataset = PluginPropertyUtils.pluginProp("dataset");
    String selectQuery = "SELECT TO_JSON(t) FROM `" + projectId + "." + dataset + "." + table + "` AS t";
    TableResult result = BigQueryClient.getQueryResult(selectQuery);
    result.iterateAll().forEach(value -> bigQueryRows.add(value.get(0).getValue()));
  }

  /**
   Compares data from a ResultSet with data from a List of JsonObjects.
   @param rsSource The ResultSet containing the source data.
   @param bigQueryData The List of JsonObjects containing the target data.
   @throws SQLException If a SQL error occurs.
   @throws ParseException If an error occurs while parsing dates.
   */

  public static boolean compareResultSetWithJsonData(ResultSet rsSource, List<JsonObject> bigQueryData) throws SQLException {

    ResultSetMetaData mdSource = rsSource.getMetaData();
    boolean result = false;
    int columnCountSource = mdSource.getColumnCount();

    if (bigQueryData == null) {
      Assert.fail("bigQueryData is null");
      return result;
    }

    // Get the column count of the first JsonObject in bigQueryData
    int columnCountTarget = 0;
    if (bigQueryData.size() > 0) {
      columnCountTarget = bigQueryData.get(0).entrySet().size();
    }
    // Compare the number of columns in the source and target
    Assert.assertEquals("Number of columns in source and target are not equal",
                        columnCountSource, columnCountTarget);

    //Variable 'jsonObjectIdx' to track the index of the current JsonObject in the bigQueryData list,
    int jsonObjectIdx = 0;
    while (rsSource.next()) {
      int currentColumnCount = 1;
      while (currentColumnCount <= columnCountSource) {
        String columnTypeName = mdSource.getColumnTypeName(currentColumnCount);
        int columnType = mdSource.getColumnType(currentColumnCount);
        String columnName = mdSource.getColumnName(currentColumnCount);
        // Perform different comparisons based on column type
        switch (columnType) {

          case Types.BINARY:
            String sourceB64String = new String(Base64.getEncoder().encode(rsSource.getBytes(currentColumnCount)));
            String targetB64String = bigQueryData.get(jsonObjectIdx).get(columnName).getAsString();
            Assert.assertEquals("Different values found for column : %s",
                                sourceB64String, targetB64String);
            break;

          case Types.BIT:
            boolean bqDateString = bigQueryData.get(jsonObjectIdx).get(columnName).getAsBoolean();
            result = getBooleanValidation(rsSource, String.valueOf(bqDateString), columnName, columnTypeName);
            Assert.assertTrue("Different values found for column : %s", result);
            break;

          case Types.NUMERIC:
            Decimal decimalSource = Decimal.fromDecimal(rsSource.getBigDecimal(currentColumnCount));
            Decimal decimalTarget = Decimal.fromDecimal(
              bigQueryData.get(jsonObjectIdx).get(columnName).getAsBigDecimal());
            Assert.assertEquals("Different values found for column : %s", decimalSource, decimalTarget);
            break;

          case Types.TIMESTAMP:
            // Haven't added the timestamp validation logic as waiting for a bug to be resolved.
            break;

          case Types.TIME:
            String bqTimeString = bigQueryData.get(jsonObjectIdx).get(columnName).getAsString();
            result = getTimeValidation(rsSource, bqTimeString, columnName, columnTypeName);
            Assert.assertTrue("Different values found for column : %s", result);
            break;

          case Types.DATE:
            java.sql.Date dateSource = rsSource.getDate(currentColumnCount);
            java.sql.Date dateTarget = java.sql.Date.valueOf(
              bigQueryData.get(jsonObjectIdx).get(columnName).getAsString());
            Assert.assertEquals("Different values found for column : %s", dateSource, dateTarget);
            break;

          case Types.BIGINT:
            long sourceBigInt = rsSource.getLong(currentColumnCount);
            long targetBigInt = bigQueryData.get(jsonObjectIdx).get(columnName).getAsLong();
            Assert.assertTrue("Different values found for column : %s",
                              String.valueOf(sourceBigInt).equals(String.valueOf(targetBigInt)));
            break;

          case Types.SMALLINT:
          case Types.INTEGER:
            int sourceInt = rsSource.getInt(currentColumnCount);
            int targetInt = bigQueryData.get(jsonObjectIdx).get(columnName).getAsInt();
            Assert.assertTrue("Different %s values found for column : %s",
                              String.valueOf(sourceInt).equals(String.valueOf(targetInt)));
            break;

          case Types.REAL:
            float sourceFloat = rsSource.getFloat(currentColumnCount);
            float targetFloat = bigQueryData.get(jsonObjectIdx).get(columnName).getAsFloat();
            Assert.assertTrue("Different %s values found for column : %s",
                              String.valueOf(sourceFloat).equals(String.valueOf(targetFloat)));
            break;

          case Types.DOUBLE:
            Double sourceMoney = rsSource.getDouble(currentColumnCount);
            String targetMoneyStr = bigQueryData.get(jsonObjectIdx).get(columnName).getAsString();
            Double targetMoney;

            // Remove non-numeric characters from the targetMoneyStr
            targetMoneyStr = targetMoneyStr.replaceAll("[^0-9.]", "");
            targetMoney = new Double(targetMoneyStr);
            Assert.assertTrue(String.format("Different values found for column: %s", columnName),
                              sourceMoney.compareTo(targetMoney) == 0);
            break;

          case Types.OTHER:
          case Types.VARCHAR:
          default:
            String sourceValue = rsSource.getString(currentColumnCount);
            JsonElement jsonElement = bigQueryData.get(jsonObjectIdx).get(columnName);
            String targetValue = (jsonElement != null && !jsonElement.isJsonNull()) ? jsonElement.getAsString() : null;
            Assert.assertEquals(
              String.format("Different %s values found for column : %s", columnTypeName, columnName),
              String.valueOf(sourceValue), String.valueOf(targetValue));
        }
        currentColumnCount++;
      }
      jsonObjectIdx++;
    }
    Assert.assertFalse("Number of rows in Source table is greater than the number of rows in Target table",
                       rsSource.next());
    return true;
  }

  private static boolean getTimeValidation(ResultSet rsSource, String bqDateString, String columnName, String
    columnTypeName) throws SQLException {
    switch (columnTypeName) {
      case "time":
        Time sourceTime = rsSource.getTime(columnName);
        Time targetTime = Time.valueOf(bqDateString);
        return sourceTime.equals(targetTime);
      case "timetz":
        Time sourceT = rsSource.getTime(columnName);
        LocalTime sourceLocalTime = sourceT.toLocalTime();
        OffsetTime targetOffsetTime = OffsetTime.parse(bqDateString, DateTimeFormatter.ISO_OFFSET_TIME);
        LocalTime targetLocalTime = targetOffsetTime.toLocalTime();
        return String.valueOf(sourceLocalTime).equals(String.valueOf(targetLocalTime));

      default:
        return false;
    }
  }

  private static boolean getBooleanValidation(ResultSet rsSource, String bqDateString, String columnName,
                                              String columnTypeName) throws SQLException {
    switch (columnTypeName) {
      case "bit":
        byte source = rsSource.getByte(columnName);
        boolean sourceAsBoolean = source != 0;
        return String.valueOf(sourceAsBoolean).equals(String.valueOf(bqDateString));
      case "bool":
        boolean sourceValue = rsSource.getBoolean(columnName);
        return String.valueOf(sourceValue).equals(String.valueOf(bqDateString));
      default:
        return false;
    }
  }
}
