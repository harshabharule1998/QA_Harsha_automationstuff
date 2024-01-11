Feature: Tag Management tag manager feature

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
    And input(loginLocator.usernameTextArea, usersValue.users.tagManager.email)
    * delay(3000)
    When click(loginLocator.continueButton)
    And input(loginLocator.passwordTextArea, usersValue.users.tagManager.password)
    * delay(3000)
    When click(loginLocator.continueButton)
    * delay(3000)
    * def dashboard = locateAll(listPageLocator.dashboardText)
    * def tagIdDetails = scriptAll(listPageLocator.tagIdDetails, '_.textContent')


  Scenario: Verify tag management list screen for tag manager
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
    Then match text(listPageLocator.newTagButton) == tagPageConstant.newTagTxt
    Then match enabled(listPageLocator.newTagButton) == true
    Then match text(listPageLocator.importButton) == tagPageConstant.importButtonText
    Then match enabled(listPageLocator.importButton) == true
    

  Scenario: Verify to create tag screen ui for tag manager with create permission with valid data
    * karate.log('***Logging into the application****')
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

  Scenario: Verify to create tag screen ui for tag manager with create Permission with duplicate values
    * karate.log('***Logging into the application****')
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

  Scenario: Verify cancel button on edit tag details screen for tag manager
    * karate.log('***Logging into the application****')
    * delay(3000)
    * def tagIdDetails = scriptAll(listPageLocator.tagIdDetails, '_.textContent')
    And input(listPageLocator.inputFld , tagIdDetails[0])
    * delay(3000)
    * highlight(listPageLocator.searchButton)
    * click(listPageLocator.searchButton)
    When click(viewPageLocator.dots)
    * karate.log('**Click on dots****')
    * delay(3000)
    * def elements = locateAll(viewPageLocator.tagOptionOnThreeDot)
    * match karate.sizeOf(elements) == 3
    * delay(3000)
    * elements[1].click()
    * karate.log('**Click on dots****')
    * delay(3000)
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
    * click(listPageLocator.cancelButtonOnPopup)
    * dashboard[1].click()
    * delay(3000)
    And input(listPageLocator.inputFld , tagIdDetails[0])
    * delay(3000)
    * highlight(listPageLocator.searchButton)
    * delay(3000)
    * click(listPageLocator.searchButton)
    * delay(3000)
    * match tagIdDetails[3] == text(viewPageLocator.sequence)
    * delay(3000)
    * match tagIdDetails[4] == text(viewPageLocator.comment)

  Scenario: Verify  edit tag functionality via tag list page with tag manager role
    * karate.log('***Logging into the application****')
    * delay(3000)
    * def tagIdDetails = scriptAll(listPageLocator.tagIdDetails, '_.textContent')
    And input(listPageLocator.inputFld , tagIdDetails[0])
    * delay(3000)
    * highlight(listPageLocator.searchButton)
    * click(listPageLocator.searchButton)
    When click(viewPageLocator.dots)
    * karate.log('**Click on dots****')
    * delay(3000)
    * def elements = locateAll(viewPageLocator.tagOptionOnThreeDot)
    * match karate.sizeOf(elements) == 3
    * delay(3000)
    * elements[1].click()
    * karate.log('**Click on dots****')
    * delay(3000)
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

  Scenario: Verify delete tag functionality via tag list page with tag manager role
    * karate.log('***Logging into the application****')
    * delay(3000)
    * def tagIdDetails = scriptAll(listPageLocator.tagIdDetails, '_.textContent')
    And input(listPageLocator.inputFld , tagIdDetails[0])
    * delay(3000)
    * highlight(listPageLocator.searchButton)
    * click(listPageLocator.searchButton)
    When click(viewPageLocator.dots)
    * karate.log('**Click on dots****')
    * delay(3000)
    * def elements = locateAll(viewPageLocator.tagOptionOnThreeDot)
    * match karate.sizeOf(elements) == 3
    * delay(3000)
    * elements[2].click()
    * karate.log('**Click on dots****')
    And match text(viewPageLocator.confirmationTextL) == tagPageConstant.ConfirmationTextOnDelete
    And match text(viewPageLocator.cancelButton) == tagPageConstant.cancelText
    And match text(viewPageLocator.actionButton) == tagPageConstant.deleteText
    * click(viewPageLocator.actionButton)
    And match text(viewPageLocator.confirmationMessageforTagId) == tagPageConstant.confirmationmessageOnDelete

  Scenario: Verify cancel delete tag functionality via tag list page with tag manager role
    * karate.log('***Logging into the application****')
    * delay(3000)
    * def tagIdDetails = scriptAll(listPageLocator.tagIdDetails, '_.textContent')
    And input(listPageLocator.inputFld , tagIdDetails[0])
    * delay(3000)
    * highlight(listPageLocator.searchButton)
    * click(listPageLocator.searchButton)
    When click(viewPageLocator.dots)
    * karate.log('**Click on dots****')
    * delay(3000)
    * def elements = locateAll(viewPageLocator.tagOptionOnThreeDot)
    * def dashboard = locateAll(listPageLocator.dashboardText)
    * match karate.sizeOf(elements) == 3
    * delay(3000)
    * elements[2].click()
    * karate.log('**Click on dots****')
    And match text(viewPageLocator.confirmationTextL) == tagPageConstant.ConfirmationTextOnDelete
    And match text(viewPageLocator.cancelButton) == tagPageConstant.cancelText
    And match text(viewPageLocator.actionButton) == tagPageConstant.deleteText
    * click(viewPageLocator.cancelButton)
    * dashboard[1].click()
    * delay(5000)
    And input(listPageLocator.inputFld , tagIdDetails[0])
    * delay(3000)
    * highlight(listPageLocator.searchButton)
    * click(listPageLocator.searchButton)
    * def tagId = scriptAll(listPageLocator.tagIdDetails, '_.textContent')
    * delay(5000)
    * match tagId[0] == tagIdDetails[0]

  Scenario: Verify history and import button on view page
    * karate.log('***Logging into the application****')
    * delay(3000)
    * def tagIdDetails = scriptAll(viewPageLocator.tagIdDatils, '_.textContent')
    When click(viewPageLocator.dots)
    * karate.log('**Click on dots****')
    * delay(4000)
    * def elements = locateAll(viewPageLocator.tagOptionOnThreeDot)
    * match karate.sizeOf(elements) == 3
    * delay(5000)
    * elements[0].click()
    And match text(viewPageLocator.viewHistoryButton) == tagPageConstant.viewHistoryButtonText
    * delay(3000)
    And match text(viewPageLocator.importButton) == tagPageConstant.importButtonText

  Scenario: Verify edit and delete icon on view page
    * karate.log('***Logging into the application****')
    * delay(3000)
    * def tagIdDetails = scriptAll(viewPageLocator.tagIdDatils, '_.textContent')
    When click(viewPageLocator.dots)
    * karate.log('**Click on dots****')
    * delay(4000)
    * def elements = locateAll(viewPageLocator.tagOptionOnThreeDot)
    * match karate.sizeOf(elements) == 3
    * delay(5000)
    * elements[0].click()
    * delay(3000)
    And match enabled(viewPageLocator.editIcon) == true
    * delay(3000)
    And match enabled(viewPageLocator.deleteIcon) == true

  Scenario: Verify is enable toggle functionality on view page
    * karate.log('***Logging into the application****')
    * delay(3000)
    * def tagIdDetails = scriptAll(viewPageLocator.tagIdDatils, '_.textContent')
    When click(viewPageLocator.dots)
    * karate.log('**Click on dots****')
    * delay(4000)
    * def elements = locateAll(viewPageLocator.tagOptionOnThreeDot)
    * match karate.sizeOf(elements) == 3
    * delay(5000)
    * elements[0].click()
    * delay(3000)
    And match enabled(viewPageLocator.isEnableToggle) == true
    * click(viewPageLocator.isEnableToggle)
    And match enabled(viewPageLocator.isEnableToggle) == false

  Scenario: Verify is enable toggle functionality on view page when disable
    * karate.log('***Logging into the application****')
       * karate.log('***Logging into the application****')
    * delay(3000)
    * def tagIdDetails = scriptAll(viewPageLocator.tagIdDatils, '_.textContent')
    When click(viewPageLocator.dots)
    * karate.log('**Click on dots****')
    * delay(4000)
    * def elements = locateAll(viewPageLocator.tagOptionOnThreeDot)
    * match karate.sizeOf(elements) == 3
    * delay(5000)
    * elements[0].click()
    * delay(3000)
    And match enabled(viewPageLocator.isEnableToggle) == false
    * click(viewPageLocator.isEnableToggle)
    And match enabled(viewPageLocator.isEnableToggle) == true

  Scenario: Verify cancel tag delete functionality from view tag page with tag manager role
    * karate.log('***Logging into the application****')
    * delay(3000)
    * def tagIdDetails = scriptAll(viewPageLocator.tagIdDatils, '_.textContent')
    When click(viewPageLocator.dots)
    * karate.log('**Click on dots****')
    * delay(4000)
    * def elements = locateAll(viewPageLocator.tagOptionOnThreeDot)
    * match karate.sizeOf(elements) == 3
    * delay(5000)
    * elements[0].click()
    * delay(3000)
    * def tagValues = scriptAll(viewPageLocator.TagValueD, '_.textContent')
    And match enabled(viewPageLocator.deleteIcon) == true
    * click(viewPageLocator.deleteIcon)
    And match text(viewPageLocator.confirmationTextL) == tagPageConstant.ConfirmationTextOnDelete
    And match text(viewPageLocator.cancelButton) == tagPageConstant.cancelText
    And match text(viewPageLocator.actionButton) == tagPageConstant.deleteText
    * click(viewPageLocator.cancelButton)
    And match tagValues[0] == tagIdDetails[0]

  Scenario: Verify delete functionality from view tag page with tag manager role
    * karate.log('***Logging into the application****')
    * delay(3000)
    * def tagIdDetails = scriptAll(viewPageLocator.tagIdDatils, '_.textContent')
    When click(viewPageLocator.dots)
    * karate.log('**Click on dots****')
    * delay(4000)
    * def elements = locateAll(viewPageLocator.tagOptionOnThreeDot)
    * match karate.sizeOf(elements) == 3
    * delay(5000)
    * elements[0].click()
    * delay(3000)
    And match enabled(viewPageLocator.deleteIcon) == true
    * click(viewPageLocator.deleteIcon)
    * print '======tagPageConstant.deleteConfirmationText====', text(viewPageLocator.confirmationText)
    And match text(viewPageLocator.confirmationTextL) == tagPageConstant.ConfirmationTextOnDelete
    And match text(viewPageLocator.cancelButton) == tagPageConstant.cancelText
    And match text(viewPageLocator.actionButton) == tagPageConstant.deleteText
    * click(viewPageLocator.actionButton)
    And match text(viewPageLocator.confirmationMessageforTagId) == tagPageConstant.confirmationmessageOnDelete

  Scenario: Verify edit tag functionality via view tag details screen with tag manager role
    * karate.log('***Logging into the application****')
    * delay(3000)
    * def tagIdDetails = scriptAll(viewPageLocator.tagIdDatils, '_.textContent')
    When click(viewPageLocator.dots)
    * karate.log('**Click on dots****')
    * delay(4000)
    * def elements = locateAll(viewPageLocator.tagOptionOnThreeDot)
    * match karate.sizeOf(elements) == 3
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

  Scenario: Verify view tag page for tag manager
    * karate.log('***landing on view page****')
    * delay(3000)
    * def tagIdDetails = scriptAll(viewPageLocator.tagIdDatils, '_.textContent')
    When click(viewPageLocator.dots)
    * karate.log('**Click on dots****')
    * delay(4000)
    * def elements = locateAll(viewPageLocator.tagOptionOnThreeDot)
    * match karate.sizeOf(elements) == 3
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
    * match enabled(viewPageLocator.deleteIcon) == true
    * def elements = locateAll(viewPageLocator.allTabs)
    * match karate.sizeOf(elements) == 4
    * def tabText = scriptAll(viewPageLocator.allTabs, '_.textContent')
    * match tabText[0] == tagPageConstant.tagDetailsText
    * match tabText[1] == tagPageConstant.tagRelationText
    * match tabText[2] == tagPageConstant.assosiatedCategoriesText
    * match tabText[3] == tagPageConstant.productLookText
    * def allHeadingText = scriptAll(viewPageLocator.allHeadingText, '_.textContent')
    * match  allHeadingText[4] == tagPageConstant.tagNameTxt
    * match  allHeadingText[5] == tagPageConstant.tagIdTxt
    * match  allHeadingText[6] == tagPageConstant.tagTypeTxt
    * match  allHeadingText[7] == tagPageConstant.sequenceTxt
    * match  allHeadingText[8] == tagPageConstant.CommentsTxt
    * match  allHeadingText[9] == tagPageConstant.moderatedByTxt
    * match  allHeadingText[10] == tagPageConstant.moderatedDateTxt
    * match  allHeadingText[11] == tagPageConstant.createdByTxt
    * match  allHeadingText[12] == tagPageConstant.createdDateTxt
    * match  allHeadingText[13] == tagPageConstant.lastModifiedBy
    * match  allHeadingText[14] == tagPageConstant.lastModifiedDate

  Scenario: Verify created date created by modified date and modified by fields populated in view page
    * karate.log('***Logging into the application****')
    * delay(3000)
    * def tagIdDetails = scriptAll(viewPageLocator.tagIdDatils, '_.textContent')
    When click(viewPageLocator.dots)
    * karate.log('**Click on dots****')
    * delay(4000)
    * def elements = locateAll(viewPageLocator.tagOptionOnThreeDot)
    * match karate.sizeOf(elements) == 3
    * delay(5000)
    * elements[0].click()
    * delay(3000)
    * def autoPopulatedTagValues = scriptAll(viewPageLocator.TagValueD, '_.textContent')
    * def allHeadingText = scriptAll(viewPageLocator.allHeadingText, '_.textContent')
    * match  allHeadingText[9] == tagPageConstant.moderatedByTxt
    * match  allHeadingText[10] == tagPageConstant.moderatedDateTxt
    * match  allHeadingText[11] == tagPageConstant.createdByTxt
    * match  allHeadingText[12] == tagPageConstant.createdDateTxt
    * match text(viewPageLocator.autoPopulatedCreatedBy) == autoPopulatedTagValues[5]
    * match text(viewPageLocator.autoPopulatedCreatedDate) == autoPopulatedTagValues[6]
    * match text(viewPageLocator.autoPopulatedLastModifiedBy) == autoPopulatedTagValues[7]
    * match text(viewPageLocator.autoPopulatedLastModifiedDate) == autoPopulatedTagValues[8]
