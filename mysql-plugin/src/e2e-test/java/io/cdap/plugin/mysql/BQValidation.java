package io.cdap.plugin.mysql;
/*
 * Copyright © 2023 Cask Data, Inc.
 *
 * Licensed under the Apache License, Version 2.0 (the "License"); you may not
 * use this file except in compliance with the License. You may obtain a copy of
 * the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
 * WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
 * License for the specific language governing permissions and limitations under
 * the License.
 */

import com.simba.googlebigquery.jdbc.DataSource;
import io.cdap.e2e.utils.PluginPropertyUtils;
import io.cdap.plugin.MysqlClient;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

/**
 *  Big Query client.
 */
public class BQValidation {

    /**
     * Extracts entire data from source and target tables.
     * @param sourceTable table at the source side
     * @param targetTable table at the BigQuery side
     * @return true if the values in source and target side are equal
     */
    public static boolean validateBQAndDBRecordValues(String sourceTable, String targetTable)
            throws SQLException, ClassNotFoundException {
        String getSourceQuery = "SELECT * FROM " + sourceTable;

        try (Connection connect = MysqlClient.getMysqlConnection()) {
            connect.setHoldability(ResultSet.HOLD_CURSORS_OVER_COMMIT);
            Statement statement1 = connect.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,
            ResultSet.CONCUR_UPDATABLE,
                    ResultSet.HOLD_CURSORS_OVER_COMMIT);

            ResultSet rsSource = statement1.executeQuery(getSourceQuery);
            ResultSet rsTarget = getBigQueryDataAsResultSet(targetTable);

            return MysqlClient.compareResultSetData(rsSource, rsTarget);
        }
    }

    public static ResultSet getBigQueryDataAsResultSet(String targetTable) throws SQLException {
        Connection connection = null;
        DataSource dataSource = new com.simba.googlebigquery.jdbc.DataSource();
        String projectId = PluginPropertyUtils.pluginProp("projectId");
        String datasetId = PluginPropertyUtils.pluginProp("dataset");

        String jdbcUrl = String.format(PluginPropertyUtils.pluginProp("jdbcUrl"), projectId);
        dataSource.setURL(jdbcUrl);
        connection = dataSource.getConnection();
        Statement statement = connection.createStatement();
        ResultSet bqResultSet = statement.executeQuery("SELECT * from " + datasetId +  "." + targetTable +  ";");

        return bqResultSet;
    }

    public static boolean validateBqToDBTarget(String sourceTable, String targetTable)
            throws SQLException, ClassNotFoundException {
        String getSinkQuery = "SELECT * FROM " + targetTable;
        try (Connection connect = MysqlClient.getMysqlConnection()) {
            connect.setHoldability(ResultSet.HOLD_CURSORS_OVER_COMMIT);
            Statement statement1 = connect.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE,
                    ResultSet.HOLD_CURSORS_OVER_COMMIT);
            ResultSet rsTarget = statement1.executeQuery(getSinkQuery);

            ResultSet rsSource = getBigQueryDataAsResultSet(sourceTable);
            System.out.println(MysqlClient.compareResultSetData(rsTarget, rsSource));
            return MysqlClient.compareResultSetData(rsTarget, rsSource);
        }
    }
}
