Feature: CloudMySql - Verify CloudMySql plugin data transfer with macro arguments

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
    Then Enter input plugin property: "connectionName" with value: "ConnectionName"
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
    Then Enter input plugin property: "connectionName" with value: "ConnectionName"
    Then Click on the Macro button of Property: "user" and set the value to: "username"
    Then Click on the Macro button of Property: "password" and set the value to: "password"
    Then Enter input plugin property: "referenceName" with value: "RefName"
    Then Replace input plugin property: "database" with value: "databaseName"
    Then Enter input plugin property: "CloudMySqlImportQuery" with value: "mytable"
#    Then Validate "CloudSQL MySQL2" plugin properties
    Then Close the Plugin Properties page
    Then Save the pipeline
    Then Preview and run the pipeline
    Then Enter runtime argument value "driver" for key "cloudsql-mysql"
    Then Enter runtime argument value from environment variable "name" for key "username"
    Then Enter runtime argument value from environment variable "pass" for key "password"
    Then Enter runtime argument value "CloudMySqlImportQuery" for key "CloudMySqlImportQuery"
    Then Run the preview of pipeline with runtime arguments
#    Then Wait till pipeline preview is in running state
#    Then Open and capture pipeline preview logs
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
    Then Enter input plugin property: "connectionName" with value: "ConnectionName"
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
    Then Enter input plugin property: "connectionName" with value: "ConnectionName"
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
    Then Select dropdown plugin property: "select-jdbcPluginName" with option value: "cloudsql-mysql"
    Then Select radio button plugin property: "instanceType" with value: "public"
    Then Enter input plugin property: "connectionName" with value: "ConnectionName"
    Then Click on the Macro button of Property: "user" and set the value to: "username"
    Then Click on the Macro button of Property: "password" and set the value to: "password"
    Then Enter input plugin property: "referenceName" with value: "RefName"
    Then Replace input plugin property: "database" with value: "databaseName"
    Then Click on the Macro button of Property: "importQuery" and set the value in textarea: "CloudMySqlImportQuery"
#    Then Validate "CloudSQL MySQL" plugin properties
    Then Close the Plugin Properties page
    Then Navigate to the properties page of plugin: "CloudSQL MySQL2"
    Then Select dropdown plugin property: "select-jdbcPluginName" with option value: "cloudsql-mysql"
    Then Select radio button plugin property: "instanceType" with value: "public"
    Then Enter input plugin property: "connectionName" with value: "ConnectionName"
    Then Click on the Macro button of Property: "user" and set the value to: "username"
    Then Click on the Macro button of Property: "password" and set the value to: "password"
    Then Enter input plugin property: "referenceName" with value: "RefName"
    Then Click on the Macro button of Property: "tableName" and set the value to: "mytable"
    Then Replace input plugin property: "database" with value: "databaseName"
#    Then Validate "CloudSQL MySQL2" plugin properties
    Then Close the Plugin Properties page
    Then Save the pipeline
    Then Preview and run the pipeline
    Then Enter runtime argument value "invalidTable" for key "mytable"
    Then Enter runtime argument value "invalidUserName" for key "username"
    Then Enter runtime argument value "invalidPassword" for key "password"
    Then Enter runtime argument value "invalidImportQuery" for key "CloudMySqlImportQuery"
    Then Run the preview of pipeline with runtime arguments
    Then Verify the preview of pipeline is "Failed"

  Scenario: To verify pipeline preview fails when invalid basic details provided using macro arguments
    Given Open Datafusion Project to configure pipeline
    When Expand Plugin group in the LHS plugins list: "Source"
    When Select plugin: "CloudSQL MySQL" from the plugins list as: "Source"
    When Expand Plugin group in the LHS plugins list: "Sink"
    When Select plugin: "CloudSQL MySQL" from the plugins list as: "Sink"
    Then Connect plugins: "CloudSQL MySQL" and "CloudSQL MySQL2" to establish connection
    Then Navigate to the properties page of plugin: "CloudSQL MySQL"
    Then Select dropdown plugin property: "select-jdbcPluginName" with option value: "cloudsql-mysql"
    Then Select radio button plugin property: "instanceType" with value: "public"
    Then Enter input plugin property: "connectionName" with value: "ConnectionName"
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
    Then Enter input plugin property: "connectionName" with value: "ConnectionName"
    Then Replace input plugin property: "user" with value: "username" for Credentials and Authorization related fields
    Then Replace input plugin property: "password" with value: "password" for Credentials and Authorization related fields
    Then Enter input plugin property: "referenceName" with value: "RefName"
    Then Click on the Macro button of Property: "tableName" and set the value to: "mytable"
    Then Replace input plugin property: "database" with value: "databaseName"
