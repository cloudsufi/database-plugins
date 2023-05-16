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

package io.cdap.plugin;

import com.google.cloud.bigquery.TableResult;
import com.google.common.base.Strings;
import io.cdap.e2e.utils.BigQueryClient;
import io.cdap.e2e.utils.PluginPropertyUtils;
import io.cdap.plugin.oracle.OracleSourceSchemaReader;
import org.junit.Assert;

import java.io.IOException;
import java.sql.Blob;
import java.sql.Clob;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.sql.Types;
import java.time.Instant;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.List;
import java.util.TimeZone;
import javax.json.JsonObject;

/**
 *  Oracle client.
 */
public class OracleClient {

  public static Connection getOracleConnection() throws SQLException, ClassNotFoundException {
    TimeZone timezone = TimeZone.getTimeZone("UTC");
    TimeZone.setDefault(timezone);
    Class.forName("oracle.jdbc.driver.OracleDriver");
    String databaseName = PluginPropertyUtils.pluginProp("databaseName");
    return DriverManager.getConnection("jdbc:oracle:thin:@//" + System.getenv("ORACLE_HOST")
                                         + ":" + System.getenv("ORACLE_PORT") + "/" + databaseName,
                                       System.getenv("ORACLE_USERNAME"), System.getenv("ORACLE_PASSWORD"));
  }

  public static int countRecord(String table, String schema) throws SQLException, ClassNotFoundException {
    String countQuery = "SELECT COUNT(*) as total FROM " + schema + "." + table;
    try (Connection connect = getOracleConnection(); Statement statement = connect.createStatement();
         ResultSet rs = statement.executeQuery(countQuery)) {
      int num = 0;
      while (rs.next()) {
        num = (rs.getInt(1));
      }
      return num;
    }
  }

  public static void createSourceTable(String sourceTable, String schema) throws SQLException, ClassNotFoundException {
    try (Connection connect = getOracleConnection(); Statement statement = connect.createStatement()) {
      String createSourceTableQuery = "CREATE TABLE " + schema + "." + sourceTable +
        "(ID number(38), LASTNAME varchar2(100))";
      statement.executeUpdate(createSourceTableQuery);

      // Insert dummy data.
      statement.executeUpdate("INSERT INTO " + schema + "." + sourceTable + " (ID, LASTNAME)" +
                                " VALUES (1, 'Shelby')");
      statement.executeUpdate("INSERT INTO " + schema + "." + sourceTable + " (ID, LASTNAME)" +
                                " VALUES (2, 'Simpson')");
    }
  }

  public static void createTargetTable(String targetTable, String schema) throws SQLException, ClassNotFoundException {
    try (Connection connect = getOracleConnection(); Statement statement = connect.createStatement()) {
      String createTargetTableQuery = "CREATE TABLE " + schema + "." + targetTable +
        "(ID number(38), LASTNAME varchar2(100))";
      statement.executeUpdate(createTargetTableQuery);
    }
  }

  public static void createSourceDatatypesTable(String sourceTable, String schema) throws SQLException,
    ClassNotFoundException {
    try (Connection connect = getOracleConnection(); Statement statement = connect.createStatement()) {
      String datatypeColumns = PluginPropertyUtils.pluginProp("datatypeColumns");
      String createSourceTableQuery2 = "CREATE TABLE " + schema + "." + sourceTable + " " + datatypeColumns;
      statement.executeUpdate(createSourceTableQuery2);

      // Insert dummy data.
      String datatypeValues = PluginPropertyUtils.pluginProp("datatypeValues");
      String datatypeColumnsList = PluginPropertyUtils.pluginProp("datatypeColumnsList");
      statement.executeUpdate("INSERT INTO " + schema + "." + sourceTable + " " + datatypeColumnsList + " " +
                                datatypeValues);
    }
  }

  public static void createTargetDatatypesTable(String targetTable, String schema) throws SQLException,
    ClassNotFoundException {
    try (Connection connect = getOracleConnection(); Statement statement = connect.createStatement()) {
      String datatypeColumns = PluginPropertyUtils.pluginProp("datatypeColumns");
      String createTargetTableQuery2 = "CREATE TABLE " + schema + "." + targetTable + " " + datatypeColumns;
      statement.executeUpdate(createTargetTableQuery2);
    }
  }

  public static void createSourceLongTable(String sourceTable, String schema) throws SQLException,
    ClassNotFoundException {
    try (Connection connect = getOracleConnection(); Statement statement = connect.createStatement()) {
      String longColumns = PluginPropertyUtils.pluginProp("longColumns");
      String createSourceTableQuery3 = "CREATE TABLE " + schema + "." + sourceTable + " " + longColumns;
      statement.executeUpdate(createSourceTableQuery3);

      // Insert dummy data.
      String longValues = PluginPropertyUtils.pluginProp("longValues");
      String longColumnsList = PluginPropertyUtils.pluginProp("longColumnsList");
      statement.executeUpdate("INSERT INTO " + schema + "." + sourceTable + " " + longColumnsList + " " +
                                longValues);
    }
  }

  public static void createTargetLongTable(String targetTable, String schema) throws SQLException,
    ClassNotFoundException {
    try (Connection connect = getOracleConnection(); Statement statement = connect.createStatement()) {
      String longColumns = PluginPropertyUtils.pluginProp("longColumns");
      String createTargetTableQuery3 = "CREATE TABLE " + schema + "." + targetTable + " " + longColumns;
      statement.executeUpdate(createTargetTableQuery3);
    }
  }

