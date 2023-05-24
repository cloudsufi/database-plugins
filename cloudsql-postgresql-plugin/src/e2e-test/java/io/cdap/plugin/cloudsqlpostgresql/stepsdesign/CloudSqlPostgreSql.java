package io.cdap.plugin.cloudsqlpostgresql.stepsdesign;

import io.cdap.e2e.pages.actions.CdfPipelineRunAction;
import io.cdap.e2e.utils.BigQueryClient;
import io.cdap.e2e.utils.CdfHelper;
import io.cdap.e2e.utils.PluginPropertyUtils;
import io.cdap.plugin.cloudsqlpostgresql.CloudSqlPostgreSqlClient;
import io.cucumber.java.en.Then;
import org.junit.Assert;
import stepsdesign.BeforeActions;

import java.io.IOException;
import java.sql.SQLException;

/**
 *  CLOUDSQLPOSTGRESQL Plugin related step design.
 */
public class CloudSqlPostgreSql implements CdfHelper {

  @Then("Click on preview data for CloudSQLPostgreSQL sink")
  public void clickOnPreviewDataForCloudSQLPostgreSQLSink() {
    openSinkPluginPreviewData("CloudSQL Postgres");
  }

  @Then("Validate the values of records transferred to target table is equal to the values from source table")
  public void validateTheValuesOfRecordsTransferredToTargetTableIsEqualToTheValuesFromSourceTable() throws
    SQLException, ClassNotFoundException {
    int countRecords = CloudSqlPostgreSqlClient.countRecord(PluginPropertyUtils.pluginProp("targetTable"),
                                                            PluginPropertyUtils.pluginProp("schema"));
    Assert.assertEquals("Number of records transferred should be equal to records out ",
                        countRecords, recordOut());
    BeforeActions.scenario.write(" ******** Number of records transferred ********:" + countRecords);
    boolean recordsMatched = CloudSqlPostgreSqlClient.validateRecordValues(
      PluginPropertyUtils.pluginProp("sourceTable"),
      PluginPropertyUtils.pluginProp("targetTable"),
      PluginPropertyUtils.pluginProp("schema"));
    Assert.assertTrue("Value of records transferred to the target table should be equal to the value " +
                        "of the records in the source table", recordsMatched);
  }

//  @Then("Validate the values of records transferred to target Big Query table is equal to the values from source table")
//  public void validateTheValuesOfRecordsTransferredToTargetBigQueryTableIsEqualToTheValuesFromSourceTable()
//    throws IOException, InterruptedException, IOException, SQLException, ClassNotFoundException {
//    int targetBQRecordsCount = BigQueryClient.countBqQuery(PluginPropertyUtils.pluginProp("bqTargetTable"));
//    BeforeActions.scenario.write("No of Records Transferred to BigQuery:" + targetBQRecordsCount);
//    Assert.assertEquals("Out records should match with target BigQuery table records count",
//                        CdfPipelineRunAction.getCountDisplayedOnSourcePluginAsRecordsOut(), targetBQRecordsCount);
//
//    boolean recordsMatched = BQValidation.validateBQAndDBRecordValues(PluginPropertyUtils.pluginProp("schema"),
//                                                                      PluginPropertyUtils.pluginProp("sourceTable"),
//                                                                      PluginPropertyUtils.pluginProp("bqTargetTable"));
//    Assert.assertTrue("Value of records transferred to the target table should be equal to the value " +
//                        "of the records in the source table", recordsMatched);
//  }
//
//  @Then("Validate the values of records transferred to target PostGreSQL table is equal to the values from source " +
//    "BigQuery table")
//  public void validateTheValuesOfRecordsTransferredToTargetPostGreSQLTableIsEqualToTheValuesFromSourceBigQueryTable()
//    throws IOException, InterruptedException, IOException, SQLException, ClassNotFoundException {
//    int sourceBQRecordsCount = BigQueryClient.countBqQuery(PluginPropertyUtils.pluginProp("bqSourceTable"));
//    BeforeActions.scenario.write("No of Records from source BigQuery table:" + sourceBQRecordsCount);
//    Assert.assertEquals("Out records should match with target PostgreSQL table records count",
//                        CdfPipelineRunAction.getCountDisplayedOnSourcePluginAsRecordsOut(), sourceBQRecordsCount);
//
//    boolean recordsMatched = BQValidation.validateBqToDBTarget(PluginPropertyUtils.pluginProp("schema"),
//                                                               PluginPropertyUtils.pluginProp("bqSourceTable"),
//                                                               PluginPropertyUtils.pluginProp("targetTable"));
//    Assert.assertTrue("Value of records transferred to the target table should be equal to the value " +
//                        "of the records in the source table", recordsMatched);
//  }
}
