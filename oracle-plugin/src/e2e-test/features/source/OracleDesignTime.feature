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
Feature: Oracle source- Verify Oracle source plugin design time scenarios
  @Oracle_Required
  Scenario: To verify Oracle source plugin validation errors for mandatory fields
    Given Open Datafusion Project to configure pipeline
    When Expand Plugin group in the LHS plugins list: "Source"
    When Select plugin: "Oracle" from the plugins list as: "Source"
    Then Navigate to the properties page of plugin: "Oracle"
    Then Click on the Validate button
    Then Verify mandatory property error for below listed properties:
      | jdbcPluginName |
      | database       |
      | referenceName  |
      | importQuery    |

  @ORACLE_SOURCE_TEST @Oracle_Required
  Scenario: To verify Oracle source plugin validation with connection and basic details for connectivity
    Given Open Datafusion Project to configure pipeline
    When Expand Plugin group in the LHS plugins list: "Source"
    When Select plugin: "Oracle" from the plugins list as: "Source"
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

  @Oracle_Required
  Scenario: To verify Oracle source plugin validation with connection arguments
    Given Open Datafusion Project to configure pipeline
    When Expand Plugin group in the LHS plugins list: "Source"
    When Select plugin: "Oracle" from the plugins list as: "Source"
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
    Then Enter Oracle plugin with connection arguments "connectionArgumentsList"
    Then Enter textarea plugin property: "importQuery" with value: "selectQuery"
    Then Click on the Get Schema button
    Then Verify the Output Schema matches the Expected Schema: "outputSchema"
    Then Validate "Oracle" plugin properties
    Then Close the Plugin Properties page

  @Oracle_Required
  Scenario: To verify Oracle source plugin validation with advanced details
    Given Open Datafusion Project to configure pipeline
    When Expand Plugin group in the LHS plugins list: "Source"
    When Select plugin: "Oracle" from the plugins list as: "Source"
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
    Then Replace input plugin property: "defaultBatchValue" with value: "batchValue"
    Then Replace input plugin property: "defaultRowPrefetch" with value: "rowPrefetch"
    Then Click on the Get Schema button
    Then Verify the Output Schema matches the Expected Schema: "outputSchema"
    Then Validate "Oracle" plugin properties
    Then Close the Plugin Properties page
