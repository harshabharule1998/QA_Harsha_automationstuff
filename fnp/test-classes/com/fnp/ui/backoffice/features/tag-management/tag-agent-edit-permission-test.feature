Feature: Tag Agent with edit permission feature

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
    And input(loginLocator.usernameTextArea, usersValue.users.superAdmin.email)
    * delay(3000)
    When click(loginLocator.continueButton)
    And input(loginLocator.passwordTextArea, usersValue.users.superAdmin.password)
    * delay(3000)
    When click(loginLocator.continueButton)
    * delay(3000)
     * def dashboard = locateAll(listPageLocator.users.superAdmin.dashboardText)
    * def tagIdDetails = scriptAll(listPageLocator.users.superAdmin.tagIdDetails, '_.textContent')

  Scenario: Verify tag management list screen for superadmin
    * karate.log('***Logging into the application****')
    Then match text(listPageLocator.users.superAdmin.title) == tagPageConstant.titleText
    Then match text(listPageLocator.users.superAdmin.title1) == tagPageConstant.title1Text
    Then match text(listPageLocator.users.superAdmin.tagManagementH) == tagPageConstant.tagManagementText
    Then match text(listPageLocator.users.superAdmin.tagManagementM) == tagPageConstant.tagManagementText
    Then match text(listPageLocator.users.superAdmin.isEnabledC) == tagPageConstant.isEnableColumn
    Then match text(listPageLocator.users.superAdmin.commentC) == tagPageConstant.commentColumn
    Then match text(listPageLocator.users.superAdmin.sequenceC) == tagPageConstant.sequenceColumn
    Then match text(listPageLocator.users.superAdmin.tagIdC) == tagPageConstant.tagIdColumn
    Then match text(listPageLocator.users.superAdmin.tagNameC) == tagPageConstant.tagNameColumn
    Then match text(listPageLocator.users.superAdmin.tagTypeC) == tagPageConstant.TagTypeColumn
    Then match text(listPageLocator.users.superAdmin.workFlowStatusC) == tagPageConstant.workFlowStatusColumn
    Then match text(listPageLocator.users.superAdmin.newTagButton) == tagPageConstant.newTagTxt
    Then match enabled(listPageLocator.users.superAdmin.newTagButton) == true
    Then match text(listPageLocator.users.superAdmin.importButton) == tagPageConstant.importButtonText
    Then match enabled(listPageLocator.users.superAdmin.importButton) == true

  Scenario: Verify to create tag screen ui for super admin with create permission with valid data
    * karate.log('***Logging into the application****')
    Then match enabled(listPageLocator.users.superAdmin.newTagButton) == true
    * click(listPageLocator.users.superAdmin.newTagButton)
    Then match text(listPageLocator.users.superAdmin.tagNameL) == tagPageConstant.newTagL
    Then match text(listPageLocator.users.superAdmin.tagTypeL) == tagPageConstant.tagtypel
    Then match enabled(listPageLocator.users.superAdmin.cancelButton) == true
    Then match enabled(listPageLocator.users.superAdmin.createButton) == true
    And input(listPageLocator.users.superAdmin.tagNameText, tagPageConstant.createTag)
    * input(listPageLocator.users.superAdmin.sequence, tagPageConstant.sequece)
    * input(listPageLocator.users.superAdmin.comment, tagPageConstant.comment)
    * delay(5000)
    * click(listPageLocator.users.superAdmin.tagTypeDropdownIcon)
    * click(listPageLocator.users.superAdmin.tagTypeValue)
    * click(listPageLocator.users.superAdmin.createButton)
    And match text(listPageLocator.users.superAdmin.confirmationTextL) == tagPageConstant.confirmationMessageOnCreate
    * click(listPageLocator.users.superAdmin.continueButton)
    And match text(listPageLocator.users.superAdmin.confirmationMessageforTagId) == tagPageConstant.confirmationmessageForCreate


