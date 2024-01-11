Feature: Assign permissions Name to the Login id of the respective Party or user

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

    * delay(1000)
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
    
    * input(usernameLocator.typePartyId,usernameConstant.lablePartyIdText)
    * delay(1000)
    * click(usernameLocator.clickOnApply)
    * delay(1000)
    * click(usernameLocator.clickOnPartyId)
    * delay(1000)
		* karate.log('***Personal information tab will get open by default****')   
    * match text(usernameLocator.personalInfoColLoadByDefault) == usernameConstant.personalInfoTabText
    * delay(1000)
    
 	
	#REV2-20419/REV2-20420/REV2-20421
  Scenario: Verify that the system allow the user to search and select the Permission Name 
 		for back office user with superadmin permission. 
 
 		* karate.log('***Verify label on username tab****') 
 		* match text(usernameLocator.usernamesLabel) == usernameConstant.usernamesTabText  				
 		* delay(1000) 
 	  * click(usernameLocator.usernamesLabel)
	  * delay(3000)
		* scroll(usernameLocator.paginationOnList)
    * delay(1000)
    * mouse().move(usernameLocator.paginationDropdownTxt).click()
    * delay(1000) 
    * def paginationDropDownOption = scriptAll(usernameLocator.paginationDropDownOption, '_.textContent')
	  * print 'paginationDropDownOption...',paginationDropDownOption  
	  * delay(1000)   
    * def optionOnPagin = locateAll(usernameLocator.paginationDropDownOption)
    * delay(1000)
    * optionOnPagin[3].click()
    * delay(2000)
    * mouse().move(usernameLocator.usrnmThreeDotLast).click()
	  * delay(2000)  
	  * def dropdownTxt = scriptAll(usernameLocator.usrnmDropdwnlast, '_.textContent')
    * print 'Dropdown...', dropdownTxt   
	  * click(usernameLocator.usrnmDropdwnlastOption)
	  * delay(3000)	 
	  * delay(1000)  
	  * highlight('{^span}ASSIGN')
	  * delay(3000)  
	  * match text(usernameLocator.assignUserLogin) == usernameConstant.assignUserLogin
    * delay(3000)
		* click(usernameLocator.assignUserLogin)
		* delay(2000)  
	  * waitForUrl("/create")
	  * delay(1000)
 		* match text(usernameLocator.permissionsNameLabel) == usernameConstant.permissionsNameLabelTxt
	  * delay(1000)
 		* click(usernameLocator.permissionNameTxtbox)
 		* delay(5000) 
  	* karate.log('**Search for the permission in dropdown****') 	
 		* input(usernameLocator.permissionNameTxtbox, ['P_FEED_A', Key.DOWN, Key.ENTER])	 
	  * delay(5000)
	  * karate.log('***List all permission names****') 
	  * def permissionNames = scriptAll("[role='listbox'] li", '_.textContent')
	  * print 'permissionNames...',permissionNames 
 		* delay(4000)
 		* clear(usernameLocator.permissionNameTxtbox)   
 		* delay(1000) 
 		* karate.log('***Select multiple permission****') 
	  * input(usernameLocator.permissionNameTxtbox, ['P_CAT_ASS', Key.DOWN, Key.ENTER])	
	  * delay(1000)
	  * input(usernameLocator.permissionNameTxtbox, ['P_CAT_ATT', Key.DOWN, Key.ENTER])
	  * delay(1000) 	
	  * input(usernameLocator.permissionNameTxtbox, ['P_PAR_REL_C', Key.DOWN, Key.ENTER])		  
	  * delay(10000)
	  
	
	#REV2-20422/REV2-20423/REV2-20428	  
  Scenario: Verify the visibility of cross icon for back office user with superadmin permission.
 
 		* karate.log('***Verify label on username tab****') 
 		* match text(usernameLocator.usernamesLabel) == usernameConstant.usernamesTabText  				
 		* delay(1000) 
 	  * click(usernameLocator.usernamesLabel)
	  * delay(2000)
   	* scroll(usernameLocator.paginationOnList)
    * delay(1000)
    * mouse().move(usernameLocator.paginationDropdownTxt).click()
    * delay(1000) 
    * def optionOnPagin = locateAll(usernameLocator.paginationDropDownOption)
    * delay(1000)
    * optionOnPagin[3].click()
    * delay(2000)
    * mouse().move(usernameLocator.usrnmThreeDotLast).click()
	  * delay(1000)  
	  * def dropdownTxt = scriptAll(usernameLocator.usrnmDropdwnlast, '_.textContent')
    * print 'Dropdown...', dropdownTxt   
	  * click(usernameLocator.usrnmDropdwnlastOption)
	  * delay(1000)  
	  * delay(3000)		 
		* click(usernameLocator.assignUserLogin)
		* delay(3000)    
    * click(usernameLocator.permissionNameTxtbox)
 		* delay(5000)  		
  	* def permissionNames = scriptAll(usernameLocator.permissionNameTxtbox, '_.textContent')
	  * print 'permissionNames...',permissionNames 
 		* delay(4000) 
  	* karate.log('***Select multiple permission names as input****') 
 	  * input(usernameLocator.permissionNameTxtbox, ['P_CAT_ASS', Key.DOWN, Key.ENTER])	
 	  * delay(1000) 
 	  * input(usernameLocator.permissionNameTxtbox, ['P_CAT_ATT', Key.DOWN, Key.ENTER])
	  * delay(1000) 	
	  * input(usernameLocator.permissionNameTxtbox, ['P_PAR_REL_C', Key.DOWN, Key.ENTER])	
	  * delay(3000)
	 	* karate.log('***Verify visibility of close icon and check if it is exist****') 
	  * def closeIconExists = exists(usernameLocator.closeIcon)
    * if (closeIconExists) karate.log("closeIconExists is present")  
	  * match usernameLocator.closeIcon == "#present" 
 	  * delay(1000)  
 	 	* karate.log('***Click on close icon for multiple permission names****')  
	  * mouse().move(usernameLocator.closeIcon).click()
	  * delay(1000)  
	  * mouse().move(usernameLocator.closeIcon).click()
	  * delay(1000)  
	  * mouse().move(usernameLocator.closeIcon).click()
	  * delay(20000)    
	  
	  
	#REV2-20424
  Scenario: Verify the functionality of "Assign" button  without entering the data in mandatory fields
   for back office user with superadmin permission.
  
  	* karate.log('***Verify label on username tab****') 
 		* match text(usernameLocator.usernamesLabel) == usernameConstant.usernamesTabText  				
 		* delay(1000) 
 	  * click(usernameLocator.usernamesLabel)
	  * delay(2000)
   	* scroll(usernameLocator.paginationOnList)
    * delay(1000)
    * mouse().move(usernameLocator.paginationDropdownTxt).click()
    * delay(1000) 
    * def optionOnPagin = locateAll(usernameLocator.paginationDropDownOption)
    * delay(1000)
    * optionOnPagin[3].click()
    * delay(2000)
    * mouse().move(usernameLocator.usrnmThreeDotLast).click()
	  * delay(1000)  
	  * def dropdownTxt = scriptAll(usernameLocator.usrnmDropdwnlast, '_.textContent')
    * print 'Dropdown...', dropdownTxt   
	  * click(usernameLocator.usrnmDropdwnlastOption)
	  * delay(3000)		    
	  * karate.log('***Click on assign user login button****')  
		* click(usernameLocator.assignUserLogin)
		* delay(2000)    			
 		* click(usernameLocator.assignPermissionButton)
 		* delay(2000)    	
	  * karate.log('***Check for validation msg if permission name is empty****')  					
 	  * match text(usernameLocator.permissionNameValidationMsg) == usernameConstant.permissionNameValidationTxt  				
 		* delay(20000)    			
 	
 	  
	#REV2-20425
	Scenario: Verify the "Assign" button functionality with entering the valid data into field for 
		back office users with superadmin permission.
 
  	* karate.log('***Verify label on username tab****') 
 		* match text(usernameLocator.usernamesLabel) == usernameConstant.usernamesTabText  				
 		* delay(1000) 
 	  * click(usernameLocator.usernamesLabel)
	  * delay(2000)
	 	* scroll(usernameLocator.paginationOnList)
    * delay(1000)
    * mouse().move(usernameLocator.paginationDropdownTxt).click()
    * delay(1000) 
    * def optionOnPagin = locateAll(usernameLocator.paginationDropDownOption)
    * delay(1000)
    * optionOnPagin[3].click()
    * delay(2000)
    * mouse().move(usernameLocator.usrnmThreeDotLast).click()
	  * delay(1000)  
	  * def dropdownTxt = scriptAll(usernameLocator.usrnmDropdwnlast, '_.textContent')
    * print 'Dropdown...', dropdownTxt   
	  * click(usernameLocator.usrnmDropdwnlastOption)
	  * delay(3000)		   
		* click(usernameLocator.assignUserLogin)
		* delay(2000)    	
		* input(usernameLocator.permissionNameTxtbox, ['P_COU_E', Key.DOWN, Key.ENTER])	
	  * delay(5000)		
 		* click(usernameLocator.assignPermissionButton)
 		* delay(2000)		
	  * karate.log('***Verify alert msg after select permission name and click on assign button****')  	
 		* match text(usernameLocator.permissionNameAssignAlertMsg) == usernameConstant.permissionNameAssignAlertMsgTxt  				
 		* delay(5000)		
 	  * waitForUrl('/permissions')
    * delay(10000)
   
  
	#REV2-20426
  Scenario: Verify "CANCEL" button functionality after entering valid data for back office user with superadmin permission. 
 		
 		* karate.log('***Verify label on username tab****') 
 		* match text(usernameLocator.usernamesLabel) == usernameConstant.usernamesTabText  				
 		* delay(1000) 
 	  * click(usernameLocator.usernamesLabel)
	  * delay(2000)
  	* scroll(usernameLocator.paginationOnList)
    * delay(1000)
    * mouse().move(usernameLocator.paginationDropdownTxt).click()
    * delay(1000) 
    * def optionOnPagin = locateAll(usernameLocator.paginationDropDownOption)
    * delay(1000)
    * optionOnPagin[3].click()
    * delay(2000)
    * mouse().move(usernameLocator.usrnmThreeDotLast).click()
	  * delay(1000)  
	  * def dropdownTxt = scriptAll(usernameLocator.usrnmDropdwnlast, '_.textContent')
    * print 'Dropdown...', dropdownTxt   
	  * click(usernameLocator.usrnmDropdwnlastOption)
	  * delay(3000)	 
		* click(usernameLocator.assignUserLogin)
		* delay(2000)    	
		* input(usernameLocator.permissionNameTxtbox, ['P_COU_E', Key.DOWN, Key.ENTER])	
	  * delay(3000)	
	  * click(usernameLocator.cancelPermissionName)
	  * delay(2000)		
	  * karate.log('***Verify navigation link after click on cancel button with etering valid data****')  
 	  * waitForUrl('https://zeus-test-r2.fnp.com/#/simsim/v1/logins/')
    * delay(5000)


 #REV2-20427
 Scenario: Verify functionality of "Cancel" button without entering data for back office user with superadmin permission.
 	
    * karate.log('***Verify label on username tab****') 
 		* match text(usernameLocator.usernamesLabel) == usernameConstant.usernamesTabText  				
 		* delay(1000) 
 	  * click(usernameLocator.usernamesLabel)
	  * delay(2000)
	  * scroll(usernameLocator.paginationOnList)
    * delay(1000)
    * mouse().move(usernameLocator.paginationDropdownTxt).click()
    * delay(1000) 
    * def optionOnPagin = locateAll(usernameLocator.paginationDropDownOption)
    * delay(1000)
    * optionOnPagin[3].click()
    * delay(2000)
    * mouse().move(usernameLocator.usrnmThreeDotLast).click()
	  * delay(1000)  
	  * def dropdownTxt = scriptAll(usernameLocator.usrnmDropdwnlast, '_.textContent')
    * print 'Dropdown...', dropdownTxt   
	  * click(usernameLocator.usrnmDropdwnlastOption)
	  * delay(3000)		
	  * karate.log('***Click on assign user login button****')  
		* click(usernameLocator.assignUserLogin)
		* delay(2000)    		  
		* karate.log('***Click on cancel  button****')  
	  * click(usernameLocator.cancelPermissionName)
	  * delay(2000)		
	  * karate.log('***Verify navigation link after click on cancel button without etering  data****')   
 	  * waitForUrl('https://zeus-test-r2.fnp.com/#/simsim/v1/logins/')
    * delay(5000)
 

 Scenario: Verify the content present in "Assign User Login" page for back office user with superadmin permission.
 
 	  * karate.log('***Verify label on username tab****') 
 		* match text(usernameLocator.usernamesLabel) == usernameConstant.usernamesTabText  				
 		* delay(1000) 
 	  * click(usernameLocator.usernamesLabel)
	  * delay(2000)
   	* scroll(usernameLocator.paginationOnList)
    * delay(1000)
    * mouse().move(usernameLocator.paginationDropdownTxt).click()
    * delay(1000) 
    * def optionOnPagin = locateAll(usernameLocator.paginationDropDownOption)
    * delay(1000)
    * optionOnPagin[3].click()
    * delay(2000)
    * mouse().move(usernameLocator.usrnmThreeDotLast).click()
	  * delay(1000)  
	  * def dropdownTxt = scriptAll(usernameLocator.usrnmDropdwnlast, '_.textContent')
    * print 'Dropdown...', dropdownTxt   
	  * click(usernameLocator.usrnmDropdwnlastOption)	  
	  * delay(3000)  
		* click(usernameLocator.assignUserLogin)
		* delay(2000)    	
	  * karate.log('***Verify cancel and assign button is exist ****')  
		* def cancelButtonExists = exists(usernameLocator.cancelButton)
    * if (cancelButtonExists) karate.log("cancel button is present") 
    * def assignButtonExists = exists(usernameLocator.assignPermissionButton)
    * if (assignButtonExists) karate.log("assign button is present") 
 		* delay(5000)    	
 		
 	