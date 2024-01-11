Feature: View Realationship Super Admin User feature

 	Background: 
		* def loginLocator = read('../../data/loginPage_locator.json')
    * def usersValue = read('../../data/users.json')
    * def dashBoardLocator = read('../../data//dashboard_locators.json')
    * def editrelationshipLocators = read('../../data/party/editRelationship_Page_locators.json')
    * def editrelationshipConstants = read('../../data/party/editRelationship_Page_constants.json')
    
    
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
    * mouse().move(editrelationshipLocators.partyTypeDropdownTxt).click()
    * delay(200)
    
    * def dropdownTxt = scriptAll(editrelationshipLocators.partyTypeDropdownMenu, '_.textContent')
    * print 'Dropdown', dropdownTxt
    * match dropdownTxt[0] contains 'Individual'
    * match dropdownTxt[1] contains 'Organization'
    * delay(100)
    
    * def optionOnDropDown = locateAll(editrelationshipLocators.partyTypeDropdownMenu)
    * delay(1000)
    * match karate.sizeOf(optionOnDropDown) == 2
    * optionOnDropDown[0].click()
    * delay(1000) 
    
    * input(editrelationshipLocators.typePartyId,editrelationshipConstants.lablePartyIdText)
    * delay(1000)
    * click(editrelationshipLocators.clickOnApply)
    * delay(300)
    
    * click(editrelationshipLocators.clickOnIndiviualPartyId)
    * delay(400)
  
 
 #REV2-22182
	Scenario: Verify View only user with view functionalities for Relationship tab 
    
    * karate.log('***list screen****')
    * match text(editrelationshipLocators.relationshipTab) == editrelationshipConstants.realtionshipTypeText
    * delay(2000)
    * click(editrelationshipLocators.clickOnRelatiosTablink)
    * delay(3000)
    * click(editrelationshipLocators.clickOnDots)
    * delay(3000)
    
    