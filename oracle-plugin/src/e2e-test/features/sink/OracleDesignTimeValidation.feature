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
Feature: Oracle sink- Verify Oracle sink plugin design time validation scenarios

  @ORACLE_SOURCE_TEST
  Scenario: To verify Oracle sink plugin validation error message with invalid reference test data
    Given Open Datafusion Project to configure pipeline
    When Expand Plugin group in the LHS plugins list: "Sink"
    When Select plugin: "Oracle" from the plugins list as: "Sink"
    Then Navigate to the properties page of plugin: "Oracle"
    Then Select dropdown plugin property: "select-jdbcPluginName" with option value: "driverName"
    Then Replace input plugin property: "host" with value: "host" for Credentials and Authorization related fields
    Then Replace input plugin property: "port" with value: "port" for Credentials and Authorization related fields
    Then Replace input plugin property: "user" with value: "username" for Credentials and Authorization related fields
    Then Replace input plugin property: "password" with value: "password" for Credentials and Authorization related fields
    Then Select radio button plugin property: "connectionType" with value: "service"
    Then Select radio button plugin property: "role" with value: "sysdba"
    Then Enter input plugin property: "referenceName" with value: "invalidRef"
    Then Replace input plugin property: "database" with value: "databaseName"
    Then Replace input plugin property: "tableName" with value: "targetTable"
    Then Click on the Validate button
    Then Verify Oracle plugin in-line error message for incorrect Reference Name: "oracleInvalidReference"

  @ORACLE_SOURCE_TEST
  Scenario: To verify Oracle sink plugin validation error message with invalid database
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
    Then Select dropdown plugin property: "select-jdbcPluginName" with option value: "driverName"
    Then Replace input plugin property: "host" with value: "host" for Credentials and Authorization related fields
    Then Replace input plugin property: "port" with value: "port" for Credentials and Authorization related fields
    Then Replace input plugin property: "user" with value: "username" for Credentials and Authorization related fields
    Then Replace input plugin property: "password" with value: "password" for Credentials and Authorization related fields
    Then Select radio button plugin property: "connectionType" with value: "service"
    Then Replace input plugin property: "database" with value: "invalidDatabase"
    Then Replace input plugin property: "tableName" with value: "oracleInvalidTable"
    Then Select radio button plugin property: "role" with value: "sysdba"
    Then Enter input plugin property: "referenceName" with value: "sourceRef"
    Then Click on the Validate button
    Then Verify that the Plugin is displaying an error message: "errorMessageInvalidSinkDatabase" on the header

  @ORACLE_SOURCE_TEST
  Scenario: To verify Oracle sink plugin validation error message with invalid table name
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
    Then Select dropdown plugin property: "select-jdbcPluginName" with option value: "driverName"
    Then Replace input plugin property: "host" with value: "host" for Credentials and Authorization related fields
    Then Replace input plugin property: "port" with value: "port" for Credentials and Authorization related fields
    Then Replace input plugin property: "user" with value: "username" for Credentials and Authorization related fields
    Then Replace input plugin property: "password" with value: "password" for Credentials and Authorization related fields
    Then Select radio button plugin property: "connectionType" with value: "service"
    Then Select radio button plugin property: "role" with value: "sysdba"
    Then Enter input plugin property: "referenceName" with value: "sourceRef"
    Then Replace input plugin property: "database" with value: "databaseName"
    Then Replace input plugin property: "tableName" with value: "invalidTable"
    Then Click on the Validate button
    Then Verify Oracle plugin in-line error message for incorrect Table Name: "oracleInvalidTable"

  Scenario: To verify Oracle sink plugin validation error message with blank username
    Given Open Datafusion Project to configure pipeline
    When Expand Plugin group in the LHS plugins list: "Sink"
    When Select plugin: "Oracle" from the plugins list as: "Sink"
    Then Navigate to the properties page of plugin: "Oracle"
    Then Select dropdown plugin property: "select-jdbcPluginName" with option value: "driverName"
    Then Replace input plugin property: "host" with value: "host" for Credentials and Authorization related fields
    Then Replace input plugin property: "port" with value: "port" for Credentials and Authorization related fields
    Then Replace input plugin property: "password" with value: "password" for Credentials and Authorization related fields
    Then Select radio button plugin property: "connectionType" with value: "service"
    Then Select radio button plugin property: "role" with value: "sysdba"
    Then Enter input plugin property: "referenceName" with value: "sourceRef"
    Then Replace input plugin property: "database" with value: "databaseName"
    Then Replace input plugin property: "tableName" with value: "targetTable"
    Then Click on the Validate button
    Then Verify that the Plugin Property: "user" is displaying an in-line error message: "errorMessageBlankUsername"
