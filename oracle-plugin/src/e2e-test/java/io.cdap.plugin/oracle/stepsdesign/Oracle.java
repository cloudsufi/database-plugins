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

import io.cdap.e2e.pages.actions.CdfPipelineRunAction;
import io.cdap.e2e.utils.BigQueryClient;
import io.cdap.e2e.utils.CdfHelper;
import io.cdap.e2e.utils.PluginPropertyUtils;
import io.cdap.plugin.OracleClient;
import io.cdap.plugin.oracle.actions.OracleActions;
import io.cdap.plugin.utils.E2ETestConstants;
import io.cucumber.java.en.Then;
import org.junit.Assert;
import stepsdesign.BeforeActions;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

/**
 *  Oracle Plugin related step design.
 */
public class Oracle implements CdfHelper {

  @Then("Click on preview data for Oracle sink")
  public void clickOnPreviewDataForOracleSink() {
    openSinkPluginPreviewData("Oracle");
  }

  @Then("Validate the values of records transferred to target table is equal to the values from source table")
  public void validateTheValuesOfRecordsTransferredToTargetTableIsEqualToTheValuesFromSourceTable() throws
    SQLException, ClassNotFoundException {
    int countRecords = OracleClient.countRecord(PluginPropertyUtils.pluginProp("targetTable"),
                                                PluginPropertyUtils.pluginProp("schema"));
    Assert.assertEquals("Number of records transferred should be equal to records out ",
                        countRecords, recordOut());
    BeforeActions.scenario.write("******** Number of records transferred ********* : " + countRecords);
    boolean recordsMatched = OracleClient.validateRecordValues(PluginPropertyUtils.pluginProp("schema"),
                                                           PluginPropertyUtils.pluginProp("sourceTable"),
                                                           PluginPropertyUtils.pluginProp("targetTable"));
    Assert.assertTrue("Value of records transferred to the target table should be equal to the value " +
                         "of the records in the source table", recordsMatched);
  }

  @Then("Enter Oracle plugin with connection arguments {string}")
  public void enterOraclePluginWithConnectionArguments(String jsonConnectionArgumentsField) {
    OracleActions.enterConnectionArguments(jsonConnectionArgumentsField);
  }

  @Then("Verify Oracle plugin in-line error message for incorrect Reference Name: {string}")
  public void verifyOraclePluginInLineErrorMessageForIncorrectReferenceName(String fields) {
    OracleActions.verifyGroupByPluginPropertyInlineErrorMessageForRow
      ("referenceName",
       PluginPropertyUtils.errorProp(E2ETestConstants.ERROR_MSG_INVALID_REFERENCE_NAME)
         .replace("REFERENCE", PluginPropertyUtils.pluginProp(fields)));
    OracleActions.verifyGroupByPluginPropertyInlineErrorMessageForColor("referenceName");
  }

  @Then("Validate OUT record count is equal to records transferred to target BigQuery table")
  public void validateOUTRecordCountIsEqualToRecordsTransferredToTargetBigQueryTable()
    throws IOException, InterruptedException, IOException {
    int targetBQRecordsCount = BigQueryClient.countBqQuery(PluginPropertyUtils.pluginProp("bqTargetTable"));
    BeforeActions.scenario.write("No of Records Transferred to BigQuery:" + targetBQRecordsCount);
    Assert.assertEquals("Out records should match with target BigQuery table records count",
                        CdfPipelineRunAction.getCountDisplayedOnSourcePluginAsRecordsOut(), targetBQRecordsCount);
  }

}
