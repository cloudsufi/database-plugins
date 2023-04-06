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

package io.cdap.plugin.oracle.locators;

import io.cdap.e2e.utils.SeleniumDriver;
import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;

/**
 * Oracle plugin related Locators.
 */

public class OracleLocators {

  public static WebElement field(int row) {
    String xpath = "//div[@data-cy='connectionArguments']//div[@data-cy= '" + row + "']//input[@placeholder='Key']";
    return SeleniumDriver.getDriver().findElement(By.xpath(xpath));
  }

  public static WebElement fieldFunctionValue(int row) {
    String xpath = "//div[@data-cy='connectionArguments']//div[@data-cy= '" + row + "']//input[@placeholder='Value']";
    return SeleniumDriver.getDriver().findElement(By.xpath(xpath));
  }

  public static WebElement fieldAddRowButton(int row) {
    String xpath = "//*[@data-cy='connectionArguments']//*[@data-cy='" + row + "']//button[@data-cy='add-row']";
    return SeleniumDriver.getDriver().findElement(By.xpath(xpath));
  }

  public static WebElement locatePluginPropertyInlineError(String propertyName) {
    return SeleniumDriver.getDriver().findElement(By.xpath("//*[@data-cy='" + propertyName + "']/following-sibling::div[@data-cy='property-row-error']"));
  }

}
