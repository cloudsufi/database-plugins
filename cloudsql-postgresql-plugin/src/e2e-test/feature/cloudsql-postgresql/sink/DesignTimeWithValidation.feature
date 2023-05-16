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

@CLOUDSQL_SINK @CLOUDSQL_SINK_DATABASE_NAME
Feature: CLOUDSQL Sink - Design time with Validation scenarios

  Scenario: To verify CLOUDSQL sink plugin validation with database name
    Given Open Datafusion Project to configure pipeline
    When Select plugin: "CloudSQL PostgreSQL" from the plugins list as: "Source"
    When Expand Plugin group in the LHS plugins list: "Sink"
    When Select plugin: "CloudSQL PostgreSQL" from the plugins list as: "Sink"
    Then Connect plugins: "CloudSQL PostgreSQL" and "CloudSQL PostgreSQL2" to establish connection
    Then Navigate to the properties page of plugin: "CloudSQL PostgreSQL"
    Then Select dropdown plugin property: "select-jdbcPluginName" with option value: "cloudsql-postgresql"
    Then Select radio button plugin property: "instanceType" with value: "public"
    Then Replace input plugin property: "connectionName" with value: "cdf-athena:europe-west1:cloud-postgresql-automation"
    Then Replace input plugin property: "user" with value: "username" for Credentials and Authorization related fields
    Then Enter input plugin property: "password" with value: "password" for Credentials and Authorization related fields
    Then Enter input plugin property: "referenceName" with value: "RefName"
    Then Replace input plugin property: "database" with value: "test_automation_db"
    Then Enter textarea plugin property: "importQuery" with value: "selectQuery"
    Then Click on the Get Schema button
    Then Verify the Output Schema matches the Expected Schema: "outputSchema"
    Then Validate "CloudSQL PostgreSQL" plugin properties
    Then Close the Plugin Properties page
    Then Navigate to the properties page of plugin: "CloudSQL PostgreSQL2"
    Then Select dropdown plugin property: "select-jdbcPluginName" with option value: "cloudsql-postgresql"
    Then Select radio button plugin property: "instanceType" with value: "public"
    Then Replace input plugin property: "connectionName" with value: "cdf-athena:europe-west1:cloud-postgresql-automation"
    Then Replace input plugin property: "user" with value: "user" for Credentials and Authorization related fields
    Then Replace input plugin property: "password" with value: "password" for Credentials and Authorization related fields
    Then Enter input plugin property: "referenceName" with value: "RefName"
    Then Replace input plugin property: "tableName" with value: "tableName"
    Then Replace input plugin property: "dbSchemaName" with value: "dbSchemaName"
    Then Replace input plugin property: "database" with value: "invalidDatabase"
    Then Click on the Validate button
    Then Verify that the Plugin is displaying an error message: "invalidMessageDatabaseName" on the header

  @CLOUDSQL_SINK @CLOUDSQL_SINK_CONNECTION_NAME
  Scenario: To verify CLOUDSQL sink plugin validation with connection name
    Given Open Datafusion Project to configure pipeline
    When Select plugin: "CloudSQL PostgreSQL" from the plugins list as: "Source"
    When Expand Plugin group in the LHS plugins list: "Sink"
    When Select plugin: "CloudSQL PostgreSQL" from the plugins list as: "Sink"
    Then Connect plugins: "CloudSQL PostgreSQL" and "CloudSQL PostgreSQL2" to establish connection
    Then Navigate to the properties page of plugin: "CloudSQL PostgreSQL"
    Then Select dropdown plugin property: "select-jdbcPluginName" with option value: "cloudsql-postgresql"
    Then Select radio button plugin property: "instanceType" with value: "public"
    Then Replace input plugin property: "connectionName" with value: "cdf-athena:europe-west1:cloud-postgresql-automation"
    Then Replace input plugin property: "user" with value: "username" for Credentials and Authorization related fields
    Then Enter input plugin property: "password" with value: "password" for Credentials and Authorization related fields
    Then Enter input plugin property: "referenceName" with value: "RefName"
    Then Replace input plugin property: "database" with value: "test_automation_db"
    Then Enter textarea plugin property: "importQuery" with value: "selectQuery"
    Then Click on the Get Schema button
    Then Verify the Output Schema matches the Expected Schema: "outputSchema"
    Then Validate "CloudSQL PostgreSQL" plugin properties
    Then Close the Plugin Properties page
    Then Navigate to the properties page of plugin: "CloudSQL PostgreSQL2"
    Then Select dropdown plugin property: "select-jdbcPluginName" with option value: "cloudsql-postgresql"
    Then Select radio button plugin property: "instanceType" with value: "public"
    Then Replace input plugin property: "connectionName" with value: "invalidConnectionName"
    Then Replace input plugin property: "user" with value: "user" for Credentials and Authorization related fields
    Then Replace input plugin property: "password" with value: "password" for Credentials and Authorization related fields
    Then Enter input plugin property: "referenceName" with value: "RefName"
    Then Replace input plugin property: "database" with value: "test_automation_db"
    Then Replace input plugin property: "tableName" with value: "tableName"
    Then Replace input plugin property: "dbSchemaName" with value: "dbSchemaName"
    Then Click on the Validate button
    Then Verify that the Plugin Property: "connectionName" is displaying an in-line error message: "invalidMessageConnectionName"

  @CLOUDSQL_SINK @CLOUDSQL_SINK_TABLE_NAME_FIELD
  Scenario: To verify CLOUDSQL sink plugin validation with table name field
    Given Open Datafusion Project to configure pipeline
    When Select plugin: "CloudSQL PostgreSQL" from the plugins list as: "Source"
    When Expand Plugin group in the LHS plugins list: "Sink"
    When Select plugin: "CloudSQL PostgreSQL" from the plugins list as: "Sink"
    Then Connect plugins: "CloudSQL PostgreSQL" and "CloudSQL PostgreSQL2" to establish connection
    Then Navigate to the properties page of plugin: "CloudSQL PostgreSQL"
    Then Select dropdown plugin property: "select-jdbcPluginName" with option value: "cloudsql-postgresql"
    Then Select radio button plugin property: "instanceType" with value: "public"
    Then Replace input plugin property: "connectionName" with value: "cdf-athena:europe-west1:cloud-postgresql-automation"
    Then Replace input plugin property: "user" with value: "username" for Credentials and Authorization related fields
    Then Enter input plugin property: "password" with value: "password" for Credentials and Authorization related fields
    Then Enter input plugin property: "referenceName" with value: "RefName"
    Then Replace input plugin property: "database" with value: "test_automation_db"
    Then Enter textarea plugin property: "importQuery" with value: "selectQuery"
    Then Click on the Get Schema button
    Then Verify the Output Schema matches the Expected Schema: "outputSchema"
    Then Validate "CloudSQL PostgreSQL" plugin properties
    Then Close the Plugin Properties page
    Then Navigate to the properties page of plugin: "CloudSQL PostgreSQL2"
    Then Select dropdown plugin property: "select-jdbcPluginName" with option value: "cloudsql-postgresql"
    Then Select radio button plugin property: "instanceType" with value: "public"
    Then Replace input plugin property: "connectionName" with value: "cdf-athena:europe-west1:cloud-postgresql-automation"
    Then Replace input plugin property: "user" with value: "user" for Credentials and Authorization related fields
    Then Replace input plugin property: "password" with value: "password" for Credentials and Authorization related fields
    Then Enter input plugin property: "referenceName" with value: "RefName"
    Then Replace input plugin property: "database" with value: "test_automation_db"
    Then Replace input plugin property: "tableName" with value: "invalidTableName"
    Then Replace input plugin property: "dbSchemaName" with value: "dbSchemaName"
    Then Click on the Validate button
    Then Verify that the Plugin is displaying an error message: "invalidMessageTableNameField" on the header

  @CLOUDSQL_SINK @CLOUDSQL_SINK_REFERENCE_NAME
  Scenario: To verify CLOUDSQL sink plugin validation with Advanced details for connectivity
    Given Open Datafusion Project to configure pipeline
    When Expand Plugin group in the LHS plugins list: "Sink"
    When Select plugin: "CloudSQL PostgreSQL" from the plugins list as: "Sink"
    Then Navigate to the properties page of plugin: "CloudSQL PostgreSQL"
    Then Select dropdown plugin property: "select-jdbcPluginName" with option value: "cloudsql-postgresql"
    Then Select radio button plugin property: "instanceType" with value: "public"
    Then Replace input plugin property: "connectionName" with value: "connectionName"
    Then Replace input plugin property: "user" with value: "user" for Credentials and Authorization related fields
    Then Replace input plugin property: "password" with value: "password" for Credentials and Authorization related fields
    Then Replace input plugin property: "database" with value: "test_automation_db"
    Then Replace input plugin property: "tableName" with value: "validTableName"
    Then Enter input plugin property: "referenceName" with value: "wrongReferenceName"
    Then Click on the Validate button
    Then Verify that the Plugin Property: "referenceName" is displaying an in-line error message: "invalidReferenceName"

  @@CLOUDSQL_SINK @CLOUDSQL_SINK_USERNAME
  Scenario: To verify CLOUDSQL sink plugin validation with username
    Given Open Datafusion Project to configure pipeline
    When Select plugin: "CloudSQL PostgreSQL" from the plugins list as: "Source"
    When Expand Plugin group in the LHS plugins list: "Sink"
    When Select plugin: "CloudSQL PostgreSQL" from the plugins list as: "Sink"
    Then Connect plugins: "CloudSQL PostgreSQL" and "CloudSQL PostgreSQL2" to establish connection
    Then Navigate to the properties page of plugin: "CloudSQL PostgreSQL"
    Then Select dropdown plugin property: "select-jdbcPluginName" with option value: "cloudsql-postgresql"
    Then Select radio button plugin property: "instanceType" with value: "public"
    Then Replace input plugin property: "connectionName" with value: "cdf-athena:europe-west1:cloud-postgresql-automation"
    Then Replace input plugin property: "user" with value: "username" for Credentials and Authorization related fields
    Then Enter input plugin property: "password" with value: "password" for Credentials and Authorization related fields
    Then Enter input plugin property: "referenceName" with value: "RefName"
    Then Replace input plugin property: "database" with value: "test_automation_db"
    Then Enter textarea plugin property: "importQuery" with value: "selectQuery"
    Then Click on the Get Schema button
    Then Verify the Output Schema matches the Expected Schema: "outputSchema"
    Then Validate "CloudSQL PostgreSQL" plugin properties
    Then Close the Plugin Properties page
    Then Navigate to the properties page of plugin: "CloudSQL PostgreSQL2"
    Then Select dropdown plugin property: "select-jdbcPluginName" with option value: "cloudsql-postgresql"
    Then Select radio button plugin property: "instanceType" with value: "public"
    Then Replace input plugin property: "connectionName" with value: "cdf-athena:europe-west1:cloud-postgresql-automation"
    Then Replace input plugin property: "user" with value: "invalidUSERNAME" for Credentials and Authorization related fields
    Then Replace input plugin property: "password" with value: "password" for Credentials and Authorization related fields
    Then Enter input plugin property: "referenceName" with value: "RefName"
    Then Replace input plugin property: "database" with value: "test_automation_db"
    Then Replace input plugin property: "tableName" with value: "tableName"
    Then Replace input plugin property: "dbSchemaName" with value: "dbSchemaName"
    Then Click on the Validate button
    Then Verify that the Plugin is displaying an error message: "invalidUSERNAME" on the header

  @CLOUDSQL_SINK @CLOUDSQL_SINK_BASIC
  Scenario: To verify CLOUDSQL sink plugin validation with connection and basic details for connectivity
    Given Open Datafusion Project to configure pipeline
    When Select plugin: "CloudSQL PostgreSQL" from the plugins list as: "Source"
    When Expand Plugin group in the LHS plugins list: "Sink"
    When Select plugin: "CloudSQL PostgreSQL" from the plugins list as: "Sink"
    Then Connect plugins: "CloudSQL PostgreSQL" and "CloudSQL PostgreSQL2" to establish connection
    Then Navigate to the properties page of plugin: "CloudSQL PostgreSQL"
    Then Select dropdown plugin property: "select-jdbcPluginName" with option value: "cloudsql-postgresql"
    Then Select radio button plugin property: "instanceType" with value: "public"
    Then Replace input plugin property: "connectionName" with value: "cdf-athena:europe-west1:cloud-postgresql-automation"
    Then Replace input plugin property: "user" with value: "username" for Credentials and Authorization related fields
    Then Enter input plugin property: "password" with value: "password" for Credentials and Authorization related fields
    Then Enter input plugin property: "referenceName" with value: "RefName"
    Then Replace input plugin property: "database" with value: "test_automation_db"
    Then Enter textarea plugin property: "importQuery" with value: "selectQuery"
    Then Click on the Get Schema button
    Then Verify the Output Schema matches the Expected Schema: "outputSchema"
    Then Validate "CloudSQL PostgreSQL" plugin properties
    Then Close the Plugin Properties page
    Then Navigate to the properties page of plugin: "CloudSQL PostgreSQL2"
    Then Select dropdown plugin property: "select-jdbcPluginName" with option value: "cloudsql-postgresql"
    Then Select radio button plugin property: "instanceType" with value: "public"
    Then Replace input plugin property: "connectionName" with value: "connectionName"
    Then Replace input plugin property: "user" with value: "username" for Credentials and Authorization related fields
    Then Replace input plugin property: "password" with value: "password" for Credentials and Authorization related fields
    Then Enter input plugin property: "referenceName" with value: "RefName"
    Then Replace input plugin property: "database" with value: "test_automation_db"
    Then Replace input plugin property: "tableName" with value: "tableName"
    Then Replace input plugin property: "dbSchemaName" with value: "dbSchemaName"
    Then Validate "CloudSQL PostgreSQL" plugin properties
    Then Close the Plugin Properties page