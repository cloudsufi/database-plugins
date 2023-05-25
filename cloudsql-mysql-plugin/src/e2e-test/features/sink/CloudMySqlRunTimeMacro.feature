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


Feature: CloudMySql Sink - Run time scenarios (macro)

  Scenario: To verify data is getting transferred from BigQuery source to CloudMySql sink using macro arguments in connection section
    Given Open Datafusion Project to configure pipeline
    When Expand Plugin group in the LHS plugins list: "Source"
    When Select plugin: "BigQuery" from the plugins list as: "Source"
    When Expand Plugin group in the LHS plugins list: "Sink"
    When Select plugin: "CloudSQL MySQL" from the plugins list as: "Sink"
    Then Connect plugins: "BigQuery" and "CloudSQL MySQL" to establish connection
    Then Navigate to the properties page of plugin: "BigQuery"
    Then Enter input plugin property: "referenceName" with value: "BQReferenceName"
    Then Click on the Macro button of Property: "project" and set the value to: "projectId"
    Then Click on the Macro button of Property: "datasetProject" and set the value to: "bqDatasetProjectId"
    Then Click on the Macro button of Property: "dataset" and set the value to: "bqDataset"
    Then Click on the Macro button of Property: "table" and set the value to: "bqTargetTable"
    Then Click on the Get Schema button
    Then Validate "BigQuery" plugin properties
    Then Close the Plugin Properties page
    Then Navigate to the properties page of plugin: "CloudSQL MySQL"
    Then Click on the Macro button of Property: "jdbcPluginName" and set the value to: "cloudsql-mysql"
    Then Select radio button plugin property: "instanceType" with value: "public"
    Then Enter input plugin property: "connectionName" with value: "ConnectionName"
    Then Click on the Macro button of Property: "user" and set the value to: "username"
    Then Click on the Macro button of Property: "password" and set the value to: "password"
    Then Enter input plugin property: "referenceName" with value: "RefName"
    Then Enter input plugin property: "database" with value: "TestDatabase"
    Then Click on the Macro button of Property: "tableName" and set the value to: "mytable"
    Then Validate "CloudSQL MySQL" plugin properties
    Then Close the Plugin Properties page
    Then Save the pipeline
    Then Preview and run the pipeline
    Then Enter runtime argument value "projectId" for key "projectId"
    Then Enter runtime argument value "bqDatasetId" for key "bqDatasetProjectId"
    Then Enter runtime argument value "dataset" for key "bqDataset"
    Then Enter runtime argument value "bqSourceTable" for key "bqTargetTable"
    Then Enter runtime argument value "driver" for key "cloudsql-mysql"
    Then Enter runtime argument value from environment variable "name" for key "username"
    Then Enter runtime argument value from environment variable "pass" for key "password"
    Then Enter runtime argument value "table" for key "mytable"
    Then Run the preview of pipeline with runtime arguments
    Then Wait till pipeline preview is in running state
    Then Open and capture pipeline preview logs
    Then Verify the preview run status of pipeline in the logs is "succeeded"
    Then Close the pipeline logs
    Then Close the preview
    Then Deploy the pipeline
    Then Run the Pipeline in Runtime
    Then Enter runtime argument value "projectId" for key "projectId"
    Then Enter runtime argument value "bqDatasetId" for key "bqDatasetProjectId"
    Then Enter runtime argument value "dataset" for key "bqDataset"
    Then Enter runtime argument value "bqSourceTable" for key "bqTargetTable"
    Then Enter runtime argument value "driver" for key "cloudsql-mysql"
    Then Enter runtime argument value from environment variable "name" for key "username"
    Then Enter runtime argument value from environment variable "pass" for key "password"
    Then Click on the Macro button of Property: "dataset" and set the value to: "bqDataset"
    Then Enter runtime argument value "table" for key "mytable"
    Then Run the Pipeline in Runtime with runtime arguments
    Then Wait till pipeline is in running state
    Then Open and capture logs
    Then Verify the pipeline status is "Succeeded"
    Then Close the pipeline logs

