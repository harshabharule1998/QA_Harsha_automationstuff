Feature: Create Realationship Super Admin User feature

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
    
 
	#REV2-22151
	Scenario: Verify relatioship tab and relationship label for Super Admin
    
    * karate.log('***Verify Party Label****')
    * match text(createRelationshipLocators.partyLabel) == createRelationshipConstants.lablePartyIdText
    * delay(2000)
    
 
  #REV2-22152
	Scenario: Verify relatioship tab list for Super Admin
    
    * karate.log('***Verify Relationship Tab ****')
    * match text(createRelationshipLocators.relationshipTab) == createRelationshipConstants.realtionshipTypeText
    * delay(2000)
    
      
  #REV2-22153
	Scenario: Verify relationship tab list is displayed for Super Admin 
    
    * karate.log('***Verify Relationship Tab List****')
    * match text(createRelationshipLocators.relationshipTab) == createRelationshipConstants.realtionshipTypeText
    * delay(2000)
    * click(createRelationshipLocators.relationsTabLink)
    * delay(3000)
    
	
  #REV2-22156
	Scenario: Verify relationship tab with view, edit, delete functionalities for Super Admin
    
    * karate.log('***list screen****')
    * match text(createRelationshipLocators.relationshipTab) == createRelationshipConstants.realtionshipTypeText
    * delay(2000)
    * click(createRelationshipLocators.relationsTabLink)
    * delay(3000)
    * click(createRelationshipLocators.dots)
    * delay(3000)
    * match text(createRelationshipLocators.newRelationshipTab) == createRelationshipConstants.newRelationshipText
    * delay(2000)
    
 
  #REV2-22157
	Scenario: Verify New relation form with relationship tab for Super Admin
    
    * karate.log('***list screen****')
    * match text(createRelationshipLocators.relationshipTab) == createRelationshipConstants.realtionshipTypeText
    * delay(2000)
    * click(createRelationshipLocators.relationsTabLink)
    * delay(3000)
    * click(createRelationshipLocators.newRelationshipTab)
    * delay(3000)
    * def label = scriptAll(createRelationshipLocators.label, '_.textContent')
    * print ' label---' , label
    * match label[0] == createRelationshipConstants.inTheRoleOfText
    * match label[1] == createRelationshipConstants.isAText
    * match label[2] == createRelationshipConstants.partyToText
    * match label[3] == createRelationshipConstants.fromPartyIdText
    * def fromDateLabel = scriptAll(createRelationshipLocators.fromDateLabel, '_.textContent')
    * print ' fromDateLabel -- ' , fromDateLabel
    * match fromDateLabel[0] == createRelationshipConstants.fromDateText
    * match fromDateLabel[1] == createRelationshipConstants.toDateText
    * scroll(createRelationshipLocators.scroll)
    * delay(3000)
    * exists(createRelationshipLocators.cancelButton)
    * delay(3000)
    * exists(createRelationshipLocators.createButton)
    * delay(3000)
    
   
  #REV2-22158
	Scenario: Verify Party to field with relationship tab for Super Admin
    
    * karate.log('***list screen****')
    * match text(createRelationshipLocators.relationshipTab) == createRelationshipConstants.realtionshipTypeText
    * delay(2000)
    * click(createRelationshipLocators.relationsTabLink)
    * delay(3000)
    * click(createRelationshipLocators.newRelationshipTab)
    * delay(3000)
    * match text(createRelationshipLocators.labelPartyTo) == createRelationshipConstants.partyToTexts
    * delay(2000)
      
 	
  #REV2-22159
	Scenario: Verify In the role field in relatiosnhip tab for Super Admin
    
    * karate.log('***Verifying in role field****')
    * match text(createRelationshipLocators.relationshipTab) == createRelationshipConstants.realtionshipTypeText
    * delay(2000)
    * click(createRelationshipLocators.relationsTabLink)
    * delay(3000)
    * click(createRelationshipLocators.newRelationshipTab)
    * delay(3000)
    * mouse().move(createRelationshipLocators.clickOnRole).click()
    * delay(2000)
    * input(createRelationshipLocators.clickOnRole, "Sa")
		* delay(3000)
		* clear(createRelationshipLocators.clickOnRole)
		* delay(3000)
		* scroll(createRelationshipLocators.scroll)
    * delay(3000)
    * click(createRelationshipLocators.createButton)
    * delay(3000)
    * waitForText('body','The form is not valid. Please check for errors')
    * delay(2000)
    

  #REV2-22160
	Scenario: Verify Is a field with relationship tab for Super Admin
    
    * karate.log('***list screen****')
    * match text(createRelationshipLocators.relationshipTab) == createRelationshipConstants.realtionshipTypeText
    * delay(2000)
    * click(createRelationshipLocators.relationsTabLink)
    * delay(3000)
    * click(createRelationshipLocators.newRelationshipTab)
    * delay(3000)
    * mouse().move(createRelationshipLocators.isA).click()
    * delay(2000)
    * input(createRelationshipLocators.isA, "Ven")
		* delay(3000)
		* clear(createRelationshipLocators.isA)
		* delay(3000)
		* scroll(createRelationshipLocators.scroll)
    * delay(3000)
    * click(createRelationshipLocators.createButton)
    * delay(3000)
    * waitForText('body','The form is not valid. Please check for errors')
    * delay(2000)
    
   
  #REV2-22161
	Scenario: Verify From Party ID field with relationship tab for Super Admin
    
    * karate.log('***list screen****')
    * match text(createRelationshipLocators.relationshipTab) == createRelationshipConstants.realtionshipTypeText
    * delay(2000)
    * click(createRelationshipLocators.relationsTabLink)
    * delay(3000)
    * click(createRelationshipLocators.newRelationshipTab)
    * delay(3000)
    * mouse().move(createRelationshipLocators.fromPartyId).click()
    * delay(2000)
    * input(createRelationshipLocators.fromPartyId, "P")
		* delay(3000)
		* clear(createRelationshipLocators.fromPartyId)
		* delay(3000)
		* scroll(createRelationshipLocators.scroll)
    * delay(3000)
    * click(createRelationshipLocators.createButton)
    * delay(3000)
    * waitForText('body','The form is not valid. Please check for errors')
    * delay(2000)
      

 	#REV2-22162
 	Scenario: Verify In the role field in relationsnhip tab for Super Admin
 	
 	  * karate.log('***list screen****')
    * match text(createRelationshipLocators.relationshipTab) == createRelationshipConstants.realtionshipTypeText
    * delay(2000)
    * click(createRelationshipLocators.relationsTabLink)
    * delay(3000)
    * match text(createRelationshipLocators.newRelationshipTab) == createRelationshipConstants.newRelationshipText
    * delay(2000)
    * click(createRelationshipLocators.newRelationshipTab)
    * delay(3000)
    * mouse().move(createRelationshipLocators.clickOnRole).click()
    * delay(2000)
    * click(createRelationshipLocators.tester)
    * delay(2000)
    * mouse().move(createRelationshipLocators.isA).click()
    * delay(2000)
    * click(createRelationshipLocators.vendor)
    * delay(2000)
    * mouse().move(createRelationshipLocators.fromPartyId).click()
    * delay(2000)
    * input(createRelationshipLocators.fromPartyId, "P_")
		* delay(3000)
		* click(createRelationshipLocators.Id)
    * delay(2000)
    * mouse().move(createRelationshipLocators.clickOnRolePartyOf).click()
    * delay(2000)
    * input(createRelationshipLocators.clickOnRolePartyOf, "B")
		* delay(3000)
    * click(createRelationshipLocators.optionB2C)
    * delay(2000)
    * clear(createRelationshipLocators.clickOnRolePartyOf)
		* delay(3000)
		* scroll(createRelationshipLocators.scroll)
    * delay(3000)
    * click(createRelationshipLocators.createButton)
    * delay(3000)
    * waitForText('body','The form is not valid. Please check for errors')
    * delay(2000)
    
 
  #REV2-22163
	Scenario: Verify From date field in relationship tab for Super Admin
    
    * karate.log('***list screen****')
    * match text(createRelationshipLocators.relationshipTab) == createRelationshipConstants.realtionshipTypeText
    * delay(2000)
    * click(createRelationshipLocators.relationsTabLink)
    * delay(3000)
    * click(createRelationshipLocators.newRelationshipTab)
    * delay(3000)
    * scroll(createRelationshipLocators.scroll)
    * delay(3000)
    * match text(createRelationshipLocators.fromDate) == createRelationshipConstants.fromDateText
    * delay(2000)
    * click(createRelationshipLocators.createButton)
    * delay(3000)
    * waitForText('body','The form is not valid. Please check for errors')
    * delay(2000)
    
  
  #REV2-22164
	Scenario: Verify From To date field in relationship tab for Super Admin
    
    * karate.log('***list screen****')
    * match text(createRelationshipLocators.relationshipTab) == createRelationshipConstants.realtionshipTypeText
    * delay(2000)
    * click(createRelationshipLocators.relationsTabLink)
    * delay(3000)
    * click(createRelationshipLocators.newRelationshipTab)
    * delay(3000)
    * scroll(createRelationshipLocators.scroll)
    * delay(3000)
    * match text(createRelationshipLocators.toDate) == createRelationshipConstants.toDateText
    * delay(2000)
    * click(createRelationshipLocators.createButton)
    * delay(3000)
    * waitForText('body','The form is not valid. Please check for errors')
    * delay(2000)
    
    
  #REV2-22165
	Scenario: Verify tooltip for In the role field in new relationship tab for Super Admin
    
    * karate.log('***list screen****')
    * match text(createRelationshipLocators.relationshipTab) == createRelationshipConstants.realtionshipTypeText
    * delay(2000)
    * click(createRelationshipLocators.relationsTabLink)
    * delay(3000)
    * match text(createRelationshipLocators.newRelationshipTab) == createRelationshipConstants.newRelationshipText
    * delay(2000)
    * click(createRelationshipLocators.newRelationshipTab)
    * delay(3000)
    * exists(createRelationshipLocators.tooltip)
    * delay(3000)
      
 
  #REV2-22166
	Scenario: Verify label in New relationship tab for Super Admin
    
    * karate.log('***list screen****')
    * match text(createRelationshipLocators.relationshipTab) == createRelationshipConstants.realtionshipTypeText
    * delay(2000)
    * click(createRelationshipLocators.relationsTabLink)
    * delay(3000)
    * match text(createRelationshipLocators.newRelationshipTab) == createRelationshipConstants.newRelationshipText
    * delay(2000)
    * click(createRelationshipLocators.newRelationshipTab)
    * delay(3000)
    * match text(createRelationshipLocators.relationshipLabel) == createRelationshipConstants.relationshipLabelText
    * delay(2000)
    
  
  #REV2-22167
	Scenario: Verify Cancel button in new relationship tab for Super Admin
    
    * karate.log('***list screen****')
    * match text(createRelationshipLocators.relationshipTab) == createRelationshipConstants.realtionshipTypeText
    * delay(2000)
    * click(createRelationshipLocators.relationsTabLink)
    * delay(3000)
    * match text(createRelationshipLocators.newRelationshipTab) == createRelationshipConstants.newRelationshipText
    * delay(2000)
    * click(createRelationshipLocators.newRelationshipTab)
    * delay(3000)
    * mouse().move(createRelationshipLocators.clickOnRole).click()
    * delay(2000)
    * click(createRelationshipLocators.tester)
    * delay(2000)
    * mouse().move(createRelationshipLocators.isA).click()
    * delay(2000)
    * click(createRelationshipLocators.vendor)
    * delay(2000)
    * mouse().move(createRelationshipLocators.fromPartyId).click()
    * delay(2000)
    * input(createRelationshipLocators.fromPartyId, "P_")
		* delay(3000)
		* click(createRelationshipLocators.Id)
    * delay(2000)
    * mouse().move(createRelationshipLocators.clickOnRolePartyOf).click()
    * delay(2000)
    * input(createRelationshipLocators.clickOnRolePartyOf, "COCO")
		* delay(3000)
		* scroll(createRelationshipLocators.scroll)
    * delay(3000)
		* click(createRelationshipLocators.cancelButton)
    * delay(2000)
    

  #REV2-22168
	Scenario: Verify Create button in new relationship form for Super Admin
    
    * karate.log('***list screen****')
    * match text(createRelationshipLocators.relationshipTab) == createRelationshipConstants.realtionshipTypeText
    * delay(2000)
    * click(createRelationshipLocators.relationsTabLink)
    * delay(3000)
    * match text(createRelationshipLocators.newRelationshipTab) == createRelationshipConstants.newRelationshipText
    * delay(2000)
    * click(createRelationshipLocators.newRelationshipTab)
    * delay(3000)
    * mouse().move(createRelationshipLocators.clickOnRole).click()
    * delay(2000)
    * click(createRelationshipLocators.tester)
    * delay(2000)
    * mouse().move(createRelationshipLocators.isA).click()
    * delay(2000)
    * click(createRelationshipLocators.vendor)
    * delay(2000)
    * mouse().move(createRelationshipLocators.fromPartyId).click()
    * delay(2000)
    * input(createRelationshipLocators.fromPartyId, "P_")
		* delay(3000)
		* click(createRelationshipLocators.Id)
    * delay(2000)
    * mouse().move(createRelationshipLocators.clickOnRolePartyOf).click()
    * delay(2000)
    * click(createRelationshipLocators.optionB2C)
    * delay(2000)
		* mouse().move(createRelationshipLocators.date).click()
    * delay(2000)
		* input(createRelationshipLocators.date, "11/18/2021")
		* delay(3000)
		* scroll(createRelationshipLocators.scroll)
    * delay(3000)
    * click(createRelationshipLocators.createButton)
    * delay(3000)
    * click(createRelationshipLocators.confirmationContinueButton)
    * delay(3000)
    
   
  #REV2-22170
	Scenario: Verify Cancel button in new relationship confirmation window for Super Admin
    
    * karate.log('***list screen****')
    * match text(createRelationshipLocators.relationshipTab) == createRelationshipConstants.realtionshipTypeText
    * delay(2000)
    * click(createRelationshipLocators.relationsTabLink)
    * delay(3000)
    * match text(createRelationshipLocators.newRelationshipTab) == createRelationshipConstants.newRelationshipText
    * delay(2000)
    * click(createRelationshipLocators.newRelationshipTab)
    * delay(3000)
    * mouse().move(createRelationshipLocators.clickOnRole).click()
    * delay(2000)
    * click(createRelationshipLocators.tester)
    * delay(2000)
    * mouse().move(createRelationshipLocators.isA).click()
    * delay(2000)
    * click(createRelationshipLocators.vendor)
    * delay(2000)
    * mouse().move(createRelationshipLocators.fromPartyId).click()
    * delay(2000)
    * input(createRelationshipLocators.fromPartyId, "P_")
		* delay(3000)
		* click(createRelationshipLocators.Id)
    * delay(2000)
    * mouse().move(createRelationshipLocators.clickOnRolePartyOf).click()
    * delay(2000)
    * click(createRelationshipLocators.optionB2C)
    * delay(2000)
		* mouse().move(createRelationshipLocators.date).click()
    * delay(2000)
		* input(createRelationshipLocators.date, "11/18/2021")
		* delay(3000)
		* scroll(createRelationshipLocators.scroll)
    * delay(3000)
    * click(createRelationshipLocators.createButton)
    * delay(3000)
    * click(createRelationshipLocators.confirmationCancelButton)
    * delay(3000)
    

  #REV2-22172
	Scenario: Verify Confirmation message inside new relationship tab for Super Admin
    
    * karate.log('***list screen****')
    * match text(createRelationshipLocators.relationshipTab) == createRelationshipConstants.realtionshipTypeText
    * delay(2000)
    * click(createRelationshipLocators.relationsTabLink)
    * delay(3000)
    * match text(createRelationshipLocators.newRelationshipTab) == createRelationshipConstants.newRelationshipText
    * delay(2000)
    * click(createRelationshipLocators.newRelationshipTab)
    * delay(3000)
    * mouse().move(createRelationshipLocators.clickOnRole).click()
    * delay(2000)
    * click(createRelationshipLocators.employeeOption)
    * delay(2000)
    * mouse().move(createRelationshipLocators.isA).click()
    * delay(2000)
    * click(createRelationshipLocators.employeeOptionIsa)
    * delay(2000)
    * mouse().move(createRelationshipLocators.fromPartyId).click()
    * delay(2000)
    * input(createRelationshipLocators.fromPartyId, "P_")
		* delay(3000)
		* click(createRelationshipLocators.Id)
    * delay(2000)
    * mouse().move(createRelationshipLocators.clickOnRolePartyOf).click()
    * delay(2000)
    * click(createRelationshipLocators.optionB2C)
    * delay(2000)
		* mouse().move(createRelationshipLocators.date).click()
    * delay(2000)
		* input(createRelationshipLocators.date, "11/18/2021")
		* delay(3000)
		* scroll(createRelationshipLocators.scroll)
    * delay(3000)
    * click(createRelationshipLocators.createButton)
    * delay(3000)
    * click(createRelationshipLocators.confirmationContinueButton)
    * delay(3000)
    * waitForText('body','New relationship created')
    * delay(2000)
    
   
  #REV2-22173
	Scenario: Verify error message in new relationship form for duplicate relationships for Super Admin 
    
    * karate.log('***list screen****')
    * match text(createRelationshipLocators.relationshipTab) == createRelationshipConstants.realtionshipTypeText
    * delay(2000)
    * click(createRelationshipLocators.relationsTabLink)
    * delay(3000)
    * match text(createRelationshipLocators.newRelationshipTab) == createRelationshipConstants.newRelationshipText
    * delay(2000)
    * click(createRelationshipLocators.newRelationshipTab)
    * delay(3000)
    * mouse().move(createRelationshipLocators.clickOnRole).click()
    * delay(2000)
    * click(createRelationshipLocators.tester)
    * delay(2000)
    * mouse().move(createRelationshipLocators.isA).click()
    * delay(2000)
    * click(createRelationshipLocators.vendor)
    * delay(2000)
    * mouse().move(createRelationshipLocators.fromPartyId).click()
    * delay(2000)
    * input(createRelationshipLocators.fromPartyId, "P_")
		* delay(3000)
		* click(createRelationshipLocators.Id)
    * delay(2000)
    * mouse().move(createRelationshipLocators.clickOnRolePartyOf).click()
    * delay(2000)
    * click(createRelationshipLocators.optionB2C)
    * delay(2000)
		* mouse().move(createRelationshipLocators.date).click()
    * delay(2000)
		* input(createRelationshipLocators.date, "11/18/2021")
		* delay(3000)
		* scroll(createRelationshipLocators.scroll)
    * delay(3000)
    * click(createRelationshipLocators.createButton)
    * delay(3000)
    * click(createRelationshipLocators.confirmationContinueButton)
    * delay(3000)
    * waitForText('body','The relationship already created for the P_01157')
    * delay(2000)
    
    
		
		
    
   
    
    
    		
    		
    
    
    
    
