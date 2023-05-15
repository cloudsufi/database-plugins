Feature: CloudMySql - Verify data transfer from BigQuery source to CloudMySql sink

  Scenario: To verify data is getting transferred from BigQuery source to CloudMySql sink successfully
    Given Open Datafusion Project to configure pipeline
    When Expand Plugin group in the LHS plugins list: "Source"
    When Select plugin: "BigQuery" from the plugins list as: "Source"
    When Expand Plugin group in the LHS plugins list: "Sink"
    When Select plugin: "CloudSQL MySQL" from the plugins list as: "Sink"
    Then Connect plugins: "BigQuery" and "CloudSQL MySQL" to establish connection
    Then Navigate to the properties page of plugin: "BigQuery"
    Then Replace input plugin property: "project" with value: "projectId"
    Then Enter input plugin property: "datasetProject" with value: "projectId"
    Then Enter input plugin property: "referenceName" with value: "BQReferenceName"
    Then Enter input plugin property: "dataset" with value: "dataset"
    Then Enter input plugin property: "table" with value: "bqTargetTable"
#    Then Click on the Get Schema button
#    Then Validate "BigQuery" plugin properties
    Then Close the Plugin Properties page
    Then Navigate to the properties page of plugin: "CloudSQL MySQL"
    Then Select dropdown plugin property: "select-jdbcPluginName" with option value: "cloudsql-mysql"
    Then Select radio button plugin property: "instanceType" with value: "public"
    Then Enter input plugin property: "connectionName" with value: "ConnectionName"
    Then Replace input plugin property: "user" with value: "username" for Credentials and Authorization related fields
    Then Replace input plugin property: "password" with value: "password" for Credentials and Authorization related fields
    Then Enter input plugin property: "referenceName" with value: "RefName"
    Then Enter input plugin property: "database" with value: "TestDatabase"
    Then Enter input plugin property: "tableName" with value: "mytable"
#    Then Validate "CloudSQL MySQL" plugin properties
    Then Close the Plugin Properties page
    Then Save the pipeline
    Then Preview and run the pipeline
    Then Wait till pipeline preview is in running state
    Then Open and capture pipeline preview logs
#    Then Verify the preview run status of pipeline in the logs is "succeeded"
#    Then Close the pipeline logs
#    Then Close the preview
#    Then Deploy the pipeline
#    Then Run the Pipeline in Runtime
#    Then Wait till pipeline is in running state
#    Then Open and capture logs
#    Then Verify the pipeline status is "Succeeded"
#    Then Close the pipeline logs
#    Then Validate OUT record count is equal to records transferred to target BigQuery table

  Scenario: To verify data is getting transferred from BigQuery source to CloudMySql sink successfully when connection arguments are set
    Given Open Datafusion Project to configure pipeline
    When Expand Plugin group in the LHS plugins list: "Source"
    When Select plugin: "BigQuery" from the plugins list as: "Source"
    When Expand Plugin group in the LHS plugins list: "Sink"
    When Select plugin: "CloudSQL MySQL" from the plugins list as: "Sink"
    Then Connect plugins: "BigQuery" and "CloudSQL MySQL" to establish connection
    Then Navigate to the properties page of plugin: "BigQuery"
    Then Replace input plugin property: "project" with value: "projectId"
    Then Enter input plugin property: "datasetProject" with value: "projectId"
    Then Enter input plugin property: "referenceName" with value: "BQReferenceName"
    Then Enter input plugin property: "dataset" with value: "dataset"
    Then Enter input plugin property: "table" with value: "bqTargetTable"
#    Then Click on the Get Schema button
#    Then Validate "BigQuery" plugin properties
    Then Close the Plugin Properties page
    Then Navigate to the properties page of plugin: "CloudSQL MySQL"
    Then Select dropdown plugin property: "select-jdbcPluginName" with option value: "cloudsql-mysql"
    Then Select radio button plugin property: "instanceType" with value: "public"
    Then Enter input plugin property: "connectionName" with value: "ConnectionName"
    Then Replace input plugin property: "user" with value: "username" for Credentials and Authorization related fields
    Then Replace input plugin property: "password" with value: "password" for Credentials and Authorization related fields
    Then Enter input plugin property: "referenceName" with value: "RefName"
    Then Enter input plugin property: "database" with value: "TestDatabase"
    Then Enter input plugin property: "tableName" with value: "mytable"
    Then Enter key value pairs for plugin property: "connectionArguments" with values from json: "connectionArgumentsList"
#    Then Validate "CloudSQL MySQL" plugin properties
    Then Close the Plugin Properties page
    Then Save the pipeline
    Then Preview and run the pipeline
    Then Wait till pipeline preview is in running state
#    Then Open and capture pipeline preview logs
#    Then Verify the preview run status of pipeline in the logs is "succeeded"
#    Then Close the pipeline logs
#    Then Close the preview
#    Then Deploy the pipeline
#    Then Run the Pipeline in Runtime
#    Then Wait till pipeline is in running state
#    Then Open and capture logs
#    Then Verify the pipeline status is "Succeeded"
#    Then Close the pipeline logs
#    Then Validate OUT record count is equal to records transferred to target BigQuery table




