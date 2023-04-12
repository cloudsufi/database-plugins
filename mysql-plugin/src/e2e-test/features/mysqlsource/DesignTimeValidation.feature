# Copyright © 2022 Cask Data, Inc.
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
# the License

Feature: MySQL Source - Design time validation scenarios

  @TS-MYSQL-SOURCE-DSGN-ERROR-01
  Scenario: Verify UserName field validation error message with invalid test data
    Given Open Datafusion Project to configure pipeline
    When Expand Plugin group in the LHS plugins list: "Source"
    When Select plugin: "MySQL" from the plugins list as: "Source"
    Then Navigate to the properties page of plugin: "MySQL"
    Then Select dropdown plugin property: "select-jdbcPluginName" with option value: "driverName"
    Then Replace input plugin property: "host" with value: "host" for Credentials and Authorization related fields
    Then Replace input plugin property: "port" with value: "port" for Credentials and Authorization related fields
    Then Replace input plugin property: "user" with value: "username" for Credentials and Authorization related fields
    Then Replace input plugin property: "user" with value: "invalid.username" for Credentials and Authorization related fields
    Then Replace input plugin property: "password" with value: "password" for Credentials and Authorization related fields
    Then Enter input plugin property: "referenceName" with value: "sourceRef"
    Then Replace input plugin property: "database" with value: "databaseName"
    Then Enter textarea plugin property: "importQuery" with value: "selectQuery"
    Then Validate "MySQL" plugin properties
    Then Verify that the Plugin is displaying an error message: "invalid.username.message" on the header

  @TS-MYSQL-SOURCE-DSGN-ERROR-02
  Scenario: Verify Password field validation error message with invalid test data
    Given Open Datafusion Project to configure pipeline
    When Expand Plugin group in the LHS plugins list: "Source"
    When Select plugin: "MySQL" from the plugins list as: "Source"
    Then Navigate to the properties page of plugin: "MySQL"
    Then Select dropdown plugin property: "select-jdbcPluginName" with option value: "driverName"
    Then Replace input plugin property: "host" with value: "host" for Credentials and Authorization related fields
    Then Replace input plugin property: "port" with value: "port" for Credentials and Authorization related fields
    Then Replace input plugin property: "user" with value: "username" for Credentials and Authorization related fields
    Then Replace input plugin property: "password" with value: "invalid.password" for Credentials and Authorization related fields
    Then Replace input plugin property: "database" with value: "databaseName"
    Then Enter textarea plugin property: "importQuery" with value: "selectQuery"
    Then Validate "MySQL" plugin properties
    Then Verify that the Plugin is displaying an error message: "invalid.password.message" on the header

  @TS-MYSQL-SOURCE-DSGN-ERROR-03
  Scenario: Verify Database field validation error message with invalid test data
    Given Open Datafusion Project to configure pipeline
    When Expand Plugin group in the LHS plugins list: "Source"
    Then Navigate to the properties page of plugin: "MySQL"
    Then Select dropdown plugin property: "select-jdbcPluginName" with option value: "driverName"
    Then Replace input plugin property: "host" with value: "host" for Credentials and Authorization related fields
    Then Replace input plugin property: "port" with value: "port" for Credentials and Authorization related fields
    Then Replace input plugin property: "user" with value: "username" for Credentials and Authorization related fields
    Then Replace input plugin property: "password" with value: "password" for Credentials and Authorization related fields
    Then Enter input plugin property: "referenceName" with value: "sourceRef"
    Then Replace input plugin property: "database" with value: "invalid.database"
    Then Enter textarea plugin property: "importQuery" with value: "selectQuery"
    Then Validate "MySQL" plugin properties
    Then Verify that the Plugin is displaying an error message: "invalid.databasename.message" on the header

  @TS-MYSQL-SOURCE-DSGN-ERROR-04
  Scenario: Verify ImportQuery Field validation error message with invalid test data
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
    Then Enter textarea plugin property: "importQuery" with value: "invalid.query"
    Then Validate "MySQL" plugin properties
    Then Verify that the Plugin is displaying an error message: "invalid.query.message" on the header

  @TS-MYSQL-SOURCE-DSGN-ERROR-05
  Scenario: Verify the Number of Splits to generate field validation error message with invalid test data
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
    Then Replace input plugin property: "numSplits" with value: "numberofsplits"
    Then Validate "MySQL" plugin properties
    Then Verify that the Plugin Property: "numSplits" is displaying an in-line error message: "numberofsplits.error.message"

  @TS-MYSQL-SOURCE-DSGN-ERROR-06
  Scenario: Verify the Bounding Query validation error when Split-By and Number of Splits values are not provided
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
    Then Replace input plugin property: "numSplits" with value: "numberofsplitsgenerate"
    Then Validate "MySQL" plugin properties
    Then Verify that the Plugin Property: "boundingQuery" is displaying an in-line error message: "boundingQuery.error.message"

  @TS-MYSQL-SOURCE-DSGN-ERROR-07
  Scenario: Verify the Split-By field validation error message with invalid test data
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
    Then Replace input plugin property: "numSplits" with value: "numbersplitsgenerate"
    Then Validate "MySQL" plugin properties
    Then Verify that the Plugin Property: "Split-By Field Name" is displaying an in-line error message: "splitfield.error.message"

  @TS-MYSQL-SOURCE-DSGN-ERROR-08
  Scenario: Verify required fields missing validation messages
    Given Open Datafusion Project to configure pipeline
    When Expand Plugin group in the LHS plugins list: "Source"
    When Select plugin: "MySQL" from the plugins list as: "Source"
    Then Navigate to the properties page of plugin: "MySQL"
    Then Validate "MySQL" plugin properties
    Then Verify mandatory property error for below listed properties:
      | jdbcPluginName |
      | referenceName  |
      | database       |
      | importQuery    |
