# Copyright © 2023 Cask Data, Inc.
##
## Licensed under the Apache License, Version 2.0 (the "License"); you may not
## use this file except in compliance with the License. You may obtain a copy of
## the License at
##
## http://www.apache.org/licenses/LICENSE-2.0
##
## Unless required by applicable law or agreed to in writing, software
## distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
## WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
## License for the specific language governing permissions and limitations under
# the License..

@CLOUDSQL
Feature:  CloudSQL-postgreSQL source - Verify CloudSQL-postgreSQL source plugin design time validation scenarios

  @CLOUDSQL_SOURCE_TEST @CLOUDSQL_DATABASE
  Scenario: Verify Database field validation error message with invalid test data
    Given Open Datafusion Project to configure pipeline
    When Expand Plugin group in the LHS plugins list: "Source"
    When Select plugin: "CloudSQL PostgreSQL" from the plugins list as: "Source"
    Then Navigate to the properties page of plugin: "CloudSQL PostgreSQL"
    Then Select dropdown plugin property: "select-jdbcPluginName" with option value: "cloudsql-postgresql"
    Then Select radio button plugin property: "instanceType" with value: "public"
    Then Replace input plugin property: "connectionName" with value: "cdf-athena:europe-west1:cloud-postgresql-automation"
    Then Replace input plugin property: "user" with value: "username" for Credentials and Authorization related fields
    Then Enter input plugin property: "password" with value: "password" for Credentials and Authorization related fields
    Then Enter input plugin property: "referenceName" with value: "RefName"
    Then Replace input plugin property: "database" with value: "null"
    Then Enter textarea plugin property: "importQuery" with value: "selectQuery"
    Then Click on the Get Schema button
    Then Verify the Output Schema matches the Expected Schema: "outputSchema"
    Then Validate "CloudSQL PostgreSQL" plugin properties

  @CLOUDSQL_SOURCE_TEST @CLOUDSQL_IMPORTQUERY
  Scenario: Verify ImportQuery Field validation error message with invalid test data
    Given Open Datafusion Project to configure pipeline
    When Expand Plugin group in the LHS plugins list: "Source"
    When Select plugin: "CloudSQL PostgreSQL" from the plugins list as: "Source"
    Then Navigate to the properties page of plugin: "CloudSQL PostgreSQL"
    Then Select dropdown plugin property: "select-jdbcPluginName" with option value: "cloudsql-postgresql"
    Then Select radio button plugin property: "instanceType" with value: "public"
    Then Replace input plugin property: "connectionName" with value: "cdf-athena:europe-west1:cloud-postgresql-automation"
    Then Replace input plugin property: "user" with value: "username" for Credentials and Authorization related fields
    Then Enter input plugin property: "password" with value: "password" for Credentials and Authorization related fields
    Then Enter input plugin property: "referenceName" with value: "RefName"
    Then Replace input plugin property: "database" with value: "databaseName"
    Then Enter textarea plugin property: "importQuery" with value: "wrongImportQuery"
    Then Click on the Get Schema button
    Then Verify the Output Schema matches the Expected Schema: "outputSchema"
    Then Validate "CloudSQL PostgreSQL" plugin properties

  @CLOUDSQL_SOURCE_TEST @CLOUDSQL_REFERENCENAME
  Scenario: Verify Reference Name field validation error message with invalid test data
    Given Open Datafusion Project to configure pipeline
    When Expand Plugin group in the LHS plugins list: "Source"
    When Select plugin: "CloudSQL PostgreSQL" from the plugins list as: "Source"
    Then Navigate to the properties page of plugin: "CloudSQL PostgreSQL"
    Then Select dropdown plugin property: "select-jdbcPluginName" with option value: "cloudsql-postgresql"
    Then Select radio button plugin property: "instanceType" with value: "public"
    Then Replace input plugin property: "connectionName" with value: "cdf-athena:europe-west1:cloud-postgresql-automation"
    Then Replace input plugin property: "user" with value: "username" for Credentials and Authorization related fields
    Then Enter input plugin property: "password" with value: "password" for Credentials and Authorization related fields
    Then Enter input plugin property: "referenceName" with value: "wrongReferenceName"
    Then Replace input plugin property: "database" with value: "databaseName"
    Then Enter textarea plugin property: "importQuery" with value: "rightImportQuery"
    Then Click on the Get Schema button
    Then Verify the Output Schema matches the Expected Schema: "outputSchema"
    Then Validate "CloudSQL PostgreSQL" plugin properties

  @CLOUDSQL_SOURCE_TEST @CLOUDSQL_USERNAME
  Scenario: Verify UserName field validation error message with invalid test data
    Given Open Datafusion Project to configure pipeline
    When Expand Plugin group in the LHS plugins list: "Source"
    When Select plugin: "CloudSQL PostgreSQL" from the plugins list as: "Source"
    Then Navigate to the properties page of plugin: "CloudSQL PostgreSQL"
    Then Select dropdown plugin property: "select-jdbcPluginName" with option value: "cloudsql-postgresql"
    Then Select radio button plugin property: "instanceType" with value: "public"
    Then Replace input plugin property: "connectionName" with value: "cdf-athena:europe-west1:cloud-postgresql-automation"
    Then Replace input plugin property: "user" with value: "wrongUserName" for Credentials and Authorization related fields
    Then Enter input plugin property: "password" with value: "password" for Credentials and Authorization related fields
    Then Enter input plugin property: "referenceName" with value: "RefName"
    Then Replace input plugin property: "database" with value: "databaseName"
    Then Enter textarea plugin property: "importQuery" with value: "rightImportQuery"
    Then Click on the Get Schema button
    Then Verify the Output Schema matches the Expected Schema: "outputSchema"
    Then Validate "CloudSQL PostgreSQL" plugin properties

  @CLOUDSQL_SOURCE_TEST @CLOUDSQL_PASSWORD
  Scenario: Verify Password field validation error message with invalid test data
    Given Open Datafusion Project to configure pipeline
    When Expand Plugin group in the LHS plugins list: "Source"
    When Select plugin: "CloudSQL PostgreSQL" from the plugins list as: "Source"
    Then Navigate to the properties page of plugin: "CloudSQL PostgreSQL"
    Then Select dropdown plugin property: "select-jdbcPluginName" with option value: "cloudsql-postgresql"
    Then Select radio button plugin property: "instanceType" with value: "public"
    Then Replace input plugin property: "connectionName" with value: "cdf-athena:europe-west1:cloud-postgresql-automation"
    Then Replace input plugin property: "user" with value: "username" for Credentials and Authorization related fields
    Then Enter input plugin property: "password" with value: "wrongPassword" for Credentials and Authorization related fields
    Then Enter input plugin property: "referenceName" with value: "RefName"
    Then Replace input plugin property: "database" with value: "databaseName"
    Then Enter textarea plugin property: "importQuery" with value: "rightImportQuery"
    Then Click on the Get Schema button
    Then Verify the Output Schema matches the Expected Schema: "outputSchema"
    Then Validate "CloudSQL PostgreSQL" plugin properties


  @CLOUDSQL_SOURCE_TEST @CLOUDSQL_SIZE
  Scenario: Verify fetch size field validation error message with invalid test data
    Given Open Datafusion Project to configure pipeline
    When Expand Plugin group in the LHS plugins list: "Source"
    When Select plugin: "CloudSQL PostgreSQL" from the plugins list as: "Source"
    Then Navigate to the properties page of plugin: "CloudSQL PostgreSQL"
    Then Select dropdown plugin property: "select-jdbcPluginName" with option value: "cloudsql-postgresql"
    Then Select radio button plugin property: "instanceType" with value: "public"
    Then Replace input plugin property: "connectionName" with value: "cdf-athena:europe-west1:cloud-postgresql-automation"
    Then Replace input plugin property: "user" with value: "username" for Credentials and Authorization related fields
    Then Enter input plugin property: "password" with value: "password" for Credentials and Authorization related fields
    Then Enter input plugin property: "referenceName" with value: "RefName"
    Then Replace input plugin property: "database" with value: "databaseName"
    Then Enter textarea plugin property: "importQuery" with value: "rightImportQuery"
    Then Replace input plugin property: "fetchSize" with value: "zeroValue"
    Then Click on the Get Schema button
    Then Verify the Output Schema matches the Expected Schema: "outputSchema"
    Then Validate "CloudSQL PostgreSQL" plugin properties

  @CLOUDSQL_SOURCE_TEST @CLOUDSQL_SPLIT
  Scenario: To Verify the Split-By field validation error message when number of Split value is changed to zero
    Given Open Datafusion Project to configure pipeline
    When Expand Plugin group in the LHS plugins list: "Source"
    When Select plugin: "CloudSQL PostgreSQL" from the plugins list as: "Source"
    Then Navigate to the properties page of plugin: "CloudSQL PostgreSQL"
    Then Select dropdown plugin property: "select-jdbcPluginName" with option value: "cloudsql-postgresql"
    Then Select radio button plugin property: "instanceType" with value: "public"
    Then Replace input plugin property: "connectionName" with value: "cdf-athena:europe-west1:cloud-postgresql-automation"
    Then Replace input plugin property: "user" with value: "username" for Credentials and Authorization related fields
    Then Enter input plugin property: "password" with value: "password" for Credentials and Authorization related fields
    Then Enter input plugin property: "referenceName" with value: "RefName"
    Then Replace input plugin property: "database" with value: "databaseName"
    Then Enter textarea plugin property: "importQuery" with value: "rightImportQuery"
    Then Replace input plugin property: "fetchSize" with value: "fetchSize"
    Then Replace input plugin property: "numSplits" with value: "invalidSplitNumber"
    Then Click on the Validate button
    Then Verify that the Plugin Property: "numSplits" is displaying an in-line error message: "errorMesagesNumberOfSplit"
    Then Verify that the Plugin Property: "splitBy" is displaying an in-line error message: "errorMessagesSplitColumn"
    Then Verify that the Plugin Property: "boundingQuery" is displaying an in-line error message: "errorMessagesBoundingQuery"
    Then Verify that the Plugin Property: "importQuery" is displaying an in-line error message: "errorMessagesimportQuery"

  @CLOUDSQL_SOURCE_TEST @CLOUDSQL_SPLIT
  Scenario: To Verify the Split-By field validation error message when number of Split value is not a number
    Given Open Datafusion Project to configure pipeline
    When Expand Plugin group in the LHS plugins list: "Source"
    When Select plugin: "CloudSQL PostgreSQL" from the plugins list as: "Source"
    Then Navigate to the properties page of plugin: "CloudSQL PostgreSQL"
    Then Select dropdown plugin property: "select-jdbcPluginName" with option value: "cloudsql-postgresql"
    Then Select radio button plugin property: "instanceType" with value: "public"
    Then Replace input plugin property: "connectionName" with value: "cdf-athena:europe-west1:cloud-postgresql-automation"
    Then Replace input plugin property: "user" with value: "username" for Credentials and Authorization related fields
    Then Enter input plugin property: "password" with value: "password" for Credentials and Authorization related fields
    Then Enter input plugin property: "referenceName" with value: "RefName"
    Then Replace input plugin property: "database" with value: "databaseName"
    Then Enter textarea plugin property: "importQuery" with value: "rightImportQuery"
    Then Replace input plugin property: "fetchSize" with value: "fetchSize"
    Then Replace input plugin property: "numSplits" with value: "invalidSplit"
    Then Click on the Validate button
    Then Verify that the Plugin Property: "numSplits" is displaying an in-line error message: "errorMessageNumberOfSplitWONumber"

  @CLOUDSQL_SOURCE_TEST @CLOUDSQL_BOUNDING_QUERY
  Scenario: Verify the Bounding Query validation error when Split-By and Number of Splits values are not provided
    Given Open Datafusion Project to configure pipeline
    When Expand Plugin group in the LHS plugins list: "Source"
    When Select plugin: "CloudSQL PostgreSQL" from the plugins list as: "Source"
    Then Navigate to the properties page of plugin: "CloudSQL PostgreSQL"
    Then Select dropdown plugin property: "select-jdbcPluginName" with option value: "cloudsql-postgresql"
    Then Select radio button plugin property: "instanceType" with value: "public"
    Then Replace input plugin property: "connectionName" with value: "cdf-athena:europe-west1:cloud-postgresql-automation"
    Then Replace input plugin property: "user" with value: "username" for Credentials and Authorization related fields
    Then Enter input plugin property: "password" with value: "password" for Credentials and Authorization related fields
    Then Enter input plugin property: "referenceName" with value: "RefName"
    Then Replace input plugin property: "database" with value: "databaseName"
    Then Enter textarea plugin property: "importQuery" with value: "rightImportQuery"
    Then Replace input plugin property: "fetchSize" with value: "fetchSize"
    Then Replace input plugin property: "splitBy" with value: "splitBy"
    Then Replace input plugin property: "numSplits" with value: "blankSplit"
    Then Click on the Validate button
    Then Verify that the Plugin Property: "boundingQuery" is displaying an in-line error message: "errorMessagesBoundingQuery"
    Then Verify that the Plugin Property: "numSplits" is displaying an in-line error message: "errorMesagesNumberOfSplit"
    Then Verify that the Plugin Property: "splitBy" is displaying an in-line error message: "errorMessagesSplitColumn"

  @CLOUDSQL_SOURCE_TEST @CLOUDSQL_GETSCHEMA
  Scenario: Verify user is able to click on GetSchema button and schema is retrieved after providing the basic connection property details
    Given Open Datafusion Project to configure pipeline
    When Expand Plugin group in the LHS plugins list: "Source"
    When Select plugin: "CloudSQL PostgreSQL" from the plugins list as: "Source"
    Then Navigate to the properties page of plugin: "CloudSQL PostgreSQL"
    Then Select dropdown plugin property: "select-jdbcPluginName" with option value: "cloudsql-postgresql"
    Then Select radio button plugin property: "instanceType" with value: "public"
    Then Replace input plugin property: "connectionName" with value: "cdf-athena:europe-west1:cloud-postgresql-automation"
    Then Replace input plugin property: "user" with value: "username" for Credentials and Authorization related fields
    Then Enter input plugin property: "password" with value: "password" for Credentials and Authorization related fields
    Then Enter input plugin property: "referenceName" with value: "RefName"
    Then Replace input plugin property: "database" with value: "databaseName"
    Then Enter textarea plugin property: "importQuery" with value: "rightImportQuery"
    Then Click on the Get Schema button