#    Then Validate "CloudSQL MySQL2" plugin properties
    Then Close the Plugin Properties page
    Then Save the pipeline
    Then Preview and run the pipeline
    Then Enter runtime argument value "invalidImportQuery" for key "CloudMySqlImportQuery"
    Then Enter runtime argument value "invalidTable" for key "mytable"
    Then Run the preview of pipeline with runtime arguments
    Then Verify the preview of pipeline is "Failed"

  Scenario: To verify data is getting transferred from CloudMySql source to BigQuery sink using macro arguments
    Given Open Datafusion Project to configure pipeline
    When Expand Plugin group in the LHS plugins list: "Source"
    When Select plugin: "CloudSQL MySQL" from the plugins list as: "Source"
    When Expand Plugin group in the LHS plugins list: "Sink"
    When Select plugin: "BigQuery" from the plugins list as: "Sink"
    Then Connect plugins: "CloudSQL MySQL" and "BigQuery" to establish connection
    Then Navigate to the properties page of plugin: "CloudSQL MySQL"
    Then Click on the Macro button of Property: "jdbcPluginName" and set the value to: "CloudMySqlDriverName"
    Then Select radio button plugin property: "instanceType" with value: "public"
    Then Enter input plugin property: "connectionName" with value: "ConnectionName"
    Then Click on the Macro button of Property: "user" and set the value to: "username"
    Then Click on the Macro button of Property: "password" and set the value to: "password"
    Then Enter input plugin property: "referenceName" with value: "RefName"
    Then Replace input plugin property: "database" with value: "databaseName"
    Then Click on the Macro button of Property: "importQuery" and set the value in textarea: "CloudMySqlImportQuery"
#    Then Validate "CloudSQL MySQL" plugin properties
    Then Close the Plugin Properties page
    Then Navigate to the properties page of plugin: "BigQuery"
    Then Enter input plugin property: "referenceName" with value: "BQReferenceName"
    Then Click on the Macro button of Property: "project" and set the value to: "projectId"
    Then Click on the Macro button of Property: "datasetProject" and set the value to: "bqDatasetId"
    Then Click on the Macro button of Property: "dataset" and set the value to: "dataset"
    Then Click on the Macro button of Property: "table" and set the value to: "bqSourceTable"
    Then Click on the Macro button of Property: "truncateTable" and set the value to: "bqTruncateTable"
    Then Click on the Macro button of Property: "allowSchemaRelaxation" and set the value to: "bqUpdateTableSchema"
#    Then Validate "BigQuery" plugin properties
    Then Close the Plugin Properties page
    Then Save the pipeline
    Then Preview and run the pipeline
    Then Enter runtime argument value "CloudMySqlDriverName" for key "CloudMySqlDriverName"
    Then Enter runtime argument value from environment variable "name" for key "username"
    Then Enter runtime argument value from environment variable "pass" for key "password"
    Then Enter runtime argument value "CloudMySqlImportQuery" for key "CloudMySqlImportQuery"
    Then Enter runtime argument value "projectId" for key "projectId"
    Then Enter runtime argument value "projectId" for key "bqDatasetId"
    Then Enter runtime argument value "dataset" for key "dataset"
    Then Enter runtime argument value "bqSourceTable" for key "bqSourceTable"
    Then Enter runtime argument value "bqTargetTable" for key "bqTruncateTable"
    Then Enter runtime argument value "bqTargetTable" for key "bqUpdateTableSchema"
    Then Run the preview of pipeline with runtime arguments
    Then Wait till pipeline preview is in running state
    Then Open and capture pipeline preview logs
#    Then Verify the preview run status of pipeline in the logs is "succeeded"
#    Then Close the pipeline logs
#    Then Close the preview
#    Then Deploy the pipeline
#    Then Run the Pipeline in Runtime
#    Then Enter runtime argument value "CloudMySqlDriverName" for key "CloudMySqlDriverName"
#    Then Enter runtime argument value from environment variable "name" for key "username"
#    Then Enter runtime argument value from environment variable "pass" for key "password"
#    Then Enter runtime argument value "CloudMySqlImportQuery" for key "CloudMySqlImportQuery"
#    Then Enter runtime argument value "projectId" for key "projectId"
#    Then Enter runtime argument value "projectId" for key "bqDatasetId"
#    Then Enter runtime argument value "dataset" for key "dataset"
#    Then Enter runtime argument value "bqSourceTable" for key "bqSourceTable"
#    Then Enter runtime argument value "bqTargetTable" for key "bqTruncateTable"
#    Then Enter runtime argument value "bqTargetTable" for key "bqUpdateTableSchema"
#    Then Run the Pipeline in Runtime with runtime arguments
#    Then Wait till pipeline is in running state
#    Then Open and capture logs
#    Then Verify the pipeline status is "Succeeded"
#    Then Close the pipeline logs
#    Then Validate OUT record count is equal to records transferred to target BigQuery table
