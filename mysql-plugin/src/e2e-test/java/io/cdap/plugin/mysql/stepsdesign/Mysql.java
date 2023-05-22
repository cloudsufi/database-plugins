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

package io.cdap.plugin.mysql.stepsdesign;

import io.cdap.e2e.pages.actions.CdfBigQueryPropertiesActions;
import io.cdap.e2e.pages.actions.CdfPipelineRunAction;
import io.cdap.e2e.utils.BigQueryClient;
import io.cdap.e2e.utils.CdfHelper;
import io.cdap.e2e.utils.PluginPropertyUtils;
import io.cdap.plugin.MysqlClient;
import io.cdap.plugin.mysql.actions.MySQLPropertiesPageActions;
import io.cdap.plugin.mysql.locators.MySQLPropertiesPage;
import io.cdap.plugin.mysql.BQValidation;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import org.apache.commons.lang3.RandomStringUtils;
import org.junit.Assert;
import stepsdesign.BeforeActions;

import java.io.IOException;
import java.sql.SQLException;

/**
 *  MYSQL Plugin related step design.
 */
public class Mysql implements CdfHelper {

  @Then("Click on preview data for MySQL sink")
  public void clickOnPreviewDataForMysqlSink() {
    openSinkPluginPreviewData("Mysql");
  }

  @Then("Validate the values of records transferred to target table is equal to the values from source table")
  public void validateTheValuesOfRecordsTransferredToTargetTableIsEqualToTheValuesFromSourceTable() throws
    SQLException, ClassNotFoundException {
    int countRecords = MysqlClient.countRecord(PluginPropertyUtils.pluginProp("targetTable"));
    Assert.assertEquals("Number of records transferred should be equal to records out ",
                        countRecords, recordOut());
    BeforeActions.scenario.write(" ******** Number of records transferred ********:" + countRecords);
    boolean recordsMatched = MysqlClient.validateRecordValues(PluginPropertyUtils.pluginProp("sourceTable"),
                                                           PluginPropertyUtils.pluginProp("targetTable"));
    Assert.assertTrue("Value of records transferred to the target table should be equal to the value " +
                        "of the records in the source table", recordsMatched);
  }

  @Then("Select Mysql Connection")
  public void clickOnMysqlConnectionButton() {
    MySQLPropertiesPageActions.clickOnMysqlConnectionButton();
  }

  @Then("Use new connection")
  public void clickOnNewMySQLConnection() {
    MySQLPropertiesPageActions.clickOnMySQLConnection();
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
  public void ValidateTheValuesOfRecordsTransferredToTargetBigQueryTableIsEqualToTheValuesFromSourceTable()
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
