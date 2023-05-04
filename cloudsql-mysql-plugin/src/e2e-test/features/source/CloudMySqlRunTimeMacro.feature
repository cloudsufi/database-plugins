Feature: CloudMySql - Verify CloudMySql plugin data transfer with macro arguments

  @ORACLE_SOURCE_TEST @ORACLE_SINK_TEST
  Scenario: To verify data is getting transferred from CloudMySql to CloudMySql successfully using macro arguments in connection section
    Given Open Datafusion Project to configure pipeline
    When Expand Plugin group in the LHS plugins list: "Source"
    When Select plugin: "CloudSQL MySQL" from the plugins list as: "Source"
    When Expand Plugin group in the LHS plugins list: "Sink"
    When Select plugin: "CloudSQL MySQL" from the plugins list as: "Sink"
    Then Connect plugins: "CloudSQL MySQL" and "CloudSQL MySQL2" to establish connection
    Then Navigate to the properties page of plugin: "CloudSQL MySQL"
    Then Click on the Macro button of Property: "jdbcPluginName" and set the value to: "cloudsql-mysql"
    Then Select radio button plugin property: "instanceType" with value: "public"
    Then Enter input plugin property: "connectionName" with value: "cdf-athena:us-central1:sql-automation-test-instance"
    Then Click on the Macro button of Property: "user" and set the value to: "username"
    Then Click on the Macro button of Property: "password" and set the value to: "password"
    Then Enter input plugin property: "referenceName" with value: "RefName"
    Then Replace input plugin property: "database" with value: "databaseName"
    Then Click on the Macro button of Property: "importQuery" and set the value in textarea: "CloudMySqlImportQuery"
#    Then Validate "CloudSQL MySQL" plugin properties
    Then Close the Plugin Properties page
    Then Navigate to the properties page of plugin: "CloudSQL MySQL2"
    Then Click on the Macro button of Property: "jdbcPluginName" and set the value to: "cloudsql-mysql"
    Then Select radio button plugin property: "instanceType" with value: "public"
    Then Enter input plugin property: "connectionName" with value: "cdf-athena:us-central1:sql-automation-test-instance"
    Then Click on the Macro button of Property: "user" and set the value to: "username"
    Then Click on the Macro button of Property: "password" and set the value to: "password"
    Then Enter input plugin property: "referenceName" with value: "RefName"
    Then Replace input plugin property: "database" with value: "databaseName"
    Then Enter input plugin property: "tableName" with value: "mytable"
#    Then Validate "CloudSQL MySQL2" plugin properties
    Then Close the Plugin Properties page
    Then Save the pipeline
    Then Preview and run the pipeline
    Then Enter runtime argument value "driver" for key "cloudsql-mysql"
    Then Enter runtime argument value from environment variable "name" for key "username"
    Then Enter runtime argument value from environment variable "pass" for key "password"
    Then Run the preview of pipeline with runtime arguments
    Then Wait till pipeline preview is in running state
    Then Open and capture pipeline preview logs
#    Then Verify the preview run status of pipeline in the logs is "succeeded"
#    Then Close the pipeline logs
#    Then Close the preview
#    Then Deploy the pipeline
#    Then Run the Pipeline in Runtime
#    Then Enter runtime argument value "driver" for key "cloudsql-mysql"
#    Then Enter runtime argument value from environment variable "name" for key "username"
#    Then Enter runtime argument value from environment variable "pass" for key "password"
#    Then Run the Pipeline in Runtime with runtime arguments
#    Then Wait till pipeline is in running state
#    Then Open and capture logs
#    Then Verify the pipeline status is "Succeeded"
#    Then Close the pipeline logs
#    Then Validate the values of records transferred to target table is equal to the values from source table

  Scenario: To verify data is getting transferred from CloudMySql to CloudMySql successfully using macro arguments in basic section
    Given Open Datafusion Project to configure pipeline
    When Expand Plugin group in the LHS plugins list: "Source"
    When Select plugin: "CloudSQL MySQL" from the plugins list as: "Source"
    When Expand Plugin group in the LHS plugins list: "Sink"
    When Select plugin: "CloudSQL MySQL" from the plugins list as: "Sink"
    Then Connect plugins: "CloudSQL MySQL" and "CloudSQL MySQL2" to establish connection
    Then Navigate to the properties page of plugin: "CloudSQL MySQL"
    Then Select dropdown plugin property: "select-jdbcPluginName" with option value: "cloudsql-mysql"
    Then Select radio button plugin property: "instanceType" with value: "public"
    Then Enter input plugin property: "connectionName" with value: "cdf-athena:us-central1:sql-automation-test-instance"
    Then Replace input plugin property: "user" with value: "username" for Credentials and Authorization related fields
    Then Replace input plugin property: "password" with value: "password" for Credentials and Authorization related fields
    Then Enter input plugin property: "referenceName" with value: "RefName"
    Then Replace input plugin property: "database" with value: "databaseName"
    Then Click on the Macro button of Property: "importQuery" and set the value in textarea: "CloudMySqlImportQuery"