  public static void createTimestampSourceTable(String sourceTable, String schema) throws SQLException,
          ClassNotFoundException {
    try (Connection connect = getOracleConnection(); Statement statement = connect.createStatement()) {
      String timestampColumns = PluginPropertyUtils.pluginProp("timestampColumns");
      String createSourceTableQuery = "CREATE TABLE " + schema + "." + sourceTable + " " + timestampColumns;
      statement.executeUpdate(createSourceTableQuery);

      int rowCount = 1;
      while (!Strings.isNullOrEmpty(PluginPropertyUtils.pluginProp("timestampValue" + rowCount))) {
        // Insert dummy data.
        String timestampValue = PluginPropertyUtils.pluginProp("timestampValue" + rowCount);
        String timestampColumnsList = PluginPropertyUtils.pluginProp("timestampColumnsList");
        statement.executeUpdate("INSERT INTO " + schema + "." + sourceTable + " " + timestampColumnsList + " " +
                timestampValue);
        rowCount++;
      }
    }
  }

  public static void createTimestampTargetTable(String targetTable, String schema) throws SQLException,
          ClassNotFoundException {
    try (Connection connect = getOracleConnection(); Statement statement = connect.createStatement()) {
      String timestampColumns = PluginPropertyUtils.pluginProp("timestampColumns");
      String createTargetTableQuery = "CREATE TABLE " + schema + "." + targetTable + " " + timestampColumns;
      statement.executeUpdate(createTargetTableQuery);
    }
  }

  public static void createSourceLongRawTable(String sourceTable, String schema) throws SQLException,
    ClassNotFoundException {
    try (Connection connect = getOracleConnection(); Statement statement = connect.createStatement()) {
      String longRawColumns = PluginPropertyUtils.pluginProp("longRawColumns");
      String createSourceTableQuery4 = "CREATE TABLE " + schema + "." + sourceTable + " " + longRawColumns;
      statement.executeUpdate(createSourceTableQuery4);

      // Insert dummy data.
      String longRawValues = PluginPropertyUtils.pluginProp("longRawValues");
      String longRawColumnsList = PluginPropertyUtils.pluginProp("longRawColumnsList");
      statement.executeUpdate("INSERT INTO " + schema + "." + sourceTable + " " + longRawColumnsList + " " +
                                longRawValues);
    }
  }

  public static void createTargetLongRawTable(String targetTable, String schema) throws SQLException,
    ClassNotFoundException {
    try (Connection connect = getOracleConnection(); Statement statement = connect.createStatement()) {
      String longRawColumns = PluginPropertyUtils.pluginProp("longRawColumns");
      String createTargetTableQuery4 = "CREATE TABLE " + schema + "." + targetTable + " " + longRawColumns;
      statement.executeUpdate(createTargetTableQuery4);
    }
  }

  public static void createSourceLongVarcharTable(String sourceTable, String schema) throws SQLException,
    ClassNotFoundException {
    try (Connection connect = getOracleConnection(); Statement statement = connect.createStatement()) {
      String longVarcharColumns = PluginPropertyUtils.pluginProp("longVarcharColumns");
      String createSourceTableQuery5 = "CREATE TABLE " + schema + "." + sourceTable + " " + longVarcharColumns;
      statement.executeUpdate(createSourceTableQuery5);

      // Insert dummy data.
      String longVarcharValues = PluginPropertyUtils.pluginProp("longVarcharValues");
      String longVarcharColumnsList = PluginPropertyUtils.pluginProp("longVarcharColumnsList");
      statement.executeUpdate("INSERT INTO " + schema + "." + sourceTable + " " + longVarcharColumnsList + " " +
                                longVarcharValues);
    }
  }

  public static void createTargetLongVarCharTable(String targetTable, String schema) throws SQLException,
    ClassNotFoundException {
    try (Connection connect = getOracleConnection(); Statement statement = connect.createStatement()) {
      String longVarcharColumns = PluginPropertyUtils.pluginProp("longVarcharColumns");
      String createSourceTableQuery5 = "CREATE TABLE " + schema + "." + targetTable + " " + longVarcharColumns;
      statement.executeUpdate(createSourceTableQuery5);
    }
  }

  public static void createSourceOracleDatatypesTable(String sourceTable, String schema) throws SQLException,
    ClassNotFoundException {
    try (Connection connect = getOracleConnection(); Statement statement = connect.createStatement()) {
      String datatypeColumns1 = PluginPropertyUtils.pluginProp("datatypeColumns1");
      String createSourceTableQuery6 = "CREATE TABLE " + schema + "." + sourceTable + " " + datatypeColumns1;
      statement.executeUpdate(createSourceTableQuery6);

      // Insert dummy data.
      String datatypeValues1 = PluginPropertyUtils.pluginProp("datatypeValues1");
      String datatypeColumnsList1 = PluginPropertyUtils.pluginProp("datatypeColumnsList1");
      statement.executeUpdate("INSERT INTO " + schema + "." + sourceTable + " " + datatypeColumnsList1 + " " +
                                datatypeValues1);
    }
  }

  public static void createTargetOracleDatatypesTable(String targetTable, String schema) throws SQLException,
    ClassNotFoundException {
    try (Connection connect = getOracleConnection(); Statement statement = connect.createStatement()) {
      String datatypeColumns1 = PluginPropertyUtils.pluginProp("datatypeColumns1");
      String createTargetTableQuery6 = "CREATE TABLE " + schema + "." + targetTable + " " + datatypeColumns1;
      statement.executeUpdate(createTargetTableQuery6);
    }
  }

  public static void deleteTables(String schema, String[] tables)
    throws SQLException, ClassNotFoundException {
    try (Connection connect = getOracleConnection(); Statement statement = connect.createStatement()) {
      for (String table : tables) {
        String dropTableQuery = "DROP TABLE " + schema + "." + table;
        statement.execute(dropTableQuery);
      }
    }
  }
}
