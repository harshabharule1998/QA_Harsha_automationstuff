Feature: Delete realationship Super Admin User feature

 	Background: 
		* def loginLocator = read('../../data/loginPage_locator.json')
    * def usersValue = read('../../data/users.json')
    * def dashBoardLocator = read('../../data//dashboard_locators.json')
    * def deleteRelationshipLocators = read('../../data/party/deleteRelationship_Page_locators.json')
    * def deleteRelationshipConstants = read('../../data/party/deleteRelationship_Page_constants.json')
    
    
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
    * mouse().move(deleteRelationshipLocators.partyTypeDropdownTxt).click()
    * delay(200)
    
    * def dropdownTxt = scriptAll(deleteRelationshipLocators.partyTypeDropdownMenu, '_.textContent')
    * print 'Dropdown', dropdownTxt
    * match dropdownTxt[0] contains 'Individual'
    * match dropdownTxt[1] contains 'Organization'
    * delay(100)
    
    * def optionOnDropDown = locateAll(deleteRelationshipLocators.partyTypeDropdownMenu)
    * delay(1000)
    * match karate.sizeOf(optionOnDropDown) == 2
    * optionOnDropDown[0].click()
    * delay(1000) 
    
    * input(deleteRelationshipLocators.typePartyId,deleteRelationshipConstants.lablePartyIdText)
    * delay(1000)
    * click(deleteRelationshipLocators.apply)
    * delay(300)
    
    * click(deleteRelationshipLocators.indiviualPartyId)
    * delay(400)
    

	#REV2-22294
	Scenario: Verify relatioship tab and relationship label for Super Admin
    
    * karate.log('***list screen****')
    * match text(deleteRelationshipLocators.partyLabel) == deleteRelationshipConstants.lablePartyIdText
    * delay(2000)
    

  #REV2-22295
	Scenario: Verify relatioship tab list for Super Admin
    
    * karate.log('***list screen****')
    * match text(deleteRelationshipLocators.relationshipTab) == deleteRelationshipConstants.realtionshipTypeText
    * delay(2000)
    
   
 	#REV2-22296
	Scenario: Verify relationship tab list for Super Admin 
    
    * karate.log('***list screen****')
    * match text(deleteRelationshipLocators.relationshipTab) == deleteRelationshipConstants.realtionshipTypeText
    * delay(3000)
    * click(deleteRelationshipLocators.relatiosTablink)
    * delay(3000)
    

  #REV2-22299
	Scenario: Verify relationship tab with view, edit, delete functionalities for Super Admin
    
    * karate.log('***list screen****')
    * match text(deleteRelationshipLocators.relationshipTab) == deleteRelationshipConstants.realtionshipTypeText
    * delay(3000)
    * click(deleteRelationshipLocators.relatiosTablink)
    * delay(3000)
    * click(deleteRelationshipLocators.dots)
    * delay(3000)
    * exists(deleteRelationshipLocators.newRelationship)
    * delay(3000)
    
    
  #REV2-22300
	Scenario: Verify delete comfirmation window in relationship tab for Super Admin
    
    * karate.log('***list screen****')
    * match text(deleteRelationshipLocators.relationshipTab) == deleteRelationshipConstants.realtionshipTypeText
    * delay(3000)
    * click(deleteRelationshipLocators.relatiosTablink)
    * delay(3000)
    * click(deleteRelationshipLocators.dots)
    * delay(3000)
    * click(deleteRelationshipLocators.deleteOption)
    * delay(3000)
    * exists(deleteRelationshipLocators.actionCancel)
    * delay(3000)
    * exists(deleteRelationshipLocators.actionDelete)
    * delay(3000)
    
    
  #REV2-22301
	Scenario: Verify Cancel button in delete confirmation window with relationship tab for Super Admin
    
    * karate.log('***list screen****')
    * match text(deleteRelationshipLocators.relationshipTab) == deleteRelationshipConstants.realtionshipTypeText
    * delay(3000)
    * click(deleteRelationshipLocators.relatiosTablink)
    * delay(3000)
    * click(deleteRelationshipLocators.dots)
    * delay(3000)
    * click(deleteRelationshipLocators.deleteOption)
    * delay(3000)
    * click(deleteRelationshipLocators.actionCancel)
    * delay(3000)
    
  
  #REV2-22302
	Scenario: Verify delete button in delete confirmation window with relationship tab for Super Admin
    
    * karate.log('***list screen****')
    * match text(deleteRelationshipLocators.relationshipTab) == deleteRelationshipConstants.realtionshipTypeText
    * delay(3000)
    * click(deleteRelationshipLocators.relatiosTablink)
    * delay(3000)
    * click(deleteRelationshipLocators.dots)
    * delay(3000)
    * click(deleteRelationshipLocators.deleteOption)
    * delay(3000)
    * click(deleteRelationshipLocators.actionDelete)
    * delay(3000)
    

  #REV2-22303
	Scenario: Verify delete confirmation window relationship tab for Super Admin
    
    * karate.log('***list screen****')
    * match text(deleteRelationshipLocators.relationshipTab) == deleteRelationshipConstants.realtionshipTypeText
    * delay(3000)
    * click(deleteRelationshipLocators.relatiosTablink)
    * delay(3000)
    * click(deleteRelationshipLocators.dots)
    * delay(3000)
    * click(deleteRelationshipLocators.deleteOption)
    * delay(3000)
    * click(deleteRelationshipLocators.actionDelete)
    * delay(3000)
    * waitForText('body','Relationship is deleted')
    * delay(2000)
    

  #REV2-22304
	Scenario: Verify delete icon in view with relationship tab for Super Admin
    
    * karate.log('***list screen****')
    * match text(deleteRelationshipLocators.relationshipTab) == deleteRelationshipConstants.realtionshipTypeText
    * delay(3000)
    * click(deleteRelationshipLocators.relatiosTablink)
    * delay(3000)
    * click(deleteRelationshipLocators.dots)
    * delay(3000)
    * click(deleteRelationshipLocators.view)
    * delay(3000)
    * def optionOnDropDowns = locateAll(deleteRelationshipLocators.deleteIcon)
    * delay(1000)
    * match karate.sizeOf(optionOnDropDowns) == 2
    * optionOnDropDowns[1].click()
    * delay(3000)
    * exists(deleteRelationshipLocators.deleteIcon)
    * delay(3000) 
    * exists(deleteRelationshipLocators.actionCancel)
    * delay(3000) 
    * exists(deleteRelationshipLocators.actionDelete)
    * delay(3000)
    

  #REV2-22305
	Scenario: Verify delete confirmation window relationship tab for Super Admin
    
    * karate.log('***list screen****')
    * match text(deleteRelationshipLocators.relationshipTab) == deleteRelationshipConstants.realtionshipTypeText
    * delay(3000)
    * click(deleteRelationshipLocators.relatiosTablink)
    * delay(3000)
    * click(deleteRelationshipLocators.dots)
    * delay(3000)
    * click(deleteRelationshipLocators.view)
    * delay(3000)
    * def optionOnDropDowns = locateAll(deleteRelationshipLocators.deleteIcon)
    * delay(1000)
    * match karate.sizeOf(optionOnDropDowns) == 2
    * optionOnDropDowns[1].click()
    * delay(3000)
    * exists(deleteRelationshipLocators.deleteIcon)
    * delay(3000) 
    * waitForText('body','Are you sure you want to delete this relationship?')
    * delay(2000)
    * exists(deleteRelationshipLocators.actionCancel)
    * delay(3000) 
    * exists(deleteRelationshipLocators.actionDelete)
    * delay(3000)
    
   
  #REV2-22306
	Scenario: Verify cancel and delete button in delete confirmation window in relationship tab for Super Admin
    
    * karate.log('***list screen****')
    * match text(deleteRelationshipLocators.relationshipTab) == deleteRelationshipConstants.realtionshipTypeText
    * delay(3000)
    * click(deleteRelationshipLocators.relatiosTablink)
    * delay(3000)
    * click(deleteRelationshipLocators.dots)
    * delay(3000)
    * click(deleteRelationshipLocators.view)
    * delay(3000)
    * def optionOnDropDowns = locateAll(deleteRelationshipLocators.deleteIcon)
    * delay(1000)
    * match karate.sizeOf(optionOnDropDowns) == 2
    * optionOnDropDowns[1].click()
    * delay(3000)
    * exists(deleteRelationshipLocators.deleteIcon)
    * delay(3000) 
    * click(deleteRelationshipLocators.actionCancel)
    * delay(3000)
    * def optionOnDropDowns = locateAll(deleteRelationshipLocators.deleteIcon)
    * delay(1000)
    * match karate.sizeOf(optionOnDropDowns) == 2
    * optionOnDropDowns[1].click()
    * delay(3000)
    * click(deleteRelationshipLocators.actionDelete)
    * delay(3000)
    * exists(deleteRelationshipLocators.actionCancel)
    * delay(3000) 
    * exists(deleteRelationshipLocators.actionDelete)
    * delay(3000)
    
    
  #REV2-22307
	Scenario: Verify To date less than Current date will deactivate relationship for Super Admin
    
    * karate.log('***list screen****')
    * match text(deleteRelationshipLocators.relationshipTab) == deleteRelationshipConstants.realtionshipTypeText
    * delay(3000)
    * click(deleteRelationshipLocators.relatiosTablink)
    * delay(3000)
    * click(deleteRelationshipLocators.dots)
    * delay(3000)
    * click(deleteRelationshipLocators.view)
    * delay(3000)
    * def optionOnDropDowns = locateAll(deleteRelationshipLocators.deleteIcon)
    * delay(1000)
    * match karate.sizeOf(optionOnDropDowns) == 2
    * optionOnDropDowns[0].click()
    * delay(3000)
    * input(deleteRelationshipLocators.toDate, "11/23/2021")
		* delay(3000)
		* input(deleteRelationshipLocators.toDate, "07:30:30PM")
		* delay(3000)
    
 
   
   

  
   
  	 
   
    
  
    
    
    
    