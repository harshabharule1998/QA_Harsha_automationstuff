Feature: Update and Delete Party user roles UI scenarios for Super Admin

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
		

	#REV2-19622
	Scenario: Verify the Label and breadcrumb for party roles delete page with super admin access
	  
	  * click(rolesLocator.rolesTab)
    * delay(1000)
    * click(rolesLocator.editButton)
    * delay(1000)
    * match driver.url contains rolesConstant.partyEditNavigationUrl
    * def buttons = locateAll(rolesLocator.editPageButtons)
    * delay(1000)
    * assert karate.sizeOf(buttons) > 1
    * delay(1000)
    * def editPageButtonLabels = scriptAll(rolesLocator.editPageButtonLabels, '_.textContent')
    * delay(1000)
    * match editPageButtonLabels contains 'Cancel'
    * match editPageButtonLabels contains 'Update'
    * delay(3000)


	#REV2-19623, REV2-19626, REV2-19627 and REV2-19628
	Scenario: Verify edit and delete other roles functionality for super admin
	  
	  * click(rolesLocator.rolesTab)
    * delay(1000)
    * click(rolesLocator.editButton)
    * delay(1000)
		* def editPageButtons = locateAll(rolesLocator.editPageButtons)
    * delay(1000)
    * editPageButtons[0].click()
    * delay(1000)
    * mouse().move(rolesLocator.otherRolesInput).click()
    * delay(1000)
    * click(rolesLocator.otherRolesOption)
    * delay(1000)
    * click(rolesLocator.addRoleButton)
    * delay(1000)
    * def otherRoleLabels = scriptAll(rolesLocator.otherRoleLabels, '_.textContent')
    * delay(1000)
    * match otherRoleLabels contains 'Sample'
    * delay(1000)
    * editPageButtons[2].click()
    * delay(1000)
    * waitForText('body', 'Roles updated')
    * delay(1000)
    * click(rolesLocator.editButton)
    * delay(1000)
    * mouse().move(rolesLocator.deleteRoleIcons).click()
    * delay(1000)
    * waitForText('body', 'Role has been deleted')
    * delay(3000)
	
	
	#REV2-19625
	Scenario: Verify edit primary role functionality for super admin
	  
	  * click(rolesLocator.rolesTab)
    * delay(1000)
    * click(rolesLocator.editButton)
    * delay(1000)
    * mouse().move(rolesLocator.primaryRolesInput).click()
    * delay(1000)
    * click(rolesLocator.primaryRolesOption)
    * delay(1000)
    * def editPageButtons = locateAll(rolesLocator.editPageButtons)
    * delay(1000)
    * editPageButtons[2].click()
    * delay(1000)
    * waitForText('body', 'Roles updated')
    
    * click(rolesLocator.editButton)
    * delay(1000)
    * mouse().move(rolesLocator.primaryRolesInput).click()
    * delay(1000)
    * click(rolesLocator.primaryRolesOption)
    * delay(1000)
    * def editPageButtons = locateAll(rolesLocator.editPageButtons)
    * delay(1000)
    * editPageButtons[2].click()
    * delay(1000)
    * waitForText('body', 'Roles updated')
    * delay(3000) 
    
  
	#REV2-19629, REV2-19630 and REV2-19631
	Scenario: Verify roles dashboard for super admin
	  
	  * click(rolesLocator.rolesTab)
    * delay(1000)
    * def rolesTypeLabelList = scriptAll(rolesLocator.rolesTypeLabelList, '_.textContent')
    * delay(1000)
    * match rolesTypeLabelList contains 'Primary Role'
    * match rolesTypeLabelList contains 'Other Roles'
    
    * def rolesList = scriptAll(rolesLocator.rolesList, '_.textContent')
    * delay(1000)
    * match rolesList[0] contains 'Employee'
    * match rolesList[1] contains 'tester'
    
    * click(rolesLocator.editButton)
    * delay(1000)
    * def editPageButtonLabels = scriptAll(rolesLocator.editPageButtonLabels, '_.textContent')
    * delay(1000)
    * match editPageButtonLabels contains 'Cancel'
    * match editPageButtonLabels contains 'Update'
    * delay(3000)
      
 
	#REV2-19634
	Scenario: Verify cancel button functionality on user roles edit page for super admin
	  
	  * click(rolesLocator.rolesTab)
    * delay(1000)
    * click(rolesLocator.editButton)
    * delay(1000)
    * mouse().move(rolesLocator.primaryRolesInput).click()
    * delay(1000)
    * click(rolesLocator.primaryRolesOption)
    * delay(1000)
    * def editPageButtons = locateAll(rolesLocator.editPageButtons)
    * delay(1000)
    
    # click cancel button
    * editPageButtons[1].click()
    * delay(1000)
    * def buttons = locateAll(rolesLocator.editButton)
    * delay(100)
    * assert karate.sizeOf(buttons) > 0
    * delay(3000)  
	