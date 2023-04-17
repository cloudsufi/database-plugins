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

package io.cdap.plugin.common.stepsdesign;

import com.google.cloud.bigquery.BigQueryException;
import io.cdap.e2e.utils.BigQueryClient;
import io.cdap.e2e.utils.PluginPropertyUtils;
import io.cdap.plugin.OracleClient;
import io.cucumber.java.After;
import io.cucumber.java.Before;
import org.apache.commons.lang3.RandomStringUtils;
import org.apache.commons.lang3.StringUtils;
import org.junit.Assert;
import stepsdesign.BeforeActions;

import java.io.IOException;
import java.sql.SQLException;
import java.util.UUID;

/**
 * Oracle test hooks.
 */
public class TestSetupHooks {

  @Before(order = 1)
  public static void setTableName() {
    String randomString = RandomStringUtils.randomAlphabetic(10).toUpperCase();
    String sourceTableName = String.format("SOURCETABLE_%s", randomString);
    String targetTableName = String.format("TARGETTABLE_%s", randomString);
    PluginPropertyUtils.addPluginProp("sourceTable", sourceTableName);
    PluginPropertyUtils.addPluginProp("targetTable", targetTableName);
    String schema = PluginPropertyUtils.pluginProp("schema");
    PluginPropertyUtils.addPluginProp("selectQuery", String.format("select * from %s.%s", schema,
                                                                   sourceTableName));
  }

  @Before(order = 2, value = "@ORACLE_SOURCE_TEST")
  public static void createTables() throws SQLException, ClassNotFoundException {
    OracleClient.createSourceTable(PluginPropertyUtils.pluginProp("sourceTable"),
                                   PluginPropertyUtils.pluginProp("schema"));
    OracleClient.createTargetTable(PluginPropertyUtils.pluginProp("targetTable"),
                                   PluginPropertyUtils.pluginProp("schema"));
  }

  @Before(order = 2, value = "@ORACLE_SOURCE_DATATYPES_TEST")
  public static void createAllDatatypesTables() throws SQLException, ClassNotFoundException {
    OracleClient.createSourceDatatypesTable(PluginPropertyUtils.pluginProp("sourceTable"),
                                   PluginPropertyUtils.pluginProp("schema"));
    OracleClient.createTargetDatatypesTable(PluginPropertyUtils.pluginProp("targetTable"),
                                   PluginPropertyUtils.pluginProp("schema"));
  }

  @Before(order = 2, value = "@ORACLE_SOURCE_DATATYPES_TEST2")
  public static void createDatatypesTablesLong() throws SQLException, ClassNotFoundException {
    OracleClient.createSourceLongTable(PluginPropertyUtils.pluginProp("sourceTable"),
                                            PluginPropertyUtils.pluginProp("schema"));
    OracleClient.createTargetLongTable(PluginPropertyUtils.pluginProp("targetTable"),
                                            PluginPropertyUtils.pluginProp("schema"));
  }

  @Before(order = 2, value = "@ORACLE_SOURCE_LONGRAW_TEST")
  public static void createDatatypesTablesLongRaw() throws SQLException, ClassNotFoundException {
    OracleClient.createSourceLongRawTable(PluginPropertyUtils.pluginProp("sourceTable"),
                                            PluginPropertyUtils.pluginProp("schema"));
    OracleClient.createTargetLongRawTable(PluginPropertyUtils.pluginProp("targetTable"),
                                            PluginPropertyUtils.pluginProp("schema"));
  }

  @Before(order = 2, value = "@ORACLE_SOURCE_DATATYPES_TEST4")
  public static void createLongVarcharTables() throws SQLException, ClassNotFoundException {
    OracleClient.createSourceLongVarcharTable(PluginPropertyUtils.pluginProp("sourceTable"),
                                            PluginPropertyUtils.pluginProp("schema"));
    OracleClient.createTargetLongVarCharTable(PluginPropertyUtils.pluginProp("targetTable"),
                                            PluginPropertyUtils.pluginProp("schema"));
  }

  @Before(order = 2, value = "@ORACLE_SOURCE_DATATYPE_TIMESTAMP")
  public static void createTimestampDatatypeTables() throws SQLException, ClassNotFoundException {
    OracleClient.createTimestampSourceTable(PluginPropertyUtils.pluginProp("sourceTable"),
            PluginPropertyUtils.pluginProp("schema"));
    OracleClient.createTimestampTargetTable(PluginPropertyUtils.pluginProp("targetTable"),
            PluginPropertyUtils.pluginProp("schema"));
  }

