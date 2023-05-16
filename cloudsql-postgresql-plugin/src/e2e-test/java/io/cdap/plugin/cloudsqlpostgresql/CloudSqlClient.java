package io.cdap.plugin.cloudsqlpostgresql;

import io.cdap.e2e.pages.actions.CdfPipelineRunAction;
import io.cdap.e2e.utils.BigQueryClient;
import io.cdap.e2e.utils.PluginPropertyUtils;
import io.cucumber.java.en.Then;
import org.junit.Assert;
import stepsdesign.BeforeActions;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class CloudSqlClient {

  public static void main(String[] args) throws ClassNotFoundException, SQLException {
   getCloudSqlConnection();
  }

   public static Connection getCloudSqlConnection() throws ClassNotFoundException, SQLException {
    Class.forName("org.postgresql.Driver");
    String instanceConnectionName = "cdf-athena:europe-west1:cloud-postgresql-automation";
    String databaseName = "test_automation_db";
    String username = "v";
    String password = "v@123";
    String jdbcUrl = String.format(
      "jdbc:postgresql://google/%s?cloudSqlInstance=%s&socketFactory=com.google.cloud.sql.postgres.SocketFactory&user=%s&password=%s",
      databaseName, instanceConnectionName, username, password);
    Connection conn = DriverManager.getConnection(jdbcUrl);
    System.out.println("Connected to the database successfully");
   return conn;
  }

//
//  public static int countRecord(String table, String schema) throws SQLException, ClassNotFoundException {
//    String countQuery = "SELECT COUNT(*) as total FROM " + schema + "." + table;
//    try (Connection connect = getCloudSqlConnection(); Statement statement = connect.createStatement();
//         ResultSet rs = statement.executeQuery(countQuery)) {
//      int num = 0;
//      while (rs.next()) {
//        num = (rs.getInt(1));
//      }
//      return num;
//    }
//  }
   public static boolean validateRecordValues(String schema, String sourceTable, String targetTable) throws
     ClassNotFoundException, SQLException {
    String getSourceQuery = "SELECT * FROM " + schema + "." + sourceTable;
    String getTargetQuery = "SELECT * FROM " + schema + "." + targetTable;
    try (Connection connect = getCloudSqlConnection()) {
      connect.setHoldability(ResultSet.HOLD_CURSORS_OVER_COMMIT);
      Statement statement1 = connect.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE,
                                                     ResultSet.HOLD_CURSORS_OVER_COMMIT);
      Statement statement2 = connect.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE,
                                                     ResultSet.HOLD_CURSORS_OVER_COMMIT);
      ResultSet rsSource = statement1.executeQuery(getSourceQuery);
      ResultSet rsTarget = statement2.executeQuery(getTargetQuery);
      return compareResultSetData(rsSource, rsTarget);
    }
  }

  static boolean compareResultSetData(ResultSet rsSource, ResultSet rsTarget) throws SQLException{
    return false;
  }

  public static void createTargetTable(String targetTable, String schema) {
  }

  public static void createSourceDatatypesTable(String sourceTable, String schema) {
  }

  public static void createTargetDatatypesTable(String targetTable, String schema) {
  }

  public static void createSourceLongTable(String sourceTable, String schema) {
  }

  public static void createTargetLongTable(String targetTable, String schema) {
  }

  public static void createSourceLongRawTable(String sourceTable, String schema) {
  }

  public static void createTargetLongRawTable(String targetTable, String schema) {
  }

  public static void createSourceLongVarcharTable(String sourceTable, String schema) {
  }

  public static void createTargetLongVarCharTable(String targetTable, String schema) {
  }

  public static void deleteTables(String schema, String[] strings) {
  }
  @Then("Validate OUT record count is equal to records transferred to target BigQuery table")
  public void validateOUTRecordCountIsEqualToRecordsTransferredToTargetBigQueryTable()
    throws IOException, InterruptedException, IOException {
    int targetBQRecordsCount = BigQueryClient.countBqQuery(PluginPropertyUtils.pluginProp("bqTargetTable"));
    BeforeActions.scenario.write("No of Records Transferred to BigQuery:" + targetBQRecordsCount);
    Assert.assertEquals("Out records should match with target BigQuery table records count",
                        CdfPipelineRunAction.getCountDisplayedOnSourcePluginAsRecordsOut(), targetBQRecordsCount);
  }

  @Then("Validate the values of records transferred to target Big Query table is equal to the values from source table")
  public void validateTheValuesOfRecordsTransferredToTargetBigQueryTableIsEqualToTheValuesFromSourceTable()
    throws IOException, InterruptedException, IOException, SQLException, ClassNotFoundException {
    int targetBQRecordsCount = BigQueryClient.countBqQuery(PluginPropertyUtils.pluginProp("bqTargetTable"));
    BeforeActions.scenario.write("No of Records Transferred to BigQuery:" + targetBQRecordsCount);
    Assert.assertEquals("Out records should match with target BigQuery table records count",
                        CdfPipelineRunAction.getCountDisplayedOnSourcePluginAsRecordsOut(), targetBQRecordsCount);

    boolean recordsMatched = BQValidation.validateBQAndDBRecordValues(PluginPropertyUtils.pluginProp("schema"),
                                                                      PluginPropertyUtils.pluginProp("sourceTable"),
                                                                      PluginPropertyUtils.pluginProp("bqTargetTable"));
    Assert.assertTrue("Value of records transferred to the target table should be equal to the value " +
                        "of the records in the source table", recordsMatched);
  }
}
