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

package io.cdap.plugin.oracle.stepsdesign;


import com.google.cloud.bigquery.Field;
import com.google.cloud.bigquery.FieldValue;
import com.google.cloud.bigquery.FieldValueList;
import com.google.cloud.bigquery.TableResult;
import com.google.common.collect.MapDifference;
import com.google.common.collect.Maps;
import com.google.common.reflect.TypeToken;
import com.google.gson.Gson;
import io.cdap.e2e.utils.BigQueryClient;
import io.cdap.e2e.utils.PluginPropertyUtils;
import io.cdap.plugin.OracleClient;

import java.io.IOException;
import java.lang.reflect.Type;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Time;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 *  Big Query client.
 */

public class BQValidation2 {

  public static void main(String[] args) throws SQLException, IOException, ClassNotFoundException, InterruptedException {
//    BQ - TestSN_tablehHI8cg1Qy3
//    SQL - SourceTable_ASgPLZAEqs

    //Bytes and string - BQ - E2E_TARGET_3deae021_18ac_437f_8ea6_eb0ac725ffad
    //oracle - SOURCETABLE_UHTTOKLBCU

    validateBQAndDBRecordValues("HR", "SOURCETABLE_IDGXDINEUX", "TestSN_tablehHI8cg1Qy3");

  }

  public static boolean validateBQAndDBRecordValues(String schema, String sourceTable, String targetTable)
    throws SQLException, ClassNotFoundException, IOException, InterruptedException {
    String getSourceQuery = "SELECT * FROM " + schema + "." + sourceTable;

    try (Connection connect = OracleClient.getOracleConnection()) {
      connect.setHoldability(ResultSet.HOLD_CURSORS_OVER_COMMIT);
      Statement statement1 = connect.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE,
                                                     ResultSet.HOLD_CURSORS_OVER_COMMIT);

      ResultSet rsSource = statement1.executeQuery(getSourceQuery);
      String sourceJson = convertResultSetToJson(rsSource);
      String targetJson = getBigQueryTableData(targetTable);

      System.out.println(sourceJson);
      System.out.println(targetJson);

      return compareValueOfBothResponses(sourceJson, targetJson);
    }
  }

  public static String convertResultSetToJson(ResultSet rs) throws SQLException {
    List<Map<String, Object>> rows = new ArrayList<>();
    ResultSetMetaData metaData = rs.getMetaData();
    int numColumns = metaData.getColumnCount();

    while (rs.next()) {
      Map<String, Object> row = new HashMap<>();
      for (int i = 1; i <= numColumns; i++) {
        String columnName = metaData.getColumnName(i);
        Object columnValue = rs.getObject(i);
        if (columnValue == null) {
          row.put(columnName, "");
        } else {
          row.put(columnName, columnValue);
        }
      }
      rows.add(row);
    }

    Gson gson = new Gson();
    return gson.toJson(rows);
  }

  private static String getBigQueryTableData(String targetTable) throws IOException, InterruptedException {
    String projectId = PluginPropertyUtils.pluginProp("");
    String dataset = PluginPropertyUtils.pluginProp("");
    String selectQuery = "SELECT * FROM `" + projectId + "." + dataset + "." + targetTable + "`";

    TableResult result = BigQueryClient.getQueryResult(selectQuery);
    List<Map<String, Object>> rows = new ArrayList<>();

    for (FieldValueList row : result.iterateAll()) {
      Map<String, Object> rowData = new HashMap<>();
      for (int i = 0; i < row.size(); i++) {
        FieldValue fieldValue = row.get(i);
        Field field = result.getSchema().getFields().get(i);
        String columnName = field.getName();
        Object columnValue = fieldValue.isNull() ? null : getFieldValue(fieldValue);
        rowData.put(columnName, columnValue);
      }
      rows.add(rowData);
    }

    Gson gson = new Gson();
    return gson.toJson(rows);
  }

  private static Object getFieldValue(Object value) {
    if (value instanceof Timestamp) {
      return value.toString();
    } else if (value instanceof Date) {
      return value.toString();
    } else if (value instanceof Time) {
      return value.toString();
    } else if (value instanceof oracle.sql.TIMESTAMP) {
      return value.toString();
    } else {
      return value;
    }
  }

  private static boolean compareValueOfBothResponses(String oracleResponse, String bigQueryResponse) {
    Gson gson = new Gson();
    Type type = new TypeToken<Map<String, Object>>() {
    }.getType();
    Map<String, Object> sfmcResponseInMap = gson.fromJson(oracleResponse, type);
    Map<String, Object> bigQueryResponseInMap = gson.fromJson(bigQueryResponse, type);
    MapDifference<String, Object> mapDifference = Maps.difference(sfmcResponseInMap, bigQueryResponseInMap);

    return mapDifference.areEqual();
  }
}

