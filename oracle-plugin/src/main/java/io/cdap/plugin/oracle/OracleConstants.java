/*
 * Copyright © 2019 Cask Data, Inc.
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

package io.cdap.plugin.oracle;

import javax.annotation.Nullable;

/**
 * Oracle Constants.
 */
public final class OracleConstants {
  private OracleConstants() {
    throw new AssertionError("Should not instantiate static utility class.");
  }

  public static final String PLUGIN_NAME = "Oracle";
  // Updating connection strings to accept protocol (e.g., jdbc:oracle:thin:@<protocol>://<host>:<port>/<SID>)
  public static final String ORACLE_CONNECTION_STRING_SID_FORMAT = "jdbc:oracle:thin:@%s:%s:%s/%s";
  public static final String ORACLE_CONNECTION_STRING_SERVICE_NAME_FORMAT = "jdbc:oracle:thin:@%s://%s:%s/%s";
  public static final String ORACLE_CONNECTION_STRING_TNS_FORMAT = "jdbc:oracle:thin:@%s";
  public static final String DEFAULT_BATCH_VALUE = "defaultBatchValue";
  public static final String DEFAULT_ROW_PREFETCH = "defaultRowPrefetch";
  public static final String SERVICE_CONNECTION_TYPE = "service";
  public static final String CONNECTION_TYPE = "connectionType";
  public static final String ROLE = "role";
  public static final String NAME_DATABASE = "database";
  public static final String TNS_CONNECTION_TYPE = "tns";
  public static final String TRANSACTION_ISOLATION_LEVEL = "transactionIsolationLevel";
  public static final String USE_SSL = "useSSL";
  public static final String DEFAULT_CONNECTION_PROTOCOL = "tcp";

  /**
   * Returns the Connection String for the given ConnectionType.
   *
   * @param connectionType TNS/Service/SID
   * @param host Host name of the oracle server
   * @param port Port of the oracle server
   * @param database Database to connect to
   * @return Connection String based on the given ConnectionType
   */
  public static String getConnectionString(String connectionType,
                                           @Nullable String host,
                                           @Nullable int port,
                                           String database) {
    if (OracleConstants.TNS_CONNECTION_TYPE.equalsIgnoreCase(connectionType)) {
      return String.format(OracleConstants.ORACLE_CONNECTION_STRING_TNS_FORMAT, database);
    }
    if (OracleConstants.SERVICE_CONNECTION_TYPE.equalsIgnoreCase(connectionType)) {
      return String.format(OracleConstants.ORACLE_CONNECTION_STRING_SERVICE_NAME_FORMAT,
             DEFAULT_CONNECTION_PROTOCOL, host, port, database);
    }
    return String.format(OracleConstants.ORACLE_CONNECTION_STRING_SID_FORMAT,
           DEFAULT_CONNECTION_PROTOCOL, host, port, database);
  }

  /**
   * Constructs the Oracle connection string based on the provided connection type, host, port, and database.
   * If SSL is enabled, the connection protocol will be "tcps" instead of "tcp".
   *
   * @param connectionType TNS/Service/SID
   * @param host Host name of the oracle server
   * @param port Port of the oracle server
   * @param database Database to connect to
   * @param useSSL Whether SSL/TLS is required(YES/NO)
   * @return Connection String based on the given parameters and connection type.
   */
  public static String getConnectionString(String connectionType,
                                           @Nullable String host,
                                           @Nullable int port,
                                           String database,
                                           @Nullable Boolean useSSL) {
    // Use protocol as "tcps" when SSL is requested or else use "tcp".
    String connectionProtocol;
    if (useSSL != null && useSSL) {
      connectionProtocol = "tcps";
    } else {
      connectionProtocol = "tcp";
    }

    switch (connectionType.toLowerCase()) {
      case OracleConstants.TNS_CONNECTION_TYPE:
        // TNS connection doesn't require protocol
        return String.format(OracleConstants.ORACLE_CONNECTION_STRING_TNS_FORMAT, database);
      case OracleConstants.SERVICE_CONNECTION_TYPE:
        // Service connection uses protocol, host, port, and database
        return String.format(OracleConstants.ORACLE_CONNECTION_STRING_SERVICE_NAME_FORMAT,
                connectionProtocol, host, port, database);
      default:
        // Default to SID format if no matching case is found
        return String.format(OracleConstants.ORACLE_CONNECTION_STRING_SID_FORMAT,
                connectionProtocol, host, port, database);
    }
  }
}
