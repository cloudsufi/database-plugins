package io.cdap.plugin;

import io.cdap.e2e.utils.PluginPropertyUtils;
import org.junit.Assert;

import java.sql.*;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.TimeZone;

public class CloudMySqlClient {

    private static final String database = PluginPropertyUtils.pluginProp("DatabaseName");
    private static final String connectionName = PluginPropertyUtils.pluginProp("ConnectionName");

    public static void main(String[] args) throws SQLException, ClassNotFoundException {
        getCloudMysqlConnection();
        //createSourceTable("myTable");
//        createSourceTable("newTable");
//        String[] tablesToDrop = {"newTable"};
//        dropTables(tablesToDrop);
        //System.out.println("done");

    }

    public static Connection getCloudMysqlConnection() throws SQLException, ClassNotFoundException {
        Class.forName("com.google.cloud.sql.mysql.SocketFactory");
        String instanceConnectionName = "cdf-athena:us-central1:sql-automation-test-instance";
        String databaseName = "TestDatabase";
        String Username = "v";
        String Password = "v@123";
        String jdbcUrl = String.format("jdbc:mysql:///%s?cloudSqlInstance=%s&socketFactory=com.google.cloud.sql.mysql.SocketFactory&user=%s&password=%s", databaseName, instanceConnectionName, Username, Password);
        Connection conn = DriverManager.getConnection(jdbcUrl);
        System.out.println("connected to database");
        return conn;
    }

    public static int countRecord(String table) throws SQLException, ClassNotFoundException {
        String countQuery = "SELECT COUNT(*) as total FROM " + table;
        try (Connection connect = getCloudMysqlConnection();
             Statement statement = connect.createStatement();
             ResultSet rs = statement.executeQuery(countQuery)) {
            int num = 0;
            while (rs.next()) {
                num = (rs.getInt(1));
            }
            return num;
        }
    }

