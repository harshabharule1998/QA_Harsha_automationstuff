Feature:  Party Create login UI scenarios

  Background: 
    * def loginLocator = read('../../data/loginPage_locator.json')
    * def usersValue = read('../../data/users.json')
    * def dashBoardLocator = read('../../data//dashboard_locators.json')
    * def usernameLocator = read('../../data/party/usernamePage_locators.json')
    * def usernameConstant = read('../../data/party/usernamePage_constants.json')
    
    * configure driver = driverConfig
    * driver backOfficeUrl
    * print '***backofficeurl***' backOfficeUrl
    And maximize()
    * delay(3000)
    * karate.log('***Logging into the application****')
    And input(loginLocator.usernameTextArea, usersValue.users.superAdmin.email)
    * delay(2000)
    And input(loginLocator.passwordTextArea, usersValue.users.superAdmin.password)
    * delay(1000)
    
    When click(loginLocator.loginButton)
    * karate.log('***Logging into the application****')
    * delay(1000)
    And click(dashBoardLocator.switchMenu)
    * delay(1000)
    And click(dashBoardLocator.partyMenu)
    * delay(1000)
		* mouse().move(usernameLocator.partyTypeDropdownTxt).click()

    * delay(2000)
    * def dropdownTxt = scriptAll(usernameLocator.partyTypeDropdownMenu, '_.textContent')
    * print 'Dropdown', dropdownTxt
    * delay(1000)
    * match dropdownTxt[0] contains 'Individual'
    * match dropdownTxt[1] contains 'Organization'
    * delay(2000)
    
    * def optionOnDropDown = locateAll(usernameLocator.partyTypeDropdownMenu)
    * delay(1000)
    * match karate.sizeOf(optionOnDropDown) == 2
    * optionOnDropDown[0].click()
    * delay(1000) 
    
    * input(usernameLocator.typePartyId,usernameConstant.lablePartyId)
    * delay(1000)
    * click(usernameLocator.clickOnApply)
    * delay(1000)
    * click(usernameLocator.clickOnPartyId)
    * delay(1000)
		* karate.log('***Personal information tab will get open by default****')   
    * match text(usernameLocator.personalInfoColLoadByDefault) == usernameConstant.personalInfoTabText
    * delay(1000)
  	* karate.log('***Click on username tab****')     
    * click(usernameLocator.usernamesLabel)
	  * delay(3000) 
	  
	
	#REV2-20558/REV2-20595/REV2-20560/REV2-20562/REV2-20571
	Scenario: Verify the functionality of "New Username" button for super admin with all 
	the permission.
		
		* karate.log('***Verify if username is loginId****')   
		* karate.log('***Match the text on new username button****')   
	  * match text(usernameLocator.newUsrnmButton) == usernameConstant.newUsrnmTxt  
	  * delay(1000) 
		* karate.log('***Click on new username button****')   
	  * click(usernameLocator.newUsrnmButton)
	  * delay(3000) 
		* karate.log('***Match the text URL on new username page****')   
	  * waitForUrl(usernameConstant.newUsrnmPageUrl)
	  * delay(1000)  
		* karate.log('***Match the label on new username page****')   
	  * match text(usernameLocator.newUsrnmLabel) == usernameConstant.newUsrnmLabelTxt
	  * delay(1000)
	  * karate.log('**** By default toggle button is on click on it to off***')    
    * delay(3000)
    * click(usernameLocator.statusToggleButton)
	  * delay(3000)
		* karate.log('**** click to on toggle button ***')      
		* click(usernameLocator.statusToggleButton)
	  * delay(3000)
	  * karate.log('***Verify loginId field validations****')   
	  * click(usernameLocator.createButton)
	  * delay(3000)
	  * match text(usernameLocator.loginIdValidation) == usernameConstant.loginIdRequiredField
		* delay(2000)  
		* click(usernameLocator.loginIdUsrnm)
	 	* delay(1000) 
		* input(usernameLocator.loginIdUsrnm,"harsh@")
	  * match text(usernameLocator.loginIdValidation) == usernameConstant.loginIdInvalidMsg
	  * delay(1000)
	 	* click(usernameLocator.loginIdUsrnm)
	 	* delay(1000) 
	 	* clear(usernameLocator.loginIdUsrnm)
	 	* delay(1000) 	
		* input(usernameLocator.loginIdUsrnm,"harsh@fnp.com") 
	 	* delay(1000) 		
	  * karate.log('***click on transfer access checkbox****')   
		* mouse().move(usernameLocator.transferAccessChkbox).click()
	  * delay(1000)
		* karate.log('***Verify  search loginId field validations****')   
		* karate.log('***Verify  error msg as No login id is available in the system as per your search text****')   		
		* click(usernameLocator.searchLoginId)
	  * delay(3000)
		* input(usernameLocator.searchLoginId,"harsh")
	  * match text(usernameLocator.loginIdNotAvailable) == usernameConstant.loginIdNotAvailTxt
		* delay(5000)
		* karate.log('***Verify  error msg "The selected login id is active in the system, so you can’t transfer access from itt****')   				
		* click(usernameLocator.searchLoginId)
	  * delay(2000)
		* clear(usernameLocator.searchLoginId)
		* input(usernameLocator.searchLoginId,"harsha")
		* delay(3000)
	  * match text(usernameLocator.loginIdNotAvailable) == usernameConstant.selectedLoginIdActive
		* delay(5000)
		* karate.log('***verify error msg as This is not a valid ‘Inactive login id****')   	
		* click(usernameLocator.searchLoginId)
	  * delay(1000)
		* clear(usernameLocator.searchLoginId)
		* input(usernameLocator.searchLoginId,"harsha@fnp")
		* delay(3000)
	  * match text(usernameLocator.loginIdNotAvailable) == usernameConstant.notValidInactive
		* delay(5000)
	  * karate.log('**** verify error msg No login id is available in the system as per your search text ***')    		
 		* click(usernameLocator.searchLoginId)
	  * delay(1000)
		* clear(usernameLocator.searchLoginId)
		* input(usernameLocator.searchLoginId,"harsha@fnp.c")
		* delay(3000)
	  * match text(usernameLocator.loginIdNotAvailable) == usernameConstant.noLoginIdAvailInSystem
		* delay(5000)
		* karate.log('***verify all fields label when username is emailId****')   			
    * def newUsrnmByEmail = scriptAll(usernameLocator.verifyTitleField, '_.textContent')
    * print 'newUsrnmByEmail...', newUsrnmByEmail  
    * delay(1000)
    * match newUsrnmByEmail[0] == usernameConstant.loginIdLabel
    * match newUsrnmByEmail[2] == usernameConstant.dateAndTimeLabel
    * match newUsrnmByEmail[3] contains usernameConstant.transferAccessTxt
    * match newUsrnmByEmail[4] == usernameConstant.searchLoginIdLabel
    * match text(usernameLocator.statusField) == usernameConstant.status
    * match text(usernameLocator.accessTransfer) == usernameConstant.accessTransferTxt 
 		* delay(10000)
	 

	#REV2-20585
	Scenario: Verify that the transfer access form the username, if the checkbox is selected only then the 
	Search and Select the existing inactive login id� box will be visible for super admin with all the permission.
	  
	  * karate.log("**Verify if checkbox selected only then Search&Select existing inactive loginid box will be visible **")      
	  * click(usernameLocator.newUsrnmButton)
	  * delay(3000) 
		* click(usernameLocator.loginIdUsrnm)
	 	* delay(1000) 
		* input(usernameLocator.loginIdUsrnm,"sachin12@fnp.com")  
	 	* delay(1000)  
		* mouse().move(usernameLocator.transferAccessChkbox).click()
	 	* delay(2000)  	
		* karate.log('**** verify if searchloginId textbox is visible after click on transferAccessChkbox***')    	 	
		* print locate(usernameLocator.searchLoginId).script("_.is(':visible')")   	
	  * delay(3000)  
	
	
	Scenario: Verify that the given 'username' is not associated with any other account for super admin / admin with all the permission.
		* karate.log('***Verify in case username is combination of letters and numbers****')   
		* click(usernameLocator.newUsrnmButton)
	  * delay(3000) 
		* click(usernameLocator.loginIdUsrnm)
	 	* delay(1000) 
		* input(usernameLocator.loginIdUsrnm,"newUsr1")  
	 	* delay(3000)  
	  * karate.log('***click on transfer access checkbox****')   
		* mouse().move(usernameLocator.transferAccessChkbox).click()
	  * delay(3000)
	  * karate.log('***click on requir change password as No***')   	  
		* mouse().move(usernameLocator.requirePassChangeNo).click()
	  * delay(3000)
	  * karate.log('***Click and give input to search loginId field ****')   
		* click(usernameLocator.searchLoginId)
	  * delay(1000)
	  * input(usernameLocator.searchLoginId,'test1234Q')	
    * delay(1000)		 
    * click(usernameLocator.searchLoginIdDropdwn)
    * delay(4000) 
	  * click(usernameLocator.passTxtboxField)
	  * delay(3000)
	  * input(usernameLocator.passTxtboxField,"Password@123")  
	 	* delay(1000)    
	  * click(usernameLocator.confirmPassTxtboxField)
	  * delay(3000)
	  * input(usernameLocator.confirmPassTxtboxField,"Password@123")  
	 	* delay(1000)       
	  * click(usernameLocator.createButton)
	  * karate.log('***Verify validation Message if searchloginId is empty ****')  
    * highlight(usernameLocator.alertPopup)	   
	  * match text(usernameLocator.alertPopup) == usernameConstant.newUsrnmCreated
		* delay(5000)


	#REV2-20586
	Scenario: Verify that the transfer access form the username, if the checkbox is not selected then the Search and Select the 
	existing inactive login id� box will not be visible for super admin with all the permission.
	
		* click(usernameLocator.newUsrnmButton)
	  * delay(3000) 
		* click(usernameLocator.loginIdUsrnm)
	 	* delay(1000) 
		* input(usernameLocator.loginIdUsrnm,"sachin12@fnp.com")  
	 	* delay(1000)  
		* mouse().move(usernameLocator.transferAccessChkbox)
	 	* delay(2000) 
	  * karate.log('**** check weather trasfer access checkbox is enable***')    	 	
	  * delay(1000)
	  And match enabled(usernameLocator.transferAccessChkbox) == true	
	  * delay(3000) 
  	* karate.log("*If the transferAccess checkbox is not selected then the SearchloginId not visible*")    		  
	  * print locate(usernameLocator.searchLoginId).script("_.is(':!visible')")   	
	  * delay(3000)
	  
	
  #REV2-20573//REV2-20587/REV2-20591/REV2-20561
  Scenario: Verify that the given 'username' is not associated with any other account for super admin 
   with all the permission.
  	
  	* karate.log('**** Create new username by email id ***')    	
  	* click(usernameLocator.newUsrnmButton)
	  * delay(3000) 
		* click(usernameLocator.loginIdUsrnm)
	 	* delay(1000) 
		* input(usernameLocator.loginIdUsrnm,"newuser2@fnp.com")  
	 	* delay(1000)  
		* mouse().move(usernameLocator.transferAccessChkbox).click()
	  * delay(3000)
		* click(usernameLocator.searchLoginId)
	  * delay(1000)
	  * input(usernameLocator.searchLoginId,'test2@fnp.com')	
    * delay(3000)		
    * def searchLoginIdDropdwn = scriptAll(usernameLocator.searchLoginIdDropdwn, '_.textContent')
    * print 'searchLoginIdDropdwn...', searchLoginIdDropdwn    
    * def optionOnDrop own = locateAll(usernameLocator.searchLoginIdDropdwn)
	  * delay(3000)
	  * click(usernameLocator.searchLoginIdDropdwn)
	  * delay(10000) 
    * click(usernameLocator.createButton)
  	* karate.log('***Verify popup as new username craeted ****')  
	  * match text(usernameLocator.alertPopup) == usernameConstant.newUsrnmCreated
		* delay(10000)
   
 
  #REV2-20577
  Scenario: Verify that the already associated 'email address' as login Id or Username  with leading and trailing space as login id/username field is
   not allowed for super admin with all the permission.  
   
    * karate.log('***Verify that the already associated "email address" with leading and trailing spaces ****')  
	  * click(usernameLocator.newUsrnmButton)
	  * delay(3000) 
		* click(usernameLocator.loginIdUsrnm)
	 	* delay(1000) 
		* karate.log('***Enter already registered loginId as email with leading and trailing spaces ****')  	
		* input(usernameLocator.loginIdUsrnm," sachin@fnp.com ")  
	 	* delay(1000)  
		* mouse().move(usernameLocator.transferAccessChkbox).click()
	  * delay(3000)
		* click(usernameLocator.searchLoginId)
	  * delay(1000)
	  * input(usernameLocator.searchLoginId,'test1@fnp.com')	
    * delay(3000)		 
    * def optionOnDropDown = locateAll(usernameLocator.searchLoginIdDropdwn)
    * delay(1000)
    * optionOnDropDown[0].click()
    * delay(5000) 
    * click(usernameLocator.createButton)
  	* karate.log('***Verify validation Message with leading& trailing spaces in login id with already registered user ****')  
    * highlight(usernameLocator.alertPopup)	    	   
	  * match text(usernameLocator.alertPopup) == usernameConstant.alreadyRegistredUsrTxt
		* delay(10000)

	
	#REV2-20575/REV2-20573//REV2-20576
	Scenario: Verify that the given 'email address' as login Id or Username is associated with any other account 
	or not for super admin with all the permission.
	
		* karate.log('****Verify loginId with  already associated "email address" ****')   
	  * click(usernameLocator.newUsrnmButton)
	  * delay(3000) 
	  * karate.log('***click on loginId username****')  	
		* click(usernameLocator.loginIdUsrnm)
	 	* delay(1000) 
		* input(usernameLocator.loginIdUsrnm,"sachin@fnp.com")  
	 	* delay(1000)  
	  * karate.log('***click on transfer access checkbox****')   
		* mouse().move(usernameLocator.transferAccessChkbox).click()
	  * delay(3000)
		* karate.log('***Click and give input to search loginId field ****')   
		* click(usernameLocator.searchLoginId)
	  * delay(1000)
	  * input(usernameLocator.searchLoginId,'test1@fnp.com')	
    * delay(1000)		 
    * def optionOnDropDown = locateAll(usernameLocator.searchLoginIdDropdwn)
    * delay(1000)
    * optionOnDropDown[0].click()
    * delay(1000) 
    * click(usernameLocator.createButton)
  	* karate.log('***Verify validation Message if User is already registered ****')  
    * highlight(usernameLocator.alertPopup)	    	   
	  * match text(usernameLocator.alertPopup) == usernameConstant.alreadyRegistredUsrTxt
		* delay(5000)
		
	
  Scenario: Verify that the given 'email address' as login Id or Username with loginId and empty
   searchLoginId for superadmin
	
		* karate.log('***Verify if search loginId is empty while creating username by emailId****')   
	  * click(usernameLocator.newUsrnmButton)
	  * delay(3000) 
	  * karate.log('***click on loginId username****')  	
		* click(usernameLocator.loginIdUsrnm)
	 	* delay(1000) 
		* input(usernameLocator.loginIdUsrnm,"sachin@fnp.com")  
	 	* delay(1000)  
	  * karate.log('***click on transfer access checkbox****')   
		* mouse().move(usernameLocator.transferAccessChkbox).click()
	  * delay(3000)
    * click(usernameLocator.createButton)
  	* karate.log('***Verify validation Message if searchloginId is empty ****')  
    * highlight(usernameLocator.alertPopup)	
	  * match text(usernameLocator.alertPopup) == usernameConstant.validInactiveValidationMsg
		* delay(5000)		 
		* delay(5000)
	
	
	#REV2-20601
  Scenario: Verify functionality of "Cancel" button  without entering data for super
   admin  with all the permission.
		
	  * karate.log('***Verify functionality of "Cancel" button  without entering data****')   
	  * click(usernameLocator.newUsrnmButton)
	  * delay(3000)
    * click(usernameLocator.cancelPermissionName)
    * delay(3000)  
  	* karate.log('***Verify Url after click on cancel button ****')  
    * waitForUrl("/show/usernames")	   
		* delay(5000)
		
		
	#REV2-20600
	Scenario: Verify "Cancel" button functionality after entering valid data for
	super admin  with all the permission.
	
	  * karate.log('***Verify functionality of "Cancel" button  with entering valid data****')   	
	  * click(usernameLocator.newUsrnmButton)
	  * delay(3000) 
		* click(usernameLocator.loginIdUsrnm)
	 	* delay(1000) 
		* input(usernameLocator.loginIdUsrnm,"sachin@fnp.com")  
	 	* delay(1000)  
		* mouse().move(usernameLocator.transferAccessChkbox).click()
	  * delay(3000)
	  * karate.log('***Click on cancel button after enter valid data****')
    * click(usernameLocator.cancelPermissionName)
    * delay(3000)  
  	* karate.log('***Verify Url after click on cancel button ****')  
    * waitForUrl("/show/usernames")	   
		* delay(5000)


	Scenario:  Verify that the given 'username' is inactive if status toggle button is of and transfer accesschkbox
	is not selected for super admin with all the permission.
	
		* click(usernameLocator.newUsrnmButton)
	  * delay(3000) 
		* click(usernameLocator.loginIdUsrnm)
	 	* delay(1000) 
		* input(usernameLocator.loginIdUsrnm,"testnewuser1@fnp.com")  
	 	* delay(3000)  
	 	* highlight(usernameLocator.statusToggleButton)
		* delay(5000) 	
		* click(usernameLocator.statusToggleButton)
	  * delay(3000) 
	  * karate.log('***Verify new inactive user is created ****')    
	  * click(usernameLocator.createButton)
		* match text(usernameLocator.alertPopup) == usernameConstant.newUsrnmCreated
	 	* delay(10000)  	
	

  #REV2-20594/REV2-20596/REV2-20602/REV2-20565/REV2-20566/REV2-20567/REV2-20568
	Scenario: Verify that the system will show error message after clicking on "Create" button if 
	"Password" field is left blank for super admin / admin with all the permission.
	
	  * karate.log('***Create username by combination of letters and numberss****')   
		* click(usernameLocator.newUsrnmButton)
	  * delay(3000) 
		* click(usernameLocator.loginIdUsrnm)
	 	* delay(1000) 
		* input(usernameLocator.loginIdUsrnm,"test123Q")  
	 	* delay(3000)  
	  * karate.log('***click on transfer access checkbox****')   
		* mouse().move(usernameLocator.transferAccessChkbox).click()
	  * delay(3000)
	  * karate.log('***click on requir change password as No***')   	  
		* mouse().move(usernameLocator.requirePassChangeNo).click()
	  * delay(3000)
	  * click(usernameLocator.createButton)
	  * delay(3000)
		* match text(usernameLocator.passwordValidation) == usernameConstant.passwordValidationTxt
	  * delay(1000)
		* match text(usernameLocator.confirmPassValidation) == usernameConstant.passwordValidationTxt
		* delay(3000)
	  * karate.log('**** Verify label on fields ***')    
    * def newUsrnmByEmail = scriptAll(usernameLocator.passRequirnmentMsges, '_.textContent')
    * newUsrnmByEmail[8] = 'At Least One Capital letter' 
    * newUsrnmByEmail[9] = 'At Least One Special Character'
    * newUsrnmByEmail[10] = 'Char should be in between 10 to 20'
    * delay(10000)
		* delay(5000)
	  * karate.log('**** Verify label on fields if username is combination of letters and numbers ***')    
    * def newUsrnmByEmail = scriptAll(usernameLocator.verifyTitleField, '_.textContent')
    * print 'newUsrnmByEmail...', newUsrnmByEmail  
    * delay(1000)
    * match newUsrnmByEmail[0] == usernameConstant.loginIdLabel
    * match newUsrnmByEmail[2] == usernameConstant.dateAndTimeLabel
    * match newUsrnmByEmail[3] contains usernameConstant.transferAccessTxt
    * match newUsrnmByEmail[4] == usernameConstant.searchLoginIdLabel
    * match newUsrnmByEmail[5] == usernameConstant.YesRadioButtonTxt
    * match newUsrnmByEmail[6] == usernameConstant.NoRadioButtonTxt
    * delay(1000)
    * match text(usernameLocator.statusField) == usernameConstant.status
    * match text(usernameLocator.accessTransfer) == usernameConstant.accessTransferTxt 
    * match text(usernameLocator.requirPassChnageOptions) == usernameConstant.passwordRequirnmentChangeTxt
    * karate.log('**** Verify label on create and cancel button ***')         
    * match text(usernameLocator.createButton) == usernameConstant.createButtonTxt
    * match text(usernameLocator.cancelPermissionName) == usernameConstant.cencelButtonTxt
    * delay(1000)  
    * karate.log('**** Verify icon on password and confirm password field ***')      
    * def showPassIconVerify = scriptAll(usernameLocator.showPassIcon, '_.textContent')
    * match showPassIconVerify[0] == "#present" 
    * match showPassIconVerify[1] == "#present"
 	  * delay(3000)
    * karate.log('**** Give input to password and confirm pasword ***')        
    * click(usernameLocator.passTxtboxField)
	  * delay(3000)
	  * input(usernameLocator.passTxtboxField,"Password@123")  
	 	* delay(1000)    
	  * click(usernameLocator.confirmPassTxtboxField)
	  * delay(3000)
	  * input(usernameLocator.confirmPassTxtboxField,"Password@123")  
	 	* delay(1000)     
	  * click(usernameLocator.createButton)
  	* karate.log('***Verify validation Message if User is already registered ****')  
    * highlight(usernameLocator.alertPopup)	    	   
	  * match text(usernameLocator.alertPopup) == usernameConstant.validInactiveValidationMsg
		* delay(5000)		  
 		* delay(10000)
 		

	Scenario: Verify the given 'username' if searchloginId is empty for super admin with all the permission.
	
		* karate.log('***Verify in case username is combination of letters and numbers****')   
		* click(usernameLocator.newUsrnmButton)
	  * delay(3000) 
		* click(usernameLocator.loginIdUsrnm)
	 	* delay(1000) 
		* input(usernameLocator.loginIdUsrnm,"test123Q")  
	 	* delay(3000)  
	  * karate.log('***click on transfer access checkbox****')   
		* mouse().move(usernameLocator.transferAccessChkbox).click()
	  * delay(3000)
	  * karate.log('***click on requir change password as No***')   	  
		* mouse().move(usernameLocator.requirePassChangeNo).click()
	  * delay(3000)
	  * click(usernameLocator.passTxtboxField)
	  * delay(3000)
	  * input(usernameLocator.passTxtboxField,"Password@123")  
	 	* delay(1000)    
	  * click(usernameLocator.confirmPassTxtboxField)
	  * delay(3000)
	  * input(usernameLocator.confirmPassTxtboxField,"Password@123")  
	 	* delay(1000)       
	  * click(usernameLocator.createButton)
	  * karate.log('***Verify validation Message if searchloginId is empty ****')  
    * highlight(usernameLocator.alertPopup)	   
	  * match text(usernameLocator.alertPopup) == usernameConstant.validInactiveValidationMsg
		* delay(5000)
	
		
  #REV2-20574		
	Scenario: Verify that the already associated "username" with leading and trailing space 
	as login id or username field is not allowed for super admin with all the permission.

		* karate.log('***Verify in case username is combination of letters and numbers****')   
	  * click(usernameLocator.newUsrnmButton)
	  * delay(3000) 
	  * karate.log('***click on loginId username****')  	
		* click(usernameLocator.loginIdUsrnm)
	 	* delay(1000) 
		* input(usernameLocator.loginIdUsrnm," test123Q ")  
	 	* delay(1000)  
	  * karate.log('***click on transfer access checkbox****')   
		* mouse().move(usernameLocator.transferAccessChkbox).click()
	  * delay(3000)
	  * karate.log('***click on requir change password as No***')   	  
		* mouse().move(usernameLocator.requirePassChangeNo).click()
	  * delay(3000)
		* karate.log('***Click and give input to search loginId field ****')   
		* click(usernameLocator.searchLoginId)
	  * delay(1000)
	  * input(usernameLocator.searchLoginId,'test1@fnp.com')	
    * delay(1000)		 
    * def optionOnDropDown = locateAll(usernameLocator.searchLoginIdDropdwn)
    * delay(1000)
    * optionOnDropDown[0].click()
    * delay(1000) 
    * click(usernameLocator.passTxtboxField)
    * delay(3000)
    * clear(usernameLocator.passTxtboxField)
    * delay(3000)
	  * input(usernameLocator.passTxtboxField,"Password@123")  
	 	* delay(1000)    
	  * click(usernameLocator.confirmPassTxtboxField)
	  * delay(3000)
	  * clear(usernameLocator.confirmPassTxtboxField)
	  * delay(3000)
	  * input(usernameLocator.confirmPassTxtboxField,"Password@123")  
	 	* delay(1000)       
	  * click(usernameLocator.createButton)
	  * karate.log('*** Verify that the already associated "username" with leading and trailing space ****')  
    * highlight(usernameLocator.alertPopup)	   
	  * match text(usernameLocator.alertPopup) == usernameConstant.alreadyRegistredUsrTxt
		* delay(10000)
	
	
	#REV2-20598/REV2-20599
	Scenario: Verify Create button functionality after putting a valid data for 
	super admin  with all the permission.
		
		* karate.log('***Verify in case username is phone number , create inactive user****')   
		* karate.log('***Click on new username button****')   
	  * click(usernameLocator.newUsrnmButton)
	  * delay(3000) 
	  * karate.log('***click on loginId username****')  	
		* click(usernameLocator.loginIdUsrnm)
	 	* delay(1000) 
		* input(usernameLocator.loginIdUsrnm,"7656789876")  
	 	* delay(3000)  
	 	* delay(1000)
	 	* mouse().move('#usernameCountryCode').click()			
		* delay(1000) 
	  * karate.log('******* Verify country field , list all country code *************')   
	  * def countryCodes = scriptAll("[role='tooltip']", '_.textContent')
	  * print 'countryCodes...',countryCodes
	  * delay(5000)
	 	* highlight(usernameLocator.statusToggleButton)
		* delay(5000) 	
		* click(usernameLocator.statusToggleButton)
	  * delay(3000) 
	  * karate.log('*******Create if inactive user is created *************')   
	 	* click(usernameLocator.createButton)
	  * match text(usernameLocator.alertPopup) == usernameConstant.newUsrnmCreated
	 	* delay(10000)  


	#REV2-20578/REV2-20587/REV2-20570/REV2-20581
	Scenario: Verify that the given 'Phone Number' as login Id or Username is associated with 
	any other account or not for super admin  with all the permission.
	
		* karate.log('***Create new username by phone number with is alredy registered user****')   
	  * click(usernameLocator.newUsrnmButton)
	  * delay(3000) 
	 	* click(usernameLocator.loginIdUsrnm)
	 	* delay(2000)
		* input(usernameLocator.loginIdUsrnm,"9893098931")  
	 	* delay(3000)  
	  * karate.log('***click on transfer access checkbox****')   
		* mouse().move(usernameLocator.transferAccessChkbox).click()
	  * delay(3000)
		* def searchLoginId = locateAll(usernameLocator.searchLoginId)
		* searchLoginId[1].click()
	  * delay(5000)
	  * input(usernameLocator.searchLoginId,'8645878312')	
    * delay(5000)		 
    * click(usernameLocator.searchLoginIdDropdwn)
    * delay(1000)
    * karate.log('**** Verify popup as alredy registered user if phone number is already registered***')       
	  * delay(5000)
	  * click(usernameLocator.createButton)
		* match text(usernameLocator.alertPopup) == usernameConstant.alreadyRegistredUsrTxt
	 	* delay(10000)  	
	  * karate.log('**** Verify label on fields when user created by phone number ***')    
    * def newUsrnmByPhoneNo = scriptAll(usernameLocator.verifyTitleField, '_.textContent')
    * print 'newUsrnmByPhoneNo...', newUsrnmByPhoneNo  
    * delay(1000)
    * match newUsrnmByPhoneNo[0] == usernameConstant.codeLabel
    * match newUsrnmByPhoneNo[1] == usernameConstant.loginIdLabel
    * match newUsrnmByPhoneNo[3] == usernameConstant.dateAndTimeLabel
    * match newUsrnmByPhoneNo[4] contains usernameConstant.transferAccessTxt
    * match newUsrnmByPhoneNo[5] == usernameConstant.codeLabel
    * match newUsrnmByPhoneNo[6] == usernameConstant.searchLoginIdLabel
    * delay(1000)
    * match text(usernameLocator.phoneNoStatusField) == usernameConstant.status
    * match text(usernameLocator.phoneNoAccessTransfer) == usernameConstant.accessTransferTxt 
    * karate.log('**** Verify label on create and cancel button ***')         
    * match text(usernameLocator.createButton) == usernameConstant.createButtonTxt
    * match text(usernameLocator.cancelPermissionName) == usernameConstant.cencelButtonTxt
    * delay(1000) 
		* delay(10000) 
		
 		
	#REV2-20582
	Scenario: Verify the error message that is displayed after clicking on create button if the phone number is not valid
	 for super admin / admin with all the permission.
	
		* karate.log('***Create new username by phone number with is alredy registered user****')   
	  * click(usernameLocator.newUsrnmButton)
	  * delay(3000) 
	 	* click(usernameLocator.loginIdUsrnm)
	 	* delay(2000)
		* input(usernameLocator.loginIdUsrnm,"9893")  
    * karate.log('**** Verify error message if phone number format is not valid**')       
	  * delay(5000)
	  * click(usernameLocator.createButton)
	  * highlight(usernameLocator.loginIdValidation)
		* match text(usernameLocator.loginIdValidation) == usernameConstant.invalidPhoneNoTxt
	 	* delay(10000)  	
	
	
	#REV2-20579
	Scenario: Verify that the given 'phone number' is not associated with any other account for
	 super admin / admin with all the permission.
	  * karate.log('***Create new username by phone number which is not is alredy registered user****')   
	  * click(usernameLocator.newUsrnmButton)
	  * delay(3000) 
	 	* click(usernameLocator.loginIdUsrnm)
	 	* delay(2000)
		* input(usernameLocator.loginIdUsrnm,"9893098332")  
	 	* delay(3000)  
	  * karate.log('***click on transfer access checkbox****')   
		* mouse().move(usernameLocator.transferAccessChkbox).click()
	  * delay(3000)
		* def searchLoginId = locateAll(usernameLocator.searchLoginId)
		* searchLoginId[1].click()
	  * delay(5000)
	  * input(usernameLocator.searchLoginId,'8645878312')	
    * delay(5000)		 
    * click(usernameLocator.searchLoginIdDropdwn)
    * delay(1000)
    * karate.log('**** Verify popup as alredy registered user if phone number is already registered***')       
	  * delay(5000)
	  * click(usernameLocator.createButton)
		* match text(usernameLocator.alertPopup) == usernameConstant.newUsrnmCreated
	 	* delay(10000)  
	
	
	#REV2-20592/REV2-20563
	Scenario: Verify date picker of "Disable date and time" in the format of 
	"DD-MM-YYYY H:M:S" for super adminwith all the permission.
	
		* karate.log('***Click on new username button****')   
	  * click(usernameLocator.newUsrnmButton)
	  * delay(3000) 
		* click(usernameLocator.dateFormatVerify)
		* delay(3000)
		* highlight('{^span}OK')
		* delay(3000)
		* click('{^span}OK')
		* click(usernameLocator.timeFormatVerify)
		* delay(3000)
		* highlight('{^span}5')	
    * delay(3000)			
		* mouse().move('{^span}5').click()
		* delay(3000)
		* click('{^span}OK')
		* delay(10000)
		
		
	#REV2-20597
	Scenario: Verify the system will show a error message after clicking on Create button
	 if the password and confirm password does not match for super admin  with all the permission.
	 
	 	* click(usernameLocator.newUsrnmButton)
	  * delay(3000) 
		* click(usernameLocator.loginIdUsrnm)
	 	* delay(1000) 
		* input(usernameLocator.loginIdUsrnm,"test123Q")  
	 	* delay(3000)  
	  * karate.log('***click on transfer access checkbox****')   
		* mouse().move(usernameLocator.transferAccessChkbox).click()
	  * delay(3000)
	  * karate.log('***click on requir change password as No***')   	  
		* mouse().move(usernameLocator.requirePassChangeNo).click()
	  * delay(3000)
	  * karate.log('***Click and give input to search loginId field ****')   
		* click(usernameLocator.searchLoginId)
	  * delay(1000)
	  * input(usernameLocator.searchLoginId,'test1@fnp.com')	
    * delay(1000)		 
    * def optionOnDropDown = locateAll(usernameLocator.searchLoginIdDropdwn)
    * delay(1000)
    * optionOnDropDown[0].click()
    * delay(1000) 
	  * click(usernameLocator.passTxtboxField)
	  * delay(3000)
	  * input(usernameLocator.passTxtboxField,"Password@123")  
	 	* delay(1000)    
	  * click(usernameLocator.confirmPassTxtboxField)
	  * delay(3000)
	  * input(usernameLocator.confirmPassTxtboxField,"Abc@123")  
	 	* delay(1000)       
	  * click(usernameLocator.createButton)
	  * karate.log('*** verify error if Password and Confirm password doesnt match" ****')  
    * highlight(usernameLocator.confirmPassValidation)	   
	  * match text(usernameLocator.confirmPassValidation) == "Password and Confirm password doesn't match"
		* delay(5000)
	
	
	#REV2-20580
  Scenario: Verify that the already associated  "phone number" with leading and trailing
   space as login id or username field is not allowed for super admin  with all the permission.
  
		* karate.log('***Create new username by phone number with leading and trailing spaces in phone no****')   
	  * click(usernameLocator.newUsrnmButton)
	  * delay(3000) 
	 	* click(usernameLocator.loginIdUsrnm)
	 	* delay(2000)
		* input(usernameLocator.loginIdUsrnm," 9893098931 ")  
	 	* delay(3000)  
	  * karate.log('***click on transfer access checkbox****')   
		* mouse().move(usernameLocator.transferAccessChkbox).click()
	  * delay(3000)
	  * karate.log('***click on requir change password as No***')   	  
		* mouse().move(usernameLocator.requirePassChangeNo).click()
	  * delay(3000)
		* def searchLoginId = locateAll(usernameLocator.searchLoginId)
		* searchLoginId[0].click()
	  * delay(5000)
	  * input(usernameLocator.searchLoginId,'8645878312')	
    * delay(5000)		 
    * click(usernameLocator.searchLoginIdDropdwn)
    * delay(3000)
	  * input(usernameLocator.passTxtboxField,"Password@123")  
	 	* delay(1000)    
	  * click(usernameLocator.confirmPassTxtboxField)
	  * delay(3000)
	  * input(usernameLocator.confirmPassTxtboxField,"Password@123")  
	 	* delay(1000)        
	  * delay(5000)
	  * click(usernameLocator.createButton)
		* match text(usernameLocator.alertPopup) == usernameConstant.alreadyRegistredUsrTxt
	 	* delay(10000) 
	 	
	 	
	#REV2-20569
	Scenario: Verify Login Id or Username field when we fill Username for super 
	admin  with all the permission.   
	
		* karate.log('**Verify and create username by combination of letters and numbers****')   
		* click(usernameLocator.newUsrnmButton)
	  * delay(3000) 
	  * click(usernameLocator.loginIdUsrnm)
	 	* delay(1000) 
		* input(usernameLocator.loginIdUsrnm,"test^")  
	 	* delay(1000)       
	  * click(usernameLocator.createButton)
	  * delay(3000)
		* karate.log('***Check validation message is username containing special characters****')   
	  * highlight(usernameLocator.loginIdValidation)	   
	  * match text("#username-helper-text") == usernameConstant.usrnmNotValid
		* delay(5000) 	
		* click(usernameLocator.loginIdUsrnm)
	 	* delay(1000) 
	 	* clear(usernameLocator.loginIdUsrnm)
	 	* delay(1000) 
		* input(usernameLocator.loginIdUsrnm,"test123455")  
	 	* delay(3000)  
	  * karate.log('***click on transfer access checkbox****')   
		* mouse().move(usernameLocator.transferAccessChkbox).click()
	  * delay(3000)
	  * karate.log('***click on requir change password as No***')   	  
		* mouse().move(usernameLocator.requirePassChangeNo).click()
	  * delay(3000)
	  * karate.log('***Click and give input to search loginId field ****')   
		* click(usernameLocator.searchLoginId)
	  * delay(1000)
	  * input(usernameLocator.searchLoginId,'test1234Q')	
    * delay(1000)		 
    * def optionOnDropDown = locateAll(usernameLocator.searchLoginIdDropdwn)
    * delay(1000)
    * optionOnDropDown[0].click()
    * delay(1000) 
	  * click(usernameLocator.passTxtboxField)
	  * delay(3000)
	  * input(usernameLocator.passTxtboxField,"Password@123")  
	 	* delay(1000)    
	  * click(usernameLocator.confirmPassTxtboxField)
	  * delay(3000)
	  * input(usernameLocator.confirmPassTxtboxField,"Password@123")  
	 	* delay(1000)       
	  * click(usernameLocator.createButton)
	  * karate.log('*** Verify new username is created" ****')  
    * highlight(usernameLocator.alertPopup)	   
	  * match text(usernameLocator.alertPopup) == "New Username Created"
		* delay(5000)