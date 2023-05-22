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
# the License..

Feature: MySQL Source - Design time scenarios

  @TS-MYSQL-SOURCE-DSGN-01 @MYSQL_SOURCE_TEST
  Scenario: Verify user is able to validate the plugin when configured for basic Section.
    Given Open Datafusion Project to configure pipeline
    When Expand Plugin group in the LHS plugins list: "Source"
    When Select plugin: "MySQL" from the plugins list as: "Source"
    Then Navigate to the properties page of plugin: "MySQL"
    Then Select dropdown plugin property: "select-jdbcPluginName" with option value: "driverName"
    Then Replace input plugin property: "host" with value: "host" for Credentials and Authorization related fields
    Then Replace input plugin property: "port" with value: "port" for Credentials and Authorization related fields
    Then Replace input plugin property: "user" with value: "username" for Credentials and Authorization related fields
    Then Replace input plugin property: "password" with value: "password" for Credentials and Authorization related fields
    Then Enter input plugin property: "referenceName" with value: "sourceRef"
    Then Replace input plugin property: "database" with value: "databaseName"
    Then Enter textarea plugin property: "importQuery" with value: "selectQuery"
    Then Click on the Get Schema button
    Then Verify the Output Schema matches the Expected Schema: "outputSchema"
    Then Validate "MySQL" plugin properties

  @TS-MYSQL-SOURCE-DSGN-02 @MYSQL_SOURCE_TEST @CONNECTION
  Scenario: Verify user is able validate the plugin with connection management functionality
    Given Open Datafusion Project to configure pipeline
    When Expand Plugin group in the LHS plugins list: "Source"
    When Select plugin: "MySQL" from the plugins list as: "Source"
    Then Navigate to the properties page of plugin: "MySQL"
    And Click plugin property: "switch-useConnection"
    And Click on the Browse Connections button
    And Click on the Add Connection button
    And Select Mysql Connection
    And Enter input plugin property: "name" with value: "connection.name"
    Then Enter input plugin property: "referenceName" with value: "sourceRef"
    Then Select dropdown plugin property: "select-jdbcPluginName" with option value: "driverName"
    Then Replace input plugin property: "host" with value: "host" for Credentials and Authorization related fields
    Then Replace input plugin property: "port" with value: "port" for Credentials and Authorization related fields
    Then Replace input plugin property: "user" with value: "username" for Credentials and Authorization related fields
    Then Replace input plugin property: "password" with value: "password" for Credentials and Authorization related fields
    Then Click on the Test Connection button
    And Verify the test connection is successful
    Then  Click on the Create button
    And Use new connection
    Then Enter input plugin property: "referenceName" with value: "sourceRef"
    Then Replace input plugin property: "database" with value: "databaseName"
    Then Enter textarea plugin property: "importQuery" with value: "selectQuery"
    Then Click on the Get Schema button
    Then Verify the Output Schema matches the Expected Schema: "outputSchema"
    Then Validate "MySQL" plugin properties

  @TS-MYSQL-SOURCE-DSGN-03 @MYSQL_SOURCE_TEST
    Scenario: Verify user should be able to validate successfully by setting the advanced section fields
    Given Open Datafusion Project to configure pipeline
    When Expand Plugin group in the LHS plugins list: "Source"
    When Select plugin: "MySQL" from the plugins list as: "Source"
    Then Navigate to the properties page of plugin: "MySQL"
    Then Select dropdown plugin property: "select-jdbcPluginName" with option value: "driverName"
    Then Replace input plugin property: "host" with value: "host" for Credentials and Authorization related fields
    Then Replace input plugin property: "port" with value: "port" for Credentials and Authorization related fields
    Then Replace input plugin property: "user" with value: "username" for Credentials and Authorization related fields
    Then Replace input plugin property: "password" with value: "password" for Credentials and Authorization related fields
    Then Enter input plugin property: "referenceName" with value: "sourceRef"
    Then Replace input plugin property: "database" with value: "databaseName"
    Then Enter textarea plugin property: "importQuery" with value: "selectQuery"
    Then Click plugin property: "useCompression"
    Then Click plugin property: "useAnsiQuotes"
    Then Click plugin property: "autoReconnect"
    Then Click on the Get Schema button
    Then Verify the Output Schema matches the Expected Schema: "outputSchema"
    Then Validate "MySQL" plugin properties
