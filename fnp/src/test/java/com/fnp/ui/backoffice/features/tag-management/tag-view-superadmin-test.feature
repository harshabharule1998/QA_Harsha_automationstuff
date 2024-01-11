Feature: Tag management super admin feature

  Background: 
    * def loginLocator = read('../../data/loginPage_locator.json')
    * def usersValue = read('../../data/users.json')
    * def tagPageConstant = read('../../data/tagPage_constants.json')
    * def viewPageLocator = read('../../data/tagViewPage_locators.json')
    * configure driver = driverConfig
    * driver backOfficeUrl
    * print '***backofficeurl***' backOfficeUrl
    And maximize()
    * karate.log('***Logging into the application****')
    And input(loginLocator.usernameTextArea, usersValue.users.superAdmin.email)
    * delay(3000)
    When click(loginLocator.continueButton)
    And input(loginLocator.passwordTextArea, usersValue.users.superAdmin.password)
    * delay(3000)
    When click(loginLocator.continueButton)
    * delay(3000)
    * def tagIdDetails = scriptAll(viewPageLocator.tagIdDatils, '_.textContent')
    When click(viewPageLocator.dots)
    * karate.log('**Click on dots****')
    * delay(4000)
    * def elements = locateAll(viewPageLocator.tagOptionOnThreeDot)
    * match karate.sizeOf(elements) == 3
    * delay(5000)
    * elements[0].click()

  Scenario: Verify history and import button on view page
    * karate.log('***Logging into the application****')
    And match text(viewPageLocator.viewHistoryButton) == tagPageConstant.viewHistoryButtonText
    * delay(3000)
    And match text(viewPageLocator.importButton) == tagPageConstant.importButtonText

  Scenario: Verify edit and delete icon on view page
    * karate.log('***Logging into the application****')
    * delay(3000)
    And match enabled(viewPageLocator.editIcon) == true
    * delay(3000)
    And match enabled(viewPageLocator.deleteIcon) == true

  Scenario: Verify is enable toggle functionality on view page
    * karate.log('***Logging into the application****')
    * delay(3000)
    And match enabled(viewPageLocator.isEnableToggle) == true
    * click(viewPageLocator.isEnableToggle)
    And match enabled(viewPageLocator.isEnableToggle) == false

  Scenario: Verify is enable toggle functionality on view page when disable
    * karate.log('***Logging into the application****')
    * delay(3000)
    And match enabled(viewPageLocator.isEnableToggle) == false
    * click(viewPageLocator.isEnableToggle)
    And match enabled(viewPageLocator.isEnableToggle) == true

  Scenario: Verify cancel tag delete functionality from view tag page with superAdmin role
    * karate.log('***Logging into the application****')
    * delay(3000)
    * def tagValues = scriptAll(viewPageLocator.TagValueD, '_.textContent')
    And match enabled(viewPageLocator.deleteIcon) == true
    * click(viewPageLocator.deleteIcon)
    And match text(viewPageLocator.confirmationTextL) == tagPageConstant.ConfirmationTextOnDelete
    And match text(viewPageLocator.cancelButton) == tagPageConstant.cancelText
    And match text(viewPageLocator.actionButton) == tagPageConstant.deleteText
    * click(viewPageLocator.cancelButton)
    And match tagValues[0] == tagIdDetails[0]

  Scenario: Verify delete functionality from view tag page with superAdmin role
    * karate.log('***Logging into the application****')
    * delay(3000)
    And match enabled(viewPageLocator.deleteIcon) == true
    * click(viewPageLocator.deleteIcon)
    * print '======tagPageConstant.deleteConfirmationText====', text(viewPageLocator.confirmationText)
    And match text(viewPageLocator.confirmationTextL) == tagPageConstant.ConfirmationTextOnDelete
    And match text(viewPageLocator.cancelButton) == tagPageConstant.cancelText
    And match text(viewPageLocator.actionButton) == tagPageConstant.deleteText
    * click(viewPageLocator.actionButton)
    And match text(viewPageLocator.confirmationMessageforTagId) == tagPageConstant.confirmationmessageOnDelete

  Scenario: Verify edit tag functionality via view tag details screen with superAdmin role
    * karate.log('***Logging into the application****')
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

  Scenario: Verify view tag page for super admin
    * karate.log('***landing on view page****')
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
    * karate.log('***landing on view page****')
    * delay(3000)
    * def tagIdDetails = scriptAll(viewPageLocator.tagIdDatils, '_.textContent')
    When click(listPageLocator.dots)
    * karate.log('**Click on dots****')
    * delay(4000)
    * def elements = locateAll(listPageLocator.tagOptionOnThreeDot)
    * match karate.sizeOf(elements) == 3
    * delay(5000)
    * elements[0].click()
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