    public static boolean validateRecordValues(String sourceTable, String targetTable)
            throws SQLException, ClassNotFoundException {
        String getSourceQuery = "SELECT * FROM " + sourceTable;
        String getTargetQuery = "SELECT * FROM " + targetTable;
        try (Connection connect = getCloudMysqlConnection()) {
            connect.setHoldability(ResultSet.HOLD_CURSORS_OVER_COMMIT);
            Statement statement1 = connect.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE,
                    ResultSet.HOLD_CURSORS_OVER_COMMIT);
            Statement statement2 = connect.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE,
                    ResultSet.HOLD_CURSORS_OVER_COMMIT);
            ResultSet rsSource = statement1.executeQuery(getSourceQuery);
            ResultSet rsTarget = statement2.executeQuery(getTargetQuery);
            return compareResultSetData(rsSource, rsTarget);
        }
    }

    /**
     * Compares the result Set data in source table and sink table..
     *
     * @param rsSource result set of the source table data
     * @param rsTarget result set of the target table data
     * @return true if rsSource matches rsTarget
     */
    public static boolean compareResultSetData(ResultSet rsSource, ResultSet rsTarget) throws SQLException {
        ResultSetMetaData mdSource = rsSource.getMetaData();
        ResultSetMetaData mdTarget = rsTarget.getMetaData();
        int columnCountSource = mdSource.getColumnCount();
        int columnCountTarget = mdTarget.getColumnCount();
        Assert.assertEquals("Number of columns in source and target are not equal",
                columnCountSource, columnCountTarget);
        while (rsSource.next() && rsTarget.next()) {
            int currentColumnCount = 1;
            while (currentColumnCount <= columnCountSource) {
                String columnTypeName = mdSource.getColumnTypeName(currentColumnCount);
                int columnType = mdSource.getColumnType(currentColumnCount);
                String columnName = mdSource.getColumnName(currentColumnCount);
                if (columnType == Types.TIMESTAMP) {
                    GregorianCalendar gc = new GregorianCalendar(TimeZone.getTimeZone("UTC"));
                    gc.setGregorianChange(new Date(Long.MIN_VALUE));
                    Timestamp sourceTS = rsSource.getTimestamp(currentColumnCount, gc);
                    Timestamp targetTS = rsTarget.getTimestamp(currentColumnCount, gc);
                    Assert.assertTrue(String.format("Different values found for column : %s", columnName),
                            sourceTS.equals(targetTS));
                } else {
                    String sourceString = rsSource.getString(currentColumnCount);
                    String targetString = rsTarget.getString(currentColumnCount);
                    Assert.assertTrue(String.format("Different values found for column : %s", columnName),
                            String.valueOf(sourceString).equals(String.valueOf(targetString)));
                }
                currentColumnCount++;
            }
        }
        Assert.assertFalse("Number of rows in Source table is greater than the number of rows in Target table",
                rsSource.next());
        Assert.assertFalse("Number of rows in Target table is greater than the number of rows in Source table",
                rsTarget.next());
        return true;
    }

    public static void createSourceTable(String sourceTable) throws SQLException, ClassNotFoundException {
        try (Connection connect = getCloudMysqlConnection();
             Statement statement = connect.createStatement()) {
            String createSourceTableQuery = "CREATE TABLE IF NOT EXISTS " + sourceTable +
                    "(id int, lastName varchar(255), PRIMARY KEY (id))";
            statement.executeUpdate(createSourceTableQuery);

            // Truncate table to clean the data of last failure run.
            String truncateSourceTableQuery = "TRUNCATE TABLE " + sourceTable;
            statement.executeUpdate(truncateSourceTableQuery);

            // Insert dummy data.
            statement.executeUpdate("INSERT INTO " + sourceTable + " (id, lastName)" +
                    "VALUES (1, 'Priya')");
            statement.executeUpdate("INSERT INTO " + sourceTable + " (id, lastName)" +
                    "VALUES (2, 'Shubhangi')");
            statement.executeUpdate("INSERT INTO " + sourceTable + " (id, lastName)" +
                    "VALUES (3, 'Shorya')");


        }
    }

    public static void createTargetTable(String targetTable) throws SQLException, ClassNotFoundException {
        try (Connection connect = getCloudMysqlConnection();
             Statement statement = connect.createStatement()) {
            String createTargetTableQuery = "CREATE TABLE IF NOT EXISTS " + targetTable +
                    "(id int, lastName varchar(255), PRIMARY KEY (id))";
            statement.executeUpdate(createTargetTableQuery);
//             Truncate table to clean the data of last failure run.
            String truncateTargetTableQuery = "TRUNCATE TABLE " + targetTable;
            statement.executeUpdate(truncateTargetTableQuery);
        }
    }

    public static void createSourceDatatypesTable(String sourceTable) throws SQLException, ClassNotFoundException {
        try (Connection connect = getCloudMysqlConnection();
             Statement statement = connect.createStatement()) {
            String datatypesColumns = PluginPropertyUtils.pluginProp("datatypesColumns");
            String createSourceTableQuery = "CREATE TABLE " + sourceTable + " " + datatypesColumns;
            statement.executeUpdate(createSourceTableQuery);
            System.out.println(createSourceTableQuery);

            // Insert dummy data.
            String datatypesValues = PluginPropertyUtils.pluginProp("datatypesValue1");
            String datatypesColumnsList = PluginPropertyUtils.pluginProp("datatypesColumnsList");
            statement.executeUpdate("INSERT INTO " + sourceTable + " " + datatypesColumnsList + " " + datatypesValues);
        }
    }

    public static void createTargetDatatypesTable(String targetTable) throws SQLException, ClassNotFoundException {
        try (Connection connect = getCloudMysqlConnection();
             Statement statement = connect.createStatement()) {
            String datatypesColumns = PluginPropertyUtils.pluginProp("datatypesColumns");
            String createTargetTableQuery = "CREATE TABLE " + targetTable + " " + datatypesColumns;
            statement.executeUpdate(createTargetTableQuery);
        }
    }

    public static void createTargetCloudMysqlTable(String targetTable) throws SQLException,
            ClassNotFoundException {
        try (Connection connect = getCloudMysqlConnection();
             Statement statement = connect.createStatement()) {
            String datatypesColumns = PluginPropertyUtils.pluginProp("SqlServerDatatypesColumns");
            String createTargetTableQuery = "CREATE TABLE " + targetTable + " " + datatypesColumns;
            statement.executeUpdate(createTargetTableQuery);
        }
    }


    public static void dropTables(String[] tables) throws SQLException, ClassNotFoundException {
        try (Connection connect = getCloudMysqlConnection();
             Statement statement = connect.createStatement()) {
            for (String table : tables) {
                String dropTableQuery = "Drop Table " + table;
                statement.executeUpdate(dropTableQuery);
            }
        }
    }
}