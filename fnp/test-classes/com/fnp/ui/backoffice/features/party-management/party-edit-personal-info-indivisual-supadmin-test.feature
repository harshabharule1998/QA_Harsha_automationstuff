Feature: UI scenarios for update personal information indivisual for super admin

  Background: 
    * def loginLocator = read('../../data/loginPage_locator.json')
    * def usersValue = read('../../data/users.json')
    * def dashBoardLocator = read('../../data//dashboard_locators.json')
    * def editPersonalInfosLocator = read('../../data/party/editPersonalInfoIndi_Page_locators.json')
    * def editPersonalInfosConstant = read('../../data/party/editPersonalInfoIndi_Page_constants.json')
    
    * configure driver = driverConfig
    * driver backOfficeUrl
    * print '***backofficeurl***' backOfficeUrl
    And maximize()
    
    * karate.log('***Logging into the application****')
    And input(loginLocator.usernameTextArea, usersValue.users.superAdmin.email)
    * delay(10)
    And input(loginLocator.passwordTextArea, usersValue.users.superAdmin.password)
    * delay(10)
    
    When click(loginLocator.loginButton)
    * karate.log('***Logging into the application****')
    * delay(10)
    And click(dashBoardLocator.switchMenu)
    * delay(10)
    And click(dashBoardLocator.partyMenu)
    * delay(1000)
		* mouse().move( editPersonalInfosLocator.partyTypeDropdownTxt).click()

    * delay(2000)
    * def dropdownTxt = scriptAll( editPersonalInfosLocator.partyTypeDropdownMenu, '_.textContent')
    * print 'Dropdown', dropdownTxt
    * delay(2000)
    * match dropdownTxt[0] contains 'Individual'
    * match dropdownTxt[1] contains 'Organization'
    * delay(1000)
    
    * def optionOnDropDown = locateAll( editPersonalInfosLocator.partyTypeDropdownMenu)
    * delay(1000)
    * match karate.sizeOf(optionOnDropDown) == 2
    * optionOnDropDown[0].click()
    * delay(2000) 
    
    * input(editPersonalInfosLocator.typePartyId,editPersonalInfosConstant.lablePartyIdText)
    * delay(1000)
    * click(editPersonalInfosLocator.apply)
    * delay(1000)
    * click(editPersonalInfosLocator.typePartyIds)
    * delay(100)
    
  
 	#REV2-35758
	Scenario: Verify personal info tab for Super Admin
    
    * karate.log('***list screen****')
    * match text(editPersonalInfosLocator.partyLabel) == editPersonalInfosConstant.lablePartyIdText
    * delay(2000)
    * exists(editPersonalInfosLocator.editIcon)
    * delay(2000)
    
     
 	#REV2-35759
	Scenario: Verify edit button in personal info tab for Super Admin
    
    * karate.log('***list screen****')
    * match text(editPersonalInfosLocator.partyLabel) == editPersonalInfosConstant.lablePartyIdText
    * delay(2000)
    * exists(editPersonalInfosLocator.editIcon)
    * delay(2000)
    * mouse().move(editPersonalInfosLocator.editIcon).click()
    * delay(2000)
    
   
  #REV2-35760
	Scenario: Verify personal info tab and party label for Super Admin
    
    * karate.log('***list screen****')
    * match text(editPersonalInfosLocator.partyLabel) == editPersonalInfosConstant.lablePartyIdText
    * delay(2000)
    * exists(editPersonalInfosLocator.editIcon)
    * delay(1000)
    * mouse().move(editPersonalInfosLocator.editIcon).click()
    * delay(2000)
    * exists(editPersonalInfosLocator.labelfield)
    * delay(2000)
    * exists(editPersonalInfosLocator.nameField)
    * delay(2000)
    * exists(editPersonalInfosLocator.genderField)
    * delay(2000)
    * exists(editPersonalInfosLocator.dobField)
    * delay(2000)
    * exists(editPersonalInfosLocator.doaField)
    * delay(2000)
    * exists(editPersonalInfosLocator.updateButton)
    * delay(2000)
    * exists(editPersonalInfosLocator.cancelButton)
    * delay(2000)


 	#REV2-35761
	Scenario: Verify Name field in personal info tab for Super Admin
    
    * karate.log('***list screen****')
    * match text(editPersonalInfosLocator.partyLabel) == editPersonalInfosConstant.lablePartyIdText
    * delay(2000)
    * exists(editPersonalInfosLocator.editIcon)
    * delay(2000)
    * mouse().move(editPersonalInfosLocator.editIcon).click()
    * delay(2000)
    * exists(editPersonalInfosLocator.nameField)
    * delay(2000)
    * input(editPersonalInfosLocator.nameField, "abacbabacbacbbacbbcabcbacbabcabcabacbbacbbacbabac")
		* delay(3000)
		* mouse().move(editPersonalInfosLocator.dobField).click()
    * delay(2000)
		* waitForText('body','You have reached the Characters limit')
    * delay(2000)
		* refresh()
		* delay(1000)
    * input(editPersonalInfosLocator.nameField, "abc@")
		* delay(3000)
		* mouse().move(editPersonalInfosLocator.dobField).click()
    * delay(2000)
		* waitForText('body','Party Name is invalid')
    * delay(2000)
    

  #REV2-35762
	Scenario: Verify Gender field in personal info tab for Super Admin
    
    * karate.log('***list screen****')
    * match text(editPersonalInfosLocator.partyLabel) == editPersonalInfosConstant.lablePartyIdText
    * delay(2000)
    * exists(editPersonalInfosLocator.editIcon)
    * delay(2000)
    * mouse().move(editPersonalInfosLocator.editIcon).click()
    * delay(2000)
    * mouse().move(editPersonalInfosLocator.genderField).click()
    * delay(2000)
    * exists(editPersonalInfosLocator.maleOption)
    * delay(2000)
    * exists(editPersonalInfosLocator.femaleOption)
    * delay(2000)
    
  
  #REV2-35763
	Scenario: Verify Date of Birth field in personal info tab for Super Admin
    
    * karate.log('***list screen****')
    * match text(editPersonalInfosLocator.partyLabel) == editPersonalInfosConstant.lablePartyIdText
    * delay(2000)
    * exists(editPersonalInfosLocator.editIcon)
    * delay(2000)
    * mouse().move(editPersonalInfosLocator.editIcon).click()
    * delay(2000)
    * exists(editPersonalInfosLocator.dobField)
    * delay(2000)
    * clear(editPersonalInfosLocator.dobField)
		* delay(2000)
		* click(editPersonalInfosLocator.updateButton)
    * delay(2000)
    
 
  #REV2-35764
	Scenario: Verify Date of Anniversary in personal info tab for Super Admin
    
    * karate.log('***list screen****')
    * match text(editPersonalInfosLocator.partyLabel) == editPersonalInfosConstant.lablePartyIdText
    * delay(2000)
    * exists(editPersonalInfosLocator.editIcon)
    * delay(2000)
    * mouse().move(editPersonalInfosLocator.editIcon).click()
    * delay(2000)
    * exists(editPersonalInfosLocator.dobField)
    * delay(2000)
    * clear(editPersonalInfosLocator.dobField)
		* delay(2000)
		* click(editPersonalInfosLocator.updateButton)
    * delay(2000)
		

	#REV2-35765
	Scenario: Verify Update button in personal info confirmation window for Super Admin
    
    * karate.log('***list screen****')
    * match text(editPersonalInfosLocator.partyLabel) == editPersonalInfosConstant.lablePartyIdText
    * delay(2000)
    * exists(editPersonalInfosLocator.editIcon)
    * delay(2000)
    * mouse().move(editPersonalInfosLocator.editIcon).click()
    * delay(2000)
    * exists(editPersonalInfosLocator.namesField)
    * delay(2000)
    * exists(editPersonalInfosLocator.continueActButton)
    * delay(2000)
    * exists(editPersonalInfosLocator.cancelActButton)
    * delay(2000)
    * exists(editPersonalInfosLocator.crossIcon)
    * delay(2000)
    
    
  #REV2-35766
 	Scenario: Verify Cancel button in update confirmation window for Super Admin
    
    * karate.log('***list screen****')
    * match text(editPersonalInfosLocator.partyLabel) == editPersonalInfosConstant.lablePartyIdText
    * delay(2000)
    * exists(editPersonalInfosLocator.editIcon)
    * delay(2000)
    * mouse().move(editPersonalInfosLocator.editIcon).click()
    * delay(2000)
    * click(editPersonalInfosLocator.updateButton)
    * delay(2000)
    * waitForText('body','Are you sure you want to update personal information?')
    * delay(2000)
    * exists(editPersonalInfosLocator.continueActButton)
    * delay(2000)
    * exists(editPersonalInfosLocator.cancelActButton)
    * delay(2000)
    * exists(editPersonalInfosLocator.crossIcon)
    * delay(2000)
    * click(editPersonalInfosLocator.cancelActButton)
    * delay(2000)
    
    
  #REV2-35767
 	Scenario: Verify Continue button in update confirmation window for Super Admin
    
    * karate.log('***list screen****')
    * match text(editPersonalInfosLocator.partyLabel) == editPersonalInfosConstant.lablePartyIdText
    * delay(2000)
    * exists(editPersonalInfosLocator.editIcon)
    * delay(2000)
    * mouse().move(editPersonalInfosLocator.editIcon).click()
    * delay(2000)
    * click(editPersonalInfosLocator.updateButton)
    * delay(2000)
    * waitForText('body','Are you sure you want to update personal information?')
    * delay(2000)
    * exists(editPersonalInfosLocator.continueActButton)
    * delay(2000)
    * exists(editPersonalInfosLocator.cancelActButton)
    * delay(2000)
    * exists(editPersonalInfosLocator.crossIcon)
    * delay(2000)
    * click(editPersonalInfosLocator.cancelActButton)
    * delay(2000)
    
 
  #REV2-35768
 	Scenario: Verify Cross Icon in update confirmation window for Super Admin
    
    * karate.log('***list screen****')
    * match text(editPersonalInfosLocator.partyLabel) == editPersonalInfosConstant.lablePartyIdText
    * delay(2000)
    * exists(editPersonalInfosLocator.editIcon)
    * delay(2000)
    * mouse().move(editPersonalInfosLocator.editIcon).click()
    * delay(2000)
    * click(editPersonalInfosLocator.updateButton)
    * delay(2000)
    * waitForText('body','Are you sure you want to update personal information?')
    * delay(2000)
    * exists(editPersonalInfosLocator.continueActButton)
    * delay(2000)
    * exists(editPersonalInfosLocator.cancelActButton)
    * delay(2000)
    * exists(editPersonalInfosLocator.crossIcon)
    * delay(2000)
    * mouse().move(editPersonalInfosLocator.crossIcon).click()
    * delay(2000)
		
	
	#REV2-35769
	Scenario: Verify Cancel button in personal info tab for Super Admin
    
    * karate.log('***list screen****')
    * match text(editPersonalInfosLocator.partyLabel) == editPersonalInfosConstant.lablePartyIdText
    * delay(2000)
    * exists(editPersonalInfosLocator.editIcon)
    * delay(2000)
    * mouse().move(editPersonalInfosLocator.editIcon).click()
    * delay(2000)
    * exists(editPersonalInfosLocator.cancelButton)
    * delay(2000)
    * click(editPersonalInfosLocator.cancelButton)
    * delay(2000)
    
    
    
    
		
    
    
		