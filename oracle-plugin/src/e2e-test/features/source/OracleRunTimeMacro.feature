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

@Oracle
Feature: Oracle - Verify Oracle source data transfer with macro arguments

  @ORACLE_SOURCE_TEST @ORACLE_SINK_TEST @Oracle_Required
  Scenario: To verify data is getting transferred from Oracle to Oracle successfully using macro arguments in connection section
    Given Open Datafusion Project to configure pipeline
    When Expand Plugin group in the LHS plugins list: "Source"
    When Select plugin: "Oracle" from the plugins list as: "Source"
    When Expand Plugin group in the LHS plugins list: "Sink"
    When Select plugin: "Oracle" from the plugins list as: "Sink"
    Then Connect plugins: "Oracle" and "Oracle2" to establish connection
    Then Navigate to the properties page of plugin: "Oracle"
    Then Click on the Macro button of Property: "jdbcPluginName" and set the value to: "oracleDriverName"
    Then Click on the Macro button of Property: "host" and set the value to: "oracleHost"
    Then Click on the Macro button of Property: "port" and set the value to: "oraclePort"
    Then Click on the Macro button of Property: "user" and set the value to: "oracleUser"
    Then Click on the Macro button of Property: "password" and set the value to: "oraclePassword"
    Then Click on the Macro button of Property: "database" and set the value to: "oracleDatabase"
    Then Click on the Macro button of Property: "connectionArguments" and set the value to: "oracleConnectionArguments"
    Then Enter input plugin property: "referenceName" with value: "sourceRef"
    Then Enter textarea plugin property: "importQuery" with value: "selectQuery"
    Then Validate "Oracle" plugin properties
    Then Close the Plugin Properties page
    Then Navigate to the properties page of plugin: "Oracle2"
    Then Select dropdown plugin property: "select-jdbcPluginName" with option value: "driverName"
    Then Replace input plugin property: "host" with value: "host" for Credentials and Authorization related fields
    Then Replace input plugin property: "port" with value: "port" for Credentials and Authorization related fields
    Then Replace input plugin property: "database" with value: "databaseName"
    Then Replace input plugin property: "tableName" with value: "targetTable"
    Then Replace input plugin property: "dbSchemaName" with value: "schema"
    Then Replace input plugin property: "user" with value: "username" for Credentials and Authorization related fields
    Then Replace input plugin property: "password" with value: "password" for Credentials and Authorization related fields
    Then Enter input plugin property: "referenceName" with value: "targetRef"
    Then Select radio button plugin property: "connectionType" with value: "service"
    Then Select radio button plugin property: "role" with value: "sysdba"
    Then Validate "Oracle2" plugin properties
    Then Close the Plugin Properties page
    Then Save the pipeline
    Then Preview and run the pipeline
    Then Enter runtime argument value "driverName" for key "oracleDriverName"
    Then Enter runtime argument value "host" for key "oracleHost"
    Then Enter runtime argument value "port" for key "oraclePort"
    Then Enter runtime argument value "username" for key "oracleUser"
    Then Enter runtime argument value "password" for key "oraclePassword"
    Then Enter runtime argument value "databaseName" for key "oracleDatabase"
    Then Enter runtime argument value "connectionArgumentsList" for key "oracleConnectionArguments"
    Then Run the preview of pipeline with runtime arguments
    Then Wait till pipeline preview is in running state
    Then Open and capture pipeline preview logs
    Then Verify the preview run status of pipeline in the logs is "succeeded"
    Then Close the pipeline logs
    Then Close the preview
    Then Deploy the pipeline
    Then Run the Pipeline in Runtime
    Then Enter runtime argument value "driverName" for key "oracleDriverName"
    Then Enter runtime argument value from environment variable "host" for key "oracleHost"
    Then Enter runtime argument value from environment variable "port" for key "oraclePort"
    Then Enter runtime argument value from environment variable "username" for key "oracleUsername"
    Then Enter runtime argument value from environment variable "password" for key "oraclePassword"
    Then Enter runtime argument value "databaseName" for key "oracleDatabase"
    Then Enter runtime argument value "connectionArgumentsList" for key "oracleConnectionArguments"
    Then Run the Pipeline in Runtime with runtime arguments
    Then Wait till pipeline is in running state
    Then Open and capture logs
    Then Verify the pipeline status is "Succeeded"
    Then Close the pipeline logs
    Then Validate the values of records transferred to target table is equal to the values from source table

  @ORACLE_SOURCE_TEST @ORACLE_SINK_TEST @Oracle_Required
  Scenario: To verify data is getting transferred from Oracle to Oracle successfully using macro arguments in basic section
    Given Open Datafusion Project to configure pipeline
    When Expand Plugin group in the LHS plugins list: "Source"
    When Select plugin: "Oracle" from the plugins list as: "Source"
    When Expand Plugin group in the LHS plugins list: "Sink"
    When Select plugin: "Oracle" from the plugins list as: "Sink"
    Then Connect plugins: "Oracle" and "Oracle2" to establish connection
    Then Navigate to the properties page of plugin: "Oracle"
    Then Select dropdown plugin property: "select-jdbcPluginName" with option value: "driverName"
    Then Replace input plugin property: "host" with value: "host" for Credentials and Authorization related fields
    Then Replace input plugin property: "port" with value: "port" for Credentials and Authorization related fields
    Then Replace input plugin property: "user" with value: "username" for Credentials and Authorization related fields
    Then Replace input plugin property: "password" with value: "password" for Credentials and Authorization related fields
    Then Select radio button plugin property: "connectionType" with value: "service"
    Then Select radio button plugin property: "role" with value: "sysdba"
    Then Enter input plugin property: "referenceName" with value: "sourceRef"
    Then Replace input plugin property: "database" with value: "databaseName"
    Then Click on the Macro button of Property: "splitBy" and set the value to: "oracleSplitByColumn"
    Then Click on the Macro button of Property: "importQuery" and set the value in textarea: "oracleImportQuery"
    Then Validate "Oracle" plugin properties
    Then Close the Plugin Properties page
    Then Navigate to the properties page of plugin: "Oracle2"
    Then Select dropdown plugin property: "select-jdbcPluginName" with option value: "driverName"
    Then Replace input plugin property: "host" with value: "host" for Credentials and Authorization related fields
    Then Replace input plugin property: "port" with value: "port" for Credentials and Authorization related fields
    Then Replace input plugin property: "database" with value: "databaseName"
    Then Replace input plugin property: "tableName" with value: "targetTable"
    Then Replace input plugin property: "dbSchemaName" with value: "schema"
    Then Replace input plugin property: "user" with value: "username" for Credentials and Authorization related fields
    Then Replace input plugin property: "password" with value: "password" for Credentials and Authorization related fields
    Then Enter input plugin property: "referenceName" with value: "targetRef"
    Then Select radio button plugin property: "connectionType" with value: "service"
    Then Select radio button plugin property: "role" with value: "sysdba"
    Then Validate "Oracle2" plugin properties
    Then Close the Plugin Properties page
    Then Save the pipeline
    Then Preview and run the pipeline
    Then Enter runtime argument value "splitByColumn" for key "oracleSplitByColumn"
    Then Enter runtime argument value "selectQuery" for key "oracleImportQuery"
    Then Run the preview of pipeline with runtime arguments
    Then Wait till pipeline preview is in running state
    Then Open and capture pipeline preview logs
    Then Verify the preview run status of pipeline in the logs is "succeeded"
    Then Close the pipeline logs
    Then Close the preview
    Then Deploy the pipeline
    Then Run the Pipeline in Runtime
    Then Enter runtime argument value "splitByColumn" for key "oracleSplitByColumn"
    Then Enter runtime argument value "selectQuery" for key "oracleImportQuery"
    Then Run the Pipeline in Runtime with runtime arguments
    Then Wait till pipeline is in running state
    Then Open and capture logs
    Then Verify the pipeline status is "Succeeded"
    Then Close the pipeline logs
    Then Validate the values of records transferred to target table is equal to the values from source table

  @ORACLE_SOURCE_TEST @ORACLE_SINK_TEST @Oracle_Required
  Scenario: To verify pipeline preview fails when invalid connection details provided using macro arguments
    Given Open Datafusion Project to configure pipeline
    When Expand Plugin group in the LHS plugins list: "Source"
    When Select plugin: "Oracle" from the plugins list as: "Source"
    When Expand Plugin group in the LHS plugins list: "Sink"
    When Select plugin: "Oracle" from the plugins list as: "Sink"
    Then Connect plugins: "Oracle" and "Oracle2" to establish connection
    Then Navigate to the properties page of plugin: "Oracle"
    Then Click on the Macro button of Property: "jdbcPluginName" and set the value to: "oracleDriverName"
    Then Click on the Macro button of Property: "host" and set the value to: "oracleHost"
    Then Click on the Macro button of Property: "port" and set the value to: "oraclePort"
    Then Click on the Macro button of Property: "user" and set the value to: "oracleUser"
    Then Click on the Macro button of Property: "password" and set the value to: "oraclePassword"
    Then Click on the Macro button of Property: "database" and set the value to: "oracleDatabase"
    Then Select radio button plugin property: "connectionType" with value: "service"
    Then Select radio button plugin property: "role" with value: "sysdba"
    Then Enter input plugin property: "referenceName" with value: "sourceRef"
    Then Enter textarea plugin property: "importQuery" with value: "selectQuery"
    Then Validate "Oracle" plugin properties
    Then Close the Plugin Properties page
    Then Navigate to the properties page of plugin: "Oracle2"
    Then Select dropdown plugin property: "select-jdbcPluginName" with option value: "driverName"
    Then Replace input plugin property: "host" with value: "host" for Credentials and Authorization related fields
    Then Replace input plugin property: "port" with value: "port" for Credentials and Authorization related fields
    Then Replace input plugin property: "database" with value: "databaseName"
    Then Replace input plugin property: "tableName" with value: "targetTable"
    Then Replace input plugin property: "dbSchemaName" with value: "schema"
    Then Replace input plugin property: "user" with value: "username" for Credentials and Authorization related fields
    Then Replace input plugin property: "password" with value: "password" for Credentials and Authorization related fields
    Then Enter input plugin property: "referenceName" with value: "targetRef"
    Then Select radio button plugin property: "connectionType" with value: "service"
    Then Select radio button plugin property: "role" with value: "sysdba"
    Then Validate "Oracle2" plugin properties
    Then Close the Plugin Properties page
    Then Save the pipeline
    Then Preview and run the pipeline
    Then Enter runtime argument value "invalidDriverName" for key "oracleDriverName"
    Then Enter runtime argument value "invalidHost" for key "oracleHost"
    Then Enter runtime argument value "invalidPort" for key "oraclePort"
    Then Enter runtime argument value "invalidUserName" for key "oracleUser"
    Then Enter runtime argument value "invalidPassword" for key "oraclePassword"
    Then Enter runtime argument value "invalidDatabaseName" for key "oracleDatabase"
    Then Run the preview of pipeline with runtime arguments
    Then Wait till pipeline preview is in running state
    Then Open and capture pipeline preview logs
    Then Verify the preview run status of pipeline in the logs is "failed"
    Then Close the pipeline logs
    Then Close the preview

  @ORACLE_SOURCE_TEST @ORACLE_SINK_TEST @Oracle_Required
  Scenario: To verify pipeline preview fails when invalid table name provided in import query using macro arguments
    Given Open Datafusion Project to configure pipeline
    When Expand Plugin group in the LHS plugins list: "Source"
    When Select plugin: "Oracle" from the plugins list as: "Source"
    When Expand Plugin group in the LHS plugins list: "Sink"
    When Select plugin: "Oracle" from the plugins list as: "Sink"
    Then Connect plugins: "Oracle" and "Oracle2" to establish connection
    Then Navigate to the properties page of plugin: "Oracle"
    Then Select dropdown plugin property: "select-jdbcPluginName" with option value: "driverName"
    Then Replace input plugin property: "host" with value: "host" for Credentials and Authorization related fields
    Then Replace input plugin property: "port" with value: "port" for Credentials and Authorization related fields
    Then Replace input plugin property: "user" with value: "username" for Credentials and Authorization related fields
    Then Replace input plugin property: "password" with value: "password" for Credentials and Authorization related fields
    Then Select radio button plugin property: "connectionType" with value: "service"
    Then Select radio button plugin property: "role" with value: "sysdba"
    Then Enter input plugin property: "referenceName" with value: "sourceRef"
    Then Replace input plugin property: "database" with value: "databaseName"
    Then Click on the Macro button of Property: "importQuery" and set the value in textarea: "oracleInvalidImportQuery"
    Then Validate "Oracle" plugin properties
    Then Close the Plugin Properties page
    Then Navigate to the properties page of plugin: "Oracle2"
    Then Select dropdown plugin property: "select-jdbcPluginName" with option value: "driverName"
    Then Replace input plugin property: "host" with value: "host" for Credentials and Authorization related fields
    Then Replace input plugin property: "port" with value: "port" for Credentials and Authorization related fields
    Then Replace input plugin property: "database" with value: "databaseName"
    Then Replace input plugin property: "tableName" with value: "targetTable"
    Then Replace input plugin property: "dbSchemaName" with value: "schema"
    Then Replace input plugin property: "user" with value: "username" for Credentials and Authorization related fields
    Then Replace input plugin property: "password" with value: "password" for Credentials and Authorization related fields
    Then Enter input plugin property: "referenceName" with value: "targetRef"
    Then Select radio button plugin property: "connectionType" with value: "service"
    Then Select radio button plugin property: "role" with value: "sysdba"
    Then Validate "Oracle2" plugin properties
    Then Close the Plugin Properties page
    Then Save the pipeline
    Then Preview and run the pipeline
    Then Enter runtime argument value "invalidTableNameImportQuery" for key "oracleInvalidImportQuery"
    Then Run the preview of pipeline with runtime arguments
    Then Wait till pipeline preview is in running state
    Then Open and capture pipeline preview logs
    Then Verify the preview run status of pipeline in the logs is "failed"
    Then Close the pipeline logs
    Then Close the preview

  @ORACLE_SOURCE_TEST @BQ_SINK_TEST
  Scenario: To verify data is getting transferred from Oracle source to BigQuery sink using macro arguments
    Given Open Datafusion Project to configure pipeline
    When Expand Plugin group in the LHS plugins list: "Source"
    When Select plugin: "Oracle" from the plugins list as: "Source"
    When Expand Plugin group in the LHS plugins list: "Sink"
    When Select plugin: "BigQuery" from the plugins list as: "Sink"
    Then Connect plugins: "Oracle" and "BigQuery" to establish connection
    Then Navigate to the properties page of plugin: "Oracle"
    Then Click on the Macro button of Property: "jdbcPluginName" and set the value to: "oracleDriverName"
    Then Click on the Macro button of Property: "host" and set the value to: "oracleHost"
    Then Click on the Macro button of Property: "port" and set the value to: "oraclePort"
    Then Click on the Macro button of Property: "user" and set the value to: "oracleUsername"
    Then Click on the Macro button of Property: "password" and set the value to: "oraclePassword"
    Then Select radio button plugin property: "connectionType" with value: "service"
    Then Select radio button plugin property: "role" with value: "sysdba"
    Then Click on the Macro button of Property: "database" and set the value to: "oracleDatabase"
    Then Enter input plugin property: "referenceName" with value: "sourceRef"
    Then Enter textarea plugin property: "importQuery" with value: "selectQuery"
    Then Validate "Oracle" plugin properties
    Then Close the Plugin Properties page
    Then Navigate to the properties page of plugin: "BigQuery"
    Then Enter input plugin property: "referenceName" with value: "BQReferenceName"
    Then Click on the Macro button of Property: "projectId" and set the value to: "bqProjectId"
    Then Click on the Macro button of Property: "datasetProjectId" and set the value to: "bqDatasetProjectId"
    Then Override Service account details if set in environment variables
    Then Click on the Macro button of Property: "dataset" and set the value to: "bqDataset"
    Then Click on the Macro button of Property: "table" and set the value to: "bqTable"
    Then Click on the Macro button of Property: "truncateTableMacroInput" and set the value to: "bqTruncateTable"
    Then Click on the Macro button of Property: "updateTableSchemaMacroInput" and set the value to: "bqUpdateTableSchema"
    Then Validate "BigQuery" plugin properties
    Then Close the Plugin Properties page
    Then Save the pipeline
    Then Preview and run the pipeline
    Then Enter runtime argument value "driverName" for key "oracleDriverName"
    Then Enter runtime argument value from environment variable "host" for key "oracleHost"
    Then Enter runtime argument value from environment variable "port" for key "oraclePort"
    Then Enter runtime argument value from environment variable "username" for key "oracleUsername"
    Then Enter runtime argument value from environment variable "password" for key "oraclePassword"
    Then Enter runtime argument value "databaseName" for key "oracleDatabase"
    Then Enter runtime argument value "projectId" for key "bqProjectId"
    Then Enter runtime argument value "projectId" for key "bqDatasetProjectId"
    Then Enter runtime argument value "dataset" for key "bqDataset"
    Then Enter runtime argument value "bqTargetTable" for key "bqTable"
    Then Enter runtime argument value "bqTruncateTable" for key "bqTruncateTable"
    Then Enter runtime argument value "bqUpdateTableSchema" for key "bqUpdateTableSchema"
    Then Run the preview of pipeline with runtime arguments
    Then Wait till pipeline preview is in running state
    Then Open and capture pipeline preview logs
    Then Verify the preview run status of pipeline in the logs is "succeeded"
    Then Close the pipeline logs
    Then Close the preview
    Then Deploy the pipeline
    Then Run the Pipeline in Runtime
    Then Enter runtime argument value "driverName" for key "oracleDriverName"
    Then Enter runtime argument value from environment variable "host" for key "oracleHost"
    Then Enter runtime argument value from environment variable "port" for key "oraclePort"
    Then Enter runtime argument value from environment variable "username" for key "oracleUsername"
    Then Enter runtime argument value from environment variable "password" for key "oraclePassword"
    Then Enter runtime argument value "databaseName" for key "oracleDatabase"
    Then Enter runtime argument value "projectId" for key "bqProjectId"
    Then Enter runtime argument value "projectId" for key "bqDatasetProjectId"
    Then Enter runtime argument value "dataset" for key "bqDataset"
    Then Enter runtime argument value "bqTargetTable" for key "bqTable"
    Then Enter runtime argument value "bqTruncateTable" for key "bqTruncateTable"
    Then Enter runtime argument value "bqUpdateTableSchema" for key "bqUpdateTableSchema"
    Then Run the Pipeline in Runtime with runtime arguments
    Then Wait till pipeline is in running state
    Then Open and capture logs
    Then Verify the pipeline status is "Succeeded"
    Then Close the pipeline logs
    Then Validate OUT record count is equal to records transferred to target BigQuery table