#    Then Validate "CloudSQL MySQL" plugin properties
    Then Close the Plugin Properties page
    Then Navigate to the properties page of plugin: "CloudSQL MySQL2"
    Then Select dropdown plugin property: "select-jdbcPluginName" with option value: "cloudsql-mysql"
    Then Select radio button plugin property: "instanceType" with value: "public"
    Then Enter input plugin property: "connectionName" with value: "cdf-athena:us-central1:sql-automation-test-instance"
    Then Enter input plugin property: "referenceName" with value: "RefName"
    Then Replace input plugin property: "database" with value: "databaseName"
    Then Click on the Macro button of Property: "tableName" and set the value to: "mytable"
#    Then Validate "CloudSQL MySQL2" plugin properties
    Then Close the Plugin Properties page
    Then Save the pipeline
    Then Preview and run the pipeline
    Then Enter runtime argument value "insertQuery" for key "CloudMySqlImportQuery"
    Then Enter runtime argument value "table" for key "mytable"
    Then Run the preview of pipeline with runtime arguments
    Then Wait till pipeline preview is in running state
    Then Open and capture pipeline preview logs
#    Then Verify the preview run status of pipeline in the logs is "succeeded"
#    Then Close the pipeline logs
#    Then Close the preview
#    Then Deploy the pipeline
#    Then Run the Pipeline in Runtime
#    Then Enter runtime argument value "selectQuery" for key "CloudMySqlImportQuery"
#    Then Enter runtime argument value "table" for key "mytable"
#    Then Run the Pipeline in Runtime with runtime arguments
#    Then Wait till pipeline is in running state
#    Then Open and capture logs
#    Then Verify the pipeline status is "Succeeded"
#    Then Close the pipeline logs
#    Then Validate the values of records transferred to target table is equal to the values from source table

  Scenario: To verify pipeline preview fails when invalid connection details provided using macro arguments
    Given Open Datafusion Project to configure pipeline
    When Expand Plugin group in the LHS plugins list: "Source"
    When Select plugin: "CloudSQL MySQL" from the plugins list as: "Source"
    When Expand Plugin group in the LHS plugins list: "Sink"
    When Select plugin: "CloudSQL MySQL" from the plugins list as: "Sink"
    Then Connect plugins: "CloudSQL MySQL" and "CloudSQL MySQL2" to establish connection
    Then Navigate to the properties page of plugin: "CloudSQL MySQL"
    Then Click on the Macro button of Property: "select-jdbcPluginName" and set the value to: "cloudsql-mysql"
    Then Select radio button plugin property: "instanceType" with value: "public"
    Then Enter input plugin property: "connectionName" with value: "cdf-athena:us-central1:sql-automation-test-instance"
    Then Click on the Macro button of Property: "user" and set the value to: "username"
    Then Click on the Macro button of Property: "password" and set the value to: "password"
    Then Enter input plugin property: "referenceName" with value: "RefName"
    Then Replace input plugin property: "database" with value: "databaseName"

    Then Click on the Macro button of Property: "database" and set the value to: "oracleDatabase"
    Then Select radio button plugin property: "connectionType" with value: "service"
    Then Select radio button plugin property: "role" with value: "sysdba"
    Then Enter input plugin property: "referenceName" with value: "sourceRef"
    Then Enter textarea plugin property: "importQuery" with value: "selectQuery"
    Then Validate "Oracle" plugin properties
    Then Close the Plugin Properties page
    Then Navigate to the properties page of plugin: "Oracle2"
    Then Click on the Macro button of Property: "jdbcPluginName" and set the value to: "oracleDriverName"
    Then Click on the Macro button of Property: "host" and set the value to: "oracleHost"
    Then Click on the Macro button of Property: "port" and set the value to: "oraclePort"
    Then Click on the Macro button of Property: "user" and set the value to: "oracleUsername"
    Then Click on the Macro button of Property: "password" and set the value to: "oraclePassword"
    Then Click on the Macro button of Property: "database" and set the value to: "oracleDatabase"
    Then Enter input plugin property: "referenceName" with value: "targetRef"
    Then Replace input plugin property: "tableName" with value: "targetTable"
    Then Replace input plugin property: "dbSchemaName" with value: "schema"
    Then Select radio button plugin property: "connectionType" with value: "service"
    Then Select radio button plugin property: "role" with value: "sysdba"
    Then Validate "Oracle2" plugin properties
    Then Close the Plugin Properties page
    Then Save the pipeline
    Then Preview and run the pipeline
    Then Enter runtime argument value "invalidDriverName" for key "oracleDriverName"
    Then Enter runtime argument value "invalidHost" for key "oracleHost"
    Then Enter runtime argument value "invalidPort" for key "oraclePort"
    Then Enter runtime argument value "invalidUserName" for key "oracleUsername"
    Then Enter runtime argument value "invalidPassword" for key "oraclePassword"
    Then Enter runtime argument value "invalidDatabaseName" for key "oracleDatabase"
    Then Run the preview of pipeline with runtime arguments
    Then Verify the preview of pipeline is "Failed"