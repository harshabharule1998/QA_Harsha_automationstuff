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
    
  
	#REV2-22179
	Scenario: Verify relatioship tab and relationship label for Super Admin
    
    * karate.log('***list screen****')
    * match text(editrelationshipLocators.partyLabel) == editrelationshipConstants.lablePartyIdText
    * delay(2000)
    
   
  #REV2-22180
	Scenario: Verify relatioship tab list for Super Admin
    
    * karate.log('***list screen****')
    * match text(editrelationshipLocators.relationshipTab) == editrelationshipConstants.realtionshipTypeText
    * delay(2000)
    
    
  #REV2-22181
	Scenario: Verify relationship tab list for Super Admin 
    #Verify label present on seo Configuration Tab for Super Admin
    
    * karate.log('***list screen****')
    * match text(editrelationshipLocators.relationshipTab) == editrelationshipConstants.realtionshipTypeText
    * delay(2000)
    * click(editrelationshipLocators.clickOnRelatiosTablink)
    * delay(3000)
    
     
  #REV2-22184
	Scenario: Verify relationship tab with view, edit, delete functionalities for Super Admin
    
    * karate.log('***list screen****')
    * match text(editrelationshipLocators.relationshipTab) == editrelationshipConstants.realtionshipTypeText
    * delay(2000)
    * click(editrelationshipLocators.clickOnRelatiosTablink)
    * delay(3000)
    * click(editrelationshipLocators.clickOnDots)
    * delay(3000)
    
     
  #REV2-22185
	Scenario: Verify relationship tab is dispalyed in editable form for Super Admin
    
    * karate.log('***list screen****')
    * match text(editrelationshipLocators.relationshipTab) == editrelationshipConstants.realtionshipTypeText
    * delay(2000)
    * click(editrelationshipLocators.clickOnRelatiosTablink)
    * delay(3000)
    * click(editrelationshipLocators.clickOnDots)
    * delay(3000)
    * click(editrelationshipLocators.clickOnEdit)
    * delay(3000)
    
    
  #REV2-22186
	Scenario: Verify relatioship tab label in edit form for Super Admin
    
    * karate.log('***list screen****')
    * match text(editrelationshipLocators.relationshipTab) == editrelationshipConstants.realtionshipTypeText
    * delay(2000)
    * click(editrelationshipLocators.clickOnRelatiosTablink)
    * delay(3000)
    * click(editrelationshipLocators.clickOnDots)
    * delay(3000)
    * click(editrelationshipLocators.clickOnEdit)
    * delay(3000)
    * match text(editrelationshipLocators.relationshipLabel) == editrelationshipConstants.relationshipLabelText
    * delay(2000)
    
 
  #REV2-22187
	Scenario: Verify relatioship tab fields in edit form for Super Admin 
    
    * karate.log('***list screen****')
    * match text(editrelationshipLocators.relationshipTab) == editrelationshipConstants.realtionshipTypeText
    * delay(2000)
    * click(editrelationshipLocators.clickOnRelatiosTablink)
    * delay(3000)
    * click(editrelationshipLocators.clickOnDots)
    * delay(3000)
    * click(editrelationshipLocators.clickOnEdit)
    * delay(3000)
    * match text(editrelationshipLocators.relationshipLabel) == editrelationshipConstants.relationshipLabelText
    * delay(2000)
    * def label = scriptAll(editrelationshipLocators.label, '_.textContent')
    * print ' label---' , label
    * match label[0] == editrelationshipConstants.inTheRoleOfText
    * match label[1] == editrelationshipConstants.isAText
    * match label[2] == editrelationshipConstants.partyToText
    * match label[3] == editrelationshipConstants.fromPartyIdText
    * def fromDateLabel = scriptAll(editrelationshipLocators.fromDateLabel, '_.textContent')
    * print ' fromDateLabel -- ' , fromDateLabel
    * match fromDateLabel[0] == editrelationshipConstants.fromDateText
    * match fromDateLabel[1] == editrelationshipConstants.toDateText
    * match text(editrelationshipLocators.updateButton) == editrelationshipConstants.updateButtonText
    * delay(2000)
    * match text(editrelationshipLocators.cancelButton) == editrelationshipConstants.cancelsButtonText
    * delay(2000)
    
   
  #REV2-22188
	Scenario: Verify Party to field in Relationship form for Super Admin
    
    * karate.log('***list screen****')
    * match text(editrelationshipLocators.relationshipTab) == editrelationshipConstants.realtionshipTypeText
    * delay(2000)
    * click(editrelationshipLocators.clickOnRelatiosTablink)
    * delay(3000)
    * click(editrelationshipLocators.clickOnDots)
    * delay(3000)
    * click(editrelationshipLocators.clickOnEdit)
    * delay(3000)
    * match text(editrelationshipLocators.relationshipLabel) == editrelationshipConstants.relationshipLabelText
    * delay(2000)
    * match text(editrelationshipLocators.labelPartyTo) == editrelationshipConstants.partyToTexts
    * delay(2000)
    

  #REV2-22189
	Scenario: Verify In the role field in Relationship form for Super Admin
    
    * karate.log('***list screen****')
    * match text(editrelationshipLocators.relationshipTab) == editrelationshipConstants.realtionshipTypeText
    * delay(2000)
    * click(editrelationshipLocators.clickOnRelatiosTablink)
    * delay(3000)
    * click(editrelationshipLocators.clickOnDots)
    * delay(3000)
    * click(editrelationshipLocators.clickOnEdit)
    * delay(3000)
    * match text(editrelationshipLocators.relationshipLabel) == editrelationshipConstants.relationshipLabelText
    * delay(2000)
    * match text(editrelationshipLocators.labelTheRoleOf) == editrelationshipConstants.inTheRoleOfTexts
    * delay(2000)
    * click(editrelationshipLocators.clickInRoleOf)
    * delay(3000)
    * clear(editrelationshipLocators.clickInRoleOf)
    * delay(3000)
    * value(editrelationshipLocators.clickInRoleOf, "Sa")
		* delay(6000)
		 
	
  #REV2-22190
	Scenario: Verify is A field in editable form for Super Admin 
    
    * karate.log('***list screen****')
    * match text(editrelationshipLocators.relationshipTab) == editrelationshipConstants.realtionshipTypeText
    * delay(2000)
    * click(editrelationshipLocators.clickOnRelatiosTablink)
    * delay(3000)
    * click(editrelationshipLocators.clickOnDots)
    * delay(3000)
    * click(editrelationshipLocators.clickOnEdit)
    * delay(3000)
    * match text(editrelationshipLocators.relationshipLabel) == editrelationshipConstants.relationshipLabelText
    * delay(2000)
    * match text(editrelationshipLocators.labelTheRoleOf) == editrelationshipConstants.inTheRoleOfTexts
    * delay(2000)
    * click(editrelationshipLocators.clickIsA)
    * delay(3000)
    * clear(editrelationshipLocators.clickIsA)
    * delay(3000)
    * value(editrelationshipLocators.clickIsA, "Ven")
		* delay(6000)
	
	
	#REV2-22191
	Scenario: Verify party id field in editable form for Super Admin  
    
    * karate.log('***list screen****')
    * match text(editrelationshipLocators.relationshipTab) == editrelationshipConstants.realtionshipTypeText
    * delay(2000)
    * click(editrelationshipLocators.clickOnRelatiosTablink)
    * delay(3000)
    * click(editrelationshipLocators.clickOnDots)
    * delay(3000)
    * click(editrelationshipLocators.clickOnEdit)
    * delay(3000)
    * match text(editrelationshipLocators.relationshipLabel) == editrelationshipConstants.relationshipLabelText
    * delay(2000)
    * match text(editrelationshipLocators.labelTheRoleOf) == editrelationshipConstants.inTheRoleOfTexts
    * delay(2000)
    * click(editrelationshipLocators.clickFromPartyid)
    * delay(3000)
    * clear(editrelationshipLocators.clickFromPartyid)
    * delay(3000)
    * value(editrelationshipLocators.clickFromPartyid, "C_01160")
		* delay(6000)
		

	#REV2-22192
	Scenario: Verify in the role field in editable form for Super admin 
    
    * karate.log('***list screen****')
    * match text(editrelationshipLocators.relationshipTab) == editrelationshipConstants.realtionshipTypeText
    * delay(2000)
    * click(editrelationshipLocators.clickOnRelatiosTablink)
    * delay(3000)
    * click(editrelationshipLocators.clickOnDots)
    * delay(3000)
    * click(editrelationshipLocators.clickOnEdit)
    * delay(3000)
    * match text(editrelationshipLocators.relationshipLabel) == editrelationshipConstants.relationshipLabelText
    * delay(2000)
    * match text(editrelationshipLocators.labelTheRoleOf) == editrelationshipConstants.inTheRoleOfTexts
    * delay(2000)
    * click(editrelationshipLocators.clickInTheRoleof)
    * delay(3000)
    * clear(editrelationshipLocators.clickInTheRoleof)
    * delay(3000)
    * select(editrelationshipLocators, 's')
    * delay(3000)
    
 
  #REV2-22193
	Scenario: Verify from date field in editable form for Super Admin
    
    * karate.log('***list screen****')
    * match text(editrelationshipLocators.relationshipTab) == editrelationshipConstants.realtionshipTypeText
    * delay(2000)
    * click(editrelationshipLocators.clickOnRelatiosTablink)
    * delay(3000)
    * click(editrelationshipLocators.clickOnDots)
    * delay(3000)
    * click(editrelationshipLocators.clickOnEdit)
    * delay(3000)
    * def fromDateLabel = scriptAll(editrelationshipLocators.fromDateLabel, '_.textContent')
    * print ' fromDateLabel -- ' , fromDateLabel
    * match fromDateLabel[0] == editrelationshipConstants.fromDateText
    

  #REV2-22194
	Scenario: Verify to date field in editable form for Super Admin
    
    * karate.log('***list screen****')
    * match text(editrelationshipLocators.relationshipTab) == editrelationshipConstants.realtionshipTypeText
    * delay(2000)
    * click(editrelationshipLocators.clickOnRelatiosTablink)
    * delay(3000)
    * click(editrelationshipLocators.clickOnDots)
    * delay(3000)
    * click(editrelationshipLocators.clickOnEdit)
    * delay(3000)
    * def fromDateLabel = scriptAll(editrelationshipLocators.fromDateLabel, '_.textContent')
    * print ' fromDateLabel -- ' , fromDateLabel
    * match fromDateLabel[1] == editrelationshipConstants.toDateText
    

  #REV2-22195
	Scenario: Verify tooltip for in the role field in editable form for Super Admin
    
    * karate.log('***list screen****')
    * match text(editrelationshipLocators.relationshipTab) == editrelationshipConstants.realtionshipTypeText
    * delay(2000)
    * click(editrelationshipLocators.clickOnRelatiosTablink)
    * delay(3000)
    * click(editrelationshipLocators.clickOnDots)
    * delay(3000)
    * click(editrelationshipLocators.clickOnEdit)
    * delay(3000)
    * exists(editrelationshipLocators.clickTooltip)
    * delay(3000)
    
    
  #REV2-22196
	Scenario: Verify cancel button in editable form for Super Admin 
    
    * karate.log('***list screen****')
    * match text(editrelationshipLocators.relationshipTab) == editrelationshipConstants.realtionshipTypeText
    * delay(2000)
    * click(editrelationshipLocators.clickOnRelatiosTablink)
    * delay(3000)
    * click(editrelationshipLocators.clickOnDots)
    * delay(3000)
    * click(editrelationshipLocators.clickOnEdit)
    * delay(5000)
    * click(editrelationshipLocators.cancelButton)
    * delay(3000)
    
 
  #REV2-22197
	Scenario: Verify update button in editable form for Super Admin  
    
    * karate.log('***list screen****')
    * match text(editrelationshipLocators.relationshipTab) == editrelationshipConstants.realtionshipTypeText
    * delay(2000)
    * click(editrelationshipLocators.clickOnRelatiosTablink)
    * delay(3000)
    * click(editrelationshipLocators.clickOnDots)
    * delay(3000)
    * click(editrelationshipLocators.clickOnEdit)
    * delay(5000)
    * scroll(editrelationshipLocators.scroll)
    * delay(3000)
   	* click(editrelationshipLocators.updateButton)
    * delay(3000)
    
    
  #REV2-22198
	Scenario:  Verify update confirmation window in editable form  for Super Admin
    
    * karate.log('***list screen****')
    * match text(editrelationshipLocators.relationshipTab) == editrelationshipConstants.realtionshipTypeText
    * delay(2000)
    * click(editrelationshipLocators.clickOnRelatiosTablink)
    * delay(3000)
    * click(editrelationshipLocators.clickOnDots)
    * delay(3000)
    * click(editrelationshipLocators.clickOnEdit)
    * delay(3000)
    * scroll(editrelationshipLocators.scroll)
    * delay(3000)
    * click(editrelationshipLocators.updateButton)
    * delay(3000)
    * match text(editrelationshipLocators.actionCancelButton) == editrelationshipConstants.cancelButtonText
    * delay(2000)
    * match text(editrelationshipLocators.actionContinueButton) == editrelationshipConstants.continueButtonText
    * delay(2000) 
    
 
  #REV2-22199
	Scenario: Verify cancel confirmation window in editable form  for Super Admin 
    
    * karate.log('***list screen****')
    * match text(editrelationshipLocators.relationshipTab) == editrelationshipConstants.realtionshipTypeText
    * delay(2000)
    * click(editrelationshipLocators.clickOnRelatiosTablink)
    * delay(3000)
    * click(editrelationshipLocators.clickOnDots)
    * delay(3000)
    * click(editrelationshipLocators.clickOnEdit)
    * delay(3000)
    * scroll(editrelationshipLocators.scroll)
    * delay(3000)
    * click(editrelationshipLocators.updateButton)
    * delay(3000)
    * click(editrelationshipLocators.actionCancelButton)
    * delay(3000)
    
  
  #REV2-22200
	Scenario:  Verify continue confirmation window in editable form  for Super Admin  
    
    * karate.log('***list screen****')
    * match text(editrelationshipLocators.relationshipTab) == editrelationshipConstants.realtionshipTypeText
    * delay(2000)
    * click(editrelationshipLocators.clickOnRelatiosTablink)
    * delay(3000)
    * click(editrelationshipLocators.clickOnDots)
    * delay(3000)
    * click(editrelationshipLocators.clickOnEdit)
    * delay(3000)
    * scroll(editrelationshipLocators.scroll)
    * delay(3000)
    * click(editrelationshipLocators.updateButton)
    * delay(3000)
    * click(editrelationshipLocators.actionContinueButton)
    * delay(3000)
    
    
  #REV2-22201
	Scenario: Verify update confirmation window in editable form  for Super Admin   
    
    * karate.log('***list screen****')
    * match text(editrelationshipLocators.relationshipTab) == editrelationshipConstants.realtionshipTypeText
    * delay(2000)
    * click(editrelationshipLocators.clickOnRelatiosTablink)
    * delay(3000)
    * click(editrelationshipLocators.clickOnDots)
    * delay(3000)
    * click(editrelationshipLocators.clickOnEdit)
    * delay(3000)
    * scroll(editrelationshipLocators.scroll)
    * delay(3000)
    * click(editrelationshipLocators.updateButton)
    * delay(3000)
    * click(editrelationshipLocators.actionContinueButton)
    * delay(3000)
    * match text(editrelationshipLocators.confirmationMessage) == editrelationshipConstants.confirmationMessageText
    * delay(2000)
    
  
  #REV2-22202
	Scenario: Verify edit and delete in view form for Super Admin
    
    * karate.log('***list screen****')
    * match text(editrelationshipLocators.relationshipTab) == editrelationshipConstants.realtionshipTypeText
    * delay(2000)
    * click(editrelationshipLocators.clickOnRelatiosTablink)
    * delay(3000)
    * click(editrelationshipLocators.clickOnDots)
    * delay(3000)
    * click(editrelationshipLocators.clickOnView)
    * delay(3000)
    * def buttonExists = exists(editrelationshipLocators.deleteButton)
    * delay(3000)
    * def buttonExists = exists(editrelationshipLocators.editButton)
    * delay(3000)
    
    
  #REV2-22203
	Scenario: Verify editable form in relationship tab for Super Admin  
    
    * karate.log('***list screen****')
    * match text(editrelationshipLocators.relationshipTab) == editrelationshipConstants.realtionshipTypeText
    * delay(2000)
    * click(editrelationshipLocators.clickOnRelatiosTablink)
    * delay(3000)
    * click(editrelationshipLocators.clickOnDots)
    * delay(3000)
    * click(editrelationshipLocators.clickOnView)
    * delay(3000)
    * click(editrelationshipLocators.editButton)
    * delay(5000)
    * def label = scriptAll(editrelationshipLocators.label, '_.textContent')
    * print ' label---' , label
    * match label[0] == editrelationshipConstants.inTheRoleOfText
    * match label[1] == editrelationshipConstants.isAText
    * match label[2] == editrelationshipConstants.partyToText
    * match label[3] == editrelationshipConstants.fromPartyIdText
    * def fromDateLabel = scriptAll(editrelationshipLocators.fromDateLabel, '_.textContent')
    * print ' fromDateLabel -- ' , fromDateLabel
    * match fromDateLabel[0] == editrelationshipConstants.fromDateText
    * match fromDateLabel[1] == editrelationshipConstants.toDateText
    * match text(editrelationshipLocators.updateButton) == editrelationshipConstants.updateButtonText
    * delay(2000)
    * match text(editrelationshipLocators.cancelButton) == editrelationshipConstants.cancelsButtonText
    * delay(200)
    

  #REV2-22204
	Scenario: Verify error message in editable form for duplicate relationships for Super Admin
    
    * karate.log('***list screen****')
    * match text(editrelationshipLocators.relationshipTab) == editrelationshipConstants.realtionshipTypeText
    * delay(2000)
    * click(editrelationshipLocators.clickOnRelatiosTablink)
    * delay(3000)
    * click(editrelationshipLocators.clickOnDots)
    * delay(3000)
    * click(editrelationshipLocators.clickOnEdit)
    * delay(3000)
    * mouse().move(editrelationshipLocators.clickIsA).click()
    * delay(2000)
    * click(editrelationshipLocators.clickCreate)
    * delay(2000)
    * click(editrelationshipLocators.updateButton)
    * delay(3000)
    * click(editrelationshipLocators.actionContinueButton)
    * delay(2000)
    * waitForText('body','The relationship already created for the P_01157')
    * delay(2000)
    
    
    
    
    
  