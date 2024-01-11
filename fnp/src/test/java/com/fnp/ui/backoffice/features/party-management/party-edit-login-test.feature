Feature:  Party edit login UI scenarios

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
    And click(usernameLocator.pawri)
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
    
    * input(usernameLocator.typePartyId,usernameConstant.lablePartyIdText)
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
	  
	  
	#REV2-20322
	Scenario: Verify the functionality of three dots options i.e.  "Edit", "Assign Security Group", 
	"Permissions" for super admin / admin with all the permission.
	  
		* karate.log('***Verify label on userLoginIdLable column****')   
		* match text(usernameLocator.userLoginIdLable) == usernameConstant.userLoginIdLabelTxt  
		* karate.log('***List all userLoginId on column ****')   
    * def userLoginIdList = scriptAll(usernameLocator.userLoginIdList, '_.textContent')
    * print 'userLoginIdList--', userLoginIdList
	  * delay(2000)  				
		* karate.log("***List status of all userLoginId's active or inactive ****")   
    * def statusList = scriptAll(usernameLocator.statusList, '_.textContent')
    * print 'statusList--', statusList
	  * delay(2000)	
 	  * karate.log("***Click on permissions option from dropdown ****")    		
	  * mouse().move(usernameLocator.usrnmThreeDotLast).click()
	  * delay(1000)  
	  * def userloginIdOpt = scriptAll(usernameLocator.usrnmDropdwnlast, '_.textContent')
    * print 'userloginIdOpt...', userloginIdOpt   
    * delay(3000)
    * karate.log('**** verify edit, assign security group ,permissions options is visible and clickable***')    	 	
		* print locate(usernameLocator.usernmDropdwnFirstOpt).script("_.is(':visible')")   	
	  * delay(1000)  
	  * print locate(usernameLocator.usernmDropdwnSecondOpt).script("_.is(':visible')")   	
	  * delay(1000)
	  * print locate(usernameLocator.usernmDropdwnLastOpt).script("_.is(':visible')")   	
	  * delay(1000)  
	#check wheather edit option is clickable   
	  * click(usernameLocator.usernmDropdwnFirstOpt)
	  * delay(3000)	 
	  * click(usernameLocator.cancelPermissionName)
	  * delay(5000)	 
	#check wheather assign security group option is clickable 
	    * mouse().move(usernameLocator.usernameThreeDots).click()
	    * delay(1000)
	    * click(usernameLocator.usernmDropdwnSecondOpt)
	    * delay(5000)	 
	    
	
	#REV2-20323/REV2-20324/REV2-20325/REV2-20326/REV2-20327/REV2-20328
	Scenario:	 Verify the content present in "Edit Login" page for super admin / admin with all the permission.   

    * mouse().move(usernameLocator.usernmThreeDotFirst).click()
	  * delay(1000)   
	  * def option = locateAll("[role='menu'] a[title='Edit']")
    * option[0].click()
    * delay(2000)
	  * delay(3000)	  
	  * waitForUrl('https://zeus-test-r2.fnp.com/#/simsim/v1/logins/')
	  * delay(1000)  
	  * match text('#main-content div h5') == '0213888888888888'
	  * delay(3000)	
	  * match usernameLocator.successiveFailedAttempt == '#present'
	  * match usernameLocator.loginIdLabel == '#present'  
	  * karate.log('***verify all fields label in edit UserLoginId****')   			
    * def editUserLoginId = scriptAll(usernameLocator.verifyTitleField, '_.textContent')
    * print 'editUserLoginId...', editUserLoginId  
    * delay(1000)
    * match editUserLoginId[0] == 'Login ID'
    * match editUserLoginId[2] == usernameConstant.dateAndTimeLabel
    * match editUserLoginId[3] == usernameConstant.successiveFailedLoginsTxt
	  * delay(3000)
		* karate.log('***Verify status field should be editable****')   
	  * click('#active')
		* delay(3000) 	
	  * click(usernameLocator.dateFormatVerify)
	  * delay(3000)	
	  * click('{span/p}20')
	  * delay(3000)	
		* highlight('{^span}OK')
		* delay(3000)
		* click('{^span}OK')
	  * delay(3000)
	  * click(usernameLocator.update)
	  * delay(5000)
	  * karate.log('***List all userLoginId on column ****')   
    * def userLoginIdList = scriptAll(usernameLocator.userLoginIdList, '_.textContent')
    * print 'userLoginIdList--', userLoginIdList
	  * delay(2000)  				
		* karate.log("***List status of  userLoginId's as inactive ****")   
    * def statusList = scriptAll(usernameLocator.statusList, '_.textContent')
    * print 'statusList--', statusList
	  * delay(2000)	
	  
	
	#REV2-20332
	Scenario:  Verify the functionality of update button entering data in all the mandatory fields for super
	 admin / admin with all the permission.
	  
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
    * delay(1000)   
    * click(usernameLocator.usernmDropdwnFirstOpt)
	  * delay(3000)	 
	  * click(usernameLocator.dateFormatVerify)
	  * delay(3000)	
	  * click('{span/p}24')
	  * delay(3000)	
		* highlight('{^span}OK')
		* delay(3000)
		* click('{^span}OK')
	  * delay(3000)
	  * click(usernameLocator.update)
	  * match text("[role='alert'] div") == 'Username Data Updated'
	  * delay(5000)
	  
 
	#REV2-20334
	Scenario: Verify the functionality of cancel button with entering data into field for super 
	admin / admin with all the permission.
 
 		* mouse().move(usernameLocator.usernmThreeDotFirst).click()
	  * delay(1000)   
	  * def option = locateAll("[role='menu'] a[title='Edit']")
    * option[0].click()
    * delay(2000)  
    * click(usernameLocator.dateFormatVerify)
	  * delay(3000)	
	  * click('{span/p}24')
	  * delay(3000)	
		* highlight('{^span}OK')
		* delay(3000)
		* click('{^span}OK')
	  * delay(3000)
	  * mouse().move("[aria-label='Cancel']").click()
	  * delay(2000)    
	  * waitForUrl("/show/usernames")
	  * delay(5000)   
	  
	#REV2-20335
	Scenario:	 Verify functionality of "Cancel" button  without entering data for super
	 admin / admin with all the permission.  
	  
		* mouse().move(usernameLocator.usernmThreeDotFirst).click()
	  * delay(1000)   
	  * def option = locateAll("[role='menu'] a[title='Edit']")
    * option[0].click()
    * delay(2000)  
	  * mouse().move("[aria-label='Cancel']").click()
	  * delay(5000)   
	    