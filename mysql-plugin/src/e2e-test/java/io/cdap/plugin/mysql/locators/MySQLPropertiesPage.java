package io.cdap.plugin.mysql.locators;

import io.cdap.e2e.utils.SeleniumDriver;
import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.How;

public class MySQLPropertiesPage {
    @FindBy(how = How.XPATH, using = "//div[@data-cy='connector-MySQL']")
    public static WebElement connectorMysql;

    public static WebElement MySQLConnection(String connectionName) {
        return SeleniumDriver.getDriver().findElement(
                By.xpath("//div[contains(text(),'" + connectionName + "')]"));
    }
}
