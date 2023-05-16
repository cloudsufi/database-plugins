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
Feature: CLOUDSQL Sink - Design time with Macros

  @CLOUDSQL_SINK @CLOUDSQL_SINK_BASIC
  Scenario: To verify CLOUDSQL sink plugin validation with basic details for connectivity
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
#    Then Replace input plugin property: "user" with value: "username" for Credentials and Authorization related fields
#    Then Replace input plugin property: "password" with value: "password" for Credentials and Authorization related fields
    Then Enter input plugin property: "referenceName" with value: "RefName"
    Then Replace input plugin property: "database" with value: "test_automation_db"
    Then Click on the Macro button of Property: "tableName" and set the value to: "newtable"
    Then Click on the Macro button of Property: "dbSchemaName" and set the value to: "schema"
    Then Validate "CloudSQL PostgreSQL2" plugin properties

  @CLOUDSQL_SINK @CLOUDSQL_SINK_CONNECTION
  Scenario: To verify CLOUDSQL sink plugin validation with connection details for connectivity
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
    Then Click on the Macro button of Property: "select-jdbcPluginName" and set the value in textarea: "abcd"
    Then Select radio button plugin property: "instanceType" with value: "public"
    Then Replace input plugin property: "connectionName" with value: "cdf-athena:europe-west1:cloud-postgresql-automation"
    Then Click on the Macro button of Property: "user" and set the value to: "user"
    Then Click on the Macro button of Property: "password" and set the value to: "password"
    Then Click on the Macro button of Property: "connectionArguments" and set the value to: "1,key"
    Then Enter input plugin property: "referenceName" with value: "RefName"
    Then Replace input plugin property: "database" with value: "test_automation_db"
    Then Replace input plugin property: "tableName" with value: "tableName"
    Then Replace input plugin property: "dbSchemaName" with value: "dbSchemaName"
    Then Validate "CloudSQL PostgreSQL2" plugin properties