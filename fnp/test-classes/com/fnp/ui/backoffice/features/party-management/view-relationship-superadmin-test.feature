Feature: View Realationship Super Admin User feature

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
    And input(loginLocator.usernameTextArea, usersValue.users.superAdmin.email)
    * delay(30)
    And input(loginLocator.passwordTextArea, usersValue.users.superAdmin.password)
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
    
    
	#REV2-22779
	Scenario: Verify Super Admin can view relatioship tab 
    
    * karate.log('***list screen****')
    * click(relationshipLocators.relationshipTab)
    * delay(100)
    

	#REV2-22780
	Scenario: Verify Super Admin user has Relationship tab present or not.
    
    * karate.log('***list screen****')
    * match text(relationshipLocators.relationshipTab) == relationshipConstants.realtionshipTypeText
    * delay(2000)
    
   
	#REV2-22781
	Scenario: Verify Super Admin user has Relatioship tab displayed or not
    
		* karate.log('***list screen****')
    * match text(relationshipLocators.relationshipTab) == relationshipConstants.realtionshipTypeText
    * delay(2000)
    * click(relationshipLocators.clickOnRelatiosTablink)
    * delay(3000)
    
   
	#REV2-22784/#REV2-22785
  Scenario: Verify Super Admin has create,view,edit,delete permission.
    
    * karate.log('***list screen****')
    * match text(relationshipLocators.relationshipTab) == relationshipConstants.realtionshipTypeText
    * delay(2000)
    * click(relationshipLocators.clickOnRelatiosTablink)
    * delay(3000)
    * click(relationshipLocators.clickOnDots)
    * delay(3000)
    * match text(relationshipLocators.newRelationshipTab) == relationshipConstants.newRelationshipText
    * delay(3000)
    * click(relationshipLocators.clickOnNewRelationshipTab)
    * delay(3000)
    
    
	#REV2-22786
	Scenario: Verify Super Admin user has relationship label when relationship tab info is displayed.
    
    * karate.log('***list screen****')
    * match text(relationshipLocators.relationshipTab) == relationshipConstants.realtionshipTypeText
    * delay(2000)
    * click(relationshipLocators.clickOnRelatiosTablink)
    * delay(3000)
    * click(relationshipLocators.clickOnDots)
    * delay(3000)
    * click(relationshipLocators.clickOnView)
    * delay(3000)
    * match text(relationshipLocators.relationshipLabel) == relationshipConstants.newRelationshipLabelText
    * delay(2000)
    
   
	#REV2-22787
	Scenario: Verify the functionality of Edit button present inside the view relationship with Edit permission.
    
    * karate.log('***list screen****')
    * match text(relationshipLocators.relationshipTab) == relationshipConstants.realtionshipTypeText
    * delay(2000)
    * click(relationshipLocators.clickOnRelatiosTablink)
    * delay(3000)
    * click(relationshipLocators.clickOnDots)
    * delay(3000)
    * click(relationshipLocators.clickOnView)
    * delay(3000)
    * def buttonExists = exists(relationshipLocators.existDeleteButton)
    * delay(3000)
   	* def editOptions = locateAll(relationshipLocators.editButton)
    * delay(3000)
    * editOptions[0].click()
    * delay(3000)
    
  
	#REV2-22788
	Scenario: Verify Super Admin user has Edit button present inside the view relationship with no Edit permission.
    
    * karate.log('***list screen****')
    * match text(relationshipLocators.relationshipTab) == relationshipConstants.realtionshipTypeText
    * delay(2000)
    * click(relationshipLocators.clickOnRelatiosTablink)
    * delay(3000)
    * click(relationshipLocators.clickOnDots)
    * delay(3000)
    * click(relationshipLocators.clickOnView)
    * delay(4000)
    
   
	#REV2-22789
	Scenario: Verify Super Admin user has delete button present inside the view relationship with delete permission.
    
    * karate.log('***list screen****')
    * match text(relationshipLocators.relationshipTab) == relationshipConstants.realtionshipTypeText
    * delay(2000)
    * click(relationshipLocators.clickOnRelatiosTablink)
    * delay(3000)
    * click(relationshipLocators.clickOnDots)
    * delay(3000)
    * click(relationshipLocators.clickOnView)
    * delay(3000)
    * def buttonExists = exists(relationshipLocators.existDeleteButton)
    * delay(3000)
    * def deleteOptions = locateAll(relationshipLocators.deleteButton)
    * delay(3000)
    * deleteOptions[1].click()
    * delay(3000)
    
   
	#REV2-22790
	Scenario: Verify Super Admin user has delete button present inside the view relationship with no delete permission.
    
    * karate.log('***list screen****')
    * match text(relationshipLocators.relationshipTab) == relationshipConstants.realtionshipTypeText
    * delay(2000)
    * click(relationshipLocators.clickOnRelatiosTablink)
    * delay(3000)
    * click(relationshipLocators.clickOnDots)
    * delay(3000)
    * click(relationshipLocators.clickOnView)
    * delay(3000)
    * def buttonExists = exists(relationshipLocators.existDeleteButton)
    * delay(3000)
    * mouse().move(relationshipLocators.deleteButton).click()
    * delay(3000)
    
    