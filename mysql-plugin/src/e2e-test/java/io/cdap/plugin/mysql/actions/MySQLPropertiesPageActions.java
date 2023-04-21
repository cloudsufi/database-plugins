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

package io.cdap.plugin.mysql.actions;

import io.cdap.e2e.utils.ElementHelper;
import io.cdap.e2e.utils.PluginPropertyUtils;
import io.cdap.e2e.utils.SeleniumHelper;
import io.cdap.plugin.mysql.locators.MySQLPropertiesPage;

/**
 * My SQL source - Properties page - Actions.
 */
public class MySQLPropertiesPageActions {
    static {
        SeleniumHelper.getPropertiesLocators(MySQLPropertiesPage.class);
    }
    public static void clickOnMysqlConnectionButton() {
        ElementHelper.clickOnElement(MySQLPropertiesPage.connectorMysql);
    }
    
    public static void clickOnMySQLConnection() {
        String connectionName = PluginPropertyUtils.pluginProp("connection.name");
        ElementHelper.clickOnElement(MySQLPropertiesPage.mySQLConnection(connectionName));
    }
}
