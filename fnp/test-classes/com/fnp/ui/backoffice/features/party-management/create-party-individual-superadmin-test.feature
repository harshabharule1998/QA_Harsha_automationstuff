Feature: Create Party Individual UI scenarios for Super Admin Role

 	Background: 
		* def loginLocator = read('../../data/loginPage_locator.json')
    * def usersValue = read('../../data/users.json')
    * def dashBoardLocator = read('../../data//dashboard_locators.json')
    * def partyPageLocator = read('../../data/party/partyPage_locators.json')
    * def partyPageConstant = read('../../data/party/partyPage_constants.json')
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
    And match text(partyPageLocator.partyManagementText) == partyPageConstant.titleText
		* delay(3000)
    And match text(partyPageLocator.newPartyButtonLabel) == partyPageConstant.newPartyButtonTxt
    
		#REV2-22745
		#Verify whether New Party button is visible or not for Super Admin
   	* def newPartyButtonExists = exists(partyPageLocator.newPartyButton)
   	* if (newPartyButtonExists) karate.log("New Party button is visible")
   	
   	#REV2-22746/REV2-22750/REV2-22743/REV2-22749
   	#Verify the Party Type drop-down and its options when Super Admin clicks on New Party button
		* match text(partyPageLocator.partyManagementText) == partyPageConstant.titleText
   	* delay(1000)
    And click(partyPageLocator.newPartyButton)
    * karate.log('*****Verify Label of the page should be New Party*****')
    * delay(1000)
    And match text(partyPageLocator.newPartyPageLabel) == partyPageConstant.newPartyPageLabelTxt
    * delay(3000)
 		* mouse().move(partyPageLocator.newPartyTypeDropDown).click()
		* delay(2000)
    * def dropdownTxt = scriptAll(partyPageLocator.partyTypeDropdownMenu, '_.textContent')
    * print 'Dropdown', dropdownTxt
    * match dropdownTxt[0] contains 'Individual'
    * match dropdownTxt[1] contains 'Organization'
    * delay(1000)
    * def optionOnDropDown = locateAll(partyPageLocator.partyTypeDropdownMenu)
    * delay(1000)
    * match karate.sizeOf(optionOnDropDown) == 2
    * optionOnDropDown[0].click()
    * delay(1000) 
    * match text(partyPageLocator.newPartyTypeDropDown) == partyPageConstant.partyTypeValueTxt
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
 
 
	#REV2-22768/REV2-22765
 	Scenario: Verify Login Phone No, Contact Phone No, Login EmailID and Contact EmailID when Not Available check-box is selected for Super Admin
		
    * delay(1000)
    * mouse().move(partyPageLocator.roleDropDownBox).click()
    * delay(1000)
    * def roleDropDownBoxValues = scriptAll(partyPageLocator.roleDropDownBoxValue, '_.textContent')
    * print 'roleDropDownBoxValues : ', roleDropDownBoxValues
    * match roleDropDownBoxValues[1] contains 'Employee'
    * delay(1000)
    * def optionOnDropDown = locateAll(partyPageLocator.roleDropDownBoxValue)
    * delay(1000)
    * optionOnDropDown[1].click()
    * delay(1000) 
    * scroll(partyPageLocator.scroll)
    * def notAvailablechkBox = scriptAll(partyPageLocator.notAvailable, '_.textContent')
    * print 'notAvailable : ', notAvailablechkBox
    * match notAvailablechkBox[0] contains 'Not Available'
    * delay(1000)
    * highlight(partyPageLocator.notAvailabeCheckBox)
    * delay(3000)
   	* mouse().move(partyPageLocator.notAvailabeCheckBox).click()
    * delay(3000)
   	* def userNameExists = exists(partyPageLocator.userName)
   	* if (userNameExists) karate.log("userName Exists") 
   	* delay(3000)
   	* match enabled(partyPageLocator.contactPhoneField) == true
   	* match enabled(partyPageLocator.contactEmailField) == true
   	* delay(3000)
   	* input(partyPageLocator.contactPhoneField, '8454545454')
   	* input(partyPageLocator.contactEmailField, 'test@cybage.com')
    * delay(1000)
   	* karate.log('*****Verify Login Phone Number and Login Email ID when Not Available chkbox is selected*****')
   	* match enabled(partyPageLocator.loginPhoneNumber) == false
   	* match enabled(partyPageLocator.loginEmailId) == false
  
    
	#REV2-22751
	Scenario: Verify Role field for Super Admin
	
		* delay(1000)
    * def roleDropDownBox = exists(partyPageLocator.roleDropDownBox)
   	* if (roleDropDownBox) karate.log("Role option is present") 
    * click(partyPageLocator.createButton)
    * delay(1000)
    * match text(partyPageLocator.roleValidationMsg) == partyPageConstant.roleValidationMsgTxt
    * delay(2000)
   	* mouse().move(partyPageLocator.roleDropDownBox).click()
    * delay(1000)
    * def roleDropDownBoxValues = scriptAll(partyPageLocator.roleDropDownBoxValue, '_.textContent')
    * print 'roleDropDownBoxValues : ', roleDropDownBoxValues
    * delay(10000)
  	* def optionOnDropDown = locateAll(partyPageLocator.roleDropDownBoxValue)
    * delay(1000)
    * optionOnDropDown[2].click()
    * delay(1000) 
    
  
  #REV2-22752
	Scenario: Verify functionality of Is Primary check box for Super Admin
 
    * delay(1000)
    * def isPrimaryChk = scriptAll(partyPageLocator.isPrimaryChkBox, '_.textContent')
    * delay(1000)
   	* match isPrimaryChk[2] == 'Is Primary'
   	* match attribute(partyPageLocator.isPrimaryChkBoxInput, 'type') == 'checkbox'
    * delay(1000)
   	
    
	#REV2-26144
	Scenario: Verify whether Login Phone Number and Login Email ID field is mandatory or not for Super Admin
    
		* delay(2000)
    * mouse().move(partyPageLocator.roleDropDownBox).click()
    * delay(1000)
    * def optionOnDropDown = locateAll(partyPageLocator.roleDropDownBoxValue)
    * delay(1000)
    * optionOnDropDown[2].click()
    * delay(1000)
    * exists(partyPageLocator.loginPhoneNumber)
   	* exists(partyPageLocator.loginEmailId)
   	* delay(1000)
   	* input(partyPageLocator.nameInputField, 'test')
   	* delay(1000)
   	* click(partyPageLocator.createButton)
    * waitForText('body', 'Please insert either Login Email Id or Login Phone Number')
    * karate.log('*** Please insert either Login Email Id or Login Phone Number ****')
    * delay(3000)
    * scroll(partyPageLocator.scroll)
    * input(partyPageLocator.loginPhoneNumber, '8864236875')
    * delay(1000)
    * click(partyPageLocator.createButton)
    * delay(3000)
    * exists(partyPageLocator.confirmationBoxPresent)
    * delay(1000)
    * match text(partyPageLocator.confirmDialogTxtL) == partyPageConstant.createNewPartyConfirmDailogTxt
    * delay(1000)
    
  
	#REV2-22772/REV2-22771/REV2-22770
	Scenario: Verify functionality of CANCEL button present inside the create confirmation window for Super Admin
    				
		* delay(2000)
    * mouse().move(partyPageLocator.roleDropDownBox).click()
    * delay(1000)
    * def optionOnDropDown = locateAll(partyPageLocator.roleDropDownBoxValue)
    * delay(1000)
    * optionOnDropDown[4].click()
    * delay(1000)
   	* input(partyPageLocator.nameInputField, 'sample')
   	* delay(1000)
   	* scroll(partyPageLocator.scroll)
    * input(partyPageLocator.loginPhoneNumber, '1234569870')
    * delay(1000)
    * click(partyPageLocator.createButton)
    * delay(3000)
    * karate.log('*****Verify create confirmation window when clicked on CREATE button*****')
    * exists(partyPageLocator.confirmationBoxPresent)
    * delay(1000)
    * match text(partyPageLocator.confirmDialogTxtL) == partyPageConstant.createNewPartyConfirmDailogTxt
    * delay(1000)
    * exists(partyPageLocator.confirmDailogCancelButton)
    * exists(partyPageLocator.dailogContinueButton)
    * delay(1000)
   	* click(partyPageLocator.confirmDailogCancelButton)
    * delay(1000)
    * match driver.url == partyPageConstant.confirmBoxCancelButtonUrl
   	* delay(1000)
   	
 	   
	#REV2-22757
	Scenario: Verify Name field for Super Admin
    
    * delay(1000)
    * exists(partyPageLocator.nameInputField)
    * delay(1000)
    * def createNewPartyFormFieldLabels = scriptAll(partyPageLocator.createNewPartyFormFieldsLabel, '_.textContent')
    * delay(1000)
    * print 'create New Party Form Field Labels : ', createNewPartyFormFieldLabels
    * delay(1000)
    * match createNewPartyFormFieldLabels[4] == partyPageConstant.createPartyNameLabelTxt
    * click(partyPageLocator.createButton)
    * delay(3000)
    * match text(partyPageLocator.nameValidationMsg) == partyPageConstant.nameValidationMsgTxt
    * delay(2000)
    

	#REV2-22756
	Scenario: Verify the Title field and its options present for Super Admin
    
		* delay(1000)
    * exists(partyPageLocator.titleField)
    * delay(1000)
    * def createNewPartyFormFieldLabels = scriptAll(partyPageLocator.createNewPartyFormFieldsLabel, '_.textContent')
    * delay(1000)
    * print 'create New Party Form Field Labels : ', createNewPartyFormFieldLabels
    * delay(1000)
    * match createNewPartyFormFieldLabels[3] == partyPageConstant.titleLabelTxt
    * match createNewPartyFormFieldLabels[3] != 'Title *'
    * delay(1000)
    * mouse().move(partyPageLocator.titleField).click()
    * delay(4000)
    * match attribute(partyPageLocator.titleField, 'value') == 'Mr'
    * mouse().move(partyPageLocator.titleDropDown)
    * delay(4000)
    * def titleOptions = scriptAll(partyPageLocator.titleDropDown, '_.textContent')
    * print 'titleOptions : ', titleOptions
    * delay(1000)
    * def optionOnTitle = locateAll(partyPageLocator.titleDropDown)
    * delay(1000)
    * optionOnTitle[1].click()
    * delay(1000)
    
      
	#REV2-22758
	Scenario: Verify Gender field and its options present for Super Admin
   
		* delay(1000)
    * exists(partyPageLocator.genderField)
    * delay(1000)
    * def createNewPartyFormFieldLabels = scriptAll(partyPageLocator.createNewPartyFormFieldsLabel, '_.textContent')
    * delay(1000)
    * print 'create New Party Form Field Labels : ', createNewPartyFormFieldLabels
    * delay(1000)
    * match createNewPartyFormFieldLabels[5] == partyPageConstant.genderLabelText
    * delay(3000)
    * mouse().move(partyPageLocator.genderField).click()
    * delay(5000)
    * def genderDropDownValues = scriptAll(partyPageLocator.genderDropDown, '_.textContent')
    * print 'genderDropDownValues : ', genderDropDownValues
    * delay(1000)
    * match genderDropDownValues[0] == partyPageConstant.genderValueMale
    * match genderDropDownValues[1] == partyPageConstant.genderValueFemale
    * delay(1000)
    
  
	#REV2-22767
	Scenario: Verify Contact Email ID field for Super Admin
    
		* delay(1000)
    * exists(partyPageLocator.contactEmailField)
    * delay(1000)
    * match enabled(partyPageLocator.contactEmailField) == true
    * delay(1000)
    * scroll(partyPageLocator.scroll)
    * input(partyPageLocator.contactEmailField, 'test21cybage.com')
    * mouse().move(100, 200).click()
    * delay(3000)
    * match text(partyPageLocator.contactEmailValidationMsg) == partyPageConstant.contactEmailValidationMsgTxt
    * delay(1000)
    * def createNewPartyFormFieldLabels = scriptAll(partyPageLocator.createNewPartyFormFieldsLabel, '_.textContent')
    * delay(1000)
    * print 'create New Party Form Field Labels : ', createNewPartyFormFieldLabels
    * delay(1000)
    * match createNewPartyFormFieldLabels[13] == partyPageConstant.contactEmailIdLabelTxt
    * match createNewPartyFormFieldLabels[13] != 'Contact Email ID *'
    
  
	#REV2-22766
	Scenario: Verify Contact Phone Number field for Super Admin
   
		* delay(1000)
    * exists(partyPageLocator.contactPhoneField)
    * delay(1000)
   	* match enabled(partyPageLocator.contactPhoneField) == true
   	* delay(3000)
   	* def createNewPartyFormFieldLabels = scriptAll(partyPageLocator.createNewPartyFormFieldsLabel, '_.textContent')
    * delay(1000)
    * print 'create New Party Form Field Labels : ', createNewPartyFormFieldLabels
    * delay(1000)
    * match createNewPartyFormFieldLabels[12] == partyPageConstant.contactPhoneNoLabelTxt
    * match createNewPartyFormFieldLabels[12] !contains '*'
    * delay(1000)
    * karate.log("******Verify invalid phonenumber******")
    * scroll(partyPageLocator.scroll)
    * delay(1000)
    * mouse().move(partyPageLocator.contactPhoneField).click()
    * delay(3000)
    * input(partyPageLocator.contactPhoneField, '84545')
    * mouse().move(100, 200).click()
    * delay(3000)
   	* match text(partyPageLocator.contactPhoneNoValidationMsg) == partyPageConstant.contactPhoneNoValidationMsgTxt
		* delay(1000)
		* mouse().move(partyPageLocator.contactPhoneCountryCodeTextBox).click()
		* delay(1000)
		* match attribute(partyPageLocator.contactPhoneCountryCodeTextBox, 'type') == 'text'		
		* delay(2000)
    * def countryCodes = locateAll(partyPageLocator.contactPhoneNumberCodeDropDown)
    * delay(2000)
    * countryCodes[1].click()
    * delay(3000)
    * clear(partyPageLocator.contactPhoneField)
    * delay(8000)
   	* value(partyPageLocator.contactPhoneField, '8000045410')
   	* def phoneno = value(partyPageLocator.contactPhoneField)
   	* delay(1000)
   	* match phoneno == '#regex [0-9]{10}'
   	* delay(1000)
   	
    	 
	#REV2-22773/REV2-22774/REV2-22775/REV2-22776/REV2-23076/REV2-23080
	Scenario: Verify the functionality of CONTINUE button present inside the create confirmation window for Super Admin
	
		* karate.log('****Verify the Create Party for Individual party type for all fields****')
		* delay(2000)
   	* mouse().move(partyPageLocator.roleDropDownBox).click()
   	* delay(1000)
   	* def optionText = scriptAll(partyPageLocator.roleDropDownBoxValue, '_.textContent')
   	* delay(1000)
    * def optionOnDropDown = locateAll(partyPageLocator.roleDropDownBoxValue)
    * delay(1000)
    * optionOnDropDown[1].click()
    * def role = optionText[1]
    * delay(1000)
   	* mouse().move(partyPageLocator.isPrimaryClickChkbox).click()
    * delay(3000)
    * mouse().move(partyPageLocator.addRolesButton).click()
    * delay(2000)
    * click(partyPageLocator.otherRolesInputBox)
    * delay(1000)
    * def otherRoleText = scriptAll(partyPageLocator.otherRoleDropDown, '_.textContent')
   	* delay(1000)
    * def otherRolesDropDownValues = locateAll(partyPageLocator.otherRoleDropDown)
    * delay(1000) 
    * otherRolesDropDownValues[1].click()
    * def otherRole = otherRoleText[1]
    * delay(3000)
    * click(partyPageLocator.classificationInput)
    * def classificationText = scriptAll(partyPageLocator.classificationDropDown, '_.textContent')
   	* delay(1000)
    * def classificationOptionOnDropDown = locateAll(partyPageLocator.classificationDropDown)
    * delay(1000)
    * classificationOptionOnDropDown[1].click()
   	* def classification = classificationText[1] 
   	* delay(1000)
   	* input(partyPageLocator.nameInputField, randomText)
    * delay(1000)
   	* def name = value(partyPageLocator.nameInputField) 
   	* delay(1000)
   	* mouse().move(partyPageLocator.genderField).click()
   	* delay(2000)
   	* def genderText = scriptAll(partyPageLocator.genderDropDown, '_.textContent')
   	* delay(1000)
   	* def genderDropDownValue = locateAll(partyPageLocator.genderDropDown)
   	* genderDropDownValue[1].click()
   	* delay(1000)   	
   	* def gender = genderText[1]
   	* delay(1000)   	
   	* input(partyPageLocator.dateOfBrith, '10/12/1991')
   	* delay(1000) 	
   	* input(partyPageLocator.dateOfAnniversary, '5/26/2003')
   	* delay(1000) 	
   	* scroll(partyPageLocator.scroll)    
    * karate.log('***Verify Contact EmailId and/or PhoneNumber is filled and Login EmailId & PhoneNumber is left blank when Not Available is checked***')
    * highlight(partyPageLocator.notAvailabeCheckBox)
    * delay(3000)
   	* mouse().move(partyPageLocator.notAvailabeCheckBox).click()
    * delay(3000)
    * def randomUsername =  random_string(4)
    * input(partyPageLocator.userName, randomUsername) 
    * def username = value(partyPageLocator.userName) 
   	* delay(1000)  
		* input(partyPageLocator.contactPhoneField, randomPhoneNo)
		* def contactPhoneNo = value(partyPageLocator.contactPhoneField) 
   	* delay(1000)
   	* input(partyPageLocator.contactEmailField, 'test' + randomUsername + '@cybage.com')
   	* def contactEmail = value(partyPageLocator.contactEmailField) 
   	* delay(3000) 	
   	* click(partyPageLocator.createButton)
    * delay(2000)
    * click(partyPageLocator.dailogBoxContinue)
    * karate.log('*********Verify the confirmation message when party is successfully created*********')
    * waitForText('body', 'New party created')
    * match driver.url contains '/show'
    * delay(2000)
    * karate.log('*******Verify the details of the created party.*********')
    * def newPartyCreatedValues = scriptAll(partyPageLocator.newPartyPersonalInfoValues, '_.textContent')
    * print 'Verify New Party Created Personal Info Values : ',  newPartyCreatedValues
    * match newPartyCreatedValues[1] == partyPageConstant.partyTypeValue
    * match newPartyCreatedValues[2] == classification
    * match newPartyCreatedValues[3] == name
    * match newPartyCreatedValues[4] == gender
    * match newPartyCreatedValues[5] == '10/12/1991'
    * match newPartyCreatedValues[6] == '5/26/2003'
   	* delay(1000) 
    * click(partyPageLocator.usernameTab)
    * delay(1000)
    * match text(partyPageLocator.userLoginIdColumnName) == partyPageConstant.userLoginIdColumnNameLabel
    * delay(1000)
    * match text(partyPageLocator.usernameList) == username
    * delay(2000)
    * click(partyPageLocator.contactInfoTab)
    * delay(1000)
    * match text(partyPageLocator.contactPhoneNoList) contains contactPhoneNo
    * delay(2000)
    * click(partyPageLocator.rolesTab)
    * delay(2000)
    * def rolesTabValues = scriptAll(partyPageLocator.rolesValue, '_.textContent')
		* delay(1000)
    * print 'Roles Value :',  rolesTabValues
    * match rolesTabValues[3] == role
    * match rolesTabValues[4] == otherRole
    * delay(2000)
    
   
	#REV2-23079/REV2-23077/REV2-22761
	Scenario: Verify Create Individual Party when Login Email Id and/or Login Phone Number is filled and Contact Email Id & Phone Number is left blank for Super Admin
    
		* karate.log('****Verify Create Party for Individual party type for only mandatory fields*****')
    * delay(2000)
   	* mouse().move(partyPageLocator.roleDropDownBox).click()
   	* delay(1000)
    * def optionOnDropDown = locateAll(partyPageLocator.roleDropDownBoxValue)
    * delay(1000)
    * optionOnDropDown[5].click()	
   	* input(partyPageLocator.nameInputField, randomText)
    * delay(1000)	
    * input(partyPageLocator.loginPhoneNumber, randomPhoneNo)
    * def phoneNumber = value(partyPageLocator.loginPhoneNumber)
    * delay(1000)
    * input(partyPageLocator.loginEmailId, 'test' + randomText + '@cybage.com')	
   	* click(partyPageLocator.createButton)
    * delay(2000)
    * click(partyPageLocator.dailogBoxContinue)
    * waitForText('body', 'New party created')
    * match driver.url contains '/show'
    * delay(2000)
    * karate.log('*****Verfiy system should store Login Phone Number as Login User Id*****')
    * click(partyPageLocator.usernameTab)
    * delay(1000)
    * match text(partyPageLocator.userLoginIdColumnName) == partyPageConstant.userLoginIdColumnNameLabel
    * delay(1000)
    * match text(partyPageLocator.usernameList) contains phoneNumber
    * delay(2000)

   
	#REV2-26152/REV2-22762
	Scenario: Verify Create Individual Party with multiple values in other roles for Super Admin
				
		* delay(2000)
   	* mouse().move(partyPageLocator.roleDropDownBox).click()
   	* delay(1000)
    * def optionOnDropDown = locateAll(partyPageLocator.roleDropDownBoxValue)
    * delay(1000)
    * optionOnDropDown[4].click()
		* delay(2000)
   	* mouse().move(partyPageLocator.isPrimaryClickChkbox).click()
    * delay(3000)
    * mouse().move(partyPageLocator.addRolesButton).click()
    * delay(2000)
    * click(partyPageLocator.otherRolesInputBox)
    * delay(1000)
    * def otherRolesDropDownValues = locateAll(partyPageLocator.otherRoleDropDown)
    * delay(1000)
    * otherRolesDropDownValues[2].click()
    * delay(1000)
    * click(partyPageLocator.otherRolesInputBox)
    * delay(2000)
    * def otherRolesDropDownValues = locateAll(partyPageLocator.otherRoleDropDown)
    * delay(1000)
    * otherRolesDropDownValues[0].click()
 		* delay(3000)
    * input(partyPageLocator.nameInputField, randomText)
    * delay(2000)   	
    * input(partyPageLocator.loginEmailId, 'test' + randomText + '@cybage.com')
    * def loginEmail = value(partyPageLocator.loginEmailId)
   	* click(partyPageLocator.createButton)
    * delay(2000)
    * click(partyPageLocator.dailogBoxContinue)
    * waitForText('body', 'New party created')
    * match driver.url contains '/show'
    * delay(2000)
		* karate.log('Check The system should store this Email Id as Login User Id.')
    * click(partyPageLocator.usernameTab)
    * delay(1000)
    * match text(partyPageLocator.userLoginIdColumnName) == partyPageConstant.userLoginIdColumnNameLabel
    * delay(1000)
    * match text(partyPageLocator.usernameList) == loginEmail
    * delay(2000)
   
 
	#REV2-26153/REV2-22755
	Scenario: Verify Create Individual Party with multiple values in Classification field for Super Admin
    	
		* delay(2000)
   	* mouse().move(partyPageLocator.roleDropDownBox).click()
   	* delay(1000)
    * def optionOnDropDown = locateAll(partyPageLocator.roleDropDownBoxValue)
    * delay(1000)
    * optionOnDropDown[6].click()
		* delay(2000)
		* exists(partyPageLocator.classificationInput)
		* delay(1000)
		* click(partyPageLocator.classificationInput)
    * delay(3000)
    * input(partyPageLocator.classificationInput,['FNP',Key.DOWN,Key.ENTER],1000)
    * delay(3000)
    * click(partyPageLocator.classificationInput)
    * delay(1000)
    * def classificationOptionOnDropDown = locateAll(partyPageLocator.classificationDropDown)
    * delay(1000)
    * classificationOptionOnDropDown[3].click()
    * delay(4000)
		* input(partyPageLocator.nameInputField, randomText)
    * delay(1000)	
    * input(partyPageLocator.loginEmailId, 'test' + randomText + '@cybage.com')
   	* click(partyPageLocator.createButton)
    * delay(2000)
    * click(partyPageLocator.dailogBoxContinue)
    * waitForText('body', 'New party created')
    * match driver.url contains '/show'
    * delay(2000)
 
 		  
	#REV2-22769
	Scenario: Verify the functionality of CANCEL button present at bottom of create party form for Super Admin
   
		* delay(2000)
   	* mouse().move(partyPageLocator.roleDropDownBox).click()
   	* delay(1000)
    * def optionOnDropDown = locateAll(partyPageLocator.roleDropDownBoxValue)
    * delay(1000)
    * optionOnDropDown[2].click()
		* delay(2000)
		* input(partyPageLocator.nameInputField, randomText)
    * delay(1000)
    * input(partyPageLocator.loginEmailId, 'test' + randomText + '@cybage.com')
   	* click(partyPageLocator.cancelButton)
    * delay(2000)
    * match driver.url contains '/search'
		* delay(2000)
    	
  	
	#REV2-22764/REV2-22763
	Scenario: Verify the Username field when Not Available check-box is selected for Super Admin
    	
		* delay(1000)
    * mouse().move(partyPageLocator.roleDropDownBox).click()
   	* delay(1000)
    * def optionOnDropDown = locateAll(partyPageLocator.roleDropDownBoxValue)
    * delay(1000)
    * optionOnDropDown[1].click()
		* delay(2000)
		* scroll(partyPageLocator.scroll)
		* delay(1000)
		* mouse().move(partyPageLocator.notAvailabeCheckBox).click()
    * delay(3000) 	
    * karate.log('****Verify username field should not allow any special character****')
    * input(partyPageLocator.userName, 'User%12543')
    * delay(1000)
    * mouse().move(100, 200).click()
    * delay(2000)
    * match text(partyPageLocator.usernameHelperTxt) == partyPageConstant.usernameSpecialCharMsg
    * delay(1000)
    * karate.log('***Verify the "Username" field when "Not Available" check-box is not selected ***')
    * mouse().move(partyPageLocator.notAvailabeCheckBox).click()
    * delay(3000)
    * def userNameExists = exists(partyPageLocator.userName)
   	* if (userNameExists) karate.log("userName Field not present")
    * delay(1000)
    * refresh() 
		* delay(1000)
		* mouse().move(partyPageLocator.newPartyTypeDropDown).click()
		* delay(2000)
		* def optionOnDropDown = locateAll(partyPageLocator.partyTypeDropdownMenu)
    * delay(1000)
    * match karate.sizeOf(optionOnDropDown) == 2
    * optionOnDropDown[0].click()
    * delay(3000) 
   	* mouse().move(partyPageLocator.roleDropDownBox).click()
   	* delay(1000)
    * def optionOnDropDown = locateAll(partyPageLocator.roleDropDownBoxValue)
    * delay(1000)
    * optionOnDropDown[1].click()
		* delay(2000)
		* input(partyPageLocator.nameInputField, randomText)
    * delay(1000)	
		* scroll(partyPageLocator.scroll)
		* delay(1000)
		* mouse().move(partyPageLocator.notAvailabeCheckBox).click()
    * delay(3000)
   	* def userNameExists = exists(partyPageLocator.userName)
   	* if (userNameExists) karate.log("userName Exists")
   	* delay(1000)
   	* karate.log('****Verify the "Not Available" field****')
   	* match attribute(partyPageLocator.notAvailableInput, 'type') == 'checkbox'		
   	* delay(1000)
   	* match text(partyPageLocator.userNameLabel) contains partyPageConstant.userNameLabelTxt
    * delay(1000)
    * input(partyPageLocator.contactEmailField, randomText + '@gmail.com')
   	* delay(1000)
   	* click(partyPageLocator.createButton)
    * delay(2000)
    * karate.log('****Verify if username is left blank it should throw a validation message****')
    * match text(partyPageLocator.usernameHelperTxt) == partyPageConstant.usernameHelperTxtMsg
		* delay(1000)
		* click(partyPageLocator.userName)
		* karate.log('**** username field should allow a maximum of Ten characters or numbers or combinations of both****')
    * input(partyPageLocator.userName, 'UserTester123')
    * delay(3000)
    * mouse().move(100, 200).click()    	   
    * match text(partyPageLocator.usernameHelperTxt) == partyPageConstant.usernameCharValidation
    * delay(1000)
		* karate.log('****Verify whether the entered username is not associated with any other account****') 
		* refresh() 
		* delay(1000)
		* mouse().move(partyPageLocator.newPartyTypeDropDown).click()
		* delay(2000)
		* def optionOnDropDown = locateAll(partyPageLocator.partyTypeDropdownMenu)
    * delay(1000)
    * match karate.sizeOf(optionOnDropDown) == 2
    * optionOnDropDown[0].click()
    * delay(2000)
   	* mouse().move(partyPageLocator.roleDropDownBox).click()
   	* delay(1000)
    * def optionOnDropDown = locateAll(partyPageLocator.roleDropDownBoxValue)
    * delay(1000)
    * optionOnDropDown[1].click()
		* delay(2000)
		* input(partyPageLocator.nameInputField, randomText)
    * delay(1000)	
		* scroll(partyPageLocator.scroll)
		* delay(1000)
		* mouse().move(partyPageLocator.notAvailabeCheckBox).click()
    * delay(3000)
    * input(partyPageLocator.userName, 'anmol21')
   	* delay(1000)   
    * input(partyPageLocator.contactEmailField, randomText + '@gmail.com')
   	* delay(1000)  		 	
   	* click(partyPageLocator.createButton)
   	* delay(3000)
   	* click(partyPageLocator.dailogBoxContinue)
		* waitForText('body', 'Username is already in used')


	#REV2-22762
	Scenario: Verify the Login Email ID field for Super Admin

		* karate.log("*****Verify The e-mail address entered is invalid*******")
		* delay(1000)
		* scroll(partyPageLocator.scroll)
		* delay(1000)
		* input(partyPageLocator.loginEmailId, 'test' + randomText + '@.com')
		* mouse().move(100, 200).click() 
		* delay(2000)
		* match text(partyPageLocator.loginEmailHelperText) == partyPageConstant.loginEmailHelperTextMsg
		* delay(2000)
		* refresh()
		* karate.log("*****Verify The e-mail address is left blank*******")
		* delay(1000)
		* mouse().move(partyPageLocator.newPartyTypeDropDown).click()
		* delay(2000)
		* def optionOnDropDown = locateAll(partyPageLocator.partyTypeDropdownMenu)
    * delay(1000)
    * optionOnDropDown[0].click()
		* delay(1000)
   	* mouse().move(partyPageLocator.roleDropDownBox).click()
   	* delay(1000)
    * def optionOnDropDown = locateAll(partyPageLocator.roleDropDownBoxValue)
    * delay(1000)
    * optionOnDropDown[4].click()
		* delay(2000)
		* input(partyPageLocator.nameInputField, randomText)
    * delay(1000)
    * scroll(partyPageLocator.scroll)
		* delay(1000)
		* exists(partyPageLocator.loginEmailId)
		* delay(1000)
   	* click(partyPageLocator.createButton)
		* waitForText('body', 'Please insert either Login Email Id or Login Phone Number')
		* delay(5000)
		* karate.log("*****Verify The e-mail address already in use*******")
		* input(partyPageLocator.loginEmailId, 'testdf@gmail.com')
		* delay(1000)
		* click(partyPageLocator.createButton)
		* delay(3000)
		* click(partyPageLocator.dailogBoxContinue)
		* waitForText('body', 'The email id is already in use')
		
	
	#REV2-22761
	Scenario: Verify the Login Phone Number field for Super Admin
		
		* delay(1000)
   	* mouse().move(partyPageLocator.roleDropDownBox).click()
   	* delay(1000)
    * def optionOnDropDown = locateAll(partyPageLocator.roleDropDownBoxValue)
    * delay(1000)
    * optionOnDropDown[4].click()
		* delay(2000)
		* input(partyPageLocator.nameInputField, randomText)
    * delay(1000)
    * scroll(partyPageLocator.scroll)
		* delay(1000)
  	* scroll(partyPageLocator.scroll)
  	* delay(1000)
  	* exists(partyPageLocator.loginPhoneNumber)
  	* match attribute(partyPageLocator.loginPhoneNumber, 'type') == 'number'
  	* delay(1000)
  	* karate.log("****Verify if Login Phone Field is left blank****")		
		* delay(1000)
   	* click(partyPageLocator.createButton)
		* waitForText('body', 'Please insert either Login Email Id or Login Phone Number')
		* delay(5000)		
  	* karate.log("*****Verify invalid phone number*******")
  	* input(partyPageLocator.loginPhoneNumber, '235')
  	* mouse().move(100,200).click()
  	* match text(partyPageLocator.loginPhoneNumberHelperTxt) == partyPageConstant.loginPhoneNumberHelperTxtMsg
  	* delay(1000)
  	* mouse().move(partyPageLocator.loginPhoneCountryCodeTextBox).click()
		* delay(1000)
		* def loginCountryCodes = locateAll(partyPageLocator.loginCountryCodeDropDown)
 	 	* delay(2000)
  	* loginCountryCodes[1].click()  	
  	* karate.log("****Verify if Login Phone Number is already in use****")
		* delay(1000)
		* delay(5000)
		* clear(partyPageLocator.loginPhoneNumber)
		* delay(10000)
  	* value(partyPageLocator.loginPhoneNumber, '8864236875')
   	* def phoneno = value(partyPageLocator.loginPhoneNumber)
   	* delay(1000)
   	* match phoneno == '#regex [0-9]{10}'
   	* delay(1000)
   	* click(partyPageLocator.createButton)
   	* click(partyPageLocator.dailogBoxContinue)
		* waitForText('body', 'The phone number/mobile number is already in used.')
		* delay(5000)
			
	
	#REV2-22760/REV2-22759
	Scenario: Verify the Date of Anniversary and Date of Birth field for Super Admin
	
		* delay(1000)
		* exists(partyPageLocator.dateOfAnniversaryInputBox)
		* delay(1000)
		* match attribute(partyPageLocator.dateOfAnniversaryInputBox, 'type') == 'date'
		* delay(1000)
		* exists(partyPageLocator.dateOfBirthInputBox)
		* delay(1000)
		* match attribute(partyPageLocator.dateOfBirthInputBox, 'type') == 'date'
		* delay(1000)
	
		
	#REV2-22754/REV2-22753
	Scenario: Verify Other roles field when Add Other Roles hyperlink is clicked for Super Admin
	
		* delay(1000)
		* exists(partyPageLocator.roleDropDownBox)
		* delay(1000)
   	* mouse().move(partyPageLocator.roleDropDownBox).click()
   	* delay(1000)
    * def optionOnDropDown = locateAll(partyPageLocator.roleDropDownBoxValue)
    * delay(1000)
    * optionOnDropDown[2].click()
    * delay(1000)
   	* mouse().move(partyPageLocator.isPrimaryClickChkbox).click()
    * delay(3000)
    * mouse().move(partyPageLocator.addRolesButton).click()
    * delay(2000)
    * exists(partyPageLocator.otherRolesInputBox)
    * delay(5000)
		* input(partyPageLocator.otherRolesInputBox, 'i')
		* delay(5000)
		* input(partyPageLocator.otherRolesInputBox, [Key.DOWN,Key.ENTER])
		* delay(5000)	
		* click(partyPageLocator.otherRolesInputBox)
   	* delay(1000)
    * def otherRolesDropDownValues = locateAll(partyPageLocator.otherRoleDropDown)
    * delay(1000)
    * otherRolesDropDownValues[1].click()
    * delay(3000)  
   	* mouse().move(partyPageLocator.isPrimaryClickChkbox).click()
   	* delay(5000)
   	* exists(partyPageLocator.otherRolesInputBox)
		* delay(3000)
		 
		  
	#REV2-22748
	Scenario: Verify CANCEL and CREATE button present inside the create party form for Super Admin
	
		* delay(2000)
		* exists(partyPageLocator.cancelButton)
		* delay(2000)
		* exists(partyPageLocator.createButton)
		* def buttonsOnCreateForm = scriptAll(partyPageLocator.buttonsOnForm, '_.textContent')
		* print 'buttonsOnCreateForm : ', buttonsOnCreateForm
		* match buttonsOnCreateForm[1] == 'Cancel'
		* match buttonsOnCreateForm[2] == 'CREATE'
		* delay(1000)
		
		 	
	#REV2-22747
	Scenario: Verify new party form fields if Super Admin select Party type as Individual
	
		* delay(1000)
		* def createPartyFormFields = scriptAll(partyPageLocator.individualPartyTypeFormFields, '_.textContent')
		* delay(1000)
		* print 'create Individual Party Form Fields : ', createPartyFormFields
		* match createPartyFormFields[0] == partyPageConstant.createPartyTypeLabelTxt
		* match createPartyFormFields[1] == partyPageConstant.roleLabelTxt
		* match createPartyFormFields[2] == partyPageConstant.classificationLabelTxt
		* match createPartyFormFields[3] == partyPageConstant.titleLabelTxt
		* match createPartyFormFields[4] == partyPageConstant.createPartyNameLabelTxt
		* match createPartyFormFields[5] == partyPageConstant.genderLabelText
		* match createPartyFormFields[6] == partyPageConstant.dobLabelTxt
		* match createPartyFormFields[7] == partyPageConstant.dateOfAnniversaryTxt
		* match createPartyFormFields[9] == partyPageConstant.loginPhoneNumberLabelTxt
		* match createPartyFormFields[10] == partyPageConstant.loginEmailIdLabelTxt
		* match createPartyFormFields[12] == partyPageConstant.contactPhoneNoLabelTxt
		* match createPartyFormFields[13] == partyPageConstant.contactEmailIdLabelTxt
		* delay(2000)
		* def chkBoxesInForm = scriptAll(partyPageLocator.infoLabel, '_.textContent')
		* delay(1000)
		* match chkBoxesInForm[0] == partyPageConstant.personalInfoLabelTxt
		* match chkBoxesInForm[1] == partyPageConstant.contactInfoLabelTxt
		* delay(1000)
		
		