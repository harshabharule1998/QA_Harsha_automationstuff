Feature: Search Party UI scenarios for Super Admin

  Background: 
    * def loginLocator = read('../../data/loginPage_locator.json')
    * def usersValue = read('../../data/users.json')
    * def dashBoardLocator = read('../../data/dashboard_locators.json')
    * def searchLocator = read('../../data/party/searchPage_locators.json')
    * def searchConstant = read('../../data/party/searchPage_constants.json')
    
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
		* mouse().move(searchLocator.partyTypeDropdownTxt).click()

    * delay(2000)
    * def dropdownTxt = scriptAll(searchLocator.partyTypeDropdownMenu, '_.textContent')
    * print 'Dropdown', dropdownTxt
    * delay(2000)
    * match dropdownTxt[0] contains 'Individual'
    * match dropdownTxt[1] contains 'Organization'
    * delay(1000)
    
    * def optionOnDropDown = locateAll(searchLocator.partyTypeDropdownMenu)
    * delay(1000)
    * match karate.sizeOf(optionOnDropDown) == 2
    * optionOnDropDown[0].click()
    * delay(1000) 
    
    
	#REV2-19638
	Scenario: Verify the Label and Navigation Link for search party form with super admin access
	  
	  * delay(1000)
	  * match driver.url contains searchConstant.partySearchNavigationUrl
	  * delay(1000)
	  * input(searchLocator.typePartyId,searchConstant.lablePartyIdText)
    * delay(1000)
    * click(searchLocator.clickOnApply)
    * delay(1000)
    * click(searchLocator.clickOnPartyId)
    * delay(1000)
    * match text(searchLocator.lableOfPartyId) == searchConstant.lablePartyIdText
    * delay(3000)

  
	#REV2-19639
	Scenario: Verify fields present in search party form with super admin access
	  
	  * delay(1000)
	  * def searchPageInputs = locateAll(searchLocator.searchPageInputs)
    * delay(1000)
    * assert karate.sizeOf(searchPageInputs) > 5
    * delay(3000)
    
  
	#REV2-19640
	Scenario: Verify party type dropdown present in search party form with super admin access
	  
	  * delay(1000)
	  * def partyTypeInput = locateAll(searchLocator.partyTypeInput)
    * delay(1000)
    * assert karate.sizeOf(partyTypeInput) > 0
    * delay(3000)
    
	  
	#REV2-19641, REV2-19642, REV2-19643, REV2-19644 and REV2-19645
	Scenario: Verify partyId, partyName, loginId, contactEmailId and contactPhoneNumber fields are present in search party form
	  
	  * delay(1000)
	  * def partyIdInput = locateAll(searchLocator.partyIdInput)
	  * def partyNameInput = locateAll(searchLocator.partyNameInput)
	  * def loginIdInput = locateAll(searchLocator.loginIdInput)
	  * def contactEmailIdInput = locateAll(searchLocator.contactEmailIdInput)
	  * def contactMobileNumberInput = locateAll(searchLocator.contactMobileNumberInput)
    * delay(1000)
    * assert karate.sizeOf(partyIdInput) > 0
    * assert karate.sizeOf(partyNameInput) > 0
    * assert karate.sizeOf(loginIdInput) > 0
    * assert karate.sizeOf(contactEmailIdInput) > 0
    * assert karate.sizeOf(contactMobileNumberInput) > 0
    * delay(2000)
	

	#REV2-19646 and REV2-19647
	Scenario: Verify error message if user selects only Party Type field and submit search party form with super admin access
	  
	  * delay(1000)
    * click(searchLocator.clickOnApply)
    * delay(1000)
    * waitForText('body', 'Enter at least one parameter to search')
    * delay(2000)
    

	#REV2-19648
	Scenario: Verify CANCEL button functionality on search party form with super admin access
	  
	  * delay(1000)
    * click(searchLocator.cancelButton)
    * delay(1000)
    * def partyTypeInput = locateAll(searchLocator.partyTypeInput)
    * def partyIdInput = locateAll(searchLocator.partyIdInput)
    * delay(1000)
    * assert karate.sizeOf(partyTypeInput) > 0
    * assert karate.sizeOf(partyIdInput) == 0
    * delay(2000)
    

	#REV2-19649 and REV2-19650
	Scenario: Verify APPLY button functionality on search party form with super admin access
	  
	  * delay(1000)
	  * input(searchLocator.typePartyId,searchConstant.lablePartyIdText)
    * delay(1000)
    * click(searchLocator.clickOnApply)
    * delay(1000)
    * click(searchLocator.clickOnPartyId)
    * delay(1000)
    * match text(searchLocator.lableOfPartyId) == searchConstant.lablePartyIdText
    * delay(2000)
    

	#REV2-19651
	Scenario: Verify party not found error message when search with super admin access
	  
	  * delay(1000)
	  * input(searchLocator.typePartyId, "123")
    * delay(1000)
    * click(searchLocator.clickOnApply)
    * delay(1000)
    * waitForText('body', 'No Result was found for the -    Party Id : 123 , Party Type : Individual  ')
    * delay(2000)
