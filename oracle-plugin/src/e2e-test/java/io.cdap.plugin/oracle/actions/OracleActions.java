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

package io.cdap.plugin.oracle.actions;

import io.cdap.e2e.pages.locators.CdfPluginPropertiesLocators;
import io.cdap.e2e.utils.AssertionHelper;
import io.cdap.e2e.utils.ElementHelper;
import io.cdap.e2e.utils.JsonUtils;
import io.cdap.e2e.utils.PluginPropertyUtils;
import io.cdap.e2e.utils.SeleniumDriver;
import io.cdap.e2e.utils.SeleniumHelper;
import io.cdap.e2e.utils.WaitHelper;
import io.cdap.plugin.oracle.locators.OracleLocators;
import io.cucumber.core.logging.Logger;
import io.cucumber.core.logging.LoggerFactory;
import org.junit.Assert;
import org.openqa.selenium.Keys;
import org.openqa.selenium.interactions.Actions;

import java.util.Map;

/**
 * Oracle plugin related Actions.
 */

public class OracleActions {
  private static final Logger logger = (Logger) LoggerFactory.getLogger(OracleActions.class);

  static {
    SeleniumHelper.getPropertiesLocators(OracleLocators.class);
  }

  public static void enterConnectionArguments(String jsonConnectionArguments) {
    Map<String, String> fieldsMapping =
      JsonUtils.convertKeyValueJsonArrayToMap(PluginPropertyUtils.pluginProp(jsonConnectionArguments));
    int index = 0;
    for (Map.Entry<String, String> entry : fieldsMapping.entrySet()) {
      ElementHelper.sendKeys(OracleLocators.field(index), entry.getKey().split("#")[0]);
      ElementHelper.sendKeys(OracleLocators.fieldFunctionValue(index), entry.getValue());
      ElementHelper.clickOnElement(OracleLocators.fieldAddRowButton(index));
      index++;
    }
  }

  public static void verifyGroupByPluginPropertyInlineErrorMessageForRow(String propertyName,
                                                                         String expectedMessage) {
    WaitHelper.waitForElementToBeDisplayed(OracleLocators.locatePluginPropertyInlineError(propertyName));
    AssertionHelper.verifyElementDisplayed(OracleLocators.locatePluginPropertyInlineError(propertyName));
    AssertionHelper.verifyElementContainsText(OracleLocators.locatePluginPropertyInlineError(propertyName), expectedMessage);
  }

  public static void verifyGroupByPluginPropertyInlineErrorMessageForColor(String propertyName) {
    logger.info("Verify if plugin property: " + propertyName + "'s inline error message is shown in the expected color:"
                  + " " + "#a40403");
    String actualColor = ElementHelper.getElementColorCssProperty(OracleLocators.
                                                         locatePluginPropertyInlineError(propertyName));
    String expectedColor = "#a40403";
    Assert.assertEquals(expectedColor, actualColor);
  }
}
