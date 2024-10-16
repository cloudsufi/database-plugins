/*
 * Copyright © 2022 Cask Data, Inc.
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

package io.cdap.plugin.mysql;

import com.google.common.collect.Lists;
import io.cdap.cdap.api.data.schema.Schema;
import io.cdap.plugin.db.CommonSchemaReader;

import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Types;
import java.util.List;
import java.util.Map;

/**
 * Schema reader for mapping Mysql DB type
 */
public class MysqlSchemaReader extends CommonSchemaReader {

  public static final String YEAR_TYPE_NAME = "YEAR";
  public static final String MEDIUMINT_UNSIGNED_TYPE_NAME = "MEDIUMINT UNSIGNED";
  private final String sessionID;
  private boolean zeroDateTimeToNull;

  public MysqlSchemaReader(String sessionID) {
    super();
    this.sessionID = sessionID;
  }

  public MysqlSchemaReader(String sessionID, Map<String, String> connectionArguments) {
    super();
    this.sessionID = sessionID;
    this.zeroDateTimeToNull = MysqlUtil.isZeroDateTimeToNull(connectionArguments);
  }

  @Override
  public List<Schema.Field> getSchemaFields(ResultSet resultSet) throws SQLException {
    List<Schema.Field> schemaFields = Lists.newArrayList();
    ResultSetMetaData metadata = resultSet.getMetaData();
    // ResultSetMetadata columns are numbered starting with 1
    for (int i = 1; i <= metadata.getColumnCount(); i++) {
      if (shouldIgnoreColumn(metadata, i)) {
        continue;
      }

      String columnName = metadata.getColumnName(i);
      Schema columnSchema = getSchema(metadata, i);

      if (ResultSetMetaData.columnNullable == metadata.isNullable(i)
          || (zeroDateTimeToNull && MysqlUtil.isDateTimeLikeType(metadata.getColumnType(i)))) {
        columnSchema = Schema.nullableOf(columnSchema);
      }
      Schema.Field field = Schema.Field.of(columnName, columnSchema);
      schemaFields.add(field);
    }
    return schemaFields;
  }

  @Override
  public boolean shouldIgnoreColumn(ResultSetMetaData metadata, int index) throws SQLException {
    return metadata.getColumnName(index).equals("c_" + sessionID) ||
      metadata.getColumnName(index).equals("sqn_" + sessionID);
  }

  @Override
  public Schema getSchema(ResultSetMetaData metadata, int index) throws SQLException {
    int sqlType = metadata.getColumnType(index);
    String sqlTypeName = metadata.getColumnTypeName(index);

    switch(sqlType) {
      case Types.DATE:
        // YEAR type in MySQL should get converted to integer to avoid truncation
        // failures in the MySQL Sink plugin due to missing date and month details.
        if (YEAR_TYPE_NAME.equalsIgnoreCase(sqlTypeName)) {
          return Schema.of(Schema.Type.INT);
        }
        break;
      case Types.INTEGER:
        // MEDIUMINT UNSIGNED should be mapped to int
        if (MEDIUMINT_UNSIGNED_TYPE_NAME.equalsIgnoreCase(sqlTypeName)) {
          // Need to handle specifically for MEDIUMINT UNSIGNED here as super.getSchema internally uses
          // metadata.getColumnType and metadata.getSigned to evaluate the type.
          // For MySQL INT UNSIGNED and MEDIUMINT UNSIGNED both getColumnType and getSigned matches, hence
          // MEDIUMINT UNSIGNED gets mapped to CDAP long type.
          return Schema.of(Schema.Type.INT);
        }
        break;
    }
    return super.getSchema(metadata, index);
  }
}
