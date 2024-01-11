Feature: Assign Security Group name to the Login id of the respective Party

  Background: 
    * def loginLocator = read('../../data/loginPage_locator.json')
    * def usersValue = read('../../data/users.json')
    * def dashBoardLocator = read('../../data//dashboard_locators.json')
    * def securityGroupLocator = read('../../data/party/securityGroupPage_locators.json')
    * def securityGroupConstant = read('../../data/party/securityGroupPage_constants.json')
    * configure driver = driverConfig
    * driver backOfficeUrl
    * print '***backofficeurl***' backOfficeUrl
    And maximize()
    * karate.log('***Logging into the application****')
    And input(loginLocator.usernameTextArea, usersValue.users.superAdmin.email)
    * delay(1000)
    And input(loginLocator.passwordTextArea, usersValue.users.superAdmin.password)
    * delay(1000)
    When click(loginLocator.loginButton)
    * karate.log('***Logging into the application****')
    * delay(1000)
    And click(dashBoardLocator.switchMenu)
    * delay(1000)
    And click(dashBoardLocator.partyMenu)
    * delay(1000)
    * mouse().move(securityGroupLocator.partyTypeDropdownTxt).click()
    * delay(1000)
    * def dropdownTxt = scriptAll(securityGroupLocator.partyTypeDropdownMenu, '_.textContent')
    * print 'Dropdown', dropdownTxt
    * delay(1000)
    * match dropdownTxt[0] contains 'Individual'
    * match dropdownTxt[1] contains 'Organization'
    * delay(1000)
    * def optionOnDropDown = locateAll(securityGroupLocator.partyTypeDropdownMenu)
    * delay(1000)
    * match karate.sizeOf(optionOnDropDown) == 2
    * optionOnDropDown[0].click()
    * delay(1000)
    * input(securityGroupLocator.typePartyId,securityGroupConstant.lablePartyIdText)
    * delay(1000)
    * click(securityGroupLocator.clickOnApply)
    * delay(1000)
    * click(securityGroupLocator.clickOnPartyId)
    * delay(1000)
    * click(securityGroupLocator.usernamesTab)
    * delay(1000)
    * click(securityGroupLocator.threeDots)
    * delay(1000)
    * click(securityGroupLocator.assignSecGrpOption)
    * delay(1000)

  #REV2-19722
  Scenario: Verify the visibility of the "Assign User Login" button to the back office user.
    * match enabled(securityGroupLocator.assignUserLoginButton) == true

  #REV2-19723
  Scenario: Verify the Label after the back office user views the list of assigned security group.
    * match text(securityGroupLocator.assignSecGrpLabel) == securityGroupConstant.assignSecGrpLabelText

  #REV2-19724/REV2-19725
  Scenario: Verify the assign user login page and label when back office user clicks on the "Assign User Login" button.
    * click(securityGroupLocator.assignUserLoginButton)
    * delay(1000)
    * match text(securityGroupLocator.assignUserLoginLabel) == securityGroupConstant.assignUserLoginLabelText
    * delay(3000)

  # REV2-19726
  Scenario: Verify the contents of the assign user login page.
    * click(securityGroupLocator.assignUserLoginButton)
    * delay(1000)
    * def secGrpNameHeader = scriptAll(securityGroupLocator.secGrpNameHeader, '_.textContent')
    * delay(1000)
    * print '---Security group name Header---', secGrpNameHeader
    * click(securityGroupLocator.secGrpDropDown)
    * delay(5000)
    * def listSecGrpName = locateAll(securityGroupLocator.listSecGrpName)
    * print 'karate.sizeOf(listSecGrpName)', karate.sizeOf(listSecGrpName)
    * listSecGrpName[0].click()
    * delay(4000)
    * click(securityGroupLocator.secGrpDropDown)
    * def listSecGrpName = locateAll(securityGroupLocator.listSecGrpName)
    * listSecGrpName[1].click()
    * delay(3000)
    * click(securityGroupLocator.secGrpDropDown)
    * def listSecGrpName = locateAll(securityGroupLocator.listSecGrpName)
    * listSecGrpName[2].click()
    * delay(2000)
    * match enabled(securityGroupLocator.cancelButton) == true
    * match enabled(securityGroupLocator.assignButton) == true

  # REV2-19727/REV2-19728
  Scenario: Verify the functionality of the "CANCEL" and "ASSIGN" button present at the bottom of the assign user login page.
    * click(securityGroupLocator.assignUserLoginButton)
    * delay(1000)
    * match enabled(securityGroupLocator.cancelButton) == true
    * match enabled(securityGroupLocator.assignButton) == true
    * click(securityGroupLocator.cancelButton)
    * match text(securityGroupLocator.assignSecurityGroupText) == securityGroupConstant.assignSecurityGroupText
    * match text(securityGroupLocator.assignUserLoginLabelT) == 'ASSIGN USER LOGIN'
    * click(securityGroupLocator.assignUserLoginButton)
    * delay(1000)
    * click(securityGroupLocator.secGrpDropDown)
    * delay(5000)
    * def listSecGrpName = locateAll(securityGroupLocator.listSecGrpName)
    * print 'karate.sizeOf(listSecGrpName)', karate.sizeOf(listSecGrpName)
    * listSecGrpName[10].click()
    * delay(2000)
    * click(securityGroupLocator.assignButton)
    * delay(1000)
    * waitForText('body', 'Security Group Assigned')
    * delay(5000)
    * karate.log('*** Security Group Assigned ****')
   
  #REV2-19728
  Scenario: Verify the functionality of the "CANCEL" and "ASSIGN" button present at the bottom of the assign user login page.
  
    * click(securityGroupLocator.assignUserLoginButton)
    * delay(1000)
    * click(securityGroupLocator.secGrpDropDown)
    * delay(5000)
    * def listSecGrpName = locateAll(securityGroupLocator.listSecGrpName)
    * print 'karate.sizeOf(listSecGrpName)', karate.sizeOf(listSecGrpName)
    * listSecGrpName[10].click()
    * delay(2000)
    * click(securityGroupLocator.assignButton)
    * delay(1000)
    * waitForText('body', 'Security group is already Present')
    * delay(5000)
    * karate.log('*** Security group is already Present ****')
    

