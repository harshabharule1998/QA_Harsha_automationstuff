Feature: Tag management tag agent view permission feature

  Background: 
    * def loginLocator = read('../../data/loginPage_locator.json')
    * def usersValue = read('../../data/users.json')
    * def tagPageConstant = read('../../data/tagPage_constants.json')
    * def viewPageLocator = read('../../data/tagViewPage_locators.json')
    * def listPageLocator = read('../../data/tagListPage_locators.json')
    * configure driver = driverConfig
    * driver backOfficeUrl
    * print '***backofficeurl***' backOfficeUrl
    And maximize()
    * karate.log('***Logging into the application****')
    And input(loginLocator.usernameTextArea, usersValue.users.tagAgentView.email)
    * delay(3000)
    When click(loginLocator.continueButton)
    And input(loginLocator.passwordTextArea, usersValue.users.tagAgentView.confirmPassword)
    * delay(3000)
    When click(loginLocator.continueButton)
    * delay(3000)
    * def dashboard = locateAll(listPageLocator.dashboardText)
    * def tagIdDetails = scriptAll(listPageLocator.tagIdDetails, '_.textContent')

  Scenario: Verify tag management list screen for tag agent view permission
    * karate.log('***Logging into the application****')
    Then match text(listPageLocator.title) == tagPageConstant.titleText
    Then match text(listPageLocator.title1) == tagPageConstant.title1Text
    Then match text(listPageLocator.tagManagementH) == tagPageConstant.tagManagementText
    Then match text(listPageLocator.tagManagementM) == tagPageConstant.tagManagementText
    Then match text(listPageLocator.isEnabledC) == tagPageConstant.isEnableColumn
    Then match text(listPageLocator.commentC) == tagPageConstant.commentColumn
    Then match text(listPageLocator.sequenceC) == tagPageConstant.sequenceColumn
    Then match text(listPageLocator.tagIdC) == tagPageConstant.tagIdColumn
    Then match text(listPageLocator.tagNameC) == tagPageConstant.tagNameColumn
    Then match text(listPageLocator.tagTypeC) == tagPageConstant.TagTypeColumn
    Then match text(listPageLocator.workFlowStatusC) == tagPageConstant.workFlowStatusColumn
    Then match text(listPageLocator.importButton) == tagPageConstant.importButtonText
    Then match enabled(listPageLocator.importButton) == true
    Then match enabled(listPageLocator.searchButton) == true

  Scenario: Verify simple search for tag agent with view permission - with valid values
    * karate.log('***Logging into the application****')
    * def tagIdDetails = scriptAll(listPageLocator.tagIdDetails, '_.textContent')
    And input(listPageLocator.inputFld , tagIdDetails[0])
    * delay(3000)
    * highlight(listPageLocator.searchButton)
    * click(listPageLocator.searchButton)
    * def tagIdValue = scriptAll(listPageLocator.tagIdDetails, '_.textContent')
    * match tagIdDetails[0] == tagIdValue[0]

  Scenario: Verify is enable toggle functionality on view page
    * karate.log('***Logging into the application****')
    * delay(3000)
    And match enabled(viewPageLocator.isEnableToggle) == true

  Scenario: Verify is enable toggle functionality on view page when disable
    * karate.log('***Logging into the application****')
    * delay(3000)
    And match enabled(viewPageLocator.isEnableToggle) == false

  Scenario: Verify view tag page for tag agent with view permission
    * karate.log('***landing on view page****')
    * def tagIdDetails = scriptAll(viewPageLocator.tagIdDatils, '_.textContent')
    * click(viewPageLocator.dots)
    * karate.log('**Click on dots****')
    * delay(3000)
    * def elements = locateAll(viewPageLocator.tagOptionOnThreeDot)
    * match karate.sizeOf(elements) == 1
    * delay(3000)
    * elements[0].click()
    * def tagVlaueOnView = scriptAll(viewPageLocator.TagValueD, '_.textContent')
    * match tagIdDetails[0] == tagVlaueOnView[1]
    * match tagIdDetails[1] == tagVlaueOnView[0]
    * match tagIdDetails[2] == tagVlaueOnView[2]
    * match tagIdDetails[4] == text(viewPageLocator.commentText)
    * match text(viewPageLocator.viewHistoryButton) == tagPageConstant.viewHistoryButtonText
    * match text(viewPageLocator.importButton) == tagPageConstant.importButtonText
    * def elements = locateAll(viewPageLocator.allTabs)
    * match karate.sizeOf(elements) == 4
    * def tabText = scriptAll(viewPageLocator.allTabs, '_.textContent')
    * match tabText[0] == tagPageConstant.tagDetailsText
    * match tabText[1] == tagPageConstant.tagRelationText
    * match tabText[2] == tagPageConstant.assosiatedCategoriesText
    * match tabText[3] == tagPageConstant.productLookText
    * def allHeadingText = scriptAll(viewPageLocator.allHeadingText, '_.textContent')
    * match  allHeadingText[0] == tagPageConstant.tagNameTxt
    * match  allHeadingText[1] == tagPageConstant.tagIdTxt
    * match  allHeadingText[2] == tagPageConstant.tagTypeTxt
    * match  allHeadingText[3] == tagPageConstant.sequenceTxt
    * match  allHeadingText[4] == tagPageConstant.CommentsTxt
    * match  allHeadingText[5] == tagPageConstant.moderatedByTxt
    * match  allHeadingText[6] == tagPageConstant.moderatedDateTxt
    * match  allHeadingText[7] == tagPageConstant.createdByTxt
    * match  allHeadingText[8] == tagPageConstant.createdDateTxt
    * match  allHeadingText[9] == tagPageConstant.lastModifiedBy
    * match  allHeadingText[10] == tagPageConstant.lastModifiedDate

  Scenario: Verify delete tag on tag list page with tag agent role and view permission
    * karate.log('***landing on view page****')
    * def tagIdDetails = scriptAll(viewPageLocator.tagIdDatils, '_.textContent')
    * click(viewPageLocator.dots)
    * karate.log('**Click on dots****')
    * delay(3000)
    * def elements = locateAll(viewPageLocator.tagOptionOnThreeDot)
    * match karate.sizeOf(elements) == 1
    * delay(3000)
    * def OptionOnDot = scriptAll(viewPageLocator.tagOptionOnThreeDot, '_.textContent')
    * delay(5000)
    * match OptionOnDot[0] != tagPageConstant.delete

  Scenario: Verify delete tag on tag view page with tag agent role and view permission
    * karate.log('***landing on view page****')
    * def tagIdDetails = scriptAll(viewPageLocator.tagIdDatils, '_.textContent')
    * click(viewPageLocator.dots)
    * karate.log('**Click on dots****')
    * delay(3000)
    * def elements = locateAll(viewPageLocator.tagOptionOnThreeDot)
    * match karate.sizeOf(elements) == 1
    * delay(3000)
    * elements[0].click()
    * delay(3000)
    * exists(viewPageLocator.deleteIcon)
