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
Feature:  CloudSQL-postgreSQL source - Verify CloudSQL-postgreSQL source plugin design time Macros scenarios

  Scenario: Verify user should be able to validate plugin with macros for Connection section
    Given Open Datafusion Project to configure pipeline
    When Expand Plugin group in the LHS plugins list: "Source"
    When Select plugin: "CloudSQL PostgreSQL" from the plugins list as: "Source"
    Then Navigate to the properties page of plugin: "CloudSQL PostgreSQL"
    Then Click on the Macro button of Property: "jdbcPluginName" and set the value to: "cloudsql-postgresql"
    Then Replace input plugin property: "connectionName" with value: "connectionName"
    Then Click on the Macro button of Property: "user" and set the value to: "user"
    Then Click on the Macro button of Property: "password" and set the value to: "pass"
    Then Click on the Macro button of Property: "connectionArguments" and set the value to: "1,key"
    Then Enter input plugin property: "referenceName" with value: "RefName"
    Then Replace input plugin property: "database" with value: "test_automation_db"
    Then Enter textarea plugin property: "importQuery" with value: "selectQuery"
    Then Validate "CloudSQL PostgreSQL" plugin properties
    Then Close the Plugin Properties page

    Scenario: Verify user should be able to validate plugin with macros for Basic section
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
      Then Replace input plugin property: "database" with value: "test_automation_db"
      Then Click on the Macro button of Property: "importQuery" and set the value in textarea: "Select * from auto.newtable;"
      Then Validate "CloudSQL PostgreSQL" plugin properties
      Then Close the Plugin Properties page