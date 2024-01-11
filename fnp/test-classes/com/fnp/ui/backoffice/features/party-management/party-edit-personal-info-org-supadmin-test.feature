Feature: UI scenarios for update personal information for super admin

  Background: 
    * def loginLocator = read('../../data/loginPage_locator.json')
    * def usersValue = read('../../data/users.json')
    * def dashBoardLocator = read('../../data//dashboard_locators.json')
    * def editPersonalInfoLocator = read('../../data/party/editPersonalInfo_Page_locators.json')
    * def editPersonalInfoConstant = read('../../data/party/editPersonalInfo_Page_constants.json')
    
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
    * delay(1020)
		* mouse().move( editPersonalInfoLocator.partyTypeDropdownTxt).click()

    * delay(2000)
    * def dropdownTxt = scriptAll( editPersonalInfoLocator.partyTypeDropdownMenu, '_.textContent')
    * print 'Dropdown', dropdownTxt
    * delay(2000)
    * match dropdownTxt[0] contains 'Individual'
    * match dropdownTxt[1] contains 'Organization'
    * delay(1000)
    
    * def optionOnDropDown = locateAll( editPersonalInfoLocator.partyTypeDropdownMenu)
    * delay(1000)
    * match karate.sizeOf(optionOnDropDown) == 2
    * optionOnDropDown[1].click()
    * delay(2000) 
    
    * input(editPersonalInfoLocator.typePartyId,editPersonalInfoConstant.lablePartyIdText)
    * delay(1000)
    * click(editPersonalInfoLocator.apply)
    * delay(1000)
    * click(editPersonalInfoLocator.typePartyIds)
    * delay(100)
		
	
	#REV2-35773
	Scenario: Verify personal info tab and relationship label for Super Admin
    
    * karate.log('***list screen****')
    * match text(editPersonalInfoLocator.partyLabel) == editPersonalInfoConstant.lablePartyIdText
    * delay(2000)
    * exists(editPersonalInfoLocator.editIcon)
    * delay(1000)
    * def label = scriptAll(editPersonalInfoLocator.label, '_.textContent')
    * print ' label---' , label
    * match label[0] == editPersonalInfoConstant.partyIdsText
    * match label[1] == editPersonalInfoConstant.partyStatusText
    * match label[10] == editPersonalInfoConstant.partyTypeStatus
    * match label[11] == editPersonalInfoConstant.partyClassifyText
    * match label[12] == editPersonalInfoConstant.personalInfText
    * match label[13] == editPersonalInfoConstant.usernamesText
    * match label[14] == editPersonalInfoConstant.contactInfText
    * match label[15] == editPersonalInfoConstant.relationshipText
    * match label[16] == editPersonalInfoConstant.rolesText
    * match label[20] == editPersonalInfoConstant.contactPersonNameText
    * match label[21] == editPersonalInfoConstant.designationText
    * match label[22] == editPersonalInfoConstant.organizationText
    * match label[23] == editPersonalInfoConstant.taxVatText
    * match label[24] == editPersonalInfoConstant.faxNoText
  
  
  #REV2-35774
	Scenario: Verify edit button in personal info tab for Super Admin
    
    * karate.log('***list screen****')
    * match text(editPersonalInfoLocator.partyLabel) == editPersonalInfoConstant.lablePartyIdText
    * delay(2000)
    * exists(editPersonalInfoLocator.editIcon)
    * delay(2000)
    * mouse().move(editPersonalInfoLocator.editIcon).click()
    * delay(2000)
    
  
  #REV2-35775
	Scenario: Verify edit page content in personal info tab for Super Admin
    
    * karate.log('***list screen****')
    * match text(editPersonalInfoLocator.partyLabel) == editPersonalInfoConstant.lablePartyIdText
    * delay(2000)
    * exists(editPersonalInfoLocator.editIcon)
    * delay(2000)
    * mouse().move(editPersonalInfoLocator.editIcon).click()
    * delay(2000)
    * exists(editPersonalInfoLocator.contactPersonField)
    * delay(2000)
    * exists(editPersonalInfoLocator.designationField)
    * delay(2000)
    * exists(editPersonalInfoLocator.orgNameField)
    * delay(2000)
    * exists(editPersonalInfoLocator.vatNumberField)
    * delay(2000)  
    * exists(editPersonalInfoLocator.faxNumberField)
    * delay(2000) 
    * exists(editPersonalInfoLocator.orgLabel)
    * delay(2000)
    * exists(editPersonalInfoLocator.updateButton)
    * delay(2000)
    * exists(editPersonalInfoLocator.cancelButton)
    * delay(2000) 
    

  #REV2-35776
	Scenario: Verify contact person name field in personal info tab for Super Admin
    
    * karate.log('***list screen****')
    * match text(editPersonalInfoLocator.partyLabel) == editPersonalInfoConstant.lablePartyIdText
    * delay(2000)
    * exists(editPersonalInfoLocator.editIcon)
    * delay(2000)
    * mouse().move(editPersonalInfoLocator.editIcon).click()
    * delay(2000)
    * exists(editPersonalInfoLocator.contactPersonField)
    * delay(2000)
    * input(editPersonalInfoLocator.contactPersonField, "abcabcbacbabcabcabacbabacbacbbacbbacbbacbbacbabac")
		* delay(3000)
		* mouse().move(editPersonalInfoLocator.designationField).click()
    * delay(2000)
		* waitForText('body','You have reached the Characters limit')
    * delay(2000)
    * clear(editPersonalInfoLocator.contactPersonField)
		* delay(2000)
		* exists(editPersonalInfoLocator.errorMsg)
    * delay(2000)


	#REV2-35777
	Scenario: Verify designation field in personal info tab for Super Admin
    
    * karate.log('***list screen****')
    * match text(editPersonalInfoLocator.partyLabel) == editPersonalInfoConstant.lablePartyIdText
    * delay(2000)
    * exists(editPersonalInfoLocator.editIcon)
    * delay(2000)
    * mouse().move(editPersonalInfoLocator.editIcon).click()
    * delay(2000)
    * click(editPersonalInfoLocator.updateButton)
    * delay(3000)
    * mouse().move(editPersonalInfoLocator.crossIcon).click()
    * delay(2000)
    * exists(editPersonalInfoLocator.designationField)
    * delay(2000)
    * input(editPersonalInfoLocator.designationField, "abc@")
		* delay(3000)
		* mouse().move(editPersonalInfoLocator.orgNameField).click()
    * delay(2000)
		* waitForText('body','Designation is invalid')
    * delay(2000)
    * clear(editPersonalInfoLocator.designationField)
		* delay(2000)

 		
  #REV2-35778
	Scenario: Verify organization field in personal info tab Super Admin
    
    * karate.log('***list screen****')
    * match text(editPersonalInfoLocator.partyLabel) == editPersonalInfoConstant.lablePartyIdText
    * delay(2000)
    * exists(editPersonalInfoLocator.editIcon)
    * delay(2000)
    * mouse().move(editPersonalInfoLocator.editIcon).click()
    * delay(2000)
    * exists(editPersonalInfoLocator.orgNameField)
    * delay(2000)
    * clear(editPersonalInfoLocator.orgNameField)
		* delay(2000)
    * input(editPersonalInfoLocator.orgNameField, "abc.@")
		* delay(3000)
		* mouse().move(editPersonalInfoLocator.vatNumberField).click()
    * delay(2000)
		* waitForText('body','Organization Name is invalid')
    * delay(2000)
    * clear(editPersonalInfoLocator.orgNameField)
		* delay(2000)
		* mouse().move(editPersonalInfoLocator.vatNumberField).click()
    * delay(2000)
		* exists(editPersonalInfoLocator.orgErrorMsg)
    * delay(2000)
   
  
  #REV2-35779
	Scenario: Verify Tax/Vat field in personal info tab for Super Admin
    
    * karate.log('***list screen****')
    * match text(editPersonalInfoLocator.partyLabel) == editPersonalInfoConstant.lablePartyIdText
    * delay(2000)
    * exists(editPersonalInfoLocator.editIcon)
    * delay(2000)
    * mouse().move(editPersonalInfoLocator.editIcon).click()
    * delay(2000)
   	* click(editPersonalInfoLocator.updateButton)
    * delay(3000)
    * mouse().move(editPersonalInfoLocator.crossIcon).click()
    * delay(2000)
    * exists(editPersonalInfoLocator.vatNumberField)
    * delay(2000)
    * clear(editPersonalInfoLocator.vatNumberField)
		* delay(2000)
    * input(editPersonalInfoLocator.vatNumberField, "abc.")
		* delay(3000)
		* mouse().move(editPersonalInfoLocator.faxNumberField).click()
    * delay(2000)
		* waitForText('body','The field will allow only Alphanumeric Value.')
    * delay(2000)
    * clear(editPersonalInfoLocator.vatNumberField)
		* delay(2000)
		
  
  #REV2-35780
	Scenario: Verify Fax field in personal info tab for Super Admin
    
    * karate.log('***list screen****')
    * match text(editPersonalInfoLocator.partyLabel) == editPersonalInfoConstant.lablePartyIdText
    * delay(2000)
    * exists(editPersonalInfoLocator.editIcon)
    * delay(2000)
    * mouse().move(editPersonalInfoLocator.editIcon).click()
    * delay(2000)
    * click(editPersonalInfoLocator.updateButton)
    * delay(3000)
    * mouse().move(editPersonalInfoLocator.crossIcon).click()
    * delay(2000)
    * exists(editPersonalInfoLocator.faxNumberField)
    * delay(2000)
    * input(editPersonalInfoLocator.faxNumberField, "123.")
		* delay(3000)
		* mouse().move(editPersonalInfoLocator.vatNumberField).click()
    * delay(2000)
		* waitForText('body','The field will allow only Numeric Value.')
    * delay(2000)
    * clear(editPersonalInfoLocator.faxNumberField)
		* delay(2000)


  #REV2-35781
	Scenario: Verify update button in personal info tab for Super Admin
    
    * karate.log('***list screen****')
    * match text(editPersonalInfoLocator.partyLabel) == editPersonalInfoConstant.lablePartyIdText
    * delay(2000)
    * exists(editPersonalInfoLocator.editIcon)
    * delay(2000)
    * mouse().move(editPersonalInfoLocator.editIcon).click()
    * delay(2000)
    * exists(editPersonalInfoLocator.contactPersonField)
    * delay(2000)
    * input(editPersonalInfoLocator.contactPersonField, "sh")
		* delay(3000)
		* mouse().move(editPersonalInfoLocator.orgNameField).click()
    * delay(2000)
    * input(editPersonalInfoLocator.orgNameField, "1")
		* delay(3000)
		* click(editPersonalInfoLocator.updateButton)
    * delay(3000)
    * click(editPersonalInfoLocator.continueActButton)
    * delay(3000)
    
 	 
  #REV2-35782
	Scenario: Verify Cancel confirmation window in personal info tab for Super Admin
    
    * karate.log('***list screen****')
    * match text(editPersonalInfoLocator.partyLabel) == editPersonalInfoConstant.lablePartyIdText
    * delay(2000)
    * exists(editPersonalInfoLocator.editIcon)
    * delay(2000)
    * mouse().move(editPersonalInfoLocator.editIcon).click()
    * delay(2000)
    * exists(editPersonalInfoLocator.contactPersonField)
    * delay(2000)
    * input(editPersonalInfoLocator.contactPersonField, "esh")
		* delay(3000)
		* mouse().move(editPersonalInfoLocator.orgNameField).click()
    * delay(2000)
    * input(editPersonalInfoLocator.orgNameField, "2")
		* delay(3000)
		* click(editPersonalInfoLocator.updateButton)
    * delay(3000)
    * exists(editPersonalInfoLocator.continueActButton)
    * delay(2000)
    * exists(editPersonalInfoLocator.cancelActButton)
    * delay(2000)
    * click(editPersonalInfoLocator.cancelActButton)
    * delay(3000)
    
   
  #REV2-35783
	Scenario: Verify Continue confirmation window in personal info tab for Super Admin
    
    * karate.log('***list screen****')
    * match text(editPersonalInfoLocator.partyLabel) == editPersonalInfoConstant.lablePartyIdText
    * delay(2000)
    * exists(editPersonalInfoLocator.editIcon)
    * delay(2000)
    * mouse().move(editPersonalInfoLocator.editIcon).click()
    * delay(2000)
    * exists(editPersonalInfoLocator.contactPersonField)
    * delay(2000)
    * input(editPersonalInfoLocator.contactPersonField, "es")
		* delay(3000)
		* mouse().move(editPersonalInfoLocator.orgNameField).click()
    * delay(2000)
    * input(editPersonalInfoLocator.orgNameField, "1")
		* delay(3000)
		* click(editPersonalInfoLocator.updateButton)
    * delay(3000)
    * exists(editPersonalInfoLocator.continueActButton)
    * delay(2000)
    * exists(editPersonalInfoLocator.cancelActButton)
    * delay(2000)
    * click(editPersonalInfoLocator.continueActButton)
    * delay(3000)
    * waitForText('body','Personal Info Updated Successfully')
    * delay(2000)
    
	
  #REV2-35784
	Scenario: Verify Cross icon in update confirmaton window in personal info tab for Super Admin
    
    * karate.log('***list screen****')
    * match text(editPersonalInfoLocator.partyLabel) == editPersonalInfoConstant.lablePartyIdText
    * delay(2000)
    * exists(editPersonalInfoLocator.editIcon)
    * delay(2000)
    * mouse().move(editPersonalInfoLocator.editIcon).click()
    * delay(2000)
    * exists(editPersonalInfoLocator.contactPersonField)
    * delay(2000)
    * input(editPersonalInfoLocator.contactPersonField, "es")
		* delay(3000)
		* mouse().move(editPersonalInfoLocator.orgNameField).click()
    * delay(2000)
    * input(editPersonalInfoLocator.orgNameField, "1")
		* delay(3000)
		* click(editPersonalInfoLocator.updateButton)
    * delay(3000)
    * exists(editPersonalInfoLocator.continueActButton)
    * delay(2000)
    * exists(editPersonalInfoLocator.cancelActButton)
    * delay(2000)
    * mouse().move(editPersonalInfoLocator.crossIcon).click()
    * delay(2000)
   

  #REV2-35785
	Scenario: Verify Cancel button in personal info tab for Super Admin
    
    * karate.log('***list screen****')
    * match text(editPersonalInfoLocator.partyLabel) == editPersonalInfoConstant.lablePartyIdText
    * delay(2000)
    * exists(editPersonalInfoLocator.editIcon)
    * delay(2000)
    * mouse().move(editPersonalInfoLocator.editIcon).click()
    * delay(2000)
    * exists(editPersonalInfoLocator.contactPersonField)
    * delay(2000)
    * input(editPersonalInfoLocator.contactPersonField, "es")
		* delay(3000)
		* mouse().move(editPersonalInfoLocator.orgNameField).click()
    * delay(2000)
    * input(editPersonalInfoLocator.orgNameField, "1")
		* delay(3000)
		* click(editPersonalInfoLocator.cancelButton)
    * delay(3000)
    
   
    