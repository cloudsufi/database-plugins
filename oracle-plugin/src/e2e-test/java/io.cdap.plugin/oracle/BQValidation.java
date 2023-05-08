/*
 * Copyright © 2023 Cask Data, Inc.
 *
 * Licensed under the Apache License, Version 2.0 (the "License"); you may not
 * use this file except in compliance with the License. You may obtain a copy of
 * the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
 * WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
 * License for the specific language governing permissions and limitations under
 * the License.
 */

package io.cdap.plugin.oracle;

import com.google.cloud.bigquery.TableResult;
import com.google.common.collect.MapDifference;
import com.google.common.collect.Maps;
import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.google.gson.reflect.TypeToken;
import io.cdap.e2e.utils.BigQueryClient;
import io.cdap.e2e.utils.PluginPropertyUtils;
import io.cdap.plugin.OracleClient;

import java.io.IOException;
import java.lang.reflect.Type;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 *  Big Query client.
 */
public class BQValidation {

  /**
   * Extracts entire data from source and target tables.
   * @param sourceTable table at the source side
   * @param targetTable table at the BigQuery side
   * @return true if the values in source and target side are equal
   */
  public static void validateBQAndDBRecordValues(String schema, String sourceTable, String targetTable)
    throws SQLException, ClassNotFoundException, IOException, InterruptedException {
    String getSourceQuery = "SELECT * FROM " + schema + "." + sourceTable;
    List<Object> bigQueryRows = new ArrayList<Object>();

    try (Connection connect = OracleClient.getOracleConnection()) {
      connect.setHoldability(ResultSet.HOLD_CURSORS_OVER_COMMIT);
      Statement statement1 = connect.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE,
                                                     ResultSet.HOLD_CURSORS_OVER_COMMIT);

      ResultSet rsSource = statement1.executeQuery(getSourceQuery);
      getBigQueryTableData(targetTable, bigQueryRows);


      System.out.println(convertResultSetToJson(rsSource));
      System.out.println(bigQueryRows.get(0));
      //return OracleClient.compareResultSetData(rsSource, rsTarget);
    }
  }

  public static void main(String[] args) throws SQLException, ClassNotFoundException, IOException, InterruptedException {
    //Bytes and string - BQ - E2E_TARGET_3deae021_18ac_437f_8ea6_eb0ac725ffad
    //oracle - SOURCETABLE_UHTTOKLBCU

    //validateBQAndDBRecordValues("HR", "SOURCETABLE_IDGXDINEUX", "TestSN_tablehHI8cg1Qy3");
    validateBQAndDBRecordValues("HR", "SOURCETABLE_UHTTOKLBCU", "E2E_TARGET_3deae021_18ac_437f_8ea6_eb0ac725ffad");
  }

  public static String convertResultSetToJson(ResultSet rs) throws SQLException {
    List<JsonObject> jsonObjects = new ArrayList<>();
    while (rs.next()) {
      int numColumns = rs.getMetaData().getColumnCount();
      JsonObject jsonObject = new JsonObject();
      for (int i = 1; i <= numColumns; i++) {
        String column_name = rs.getMetaData().getColumnName(i);
        Object column_value = rs.getObject(i);
        if (column_value == null) {
          jsonObject.addProperty(column_name, "");
        } else {
          jsonObject.addProperty(column_name, column_value.toString());
        }
      }
      jsonObjects.add(jsonObject);
    }

    JsonArray jsonArray = new JsonArray();
    for (JsonObject jsonObject : jsonObjects) {
      jsonArray.add(jsonObject);
    }

    // Convert JSON array to JSON string
    Gson gson = new Gson();
    String jsonString = gson.toJson(jsonArray);

    return jsonString;
  }

  private static void getBigQueryTableData(String table, List<Object> bigQueryRows)
    throws IOException, InterruptedException {

    String projectId = PluginPropertyUtils.pluginProp("projectId");
    String dataset = PluginPropertyUtils.pluginProp("dataset");
    String selectQuery = "SELECT TO_JSON(t) FROM `" + projectId + "." + dataset + "." + table + "` AS t";
    System.out.println(selectQuery);
    TableResult result = BigQueryClient.getQueryResult(selectQuery);
    result.iterateAll().forEach(value -> bigQueryRows.add(value.get(0).getValue()));
  }

  private static boolean compareValueOfBothResponses(String sfmcResponse, String bigQueryResponse) {
    Gson gson = new Gson();
    Type type = new TypeToken<Map<String, Object>>() {
    }.getType();
    Map<String, Object> sfmcResponseInmap = gson.fromJson(sfmcResponse, type);
    Map<String, Object> bigQueryResponseInMap = gson.fromJson(bigQueryResponse, type);
    MapDifference<String, Object> mapDifference = Maps.difference(sfmcResponseInmap, bigQueryResponseInMap);

    return mapDifference.areEqual();
  }
}
