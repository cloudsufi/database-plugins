@CloudMySql
Feature: CloudMySql sink- Verify CloudMySql sink plugin design time scenarios

  Scenario: To verify CloudMySql sink plugin validation with mandatory properties
    Given Open Datafusion Project to configure pipeline
    When Expand Plugin group in the LHS plugins list: "Sink"
    When Select plugin: "CloudSQL MySQL" from the plugins list as: "Sink"
    Then Navigate to the properties page of plugin: "CloudSQL MySQL"
    Then Select dropdown plugin property: "select-jdbcPluginName" with option value: "cloudsql-mysql"
    Then Select radio button plugin property: "instanceType" with value: "public"
    Then Enter input plugin property: "connectionName" with value: "cdf-athena:us-central1:sql-automation-test-instance"
    Then Enter input plugin property: "referenceName" with value: "RefName"
    Then Enter input plugin property: "database" with value: "TestDatabase"
    Then Enter input plugin property: "tableName" with value: "mytable"
    Then Validate "CloudSQL MySQL" plugin properties
    Then Close the Plugin Properties page

  Scenario: To verify CloudMySql sink plugin validation with connection and basic details for connectivity
    Given Open Datafusion Project to configure pipeline
    When Expand Plugin group in the LHS plugins list: "Sink"
    When Select plugin: "CloudSQL MySQL" from the plugins list as: "Sink"
    Then Navigate to the properties page of plugin: "CloudSQL MySQL"
    Then Select dropdown plugin property: "select-jdbcPluginName" with option value: "cloudsql-mysql"
    Then Select radio button plugin property: "instanceType" with value: "public"
    Then Enter input plugin property: "connectionName" with value: "cdf-athena:us-central1:sql-automation-test-instance"
    Then Replace input plugin property: "user" with value: "username" for Credentials and Authorization related fields
    Then Replace input plugin property: "password" with value: "password" for Credentials and Authorization related fields
    Then Enter key value pairs for plugin property: "connectionArguments" with values from json: "connectionArgumentsList"
    Then Enter input plugin property: "referenceName" with value: "RefName"
    Then Enter input plugin property: "database" with value: "TestDatabase"
    Then Enter input plugin property: "tableName" with value: "mytable"
    Then Validate "CloudSQL MySQL" plugin properties
    Then Close the Plugin Properties page



