Feature: Tag management tag agent edit and view permission feature

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
    And input(loginLocator.usernameTextArea, usersValue.users.tagAgent.email)
    * delay(3000)
    When click(loginLocator.continueButton)
    And input(loginLocator.passwordTextArea, usersValue.users.tagAgent.confirmPassword)
    * delay(3000)
    When click(loginLocator.continueButton)
    * delay(3000)
    * def dashboard = locateAll(listPageLocator.dashboardText)
    * def tagIdDetails = scriptAll(listPageLocator.tagIdDetails, '_.textContent')

  Scenario: Verify delete tag Id from tag management list page for tag agent edit and view permission
    * karate.log('***Logging into the application****')
    * click(listPageLocator.dots)
    * delay(3000)
    * def OptionOnDot = scriptAll(listPageLocator.tagOptionOnThreeDot, '_.textContent')
    * delay(5000)
    * match OptionOnDot[0] == 'ViewView'
    * match OptionOnDot[1] == 'EditEdit'
    * match OptionOnDot[0] != 'DeleteDelete'
    * match OptionOnDot[1] != 'DeleteDelete'

  Scenario: Verify edit icon functionality on view tag management screen for tag agent with view and edit permission.
    * karate.log('***Logging into the application****')
    * def tagIdDetails = scriptAll(listPageLocator.tagIdDetails, '_.textContent')
    When click(listPageLocator.dots)
    * karate.log('**Click on dots****')
    * delay(4000)
    * def elements = locateAll(listPageLocator.tagOptionOnThreeDot)
    * match karate.sizeOf(elements) == 2
    * delay(5000)
    * elements[0].click()
    * delay(3000)
    And match enabled(viewPageLocator.editIcon) == true
    * click(viewPageLocator.editIcon)
    And match enabled(viewPageLocator.updateButton) == true
    And match enabled(viewPageLocator.editCancelButton) == true
    * delay(3000)
    And clear(viewPageLocator.sequence)
    * delay(3000)
    * input(viewPageLocator.sequence, tagPageConstant.updateSequenceNumber)
    * delay(3000)
    And clear(viewPageLocator.comment)
    * delay(3000)
    * input(viewPageLocator.comment, tagPageConstant.updatedComment)
    * delay(3000)
    And click(viewPageLocator.updateButton)
    * delay(3000)
    And match text(viewPageLocator.confirmationTextL) == tagPageConstant.ConfirmationTextOnUpdate
    * click(viewPageLocator.actionButton)
    * delay(3000)
    And match text(viewPageLocator.confirmationMessageforTagId) == tagPageConstant.confirmationmessageOnUpdate

  Scenario: Verify is enable toggle functionality on view tag management screen for tag agent with view and edit permission.
    * karate.log('***Logging into the application****')
    * def tagIdDetails = scriptAll(listPageLocator.tagIdDetails, '_.textContent')
    When click(listPageLocator.dots)
    * karate.log('**Click on dots****')
    * delay(4000)
    * def elements = locateAll(listPageLocator.tagOptionOnThreeDot)
    * match karate.sizeOf(elements) == 2
    * delay(5000)
    * elements[0].click()
    * delay(3000)
    And match enabled(viewPageLocator.isEnableToggle) == true
    * click(viewPageLocator.isEnableToggle)
    And match enabled(viewPageLocator.isEnableToggle) == false

  Scenario: Verify is enable toggle functionality on view tag management screen for tag agent with view and edit permission when disable
    * karate.log('***Logging into the application****')
    * def tagIdDetails = scriptAll(listPageLocator.tagIdDetails, '_.textContent')
    When click(listPageLocator.dots)
    * karate.log('**Click on dots****')
    * delay(4000)
    * def elements = locateAll(listPageLocator.tagOptionOnThreeDot)
    * match karate.sizeOf(elements) == 2
    * delay(5000)
    * elements[0].click()
    * delay(3000)
    And match enabled(viewPageLocator.isEnableToggle) == false
    * click(viewPageLocator.isEnableToggle)
    And match enabled(viewPageLocator.isEnableToggle) == true

  Scenario: Verify view tag management screen for tag agent with view and edit permission.
    * karate.log('***landing on view page****')
    * delay(3000)
    * def tagIdDetails = scriptAll(viewPageLocator.tagIdDatils, '_.textContent')
    When click(listPageLocator.dots)
    * karate.log('**Click on dots****')
    * delay(4000)
    * def elements = locateAll(listPageLocator.tagOptionOnThreeDot)
    * match karate.sizeOf(elements) == 2
    * delay(5000)
    * elements[0].click()
    * def tagVlaueOnView = scriptAll(viewPageLocator.TagValueD, '_.textContent')
    * match tagIdDetails[0] == tagVlaueOnView[1]
    * match tagIdDetails[1] == tagVlaueOnView[0]
    * match tagIdDetails[2] == tagVlaueOnView[2]
    * match tagIdDetails[4] == text(viewPageLocator.commentText)
    * match text(viewPageLocator.viewHistoryButton) == tagPageConstant.viewHistoryButtonText
    * match text(viewPageLocator.importButton) == tagPageConstant.importButtonText
    * match enabled(viewPageLocator.editIcon) == true
    * def elements = locateAll(viewPageLocator.allTabs)
    * match karate.sizeOf(elements) == 4
    * def tabText = scriptAll(viewPageLocator.allTabs, '_.textContent')
    * match tabText[0] == tagPageConstant.tagDetailsText
    * match tabText[1] == tagPageConstant.tagRelationText
    * match tabText[2] == tagPageConstant.assosiatedCategoriesText
    * match tabText[3] == tagPageConstant.productLookText
    * def allHeadingText = scriptAll(viewPageLocator.allHeadingText, '_.textContent')
    * match  allHeadingText[2] == tagPageConstant.tagNameTxt
    * match  allHeadingText[3] == tagPageConstant.tagIdTxt
    * match  allHeadingText[4] == tagPageConstant.tagTypeTxt
    * match  allHeadingText[5] == tagPageConstant.sequenceTxt
    * match  allHeadingText[6] == tagPageConstant.CommentsTxt
    * match  allHeadingText[7] == tagPageConstant.moderatedByTxt
    * match  allHeadingText[8] == tagPageConstant.moderatedDateTxt
    * match  allHeadingText[9] == tagPageConstant.createdByTxt
    * match  allHeadingText[10] == tagPageConstant.createdDateTxt
    * match  allHeadingText[11] == tagPageConstant.lastModifiedBy
    * match  allHeadingText[12] == tagPageConstant.lastModifiedDate

  # Defect id: REV2-5044
  Scenario: Verify tag management create tag screen ui for tag agent with create permission.
    * karate.log('***Logging into the application****')
    * def dashboard = locateAll(listPageLocator.dashboardText)
    Then match enabled(listPageLocator.newTagButton) == true
    * click(listPageLocator.newTagButton)
    Then match text(listPageLocator.tagNameL) == tagPageConstant.newTagL
    Then match text(listPageLocator.tagTypeL) == tagPageConstant.tagtypel
    Then match enabled(listPageLocator.cancelButton) == true
    Then match enabled(listPageLocator.createButton) == true
    And input(listPageLocator.tagNameText, tagPageConstant.createTag)
    * input(listPageLocator.sequence, tagPageConstant.sequence)
    * input(listPageLocator.comment, tagPageConstant.comment)
    * delay(5000)
    * click(listPageLocator.tagTypeDropdownIcon)
    * click(listPageLocator.tagTypeValue)
    * click(listPageLocator.createButton)
    And match text(listPageLocator.confirmationTextL) == tagPageConstant.confirmationMessageOnCreate
    * click(listPageLocator.continueButton)
    And match text(listPageLocator.confirmationMessageforTagId) == tagPageConstant.confirmationmessageForCreate
    * dashboard[1].click()
    And input(listPageLocator.inputFld , tagPageConstant.createTag)
    * delay(3000)
    * highlight(listPageLocator.searchButton)
    * click(listPageLocator.searchButton)
    * match text(tagPageConstant.createTag) == tagIdDetails[0]

  # Defect id: REV2-5044
  Scenario: Verify tag agent with view and edit permission gets error when trying to add duplicate tag record
    * karate.log('***Logging into the application****')
    * def dashboard = locateAll(listPageLocator.dashboardText)
    Then match enabled(listPageLocator.newTagButton) == true
    * click(listPageLocator.newTagButton)
    Then match text(listPageLocator.tagNameL) == tagPageConstant.newTagL
    Then match text(listPageLocator.tagTypeL) == tagPageConstant.tagtypel
    Then match enabled(listPageLocator.cancelButton) == true
    Then match enabled(listPageLocator.createButton) == true
    And input(listPageLocator.tagNameText, tagPageConstant.createTag)
    * input(listPageLocator.sequence, tagPageConstant.sequence)
    * input(listPageLocator.comment, tagPageConstant.comment)
    * delay(5000)
    * click(listPageLocator.tagTypeDropdownIcon)
    * click(listPageLocator.tagTypeValue)
    * click(listPageLocator.createButton)
    And match text(listPageLocator.confirmationTextL) == tagPageConstant.confirmationMessageOnCreate
    * click(listPageLocator.continueButton)
    And match text(listPageLocator.confirmationMessageforTagId) == tagPageConstant.errorMessageOnDuplicate

  Scenario: Verify tag management list screen for tag agent with view and edit permission.
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
    * click(listPageLocator.dots)
    * delay(3000)
    * def OptionOnDot = scriptAll(listPageLocator.tagOptionOnThreeDot, '_.textContent')
    * delay(5000)
    * match OptionOnDot[0] == 'ViewView'
    * match OptionOnDot[1] == 'EditEdit'
    * def elements = locateAll(listPageLocator.tagOptionOnThreeDot)
    * match karate.sizeOf(elements) == 2

  Scenario: Verify tag agent should able to see "Created Date","Created By","Modified Date" and "Modified By" fields populated in view screen.
    * karate.log('***landing on view page****')
    * delay(3000)
    * def tagIdDetails = scriptAll(viewPageLocator.tagIdDatils, '_.textContent')
    When click(listPageLocator.dots)
    * karate.log('**Click on dots****')
    * delay(4000)
    * def elements = locateAll(listPageLocator.tagOptionOnThreeDot)
    * match karate.sizeOf(elements) == 2
    * delay(5000)
    * elements[0].click()
    * def allHeadingText = scriptAll(viewPageLocator.allHeadingText, '_.textContent')
    * match  allHeadingText[7] == tagPageConstant.moderatedByTxt
    * match  allHeadingText[8] == tagPageConstant.moderatedDateTxt
    * match  allHeadingText[9] == tagPageConstant.createdByTxt
    * match  allHeadingText[10] == tagPageConstant.createdDateTxt
    * def autoPopulatedTagValues = scriptAll(viewPageLocator.TagValueD, '_.textContent')
    * match text(viewPageLocator.autoPopulatedCreatedBy) == autoPopulatedTagValues[3]
    * match text(viewPageLocator.autoPopulatedCreatedDate) == autoPopulatedTagValues[4]
    * match text(viewPageLocator.autoPopulatedLastModifiedBy) == autoPopulatedTagValues[7]
    * match text(viewPageLocator.autoPopulatedLastModifiedDate) == autoPopulatedTagValues[8]
