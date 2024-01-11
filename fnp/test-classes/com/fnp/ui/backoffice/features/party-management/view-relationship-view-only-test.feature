Feature: View Realationship View only user feature

  Background: 
    * def loginLocator = read('../../data/loginPage_locator.json')
    * def usersValue = read('../../data/users.json')
    * def dashBoardLocator = read('../../data//dashboard_locators.json')
    * def relationshipLocators = read('../../data/party/relationshipPage_locators.json')
    * def relationshipConstants = read('../../data/party/relationshipPage_constants.json')
    
    
    * configure driver = driverConfig
    * driver backOfficeUrl
    * print '***backofficeurl***' backOfficeUrl
    And maximize()
    * karate.log('***Logging into the application****')
    And input(loginLocator.usernameTextArea, usersValue.users.partyViewOnly.email)
    * delay(30)
    And input(loginLocator.passwordTextArea, usersValue.users.partyViewOnly.password)
    * delay(30)
    When click(loginLocator.loginButton)
    * karate.log('***Logging into the application****')
    * delay(300)
    And click(dashBoardLocator.switchMenu)
    * delay(30)
    And click(dashBoardLocator.partyMenu)
    * delay(400)
    * mouse().move(relationshipLocators.partyTypeDropdownTxt).click()
    * delay(200)
    
    * def dropdownTxt = scriptAll(relationshipLocators.partyTypeDropdownMenu, '_.textContent')
    * print 'Dropdown', dropdownTxt
    * match dropdownTxt[0] contains 'Individual'
    * match dropdownTxt[1] contains 'Organization'
    * delay(100)
    
    * def optionOnDropDown = locateAll(relationshipLocators.partyTypeDropdownMenu)
    * delay(1000)
    * match karate.sizeOf(optionOnDropDown) == 2
    * optionOnDropDown[0].click()
    * delay(1000) 
    
    * input(relationshipLocators.typePartyId,relationshipConstants.lablePartyIdText)
    * delay(1000)
    * click(relationshipLocators.clickOnApply)
    * delay(300)
    
    * click(relationshipLocators.clickOnIndiviualPartyId)
    * delay(400)
    
  
	#REV2-22782
  Scenario: Verify View only permission for View only User.
    
    * karate.log('***list screen****')
    * match text(relationshipLocators.relationshipTab) == relationshipConstants.realtionshipTypeText
    * delay(2000)
    * click(relationshipLocators.clickOnRelatiosTablink)
    * delay(3000)
    * click(relationshipLocators.clickOnDots)
    * delay(5000)