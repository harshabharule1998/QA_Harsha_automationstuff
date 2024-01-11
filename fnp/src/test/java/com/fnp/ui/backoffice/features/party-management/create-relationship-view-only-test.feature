Feature: View Realationship View only User feature

 	Background: 
		* def loginLocator = read('../../data/loginPage_locator.json')
    * def usersValue = read('../../data/users.json')
    * def dashBoardLocator = read('../../data//dashboard_locators.json')
    * def createRelationshipLocators = read('../../data/party/createRelationship_Page_locators.json')
    * def createRelationshipConstants = read('../../data/party/createRelationship_Page_constants.json')
    
    
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
    * mouse().move(createRelationshipLocators.partyTypeDropdownTxt).click()
    * delay(200)
    
    * def dropdownTxt = scriptAll(createRelationshipLocators.partyTypeDropdownMenu, '_.textContent')
    * print 'Dropdown', dropdownTxt
    * match dropdownTxt[0] contains 'Individual'
    * match dropdownTxt[1] contains 'Organization'
    * delay(100)
    
    * def optionOnDropDown = locateAll(createRelationshipLocators.partyTypeDropdownMenu)
    * delay(1000)
    * match karate.sizeOf(optionOnDropDown) == 2
    * optionOnDropDown[0].click()
    * delay(1000) 
    
    * input(createRelationshipLocators.typePartyId,createRelationshipConstants.lablePartyIdText)
    * delay(1000)
    * click(createRelationshipLocators.apply)
    * delay(300)
    
    * click(createRelationshipLocators.indiviualPartyId)
    * delay(400)
  

	#REV2-22154
	Scenario: Verify View only user with view functionalities for Relationship tab 
    
    * karate.log('***list screen****')
    * match text(createRelationshipLocators.relationshipTab) == createRelationshipConstants.realtionshipTypeText
    * delay(2000)
    * click(createRelationshipLocators.relationsTabLink)
    * delay(3000)
    * click(createRelationshipLocators.dots)
    * delay(3000)