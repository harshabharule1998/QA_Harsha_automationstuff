Feature: UI scenarios for List Contact Information with Grid functionality for view only user

  Background: 
    * def loginLocator = read('../../data/loginPage_locator.json')
    * def usersValue = read('../../data/users.json')
    * def dashBoardLocator = read('../../data//dashboard_locators.json')
    * def contactLocator = read('../../data/party/contactPage_locators.json')
    * def contactConstant = read('../../data/party/contactPage_constants.json')
    
    * configure driver = driverConfig
    * driver backOfficeUrl
    * print '***backofficeurl***' backOfficeUrl
    And maximize()
    
    * karate.log('***Logging into the application****')
    And input(loginLocator.usernameTextArea, usersValue.users.partyViewOnly.email)
    * delay(300)
    And input(loginLocator.passwordTextArea, usersValue.users.partyViewOnly.password)
    * delay(300)
    
    When click(loginLocator.loginButton)
    * karate.log('***Logging into the application****')
    * delay(300)
    And click(dashBoardLocator.switchMenu)
    * delay(300)
    And click(dashBoardLocator.partyMenu)
    * delay(300)
		* mouse().move(contactLocator.partyTypeDropdownTxt).click()

    * delay(200)
    * def dropdownTxt = scriptAll(contactLocator.partyTypeDropdownMenu, '_.textContent')
    * print 'Dropdown', dropdownTxt
    * delay(200)
    * match dropdownTxt[0] contains 'Individual'
    * match dropdownTxt[1] contains 'Organization'
    * delay(100)
    
    * def optionOnDropDown = locateAll(contactLocator.partyTypeDropdownMenu)
    * delay(100)
    * match karate.sizeOf(optionOnDropDown) == 2
    * optionOnDropDown[0].click()
    * delay(100) 
    
    * input(contactLocator.typePartyId,contactConstant.lablePartyIdText)
    * delay(100)
    * click(contactLocator.clickOnApply)
    * delay(1000)
    * click(contactLocator.clickOnPartyId)
    * delay(1000)
	
  		   
	#REV2-22254
	Scenario: Verify the Label after the super admin access user select the party in which user wants to view list of contact information.
	  
	  * karate.log('***After click on New Contact button and entering information user with view only permission should be logged out successfully.***')
	  
	  * click(contactLocator.contactInfoTab)
    * delay(100)
    * click(contactLocator.newContactButton)
    * delay(300)
  	
  	* mouse().move(contactLocator.clickOnContactType).click()
    * delay(300)
    
    * def contactTypeCheckBoxValue = scriptAll(contactLocator.contactTypeCheckBox, '_.textContent')
    * print 'contactTypeCheckBox', contactTypeCheckBoxValue
    * delay(200)
    * match contactTypeCheckBoxValue[0] contains 'Postal Address'
    * match contactTypeCheckBoxValue[1] contains 'Email Address'
    * match contactTypeCheckBoxValue[2] contains 'Phone Number'
    * delay(100)
       
    * def contactTypeValue = locateAll(contactLocator.contactTypeCheckBox)  
    * contactTypeValue[2].click()
    * delay(1000) 
    
    * mouse().move(contactLocator.clickOnContactPurpose).click()
    * delay(200)
    
    * def clickOnContactPurposeDropDownValue = scriptAll(contactLocator.clickOnContactPurposeCheckbox, '_.textContent')
    * print 'clickOnContactPurposeCheckbox', clickOnContactPurposeDropDownValue
    * delay(200)
  
    * def clickOnContactPurposevalue = locateAll(contactLocator.clickOnContactPurposeCheckbox)  
    * clickOnContactPurposevalue[1].click()
   
    * delay(200)
    * click(contactLocator.phoneNo)
    * delay(1000)
    * input(contactLocator.phoneNo ,"9127267815")
    * delay(200)
    * mouse().move(contactLocator.fromDate).click()
    * delay(200)
    
    * input(contactLocator.date , "15011998")
    * input(contactLocator.time , "112233")
		* delay(2000)
   
    * click(contactLocator.createButton)
    * delay(1000)
    And match text(contactLocator.createDilogBox) == contactConstant.createDilogBoxText
    * delay(100)
    * click(contactLocator.continueButton)
    * delay(10000)
    * match driver.url == contactConstant.viewOnlyLoginPageUrl 
    * delay(1000)
    