  @After(order = 1, value = "@ORACLE_SINK_TEST")
  public static void dropTables() throws SQLException, ClassNotFoundException {
    OracleClient.deleteTables(PluginPropertyUtils.pluginProp("schema"),
                              new String[]{PluginPropertyUtils.pluginProp("sourceTable"),
                                PluginPropertyUtils.pluginProp("targetTable")});
  }

  @Before(order = 2, value = "@ORACLE_SOURCE_DATATYPES_TEST1")
  public static void createAllOracleDatatypesTables() throws SQLException, ClassNotFoundException {
    OracleClient.createSourceOracleDatatypesTable(PluginPropertyUtils.pluginProp("sourceTable"),
                                                  PluginPropertyUtils.pluginProp("schema"));
    OracleClient.createTargetOracleDatatypesTable(PluginPropertyUtils.pluginProp("targetTable"),
                                                  PluginPropertyUtils.pluginProp("schema"));
  }

  @Before(order = 1, value = "@BQ_SINK_TEST")
  public static void setTempTargetBQTableName() {
    String bqTargetTableName = "E2E_TARGET_" + UUID.randomUUID().toString().replaceAll("-", "_");
    PluginPropertyUtils.addPluginProp("bqTargetTable", bqTargetTableName);
    BeforeActions.scenario.write("BQ Target table name - " + bqTargetTableName);
  }

  @After(order = 1, value = "@BQ_SINK_TEST")
  public static void deleteTempTargetBQTable() throws IOException, InterruptedException {
    String bqTargetTableName = PluginPropertyUtils.pluginProp("bqTargetTable");
    try {
      BigQueryClient.dropBqQuery(bqTargetTableName);
      BeforeActions.scenario.write("BQ Target table - " + bqTargetTableName + " deleted successfully");
      PluginPropertyUtils.removePluginProp("bqTargetTable");
    } catch (BigQueryException e) {
      if (e.getMessage().contains("Not found: Table")) {
        BeforeActions.scenario.write("BQ Target Table " + bqTargetTableName + " does not exist");
      } else {
        Assert.fail(e.getMessage());
      }
    }
  }

  /**
   * Create BigQuery table with 3 columns (Id - Int, Value - Int, UID - string) containing random testdata.
   * Sample row:
   * Id | Value | UID
   * 22 | 968   | 245308db-6088-4db2-a933-f0eea650846a
   */
  @Before(order = 1, value = "@BQ_SOURCE_TEST")
  public static void createTempSourceBQTable() throws IOException, InterruptedException {
    String bqSourceTable = "E2E_SOURCE_" + UUID.randomUUID().toString().replaceAll("-", "_");
    StringBuilder records = new StringBuilder(StringUtils.EMPTY);
    for (int index = 2; index <= 25; index++) {
      records.append(" (").append(index).append(", ").append((int) (Math.random() * 1000 + 1)).append(", '")
        .append(UUID.randomUUID()).append("'), ");
    }
    BigQueryClient.getSoleQueryResult("create table `test_automation." + bqSourceTable + "` as " +
                                        "SELECT * FROM UNNEST([ " +
                                        " STRUCT(1 AS Id, " + ((int) (Math.random() * 1000 + 1)) + " as Value, " +
                                        "'" + UUID.randomUUID() + "' as UID), " +
                                        records +
                                        "  (26, " + ((int) (Math.random() * 1000 + 1)) + ", " +
                                        "'" + UUID.randomUUID() + "') " +
                                        "])");
    PluginPropertyUtils.addPluginProp("bqSourceTable", bqSourceTable);
    BeforeActions.scenario.write("BQ source Table " + bqSourceTable + " created successfully");
  }

  @After(order = 1, value = "@BQ_SOURCE_TEST")
  public static void deleteTempSourceBQTable() throws IOException, InterruptedException {
    String bqSourceTable = PluginPropertyUtils.pluginProp("bqSourceTable");
    BigQueryClient.dropBqQuery(bqSourceTable);
    BeforeActions.scenario.write("BQ source Table " + bqSourceTable + " deleted successfully");
    PluginPropertyUtils.removePluginProp("bqSourceTable");
  }
}
