Feature: Category Management Super Admin History feature

  Background: 
    * def loginLocator = read('../../data/loginPage_locator.json')
    * def usersValue = read('../../data/users.json')
    * def dashBoardLocator = read('../../data//dashboard_locators.json')
    * def categoryLocater = read('../../data/categoryPage_locators.json')
    * def categoryConstant = read('../../data/categoryPage_constants.json')
    * configure driver = driverConfig
    * driver backOfficeUrl
    * print '***backofficeurl***' backOfficeUrl
    And maximize()
    * karate.log('***Logging into the application****')
    And input(loginLocator.usernameTextArea, usersValue.users.superAdmin.email)
    * delay(3000)
    And input(loginLocator.passwordTextArea, usersValue.users.superAdmin.password)
    * delay(3000)
    When click(loginLocator.loginButton)
    * karate.log('***Logging into the application****')
    * delay(3000)
    And click(dashBoardLocator.switchMenu)
    * delay(3000)
    And click(dashBoardLocator.galleriaMenu)
    * delay(4000)
    * def categoryName = scriptAll(categoryLocater.categoryNameList, '_.textContent')
    * delay(3000)
    * def options = scriptAll(categoryLocater.optionOnThreeDots, '_.textContent')
    * def elements = locateAll(categoryLocater.optionOnThreeDots)
    * delay(2000)
    * click(categoryLocater.dots)
    * delay(2000)
    * elements[0].click()


  Scenario: Verify History button on view page for Super Admin.
    * karate.log('***History button ****')
    And match enabled(categoryLocater.isEnableToggle) == true
    And match text(categoryLocater.viewHistoryButton) == categoryConstant.viewHistoryButtonTxt


  Scenario: Verify all column Name on history page for Super Admin.
    * karate.log('***all column Name on history page****')
    And click(categoryLocater.historyButton)
    * delay(2000)
    * def columnName = scriptAll(categoryLocater.historyPageColumnName, '_.textContent')
    * match  columnName[0] == categoryConstant.entityColumn
    * match  columnName[1] == categoryConstant.fieldNameColumn
    * match  columnName[2] == categoryConstant.oldValueColumn
    * match  columnName[3] == categoryConstant.newValueColumn
    * match  columnName[4] == categoryConstant.lastModColumn
    * match  columnName[5] == categoryConstant.modifiedDateColumn
    * match  columnName[6] == categoryConstant.actionColumn
    * match  columnName[7] == categoryConstant.commentColumn


  Scenario: Verify close button functionality on history page for Super Admin.
    * karate.log('***close button on history page****')
    And click(categoryLocater.historyButton)
    * delay(2000)
    And match text(categoryLocater.closeButton) == categoryConstant.closeButtonTxt
    And match enabled(categoryLocater.closeButton) == true
    * click(categoryLocater.closeButton)
    And match text(categoryLocater.viewHistoryButton) == categoryConstant.viewHistoryButtonTxt
    * delay(2000)
    Then match driver.url contains 'show'


  Scenario: Verify old and new value on history page for Super Admin.
    * karate.log('***old and new value on history page****')
    And click(categoryLocater.historyButton)
    * delay(2000)
    * def onHistoryUpdateValue = scriptAll(categoryLocater.historyUpdateValue, '_.textContent')
    * match  onHistoryUpdateValue[2] != onHistoryUpdateValue[3]
    Then match driver.url contains 'history'


  Scenario: Verify all input field and grid on history page for Super Admin.
    * karate.log('***all input field and grid present on history page****')
    And click(categoryLocater.historyButton)
    * delay(2000)
    And match text(categoryLocater.closeButton) == categoryConstant.closeButtonTxt
    And match text(categoryLocater.viewHistoryTxt) == categoryConstant.historyTxt
    And match enabled(categoryLocater.closeButton) == true
    * match enabled(categoryLocater.searchInputBox) == true
    * match enabled(categoryLocater.gridOnPage) == true


  Scenario: Verify history details on basis of sequence for Super Admin.
    * karate.log('***all input field and grid present on history page****')
    And click(categoryLocater.historyButton)
    * delay(2000)
    * input(categoryLocater.searchInputBox, 'sequence')
    * delay(2000)
    * def onHistoryUpdateValue = scriptAll(categoryLocater.historyUpdateValue, '_.textContent')
    * match  onHistoryUpdateValue[2] != onHistoryUpdateValue[3]


  Scenario: Verify history details on basis of isEnabled for Super Admin.
    * karate.log('***all input field and grid present on history page****')
    And click(categoryLocater.historyButton)
    * delay(2000)
    * input(categoryLocater.searchInputBox, 'sequence')
    * delay(2000)
    * def onHistoryUpdateValue = scriptAll(categoryLocater.historyUpdateValue, '_.textContent')
    * match  onHistoryUpdateValue[2] != onHistoryUpdateValue[3]
