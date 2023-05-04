@CloudMySql
Feature: CloudMySql source- Verify CloudMySql source plugin design time scenarios

  Scenario: To verify CloudMySql source plugin validation with mandatory properties
    Given Open Datafusion Project to configure pipeline
    When Expand Plugin group in the LHS plugins list: "Source"
    When Select plugin: "CloudSQL MySQL" from the plugins list as: "Source"
    Then Navigate to the properties page of plugin: "CloudSQL MySQL"
    Then Select dropdown plugin property: "select-jdbcPluginName" with option value: "cloudsql-mysql"
    Then Click on the Macro button of Property: "user" and set the value to: "username"
    Then Click on the Macro button of Property: "password" and set the value to: "password"
    Then Select radio button plugin property: "instanceType" with value: "public"
    Then Enter input plugin property: "connectionName" with value: "cdf-athena:us-central1:sql-automation-test-instance"
    Then Enter input plugin property: "referenceName" with value: "RefName"
    Then Enter input plugin property: "database" with value: "TestDatabase"
    Then Enter textarea plugin property: "importQuery" with value: "insertQuery"
    Then Click on the Get Schema button
    Then Verify the Output Schema matches the Expected Schema: "outputSchema"
    Then Validate "CloudSQL MySQL" plugin properties
    Then Close the Plugin Properties page

  Scenario: To verify CloudMySql source plugin validation with connection and basic details for connectivity
    Given Open Datafusion Project to configure pipeline
    When Expand Plugin group in the LHS plugins list: "Source"
    When Select plugin: "CloudSQL MySQL" from the plugins list as: "Source"
    Then Navigate to the properties page of plugin: "CloudSQL MySQL"
    Then Select dropdown plugin property: "select-jdbcPluginName" with option value: "cloudsql-mysql"
    Then Select radio button plugin property: "instanceType" with value: "public"
    Then Enter input plugin property: "connectionName" with value: "connection"
    Then Replace input plugin property: "user" with value: "username" for Credentials and Authorization related fields
    Then Replace input plugin property: "password" with value: "password" for Credentials and Authorization related fields
    Then Enter key value pairs for plugin property: "connectionArguments" with values from json: "connectionArgumentsList"
    Then Enter input plugin property: "referenceName" with value: "refName"
    Then Enter input plugin property: "database" with value: "TestDatabase"
    Then Enter textarea plugin property: "importQuery" with value: "selectQuery"
    Then Click on the Get Schema button
    Then Verify the Output Schema matches the Expected Schema: "outputSchema"
    Then Validate "CloudSQL MySQL" plugin properties
    Then Close the Plugin Properties page

  Scenario: To verify CloudMySql source plugin validation setting up connection arguments
    Given Open Datafusion Project to configure pipeline
    When Expand Plugin group in the LHS plugins list: "Source"
    When Select plugin: "CloudSQL MySQL" from the plugins list as: "Source"
    Then Navigate to the properties page of plugin: "CloudSQL MySQL"
    Then Select dropdown plugin property: "select-jdbcPluginName" with option value: "cloudsql-mysql"
    Then Select radio button plugin property: "instanceType" with value: "public"
    Then Enter input plugin property: "connectionName" with value: "connection"
    Then Enter key value pairs for plugin property: "connectionArguments" with values from json: "connectionArgumentsList"
    Then Enter input plugin property: "referenceName" with value: "referencename"
    Then Enter input plugin property: "database" with value: "TestDatabase"
    Then Enter textarea plugin property: "importQuery" with value: "selectQuery"
    Then Click on the Get Schema button
    Then Verify the Output Schema matches the Expected Schema: "outputSchema"
    Then Validate "CloudSQL MySQL" plugin properties
    Then Close the Plugin Properties page