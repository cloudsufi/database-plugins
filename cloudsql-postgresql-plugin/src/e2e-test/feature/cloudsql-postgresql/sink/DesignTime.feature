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
Feature: CLOUDSQL Sink - Design time scenarios

  @CLOUDSQL_SINK @CLOUDSQL_SINK_BASIC
  Scenario: To verify CLOUDSQL sink plugin validation with connection and basic details for connectivity
    Given Open Datafusion Project to configure pipeline
    When Expand Plugin group in the LHS plugins list: "Sink"
    When Select plugin: "CloudSQL PostgreSQL" from the plugins list as: "Sink"
    Then Navigate to the properties page of plugin: "CloudSQL PostgreSQL"
    Then Select dropdown plugin property: "select-jdbcPluginName" with option value: "cloudsql-postgresql"
    Then Select radio button plugin property: "instanceType" with value: "public"
    Then Replace input plugin property: "connectionName" with value: "connectionName"
    Then Replace input plugin property: "user" with value: "user" for Credentials and Authorization related fields
    Then Replace input plugin property: "password" with value: "password" for Credentials and Authorization related fields
    Then Enter input plugin property: "referenceName" with value: "RefName"
    Then Replace input plugin property: "database" with value: "test_automation_db"
    Then Replace input plugin property: "tableName" with value: "tableName"
    Then Replace input plugin property: "dbSchemaName" with value: "dbSchemaName"
    Then Validate "CloudSQL PostgreSQL" plugin properties
    Then Close the Plugin Properties page

    @CLOUDSQL_SINK @CLOUDSQL_CONNECTION_ARGUMENT
    Scenario: To verify CLOUDSQL sink plugin validation with connection argument
      Given Open Datafusion Project to configure pipeline
      When Expand Plugin group in the LHS plugins list: "Sink"
      When Select plugin: "CloudSQL PostgreSQL" from the plugins list as: "Sink"
      Then Navigate to the properties page of plugin: "CloudSQL PostgreSQL"
      Then Select dropdown plugin property: "select-jdbcPluginName" with option value: "cloudsql-postgresql"
      Then Select radio button plugin property: "instanceType" with value: "public"
      Then Replace input plugin property: "connectionName" with value: "connectionName"
      Then Replace input plugin property: "user" with value: "user" for Credentials and Authorization related fields
      Then Replace input plugin property: "password" with value: "password" for Credentials and Authorization related fields
      Then Enter key value pairs for plugin property: "connectionArguments" with values from json: "connectionArgumentsList"
      Then Enter input plugin property: "referenceName" with value: "RefName"
      Then Replace input plugin property: "database" with value: "test_automation_db"
      Then Replace input plugin property: "tableName" with value: "tableName"
      Then Replace input plugin property: "dbSchemaName" with value: "dbSchemaName"
      Then Validate "CloudSQL PostgreSQL" plugin properties
      Then Close the Plugin Properties page

      @CLOUDSQL_SINK @CLOUDSINK_REFERENCE
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
        Then Enter key value pairs for plugin property: "connectionArguments" with values from json: "connectionArgumentsList"
        Then Enter input plugin property: "referenceName" with value: "RefName"
        Then Replace input plugin property: "database" with value: "test_automation_db"
        Then Replace input plugin property: "tableName" with value: "tableName"
        Then Replace input plugin property: "dbSchemaName" with value: "dbSchemaName"
        Then Select dropdown plugin property: "transactionIsolationLevel" with option value: "transactionLevel"
        Then Replace input plugin property: "connectionTimeout" with value: "connectionTimeout"
        Then Validate "CloudSQL PostgreSQL" plugin properties
        Then Close the Plugin Properties page


