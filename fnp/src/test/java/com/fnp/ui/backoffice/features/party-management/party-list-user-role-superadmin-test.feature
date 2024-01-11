Feature: List Party user roles UI scenarios for Super Admin

  Background: 
    * def loginLocator = read('../../data/loginPage_locator.json')
    * def usersValue = read('../../data/users.json')
    * def dashBoardLocator = read('../../data/dashboard_locators.json')
    * def rolesLocator = read('../../data/party/rolesPage_locators.json')
    * def rolesConstant = read('../../data/party/rolesPage_constants.json')
    
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
		* mouse().move(rolesLocator.partyTypeDropdownTxt).click()

    * delay(2000)
    * def dropdownTxt = scriptAll(rolesLocator.partyTypeDropdownMenu, '_.textContent')
    * print 'Dropdown', dropdownTxt
    * delay(2000)
    * match dropdownTxt[0] contains 'Individual'
    * match dropdownTxt[1] contains 'Organization'
    * delay(1000)
    
    * def optionOnDropDown = locateAll(rolesLocator.partyTypeDropdownMenu)
    * delay(1000)
    * match karate.sizeOf(optionOnDropDown) == 2
    * optionOnDropDown[0].click()
    * delay(1000) 
    
    * input(rolesLocator.typePartyId,rolesConstant.lablePartyIdText)
    * delay(1000)
    * click(rolesLocator.clickOnApply)
    * delay(1000)
    * click(rolesLocator.clickOnPartyId)
    * delay(1000)
		
  
	#REV2-22131
	Scenario: Verify the Label and breadcrumb for party roles list with super admin access
	  
	  * click(rolesLocator.rolesTab)
    * delay(1000)
    * match text(rolesLocator.lableOfPartyId) == rolesConstant.lablePartyIdText
    * delay(1000)
    * match driver.url contains rolesConstant.partyListNavigationUrl
    * delay(3000)

 
	#REV2-22132
	Scenario: Verify roles tab present for super admin
	  
	  * click(rolesLocator.rolesTab)
    * delay(1000)
    * match text(rolesLocator.rolesTabLabel) == rolesConstant.rolesTabText
    * delay(3000)
	
  
	#REV2-22133
	Scenario: Verify list of user roles displayed for super admin
	  
	  * click(rolesLocator.rolesTab)
    * delay(1000)
    * def rolesTypeLabelList = scriptAll(rolesLocator.rolesTypeLabelList, '_.textContent')
    * delay(1000)
    * match rolesTypeLabelList contains 'Primary Role'
    * match rolesTypeLabelList contains 'Other Roles'
    * delay(3000)
    
	  
	#REV2-22134
	Scenario: Verify primary and other roles displayed for super admin
	  
	  * click(rolesLocator.rolesTab)
    * delay(1000)
    * def rolesList = scriptAll(rolesLocator.rolesList, '_.textContent')
    * delay(1000)
    * match rolesList contains 'Employee'
    * match rolesList contains 'tester'
    * delay(3000)
    
  
	#REV2-22135
	Scenario: Verify edit button present on the user roles listing page for super admin
	  
	  * click(rolesLocator.rolesTab)
    * delay(1000)
    * def buttons = locateAll(rolesLocator.editButton)
    * delay(100)
    * assert karate.sizeOf(buttons) > 0
    * delay(3000)  
	