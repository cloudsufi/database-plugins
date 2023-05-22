#
# Copyright © 2023 Cask Data, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License"); you may not
# use this file except in compliance with the License. You may obtain a copy of
# the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
# WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
# License for the specific language governing permissions and limitations under
# the License.
#

@Mysql
Feature: Mysql - Verify Mysql sink data transfer for different datatypes

  @BQ_SOURCE_TEST @Mysql_TEST_TABLE
  Scenario: To verify data is getting transferred from BigQuery to Mysql successfully
    Given Open Datafusion Project to configure pipeline
    When Expand Plugin group in the LHS plugins list: "Source"
    When Select plugin: "BigQuery" from the plugins list as: "Source"
    And Navigate to the properties page of plugin: "BigQuery"
    And Enter input plugin property: "referenceName" with value: "Reference"
    And Replace input plugin property: "project" with value: "project.id"
    And Enter input plugin property: "datasetProject" with value: "datasetprojectId"
    And Enter input plugin property: "dataset" with value: "dataset"
    And Enter input plugin property: "table" with value: "bqtable"
    Then Validate "BigQuery" plugin properties
    And Close the Plugin Properties page
    When Expand Plugin group in the LHS plugins list: "Sink"
    When Select plugin: "MySQL" from the plugins list as: "Sink"
    Then Connect plugins: "BigQuery" and "MySQL" to establish connection
    Then Navigate to the properties page of plugin: "MySQL"
    Then Select dropdown plugin property: "select-jdbcPluginName" with option value: "driverName"
    Then Replace input plugin property: "host" with value: "host" for Credentials and Authorization related fields
    Then Replace input plugin property: "port" with value: "port" for Credentials and Authorization related fields
    Then Replace input plugin property: "database" with value: "databaseName"
    Then Replace input plugin property: "tableName" with value: "targetTable"
    Then Replace input plugin property: "user" with value: "username" for Credentials and Authorization related fields
    Then Replace input plugin property: "password" with value: "password" for Credentials and Authorization related fields
    Then Enter input plugin property: "referenceName" with value: "targetRef"
    Then Validate "MySQL2" plugin properties
    Then Close the Plugin Properties page
    Then Save the pipeline
    Then Preview and run the pipeline
    Then Verify the preview of pipeline is "success"
    Then Click on preview data for MySQL sink
    Then Close the preview data
    Then Deploy the pipeline
    Then Run the Pipeline in Runtime
    Then Wait till pipeline is in running state
    Then Open and capture logs
    Then Verify the pipeline status is "Succeeded"
