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
import io.cdap.plugin.MysqlClient;
import io.cucumber.java.After;
import io.cucumber.java.Before;
import org.apache.commons.lang3.RandomStringUtils;
import org.apache.commons.lang3.StringUtils;
import org.junit.Assert;
import stepsdesign.BeforeActions;

import java.io.IOException;
import java.sql.SQLException;

/**
 * MYSQL test hooks.
 */
public class TestSetupHooks {
  public static String bqTargetTable = StringUtils.EMPTY;

  private static void setTableName() {
    String randomString = RandomStringUtils.randomAlphabetic(10);
    String sourceTableName = String.format("SourceTable_%s", randomString);
    String targetTableName = String.format("TargetTable_%s", randomString);
    PluginPropertyUtils.addPluginProp("sourceTable", sourceTableName);
    PluginPropertyUtils.addPluginProp("targetTable", targetTableName);
    PluginPropertyUtils.addPluginProp("selectQuery", String.format("select * from %s", sourceTableName));
  }

  @Before(order = 1)
  public static void initializeDBProperties() {
    String username = System.getenv("username");
    if (username != null && !username.isEmpty()) {
        PluginPropertyUtils.addPluginProp("username", username);
    }
    String password = System.getenv("password");
    if (password != null && !password.isEmpty()) {
      PluginPropertyUtils.addPluginProp("password", password);
    }
    TestSetupHooks.setTableName();
  }

  @Before(order = 2, value = "@MYSQL_SOURCE_TEST")
  public static void createTables() throws SQLException, ClassNotFoundException {
    MysqlClient.createSourceTable(PluginPropertyUtils.pluginProp("sourceTable"));
    MysqlClient.createTargetTable(PluginPropertyUtils.pluginProp("targetTable"));
  }

  @Before(order = 2, value = "@MYSQL_SOURCE_DATATYPES_TEST")
  public static void createDatatypesTable() throws SQLException, ClassNotFoundException {
    MysqlClient.createSourceDatatypesTable(PluginPropertyUtils.pluginProp("sourceTable"));
    MysqlClient.createTargetDatatypesTable(PluginPropertyUtils.pluginProp("targetTable"));
  }

  @After(order = 2, value = "@MYSQL_SINK_TEST")
  public static void dropTables() throws SQLException, ClassNotFoundException {
    MysqlClient.dropTables(new String[]{PluginPropertyUtils.pluginProp("sourceTable"),
      PluginPropertyUtils.pluginProp("targetTable")});
  }

  @Before(order = 1, value = "@BQ_SINK")
  public static void setTempTargetBQTable() {
    bqTargetTable = "TestSN_table" + RandomStringUtils.randomAlphanumeric(10);
    PluginPropertyUtils.addPluginProp("bqtarget.table", bqTargetTable);
    BeforeActions.scenario.write("BigQuery Target table name: " + bqTargetTable);
  }

  @After(order = 1, value = "@BQ_SINK_CLEANUP")
  public static void deleteTempTargetBQTable() throws IOException, InterruptedException {
    try {
      BigQueryClient.dropBqQuery(bqTargetTable);
      BeforeActions.scenario.write("BigQuery Target table: " + bqTargetTable + " is deleted successfully");
      bqTargetTable = StringUtils.EMPTY;
    } catch (BigQueryException e) {
      if (e.getCode() == 404) {
        BeforeActions.scenario.write("BigQuery Target Table: " + bqTargetTable + " does not exist");
      } else {
        Assert.fail(e.getMessage());
      }
    }
  }
}
