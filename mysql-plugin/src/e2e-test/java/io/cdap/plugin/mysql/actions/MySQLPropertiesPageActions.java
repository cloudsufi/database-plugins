package io.cdap.plugin.mysql.actions;

import io.cdap.e2e.utils.AssertionHelper;
import io.cdap.e2e.utils.ElementHelper;
import io.cdap.e2e.utils.PluginPropertyUtils;
import io.cdap.e2e.utils.SeleniumHelper;
import io.cdap.plugin.mysql.locators.MySQLPropertiesPage;

public class MySQLPropertiesPageActions {
    public static void clickOnMysqlConnectionButton() {
        ElementHelper.clickOnElement(MySQLPropertiesPage.connectorMysql);
    }

    public static void clickOnMySQLConnection() {
        String connectionName = PluginPropertyUtils.pluginProp("connection.name");
        ElementHelper.clickOnElement(MySQLPropertiesPage.MySQLConnection(connectionName));
    }
}

