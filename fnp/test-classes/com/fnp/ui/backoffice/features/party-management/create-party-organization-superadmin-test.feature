Feature: Create Party Organization UI scenarios for Super Admin Role

 	Background: 
		* def loginLocator = read('../../data/loginPage_locator.json')
    * def usersValue = read('../../data/users.json')
    * def dashBoardLocator = read('../../data//dashboard_locators.json')
    * def createPartyLocator = read('../../data/party/partyPage_locators.json')
    * def createPartyConstant = read('../../data/party/partyPage_constants.json')
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
    And match text(createPartyLocator.partyManagementText) == createPartyConstant.titleText
		* delay(3000)
    And match text(createPartyLocator.newPartyButtonLabel) == createPartyConstant.newPartyButtonTxt
    
		#REV2-22796
		#Verify whether the New Party button is visible or not for Super Admin Access
   	* def newPartyButtonExists = exists(createPartyLocator.newPartyButton)
   	* if (newPartyButtonExists) karate.log("New Party button is visible")
   	
   	#REV2-22797, REV2-22794, REV2-22801
   	#Verify the Party Type drop-down and its options when Super Admin clicks on New Party button
		* match text(createPartyLocator.partyManagementText) == createPartyConstant.titleText
   	* delay(1000)
    And click(createPartyLocator.newPartyButton)
    And match driver.url contains '/create'
    
    #REV2-22800
    #Verify the Label after Super Admin views the create party form
    * karate.log('*****Verify Label of the page should be New Party*****')
    * delay(1000)
    * match text(createPartyLocator.newPartyPageLabel) == createPartyConstant.newPartyPageLabelTxt
    * delay(3000)
 		* mouse().move(createPartyLocator.newPartyTypeDropDown).click()
		* delay(2000)
    * def dropdownTxt = scriptAll(createPartyLocator.partyTypeDropdownMenu, '_.textContent')
    * print 'Dropdown', dropdownTxt
    * match dropdownTxt[0] contains 'Individual'
    * match dropdownTxt[1] contains 'Organization'
    * delay(1000)
    * def optionOnDropDown = locateAll(createPartyLocator.partyTypeDropdownMenu)
    * delay(1000)
    * match karate.sizeOf(optionOnDropDown) == 2
    * optionOnDropDown[1].click()
    * delay(1000) 
    * match text(createPartyLocator.newPartyTypeDropDown) == createPartyConstant.partyTypeOrgTxt
    * delay(1000)
    
    
    * def random_string =
      """
          function(s) {
          var text = "";
          var possible = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
              
              for (var i = 0; i < s; i++)
                text += possible.charAt(Math.floor(Math.random() * possible.length));
          
          return text;
          }
      """
    * def randomText =  random_string(4)
    
    
    * def random_phoneno =
      """
          function(s) {
          var text = "";
          var possible = "123456789";
              
              for (var i = 0; i < s; i++)
                text += possible.charAt(Math.floor(Math.random() * possible.length));
          
          return text;
          }
      """
		* def randomPhoneNo =  random_phoneno(10)
		
 
	#REV2-22803
	Scenario: Verify functionality of Is Primary field for Super Admin
		
		* delay(1000)
		* below(createPartyLocator.roleDropDownBox).find('{}Is Primary')
		* delay(1000)
		* exists(createPartyLocator.isPrimaryChkBoxInput)
		* delay(1000)
    * def isPrimaryChk = scriptAll(createPartyLocator.isPrimaryChkBox, '_.textContent')
    * delay(1000)
   	* match isPrimaryChk[2] == 'Is Primary'
   	* match attribute(createPartyLocator.isPrimaryChkBoxInput, 'type') == 'checkbox'
    * delay(1000)
 

	#REV2-22802
	Scenario: Verify the functionality of Role field for Super Admin
 
 		* delay(1000)
    * def roleDropDownBox = exists(createPartyLocator.roleDropDownBox)
   	* if (roleDropDownBox) karate.log("Role option is present")
   	* delay(1000)
    * click(createPartyLocator.createButton)
    * delay(1000)
    * match text(createPartyLocator.roleValidationMsg) == createPartyConstant.roleValidationMsgTxt
    * delay(2000)
   	* mouse().move(createPartyLocator.roleDropDownBox).click()
    * delay(1000)
    * def roleDropDownBoxValues = scriptAll(createPartyLocator.roleDropDownBoxValue, '_.textContent')
    * print 'roleDropDownBoxValues : ', roleDropDownBoxValues
    * delay(5000)
  	* def optionOnDropDown = locateAll(createPartyLocator.roleDropDownBoxValue)
    * delay(1000)
    * optionOnDropDown[2].click()
    * delay(1000) 
    
    	
	#REV2-22798, REV2-22801
	Scenario: Verify form fields if Super Admin selects Party type as Organization
		
  	* delay(1000)
		* def createPartyFormFields = scriptAll(createPartyLocator.orgCreatePartyFormFields, '_.textContent')
		* delay(1000)
		* assert karate.sizeOf(createPartyFormFields) > 14
		* delay(1000)
		* karate.log('*****Verify form fields should be visible according to the party type selected*****')
		* print 'create Organization Party Form Fields : ', createPartyFormFields
		* match createPartyFormFields[0] contains createPartyConstant.createPartyTypeLabelTxt
		* match createPartyFormFields[1] contains createPartyConstant.roleLabelTxt
		* match createPartyFormFields[2] contains createPartyConstant.classificationLabelTxt
		* match createPartyFormFields[3] contains createPartyConstant.titleLabelTxt
		* match createPartyFormFields[4] contains createPartyConstant.contactPersonNameTxt
		* match createPartyFormFields[5] contains createPartyConstant.designationLabelTxt
		* match createPartyFormFields[7] contains createPartyConstant.loginPhoneNumberLabelTxt
		* match createPartyFormFields[8] contains createPartyConstant.loginEmailIdLabelTxt
		* match createPartyFormFields[9] contains createPartyConstant.orgNameLabelTxt
		* match createPartyFormFields[10] contains createPartyConstant.taxVatNumberLabel
		* match createPartyFormFields[11] contains createPartyConstant.faxNumber
		* match createPartyFormFields[13] contains createPartyConstant.contactPhoneNoLabelTxt
		* match createPartyFormFields[14] contains createPartyConstant.contactEmailIdLabelTxt		
		* delay(2000)
		* def infoLabels = scriptAll(createPartyLocator.infoLabel, '_.textContent')
		* delay(1000)
		* match infoLabels[0] == createPartyConstant.orgNameInfoLabel
		* match infoLabels[1] == createPartyConstant.businessInfoTxt
		* match infoLabels[2] == createPartyConstant.contactInfoLabelTxt
		* delay(1000)


	#REV2-22799
	Scenario: Verify CANCEL and CREATE button present inside the create party form for Super Admin
	
		* delay(2000)
		* scroll(createPartyLocator.scroll)
		* exists(createPartyLocator.cancelButton)
		* delay(2000)
		* exists(createPartyLocator.createButton)
		* def buttonsOnCreateForm = scriptAll(createPartyLocator.buttonsOnForm, '_.textContent')
		* print 'buttonsOnCreateForm : ', buttonsOnCreateForm
		* match buttonsOnCreateForm[1] == 'Cancel'
		* match buttonsOnCreateForm[2] == 'CREATE'
		* def buttons = locateAll(createPartyLocator.buttonsOnForm)
    * delay(1000)
    * assert karate.sizeOf(buttons) > 0
		* delay(1000)
		
	 
	#REV2-22804, REV2-22805
	Scenario: Verify + Add Other Roles hyperlink when Is Primary check-box is selected for Super Admin
	
		* delay(1000)
		* exists(createPartyLocator.roleDropDownBox)
		* delay(1000)
   	* mouse().move(createPartyLocator.roleDropDownBox).click()
   	* delay(1000)
    * def optionOnDropDown = locateAll(createPartyLocator.roleDropDownBoxValue)
    * delay(1000)
    * optionOnDropDown[2].click()
    * delay(3000)
   	* mouse().move(createPartyLocator.isPrimaryClickChkbox).click()
    * delay(3000)
    * mouse().move(createPartyLocator.addRolesButton).click()
    * delay(2000)
    * exists(createPartyLocator.otherRolesInputBox)
    * delay(5000)
		* input(createPartyLocator.otherRolesInputBox, 's')
		* delay(5000)
		* input(createPartyLocator.otherRolesInputBox, [Key.DOWN,Key.ENTER])
		* delay(5000)	
		* click(createPartyLocator.otherRolesInputBox)
   	* delay(1000)
    * def otherRolesDropDownValues = locateAll(createPartyLocator.otherRoleDropDown)
    * delay(1000)
    * otherRolesDropDownValues[1].click()
    * delay(3000)  
   	* mouse().move(createPartyLocator.isPrimaryClickChkbox).click()
   	* delay(5000)
   	* exists(createPartyLocator.otherRolesInputBox)
		* delay(3000)
		
			
	#REV2-22806
	Scenario: Verify the Classification field for Super Admin
	
		* delay(2000) 
		* exists(createPartyLocator.classificationInput)
		* delay(1000)
		* click(createPartyLocator.classificationInput)
    * delay(3000)
    * input(createPartyLocator.classificationInput,['FNP',Key.DOWN,Key.ENTER],1000)
    * delay(3000)
    * click(createPartyLocator.classificationInput)
    * delay(1000)
    * def classificationOptionOnDropDown = locateAll(createPartyLocator.classificationDropDown)
    * delay(1000)
    * classificationOptionOnDropDown[3].click()
    * delay(4000)

  
	#REV2-22807
	Scenario: Verify Title field and its options present for Super Admin
	
		* delay(1000)
    * exists(createPartyLocator.titleField)
    * delay(1000)
    * scroll(createPartyLocator.scrollTitle)
    * delay(1000)
    * def createNewPartyFormFieldLabels = scriptAll(createPartyLocator.createNewPartyFormFieldsLabel, '_.textContent')
    * delay(1000)
    * print 'create New Party Form Field Labels : ', createNewPartyFormFieldLabels
    * delay(1000)
    * match createNewPartyFormFieldLabels[3] == createPartyConstant.titleLabelTxt
    * match createNewPartyFormFieldLabels[3] != 'Title *'
    * delay(1000)
    * mouse().move(createPartyLocator.titleField).click()
    * delay(4000)
    * match attribute(createPartyLocator.titleField, 'value') == 'Mr'
    * mouse().move(createPartyLocator.titleDropDown)
    * delay(4000)
    * def titleOptions = scriptAll(createPartyLocator.titleDropDown, '_.textContent')
    * print 'titleOptions : ', titleOptions
    * def optionOnTitle = locateAll(createPartyLocator.titleDropDown)
    * assert karate.sizeOf(optionOnTitle) > 0
    * delay(1000)
    * optionOnTitle[1].click()
    * delay(1000)
  

	#REV2-22809
	Scenario: Verify the Designation field for Super Admin
		
		* karate.log('*****Verify designation field should not be mandatory*****')
		* delay(2000)
    * mouse().move(createPartyLocator.roleDropDownBox).click()
    * delay(1000)
    * def optionOnDropDown = locateAll(createPartyLocator.roleDropDownBoxValue)
    * delay(1000)
    * optionOnDropDown[2].click()
		* scroll(createPartyLocator.nameInputField)
   	* delay(1000)
   	* input(createPartyLocator.nameInputField, 'tester')
   	* delay(1000)
   	* input(createPartyLocator.orgNameField, 'FNPTest')
   	* delay(1000)
   	* input(createPartyLocator.loginPhoneNumber, randomPhoneNo)
  	* click(createPartyLocator.createButton)
    * delay(3000)
    * exists(createPartyLocator.confirmationBoxPresent)
    * delay(1000)
    * match text(createPartyLocator.confirmDialogTxtL) == createPartyConstant.createNewPartyConfirmDailogTxt
    * delay(1000)
  	* click(createPartyLocator.confirmDailogCancelButton)
		* karate.log('*****Verify designation field validations*****')
		* delay(1000)
		* exists(createPartyLocator.designationField)
		* delay(1000)
		* scroll(createPartyLocator.designationField)
		* match text(createPartyLocator.designationLabel) == createPartyConstant.designationLabelTxt
		* delay(1000)
		* match attribute(createPartyLocator.designationField, 'type') == 'text'
		* delay(1000)
		* input(createPartyLocator.designationField, 'QA$#123')
		* mouse().move(100,200).click()
		* delay(6000)
		* match text(createPartyLocator.designationHelper) == createPartyConstant.designationHelperTxt
   
 
	#REV2-22814
	Scenario: Verify the FAX Number field for Super Admin
		
		* karate.log('*****Verify FAX Number field should not be mandatory*****')
		* delay(2000)
    * mouse().move(createPartyLocator.roleDropDownBox).click()
    * delay(1000)
    * def optionOnDropDown = locateAll(createPartyLocator.roleDropDownBoxValue)
    * delay(1000)
    * optionOnDropDown[2].click()
		* scroll(createPartyLocator.nameInputField)
   	* delay(1000)
   	* input(createPartyLocator.nameInputField, 'tester')
   	* delay(1000)
   	* input(createPartyLocator.orgNameField, 'FNPTest')
   	* delay(1000)
   	* input(createPartyLocator.loginPhoneNumber, randomPhoneNo)
  	* click(createPartyLocator.createButton)
    * delay(3000)
    * exists(createPartyLocator.confirmationBoxPresent)
    * delay(1000)
    * match text(createPartyLocator.confirmDialogTxtL) == createPartyConstant.createNewPartyConfirmDailogTxt
    * delay(1000)
  	* click(createPartyLocator.confirmDailogCancelButton)
		* karate.log('*****Verify FAX Number field validations*****')
		* delay(1000)
		* exists(createPartyLocator.faxNumberField)
		* delay(1000)
		* scroll(createPartyLocator.faxNumberField)
		* match text(createPartyLocator.faxNumberLabel) == createPartyConstant.faxNumber
		* delay(1000)
		* match attribute(createPartyLocator.faxNumberField, 'type') == 'text'
		* delay(1000)
		* input(createPartyLocator.faxNumberField, 'AB$#VB')
		* mouse().move(100,200).click()
		* delay(6000)
		* match text(createPartyLocator.faxNumberHelperTxt) contains createPartyConstant.faxNumberHelperMsg
		
	 
	#REV2-22813
	Scenario: Verify the TAX/VAT Number field for Super Admin

		* karate.log('*****Verify TAX/VAT Number field should not be mandatory*****')
		* delay(2000)
    * mouse().move(createPartyLocator.roleDropDownBox).click()
    * delay(1000)
    * def optionOnDropDown = locateAll(createPartyLocator.roleDropDownBoxValue)
    * delay(1000)
    * optionOnDropDown[2].click()
		* scroll(createPartyLocator.nameInputField)
   	* delay(1000)
   	* input(createPartyLocator.nameInputField, 'tester')
   	* delay(1000)
   	* input(createPartyLocator.orgNameField, 'FNPTest')
   	* delay(1000)
   	* input(createPartyLocator.loginPhoneNumber, randomPhoneNo)
  	* click(createPartyLocator.createButton)
    * delay(3000)
    * exists(createPartyLocator.confirmationBoxPresent)
    * delay(1000)
    * match text(createPartyLocator.confirmDialogTxtL) == createPartyConstant.createNewPartyConfirmDailogTxt
    * delay(1000)
  	* click(createPartyLocator.confirmDailogCancelButton)
		* exists(createPartyLocator.taxVatField)
		* delay(1000)
		* scroll(createPartyLocator.taxVatField)
		* match text(createPartyLocator.taxNumberLabel) == createPartyConstant.taxVatNumberLabel
		* delay(1000)
		* match attribute(createPartyLocator.taxVatField, 'type') == 'text'
		* delay(1000)
		* input(createPartyLocator.taxVatField, '%%$#AB12')
		* mouse().move(100,200).click()
		* delay(6000)
		* match text(createPartyLocator.taxNumberHelperTxt) contains createPartyConstant.taxNumberHelperMsg
		

	#REV2-26166
	Scenario: Verify whether Login Phone Number and Login Email ID field is mandatory or not for Super Admin
	
		* delay(2000)
    * mouse().move(createPartyLocator.roleDropDownBox).click()
    * delay(1000)
    * def optionOnDropDown = locateAll(createPartyLocator.roleDropDownBoxValue)
    * delay(1000)
    * optionOnDropDown[2].click()
    * delay(1000)
    * exists(createPartyLocator.loginPhoneNumber)
   	* exists(createPartyLocator.loginEmailId)
   	* delay(1000)
   	* input(createPartyLocator.nameInputField, 'tester')
   	* delay(1000)
   	* input(createPartyLocator.orgNameField, 'FNPTest')
   	* delay(1000)
   	* click(createPartyLocator.createButton)
    * waitForText('body', 'Please insert either Login Email Id or Login Phone Number')
    * karate.log('*** Please insert either Login Email Id or Login Phone Number ****')
    * delay(3000)
    * scroll(createPartyLocator.loginEmailId)
    * input(createPartyLocator.loginPhoneNumber, '8864236875')
    * delay(1000)
    * click(createPartyLocator.createButton)
    * delay(3000)
    * exists(createPartyLocator.confirmationBoxPresent)
    * delay(1000)
    * match text(createPartyLocator.confirmDialogTxtL) == createPartyConstant.createNewPartyConfirmDailogTxt
    * delay(1000)
    
  
	#REV2-23083, REV2-22821, REV2-22822, REV2-22823, REV2-22824, REV2-22810
	Scenario: Verify Super Admin can create party for organization party type with all fields
	
		* delay(2000)
   	* mouse().move(createPartyLocator.roleDropDownBox).click()
   	* delay(1000)
   	* def optionText = scriptAll(createPartyLocator.roleDropDownBoxValue, '_.textContent')
   	* delay(1000)
    * def optionOnDropDown = locateAll(createPartyLocator.roleDropDownBoxValue)
    * delay(1000)
    * optionOnDropDown[4].click()
    * def role = optionText[4]
    * delay(1000)
   	* mouse().move(createPartyLocator.isPrimaryClickChkbox).click()
    * delay(3000)
    * mouse().move(createPartyLocator.addRolesButton).click()
    * delay(2000)
    * click(createPartyLocator.otherRolesInputBox)
    * delay(1000)
    * def otherRoleText = scriptAll(createPartyLocator.otherRoleDropDown, '_.textContent')
   	* delay(1000)
    * def otherRolesDropDownValues = locateAll(createPartyLocator.otherRoleDropDown)
    * delay(1000) 
    * otherRolesDropDownValues[1].click()
    * def otherRole = otherRoleText[1]
    * delay(3000)
    * click(createPartyLocator.classificationInput)
    * def classificationText = scriptAll(createPartyLocator.classificationDropDown, '_.textContent')
   	* delay(1000)
    * def classificationOptionOnDropDown = locateAll(createPartyLocator.classificationDropDown)
    * delay(1000)
    * classificationOptionOnDropDown[1].click()
   	* def classification = classificationText[1] 
   	* delay(1000)
   	* karate.log('*****Filling Organization User Information*****')
   	* scroll(createPartyLocator.loginEmailId)
   	* input(createPartyLocator.nameInputField, randomText)
    * delay(1000)
   	* def name = value(createPartyLocator.nameInputField) 
   	* delay(1000)
   	* input(createPartyLocator.designationField, 'QA')
   	* delay(1000)
   	* def designation = value(createPartyLocator.designationField) 
   	* delay(1000)
    * input(createPartyLocator.loginPhoneNumber, randomPhoneNo)
    * delay(1000)
    * def loginPhoneNumber = value(createPartyLocator.loginPhoneNumber)
   	* delay(1000) 
    * def randomOrgName = random_string(5)
    * input(createPartyLocator.loginEmailId, 'test' + randomOrgName + '@cybage.com')
    * delay(1000)
    * def loginEmailId = value(createPartyLocator.loginEmailId)
   	* delay(1000)
    * karate.log('*****Filling Business Information*****')
    * scroll(createPartyLocator.orgNameField)
   	* input(createPartyLocator.orgNameField, randomOrgName)
   	* delay(1000)
   	* def orgName = value(createPartyLocator.orgNameField)
   	* delay(1000) 
    * def randomTaxText = random_string(2)
    * def randomTaxNumber = random_phoneno(3)
    * delay(1000)
    * input(createPartyLocator.taxVatField, randomTaxText + randomTaxNumber)
    * delay(1000)
    * def taxVatNumber = value(createPartyLocator.taxVatField)
   	* delay(1000)  
    * def randomFaxNumber = random_phoneno(8)
    * delay(1000)
    * input(createPartyLocator.faxNumberField, randomFaxNumber)
    * delay(1000)
    * def faxNumber = value(createPartyLocator.faxNumberField)
   	* delay(1000)    
    * karate.log('*****Filling Contact  Information*****')
    * scroll(createPartyLocator.contactPhoneField)
   	* delay(1000)  
   	* def randomContactNumber = random_phoneno(10)
		* input(createPartyLocator.contactPhoneField, randomContactNumber)
		* def contactPhoneNo = value(createPartyLocator.contactPhoneField) 
   	* delay(1000)   	
   	* input(createPartyLocator.contactEmailField, 'test' + randomText + '@cybage.com')
   	* def contactEmail = value(createPartyLocator.contactEmailField) 
   	* delay(3000) 	
   	* click(createPartyLocator.createButton)
    * delay(2000)
    * karate.log('*****Verify the functionality of the CONTINUE button present inside the create confirmation window*****')
    * click(createPartyLocator.dailogBoxContinue)
    * karate.log('*********Verify the confirmation message when party is successfully created*********')
    * waitForText('body', 'New party created')
    * delay(1000)
    * karate.log('*****Verify the Label after super Admin redirected to the view page of the created party*****')
    * delay(1000)
    * def partyIdPageLabel = scriptAll(createPartyLocator.partyIdPageLabel, '_.textContent')
    * delay(1000)
    * def newPartyCreatedValues = scriptAll(createPartyLocator.newPartyPersonalInfoValues, '_.textContent')
    * match partyIdPageLabel[0] == newPartyCreatedValues[0]
    * match driver.url contains '/show'
    * delay(2000)    
    * karate.log('*******Verify the details of the created organization party*********')
    * print 'Verify New Party Created Personal Info Values : ',  newPartyCreatedValues
    * match newPartyCreatedValues[1] == createPartyConstant.partyTypeOrgTxt
    * match newPartyCreatedValues[2] == classification
    * match newPartyCreatedValues[3] == createPartyConstant.organizationInfoLabelTxt
    * match newPartyCreatedValues[4] == name
    * match newPartyCreatedValues[5] == designation
    * match newPartyCreatedValues[6] == createPartyConstant.businessInfoTxt
    * match newPartyCreatedValues[7] == orgName
    * match newPartyCreatedValues[8] == taxVatNumber
    * match newPartyCreatedValues[9] == faxNumber
    * delay(1000)  
    * karate.log('Verify system should store phone number and/or emailid as Login User Id.')
    * click(createPartyLocator.usernameTab)
    * delay(1000)
    * match text(createPartyLocator.userLoginIdColumnName) == createPartyConstant.userLoginIdColumnNameLabel
    * delay(1000)
    * def userLoginIds = scriptAll(createPartyLocator.usernameList, '_.textContent')
    * match userLoginIds[0] contains loginPhoneNumber
    * match userLoginIds[1] contains loginEmailId
    * delay(2000)    
    * click(createPartyLocator.contactInfoTab)
    * delay(1000)
    * match text(createPartyLocator.contactInfoColumnName) == createPartyConstant.contactInfoLabelTxt
    * delay(1000)
    * def contactInfoRowData = scriptAll(createPartyLocator.contactPhoneNoList, '_.textContent')
    * delay(2000)
    * match contactInfoRowData[0] contains contactPhoneNo
    * match contactInfoRowData[1] contains loginPhoneNumber
    * match contactInfoRowData[2] contains contactEmail
    * match contactInfoRowData[3] contains loginEmailId    
    * click(createPartyLocator.rolesTab)
    * delay(2000)
    * def rolesTabValues = scriptAll(createPartyLocator.orgRolesValue, '_.textContent')
		* delay(1000)
    * print 'Roles Value :',  rolesTabValues
    * match rolesTabValues[0] == role
    * match rolesTabValues[1] == otherRole
    * delay(2000)
    
	 
	#REV2-23084, REV2-22819, REV2-22818
	Scenario: Verify Super Admin can create party for organization party type with only mandatory fields
	
		* delay(2000)
   	* mouse().move(createPartyLocator.roleDropDownBox).click()
   	* delay(1000)
   	* def optionText = scriptAll(createPartyLocator.roleDropDownBoxValue, '_.textContent')
   	* delay(1000)
    * def optionOnDropDown = locateAll(createPartyLocator.roleDropDownBoxValue)
    * delay(1000)
    * optionOnDropDown[4].click()
    * def role = optionText[4]
    * delay(1000) 
   	* scroll(createPartyLocator.loginEmailId)
   	* input(createPartyLocator.nameInputField, randomText)
    * delay(1000)   
    * input(createPartyLocator.loginPhoneNumber, randomPhoneNo)
    * delay(1000)
    * def loginPhoneNumber = value(createPartyLocator.loginPhoneNumber)
   	* delay(1000)	
   	* def randomOrgName = random_string(5) 
    * scroll(createPartyLocator.orgNameField)
   	* input(createPartyLocator.orgNameField, randomOrgName)
   	* delay(1000) 
   	* delay(3000) 	
   	* click(createPartyLocator.createButton)
    * delay(2000)
    * karate.log('*****Verify create confirmation window when clicked on CREATE button*****')
    * exists(createPartyLocator.confirmationBoxPresent)
    * delay(1000)
    * match text(createPartyLocator.confirmDialogTxtL) == createPartyConstant.createNewPartyConfirmDailogTxt
    * delay(1000)
    * exists(createPartyLocator.confirmDailogCancelButton)
    * exists(createPartyLocator.dailogContinueButton) 	
    * karate.log('*****Verify the functionality of CONTINUE button present inside the create confirmation window*****')
    * click(createPartyLocator.dailogBoxContinue)
    * karate.log('*********Verify the confirmation message when party is successfully created*********')
    * waitForText('body', 'New party created')
    * delay(1000)
    * match driver.url contains '/show'
    
   
	#REV2-22820
	Scenario: Verify functionality of CANCEL button present at the bottom of create party form for Super Admin
	
		* delay(2000)
   	* mouse().move(createPartyLocator.roleDropDownBox).click()
   	* delay(1000)
   	* def optionText = scriptAll(createPartyLocator.roleDropDownBoxValue, '_.textContent')
   	* delay(1000)
    * def optionOnDropDown = locateAll(createPartyLocator.roleDropDownBoxValue)
    * delay(1000)
    * optionOnDropDown[4].click()
    * def role = optionText[4]
    * delay(1000) 
   	* scroll(createPartyLocator.loginEmailId)
   	* input(createPartyLocator.nameInputField, randomText)
    * delay(1000)   
    * input(createPartyLocator.loginPhoneNumber, randomPhoneNo)
    * delay(1000)
    * def loginPhoneNumber = value(createPartyLocator.loginPhoneNumber)
   	* delay(1000)	
   	* def randomOrgName = random_string(5) 
    * scroll(createPartyLocator.orgNameField)
   	* input(createPartyLocator.orgNameField, randomOrgName)
   	* delay(1000) 
   	* delay(3000) 	
   	* click(createPartyLocator.createButton)
    * delay(2000)
    * karate.log('*****Verify create confirmation window when clicked on CREATE button*****')
    * exists(createPartyLocator.confirmationBoxPresent)
    * delay(1000)
    * match text(createPartyLocator.confirmDialogTxtL) == createPartyConstant.createNewPartyConfirmDailogTxt
    * delay(1000)
    * exists(createPartyLocator.confirmDailogCancelButton)
    * click(createPartyLocator.confirmDailogCancelButton)
    * delay(1000)
    * match driver.url contains '/create'
    * delay(2000)
    * karate.log('*****Verify functionality of cancel button in create party form*****')
    * click(createPartyLocator.cancelButton)
    * delay(2000)
    * match driver.url contains '/search'
    * delay(2000)
    
    
	#REV2-22816
	Scenario: Verify the Contact Email ID field for Super Admin
	
		* delay(1000)
    * exists(createPartyLocator.contactEmailField)
    * delay(1000)
    * match enabled(createPartyLocator.contactEmailField) == true
    * delay(1000)
    * scroll(createPartyLocator.contactEmailField)
    * input(createPartyLocator.contactEmailField, 'test21cybage.com')
    * mouse().move(100, 200).click()
    * delay(3000)
    * match text(createPartyLocator.contactEmailValidationMsg) == createPartyConstant.contactEmailValidationMsgTxt
    * delay(1000)
    * def createNewPartyFormFieldLabels = scriptAll(createPartyLocator.createNewPartyFormFieldsLabel, '_.textContent')
    * delay(1000)
    * print 'create New Party Form Field Labels : ', createNewPartyFormFieldLabels
    * delay(1000)
    * match createNewPartyFormFieldLabels[14] == createPartyConstant.contactEmailIdLabelTxt
    * match createNewPartyFormFieldLabels[14] != 'Contact Email ID *'
    
    
	#REV2-22815
	Scenario: Verify the Contact Phone Number field for Super Admin
	
		* delay(1000)
    * exists(createPartyLocator.contactPhoneField)
    * delay(1000)
   	* match enabled(createPartyLocator.contactPhoneField) == true
   	* delay(3000)
   	* def createNewPartyFormFieldLabels = scriptAll(createPartyLocator.createNewPartyFormFieldsLabel, '_.textContent')
    * delay(1000)
    * print 'create New Party Form Field Labels : ', createNewPartyFormFieldLabels
    * delay(1000)
    * match createNewPartyFormFieldLabels[13] == createPartyConstant.contactPhoneNoLabelTxt
    * match createNewPartyFormFieldLabels[13] !contains '*'
    * delay(1000)
    * karate.log("******Verifying invalid phonenumber******")
    * scroll(createPartyLocator.scroll)
    * delay(1000)
    * mouse().move(createPartyLocator.contactPhoneField).click()
    * delay(3000)
    * input(createPartyLocator.contactPhoneField, '84545')
    * mouse().move(100, 200).click()
    * delay(3000)
   	* match text(createPartyLocator.contactPhoneNoValidationMsg) == createPartyConstant.contactPhoneNoValidationMsgTxt
		* delay(1000)
		* mouse().move(createPartyLocator.contactPhoneCountryCodeTextBox).click()
		* delay(1000)
		* match attribute(createPartyLocator.contactPhoneCountryCodeTextBox, 'type') == 'text'		
		* delay(2000)
    * def countryCodes = locateAll(createPartyLocator.contactPhoneNumberCodeDropDown)
    * delay(2000)
    * countryCodes[1].click()
    * delay(3000)
    * clear(createPartyLocator.contactPhoneField)
    * delay(8000)
   	* value(createPartyLocator.contactPhoneField, '8410212421')
   	* def phoneno = value(createPartyLocator.contactPhoneField)
   	* delay(1000)
   	* match phoneno == '#regex [0-9]{10}'
   	* delay(1000)
   	
   	 
	#REV2-23085
	Scenario: Verify Super admin can create party when Login EmailId and/or Login Phone Number is filled and Contact EmailId, Contact Phone Number is left blank
	
		* delay(2000)
   	* mouse().move(createPartyLocator.roleDropDownBox).click()
   	* delay(1000)
   	* def optionText = scriptAll(createPartyLocator.roleDropDownBoxValue, '_.textContent')
   	* delay(1000)
    * def optionOnDropDown = locateAll(createPartyLocator.roleDropDownBoxValue)
    * delay(1000)
    * optionOnDropDown[3].click()
    * def role = optionText[3]
    * delay(1000) 
   	* scroll(createPartyLocator.loginEmailId)
   	* input(createPartyLocator.nameInputField, randomText)
    * delay(1000)   
    * input(createPartyLocator.loginPhoneNumber, randomPhoneNo)
    * delay(1000)
    * input(createPartyLocator.loginEmailId, 'test' + randomText + '@cybage.com')
    * delay(1000)
   	* def randomOrgName = random_string(5) 
    * scroll(createPartyLocator.orgNameField)
   	* input(createPartyLocator.orgNameField, randomOrgName)
   	* delay(3000) 	
   	* click(createPartyLocator.createButton)
    * delay(2000)
    * click(createPartyLocator.dailogBoxContinue)
    * karate.log('*********Verify the confirmation message when party is successfully created*********')
    * waitForText('body', 'New party created')
    * delay(1000)
    * match driver.url contains '/show'
    
   
	#REV2-22808
	Scenario: Verify the Contact Person Name field for Super Admin
	
		* delay(1000)
		* scroll(createPartyLocator.nameInputField)
		* delay(1000)
		* exists(createPartyLocator.nameInputField)
		* delay(1000)
    * match attribute(createPartyLocator.nameInputField, 'type') == 'text'
    * delay(1000)
    * click(createPartyLocator.createButton)
    * delay(2000)
    * match text(createPartyLocator.nameValidationMsg) == createPartyConstant.nameValidationMsgTxt
    * delay(1000)
    * input(createPartyLocator.nameInputField,'abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxy')
    * delay(3000)
    * mouse().move(100,200).click()
    * match text(createPartyLocator.nameValidationMsg) == createPartyConstant.nameCharLimitationMsgTxt
    * delay(3000)
    * clear(createPartyLocator.nameInputField)
    * delay(3000)
    * refresh()
    * delay(3000)
    * mouse().move(createPartyLocator.newPartyTypeDropDown).click()
		* delay(2000)
		* def optionOnDropDown = locateAll(createPartyLocator.partyTypeDropdownMenu)
    * delay(1000)
		* optionOnDropDown[1].click()
    * delay(1000)
    * scroll(createPartyLocator.nameInputField)
    * delay(1000)
    * input(createPartyLocator.nameInputField, '&^AB12345')
    * delay(3000)
    * mouse().move(100,200).click()
    * delay(3000)
    * match text(createPartyLocator.nameValidationMsg) == createPartyConstant.nameSpecialCharMsgTxt
    
  
	#REV2-22810
	Scenario: Verify the Login Phone Number field for Super Admin
	
		* delay(1000)
   	* mouse().move(createPartyLocator.roleDropDownBox).click()
   	* delay(1000)
    * def optionOnDropDown = locateAll(createPartyLocator.roleDropDownBoxValue)
    * delay(1000)
    * optionOnDropDown[4].click()
		* delay(2000)
		* input(createPartyLocator.nameInputField, randomText)
    * delay(1000)
  	* scroll(createPartyLocator.loginPhoneNumber)
  	* delay(1000)
  	* exists(createPartyLocator.loginPhoneNumber)
  	* match attribute(createPartyLocator.loginPhoneNumber, 'type') == 'number'
  	* delay(1000)
  	* def randomOrgName = random_string(5) 
    * scroll(createPartyLocator.orgNameField)
   	* input(createPartyLocator.orgNameField, randomOrgName)
   	* delay(3000) 	
  	* karate.log("****Verify if Login Phone Field is left blank****")		
		* delay(1000)
   	* click(createPartyLocator.createButton)
		* waitForText('body', 'Please insert either Login Email Id or Login Phone Number')
		* delay(5000)		
  	* karate.log("*****Verify validations for invalid phone number*******")
  	* input(createPartyLocator.loginPhoneNumber, '888')
  	* mouse().move(100,200).click()
  	* match text(createPartyLocator.loginPhoneNumberHelperTxt) == createPartyConstant.loginPhoneNumberHelperTxtMsg
  	* delay(1000)
  	* mouse().move(createPartyLocator.loginPhoneCountryCodeTextBox).click()
		* delay(1000)
		* def loginCountryCodes = locateAll(createPartyLocator.loginCountryCodeDropDown)
 	 	* delay(2000)
  	* loginCountryCodes[1].click()  	
  	* karate.log("****Verify validations if Login Phone Number is already in use****")
		* delay(1000)
		* delay(5000)
		* clear(createPartyLocator.loginPhoneNumber)
		* delay(10000)
  	* input(createPartyLocator.loginPhoneNumber, '6547877')
   	* def phoneno = value(createPartyLocator.loginPhoneNumber)
   	* delay(1000)
   	* match phoneno == '#regex [0-9]{10}'
   	* delay(1000)
   	* click(createPartyLocator.createButton)
   	* click(createPartyLocator.dailogBoxContinue)
		* waitForText('body', 'The phone number/mobile number is already in used.')
		* delay(5000)
	

	#REV2-22811
	Scenario: Verify the Login Email ID field for Super Admin
	
		* karate.log("*****Verify The e-mail address entered is invalid*******")
		* delay(1000)
		* scroll(createPartyLocator.loginEmailId)
		* delay(1000)
		* input(createPartyLocator.loginEmailId, 'test' + randomText + '@.com')
		* mouse().move(100, 200).click() 
		* delay(2000)
		* match text(createPartyLocator.loginEmailHelperText) == createPartyConstant.loginEmailHelperTextMsg
		* delay(2000)
		* refresh()
		* karate.log("*****Verify The e-mail address field is left blank*******")
		* delay(1000)
		* mouse().move(createPartyLocator.newPartyTypeDropDown).click()
		* delay(2000)
		* def optionOnDropDown = locateAll(createPartyLocator.partyTypeDropdownMenu)
    * delay(1000)
    * optionOnDropDown[1].click()
		* delay(1000)
   	* mouse().move(createPartyLocator.roleDropDownBox).click()
   	* delay(1000)
    * def optionOnDropDown = locateAll(createPartyLocator.roleDropDownBoxValue)
    * delay(1000)
    * optionOnDropDown[4].click()
		* delay(2000)
		* input(createPartyLocator.nameInputField, randomText)
    * delay(1000)
    * def randomOrgName = random_string(5) 
    * scroll(createPartyLocator.orgNameField)
   	* input(createPartyLocator.orgNameField, randomOrgName)
   	* delay(3000) 	
    * scroll(createPartyLocator.loginEmailId)
		* delay(1000)
		* exists(createPartyLocator.loginEmailId)
		* delay(1000)
   	* click(createPartyLocator.createButton)
		* waitForText('body', 'Please insert either Login Email Id or Login Phone Number')
		* delay(5000)
		* karate.log("*****Verify validations if e-mail address entered is already in use*******")
		* input(createPartyLocator.loginEmailId, 'testVVSSQ@cybage.com')
		* delay(1000)
		* click(createPartyLocator.createButton)
		* delay(3000)
		* click(createPartyLocator.dailogBoxContinue)
		* waitForText('body', 'The email id is already in use')
		
   	  
	#REV2-22812
	Scenario: Verify the Organization Name field for Super Admin
	
		* delay(1000)
		* scroll(createPartyLocator.orgNameField)
		* delay(1000)
		* exists(createPartyLocator.orgNameField)
		* delay(1000)
		* match attribute(createPartyLocator.orgNameField, 'type') == 'text'
		* click(createPartyLocator.createButton)
		* delay(3000)
		* match text(createPartyLocator.orgNameHelperTxt) == createPartyConstant.orgNameHelperTxtMsg
		* delay(1000)
		* scroll(createPartyLocator.roleDropDownBox)
		* delay(1000)
		* mouse().move(createPartyLocator.roleDropDownBox).click()
   	* delay(1000)
    * def optionOnDropDown = locateAll(createPartyLocator.roleDropDownBoxValue)
    * delay(1000)
    * optionOnDropDown[4].click()
		* delay(2000)
		* input(createPartyLocator.nameInputField, randomText)
    * delay(1000)
    * input(createPartyLocator.loginPhoneNumber, randomPhoneNo)
    * delay(1000)
    * scroll(createPartyLocator.orgNameField)
   	* input(createPartyLocator.orgNameField, '124&^%AB')
   	* delay(2000)
   	* mouse().move(100,200).click()
   	* delay(2000)
   	* match text(createPartyLocator.orgNameHelperTxt) == createPartyConstant.orgNameInvalidMsg
   	* delay(2000)
   	
   	