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

@Oracle @Oracle_Required
Feature: Oracle - Verify data transfer to Oracle sink with macro arguments

  @ORACLE_SOURCE_TEST @ORACLE_SINK_TEST
  Scenario: To verify data is getting transferred from Oracle to Oracle successfully using macro arguments in connection section
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
    Then Enter textarea plugin property: "importQuery" with value: "selectQuery"
    Then Click on the Get Schema button
    Then Verify the Output Schema matches the Expected Schema: "outputSchema"
    Then Validate "Oracle" plugin properties
    Then Close the Plugin Properties page
    Then Navigate to the properties page of plugin: "Oracle2"
    Then Click on the Macro button of Property: "jdbcPluginName" and set the value to: "oracleDriverName"
    Then Click on the Macro button of Property: "host" and set the value to: "oracleHost"
    Then Click on the Macro button of Property: "port" and set the value to: "oraclePort"
    Then Click on the Macro button of Property: "user" and set the value to: "oracleUsername"
    Then Click on the Macro button of Property: "password" and set the value to: "oraclePassword"
    Then Select radio button plugin property: "connectionType" with value: "service"
    Then Select radio button plugin property: "role" with value: "sysdba"
    Then Enter input plugin property: "referenceName" with value: "targetRef"
    Then Replace input plugin property: "database" with value: "databaseName"
    Then Replace input plugin property: "tableName" with value: "targetTable"
    Then Replace input plugin property: "dbSchemaName" with value: "schema"
    Then Validate "Oracle2" plugin properties
    Then Close the Plugin Properties page
    Then Save the pipeline
    Then Preview and run the pipeline
    Then Enter runtime argument value "driverName" for key "oracleDriverName"
    Then Enter runtime argument value from environment variable "host" for key "oracleHost"
    Then Enter runtime argument value from environment variable "port" for key "oraclePort"
    Then Enter runtime argument value from environment variable "username" for key "oracleUsername"
    Then Enter runtime argument value from environment variable "password" for key "oraclePassword"
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
    Then Run the Pipeline in Runtime with runtime arguments
    Then Wait till pipeline is in running state
    Then Open and capture logs
    Then Verify the pipeline status is "Succeeded"
    Then Close the pipeline logs
    Then Validate the values of records transferred to target table is equal to the values from source table

  @ORACLE_SOURCE_DATATYPES_TEST2 @ORACLE_SINK_TEST
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
    Then Enter textarea plugin property: "importQuery" with value: "selectQuery"
    Then Click on the Get Schema button
    Then Verify the Output Schema matches the Expected Schema: "outputDatatypesSchema2"
    Then Validate "Oracle" plugin properties
    Then Close the Plugin Properties page
    Then Navigate to the properties page of plugin: "Oracle2"
    Then Select dropdown plugin property: "select-jdbcPluginName" with option value: "driverName"
    Then Replace input plugin property: "host" with value: "host" for Credentials and Authorization related fields
    Then Replace input plugin property: "port" with value: "port" for Credentials and Authorization related fields
    Then Replace input plugin property: "user" with value: "username" for Credentials and Authorization related fields
    Then Replace input plugin property: "password" with value: "password" for Credentials and Authorization related fields
    Then Enter input plugin property: "referenceName" with value: "targetRef"
    Then Select radio button plugin property: "connectionType" with value: "service"
    Then Select radio button plugin property: "role" with value: "sysdba"
    Then Click on the Macro button of Property: "database" and set the value to: "oracleDatabaseName"
    Then Click on the Macro button of Property: "tableName" and set the value to: "oracleTableName"
    Then Click on the Macro button of Property: "dbSchemaName" and set the value to: "oracleSchemaName"
    Then Validate "Oracle2" plugin properties
    Then Close the Plugin Properties page
    Then Save the pipeline
    Then Preview and run the pipeline
    Then Enter runtime argument value "databaseName" for key "oracleDatabaseName"
    Then Enter runtime argument value "targetTable" for key "oracleTableName"
    Then Enter runtime argument value "schema" for key "oracleSchemaName"
    Then Run the preview of pipeline with runtime arguments
    Then Wait till pipeline preview is in running state
    Then Open and capture pipeline preview logs
    Then Verify the preview run status of pipeline in the logs is "succeeded"
    Then Close the pipeline logs
    Then Close the preview
    Then Deploy the pipeline
    Then Run the Pipeline in Runtime
    Then Enter runtime argument value "databaseName" for key "oracleDatabaseName"
    Then Enter runtime argument value "targetTable" for key "oracleTableName"
    Then Enter runtime argument value "schema" for key "oracleSchemaName"
    Then Run the Pipeline in Runtime with runtime arguments
    Then Wait till pipeline is in running state
    Then Open and capture logs
    Then Verify the pipeline status is "Succeeded"
    Then Close the pipeline logs
    Then Validate the values of records transferred to target table is equal to the values from source table

  @ORACLE_SOURCE_TEST @ORACLE_SINK_TEST
  Scenario: To verify pipeline preview fails when invalid connection details provided using macro arguments
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
    Then Enter textarea plugin property: "importQuery" with value: "selectQuery"
    Then Click on the Get Schema button
    Then Verify the Output Schema matches the Expected Schema: "outputSchema"
    Then Validate "Oracle" plugin properties
    Then Close the Plugin Properties page
    Then Navigate to the properties page of plugin: "Oracle2"
    Then Click on the Macro button of Property: "jdbcPluginName" and set the value to: "oracleDriverName"
    Then Click on the Macro button of Property: "host" and set the value to: "oracleHost"
    Then Click on the Macro button of Property: "port" and set the value to: "oraclePort"
    Then Click on the Macro button of Property: "user" and set the value to: "oracleUsername"
    Then Click on the Macro button of Property: "password" and set the value to: "oraclePassword"
    Then Click on the Macro button of Property: "database" and set the value to: "oracleDatabase"
    Then Enter input plugin property: "referenceName" with value: "targetRef"
    Then Replace input plugin property: "tableName" with value: "targetTable"
    Then Replace input plugin property: "dbSchemaName" with value: "schema"
    Then Select radio button plugin property: "connectionType" with value: "service"
    Then Select radio button plugin property: "role" with value: "sysdba"
    Then Validate "Oracle2" plugin properties
    Then Close the Plugin Properties page
    Then Save the pipeline
    Then Preview and run the pipeline
    Then Enter runtime argument value "invalidDriverName" for key "oracleDriverName"
    Then Enter runtime argument value "invalidHost" for key "oracleHost"
    Then Enter runtime argument value "invalidPort" for key "oraclePort"
    Then Enter runtime argument value "invalidUserName" for key "oracleUsername"
    Then Enter runtime argument value "invalidPassword" for key "oraclePassword"
    Then Enter runtime argument value "invalidDatabaseName" for key "oracleDatabase"
    Then Run the preview of pipeline with runtime arguments
    Then Verify the preview of pipeline is "Failed"

  @ORACLE_SOURCE_LONGRAW_TEST @ORACLE_SINK_TEST
  Scenario: To verify pipeline preview fails when invalid basic details provided using macro arguments
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
    Then Enter textarea plugin property: "importQuery" with value: "selectQuery"
    Then Click on the Get Schema button
    Then Verify the Output Schema matches the Expected Schema: "outputDatatypesSchema3"
    Then Validate "Oracle" plugin properties
    Then Close the Plugin Properties page
    Then Navigate to the properties page of plugin: "Oracle2"
    Then Select dropdown plugin property: "select-jdbcPluginName" with option value: "driverName"
    Then Replace input plugin property: "host" with value: "host" for Credentials and Authorization related fields
    Then Replace input plugin property: "port" with value: "port" for Credentials and Authorization related fields
    Then Replace input plugin property: "user" with value: "username" for Credentials and Authorization related fields
    Then Replace input plugin property: "password" with value: "password" for Credentials and Authorization related fields
    Then Click on the Macro button of Property: "database" and set the value to: "oracleDatabaseName"
    Then Click on the Macro button of Property: "tableName" and set the value to: "oracleTableName"
    Then Click on the Macro button of Property: "dbSchemaName" and set the value to: "oracleSchemaName"
    Then Enter input plugin property: "referenceName" with value: "targetRef"
    Then Select radio button plugin property: "connectionType" with value: "service"
    Then Select radio button plugin property: "role" with value: "sysdba"
    Then Validate "Oracle2" plugin properties
    Then Close the Plugin Properties page
    Then Save the pipeline
    Then Preview and run the pipeline
    Then Enter runtime argument value "invalidDatabaseName" for key "oracleDatabaseName"
    Then Enter runtime argument value "oracleInvalidTable" for key "oracleTableName"
    Then Enter runtime argument value "schema" for key "oracleSchemaName"
    Then Run the preview of pipeline with runtime arguments
    Then Verify the preview of pipeline is "Failed"
