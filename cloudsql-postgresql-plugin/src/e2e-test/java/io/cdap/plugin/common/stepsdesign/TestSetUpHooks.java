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


import io.cdap.e2e.utils.PluginPropertyUtils;
import io.cdap.plugin.cloudsqlpostgresql.CloudSqlClient;
import io.cucumber.java.After;
import io.cucumber.java.Before;
import org.apache.commons.lang3.RandomStringUtils;

/**
 * Cloudsql-postgresql test hooks.
 */

public class TestSetUpHooks {

  @Before(order = 1)
  public static void setTableName() {
    String randomString = RandomStringUtils.randomAlphabetic(10).toUpperCase();
    String sourceTableName = String.format("SOURCETABLE_%s", randomString);
    String targetTableName = String.format("TARGETTABLE_%s", randomString);
    PluginPropertyUtils.addPluginProp("sourceTable", sourceTableName);
    PluginPropertyUtils.addPluginProp("targetTable", targetTableName);
    String schema = PluginPropertyUtils.pluginProp("schema");
    PluginPropertyUtils.addPluginProp("selectQuery", String.format("Select * from auto.newtable;"));
  }
//  @Before(order = 2, value = "@CLOUDSQL_SOURCE_TEST")
//  public static void createTables() {
//    CloudSqlClient.createSourceTable(PluginPropertyUtils.pluginProp("sourceTable"),
//                                     PluginPropertyUtils.pluginProp("schema"));
//    CloudSqlClient.createTargetTable(PluginPropertyUtils.pluginProp("targetTable"),
//                                     PluginPropertyUtils.pluginProp("schema"));
//  }

  @Before(order = 2, value = "CLOUDSQL_SOURCE_DATATYPES_TEST")
  public static void createAllDatatypesTables() {
    CloudSqlClient.createSourceDatatypesTable(PluginPropertyUtils.pluginProp("sourceTable"),
                                              PluginPropertyUtils.pluginProp("schema"));
    CloudSqlClient.createTargetDatatypesTable(PluginPropertyUtils.pluginProp("targetTable"),
                                              PluginPropertyUtils.pluginProp("schema"));
  }

  @Before(order = 2, value = "@CLOUDSQL_SOURCE_DATATYPES_TEST2")
  public static void createDatatypesTablesLong() {
    CloudSqlClient.createSourceLongTable(PluginPropertyUtils.pluginProp("sourceTable"),
                                         PluginPropertyUtils.pluginProp("schema"));
    CloudSqlClient.createTargetLongTable(PluginPropertyUtils.pluginProp("targetTable"),
                                         PluginPropertyUtils.pluginProp("schema"));
  }

  @Before(order = 2, value = "@CLOUDSQL_SOURCE_LONGRAW_TEST")
  public static void createDatatypesTablesLongRaw() {
    CloudSqlClient.createSourceLongRawTable(PluginPropertyUtils.pluginProp("sourceTable"),
                                            PluginPropertyUtils.pluginProp("schema"));
    CloudSqlClient.createTargetLongRawTable(PluginPropertyUtils.pluginProp("targetTable"),
                                            PluginPropertyUtils.pluginProp("schema"));
  }

  @Before(order = 2, value = "@CLOUDSQL_SOURCE_DATATYPES_TEST4")
  public static void createLongVarcharTables() {
    CloudSqlClient.createSourceLongVarcharTable(PluginPropertyUtils.pluginProp("sourceTable"),
                                                PluginPropertyUtils.pluginProp("schema"));
    CloudSqlClient.createTargetLongVarCharTable(PluginPropertyUtils.pluginProp("targetTable"),
                                                PluginPropertyUtils.pluginProp("schema"));
  }

  @After(order = 1, value = "@CLOUDSQL_SINK_TEST")
  public static void dropTables() {
    CloudSqlClient.deleteTables(PluginPropertyUtils.pluginProp("schema"),
                                new String[]{PluginPropertyUtils.pluginProp("sourceTable"),
                                PluginPropertyUtils.pluginProp("targetTable")});
  }
}
