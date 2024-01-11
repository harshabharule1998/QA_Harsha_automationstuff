Feature: Party View Personal Information on Dashboard for partyViewOnly Role

  Background: 
    * def loginLocator = read('../../data/loginPage_locator.json')
    * def usersValue = read('../../data/users.json')
    * def dashBoardLocator = read('../../data//dashboard_locators.json')
    * def partyLocator = read('../../data/party/partyPage_locators.json')
    * def partyConstant = read('../../data/party/partyPage_constants.json')
    * configure driver = driverConfig
    * driver backOfficeUrl
    * print '***backofficeurl***' backOfficeUrl
    And maximize()
    * karate.log('***Logging into the application****')
    And input(loginLocator.usernameTextArea, usersValue.users.partyViewOnly.email)
    * delay(1000)
    And input(loginLocator.passwordTextArea, usersValue.users.partyViewOnly.password)
    * delay(1000)
    When click(loginLocator.loginButton)
    * karate.log('***Logging into the application****')
    * delay(1000)
    And click(dashBoardLocator.switchMenu)
    * delay(1000)
    And click(dashBoardLocator.partyMenu)
    * delay(5000)
    * match text(partyLocator.partyManagementText) == partyConstant.titleText
		* delay(1000)
		* def isValidDateFormat =
    
							"""
							function(date) {
								var date_regex = /^([1-9]|0[1-9]|1[0-2])\/(0[1-9]|1\d|2\d|3[01])\/(19|20)\d{2}$/;
								if (!(date_regex.test(date))) {
    							return false;
								} else {
									return true;
								}
							}
							
							"""
							
		
		#REV2-19673/REV2-19672/REV2-19671
		Scenario: Verify partyViewOnly user can view personal info and edit link on dashboard but cannot edit personal info for Individual party type
		
		* mouse().move(partyLocator.partyTypeDropdownTxt).click()
		* delay(200)
    * def dropdownTxt = scriptAll(partyLocator.partyTypeDropdownMenu, '_.textContent')
    * print 'Dropdown', dropdownTxt
    * match dropdownTxt[0] contains 'Individual'
    * match dropdownTxt[1] contains 'Organization'
    * delay(100)
    * def optionOnDropDown = locateAll(partyLocator.partyTypeDropdownMenu)
    * delay(100)
    * match karate.sizeOf(optionOnDropDown) == 2
    * optionOnDropDown[0].click()
    * delay(100) 
    * input(partyLocator.typePartyId, 'P_00170')
    * delay(100)
    * click(partyLocator.clickOnApply)
    * delay(100)
    * click(partyLocator.clickOnIndiviualPartyId)
    * delay(100)
    * match driver.url == partyConstant.partyIndiviualNavigationURL
   	* delay(100)
    * match text(partyLocator.lableOfPartyId) == partyConstant.partyIndiviualLabelTxt
   	* karate.log("label match")
   	* karate.log(partyLocator.lableOfPartyId.textContent)
    * delay(1000)  
    * karate.log("*****Verifying the personal info data for Individual party type******")
    * def namegenderdobdoaLabel = scriptAll(partyLocator.namegenderdobdoaLabel, '_.textContent')
    * print 'PersonalInfoTabDetails', namegenderdobdoaLabel
    * match namegenderdobdoaLabel[0] == partyConstant.nameLabelTxt
    * match namegenderdobdoaLabel[1] == partyConstant.genderLabelTxt
    * match namegenderdobdoaLabel[3] == partyConstant.dobTxt
    * match namegenderdobdoaLabel[4] == partyConstant.doanniversayTxt
    * def namegenderdobdoavalues = scriptAll(partyLocator.dateOfBirth, '_.textContent')
    * print 'Name,Gender,DOB,DOA', namegenderdobdoaLabelvalues
    * match namegenderdobdoavalues[0] == '#present'
    * match namegenderdobdoavalues[1] == '#present'
    * match namegenderdobdoavalues[2] == '#present'
    * match namegenderdobdoavalues[3] == '#present'
		* def buttonExists = exists(partyLocator.clickEditButton)
    * if (buttonExists) karate.log("Edit button is present")   
  	* karate.log("*****Verifying date format***** ")  
		* def doadate = namegenderdobdoavalues[3]
		* karate.log(doadate)				
		* def isValid = isValidDateFormat(doadate)
		* karate.log("Date of Anniversary in DD/MM/YYYY format is : ", isValid)
		* def dobdate = namegenderdobdoavalues[2]
		* karate.log(dobdate)	
		* def isValid = isValidDateFormat(dobdate)
		* karate.log("Date of Birth in DD/MM/YYYY format is : ", isValid)		
		* karate.log("*****Verifying edit button link for Individual party type******")  
		* match enabled(partyLocator.clickEditButton) == true
 	 	* delay(2000)
  	* mouse().move(partyLocator.clickEditButton).click()
 		* delay(5000)
 		* input(partyLocator.updatePageNameInputbox, 'test')
    * click(partyLocator.updateButton)
    * delay(5000)
    * match text(partyLocator.confirmDialogTxtL) == partyConstant.confirmDialogTxt
    * click(partyLocator.dailogBoxContinue)
    * delay(5000)
    * match driver.url == partyConstant.afterClickUpdateNavigationLink
				
					
	#REV2-19671/REV2-19670
	Scenario:  Verify partyViewOnly user can view personal info, edit link on dashboard but cannot edit personal info for Organization party type
	
		* match text(partyLocator.partyManagementText) == partyConstant.titleText
 		* mouse().move(partyLocator.partyTypeDropdownTxt).click()
		* delay(200)
    * def dropdownTxt = scriptAll(partyLocator.partyTypeDropdownMenu, '_.textContent')
    * print 'Dropdown', dropdownTxt
    * match dropdownTxt[0] contains 'Individual'
    * match dropdownTxt[1] contains 'Organization'
    * delay(100)
    * def optionOnDropDown = locateAll(partyLocator.partyTypeDropdownMenu)
    * delay(100)
    * match karate.sizeOf(optionOnDropDown) == 2
    * optionOnDropDown[1].click()
    * delay(100) 
    * input(partyLocator.typePartyId, 'C_01160')
    * delay(100)
    * click(partyLocator.clickOnApply)
    * delay(100)
    * click(partyLocator.clickOnPartyId)
    * delay(100)
    * match driver.url == partyConstant.partyNavigationURL
   	* delay(100) 	
   	* karate.log("*****Verifying the personal info data for Organization party type******")
    * match text(partyLocator.lableOfPartyId) == partyConstant.labelPartyIdText
   	* karate.log("label match")
   	* karate.log(partyLocator.lableOfPartyId.textContent)
    * delay(100)
		* def aboveNavInfo = scriptAll(partyLocator.aboveNavigationInfo, '_.textContent')
 		* delay(1000)
    * print 'aboveNavTxt', aboveNavInfo
    * delay(1000)
    * match karate.sizeOf(aboveNavInfo) == 4
    * match aboveNavInfo[0] == partyConstant.aboveNavInfoOne
    * match aboveNavInfo[1] == partyConstant.aboveNavInfoTwo
    * match aboveNavInfo[2] == partyConstant.aboveNavInfoThree
    * match aboveNavInfo[3] == partyConstant.aboveNavInfoFour
    * delay(100)
    * def navBarModules = scriptAll(partyLocator.navBarModules, '_.textContent')
    * delay(1000)
    * print 'navBarModules', navBarModules
    * match karate.sizeOf(navBarModules) == 5
   	* match navBarModules[0] == partyConstant.navBarModulesOneTxt
    * match navBarModules[1] == partyConstant.navBarModulesTwoTxt
    * match navBarModules[2] == partyConstant.navBarModulesThreeTxt
    * match navBarModules[3] == partyConstant.navBarModulesFourTxt
    * match navBarModules[4] == partyConstant.navBarModulesFiveTxt
    * delay(1000)
   	* def labels = scriptAll(partyLocator.organizationInfoLabel, '_.textContent')
		* delay(1000)
    * print 'labels', labels
    * match labels[0] == partyConstant.organizationInfoLabelTxt
    * match labels[3] == partyConstant.businessInfoTxt
    * delay(1000)
    * def orgBusinessInfoLabels = scriptAll(partyLocator.orgBusinessInfoLabels, '_.textContent')
    * print 'orgBusinessInfoLabels', orgBusinessInfoLabels
    * match orgBusinessInfoLabels[1] == partyConstant.contactPersonNameTxt
    * match orgBusinessInfoLabels[2] == partyConstant.designationLabelTxt
    * match orgBusinessInfoLabels[3] == partyConstant.orgNameTxt
    * match orgBusinessInfoLabels[4] == partyConstant.taxvatTxt
    * match orgBusinessInfoLabels[5] == partyConstant.faxNumberTxt 
    * karate.log("*****Verifying edit button link for Organization party type******")  
    * def buttonExists = exists(partyLocator.clickEditButton)
  	* if(buttonExists) karate.log("Edit button is present") 
 	 	* match enabled(partyLocator.clickEditButton) == true
 	 	* delay(2000)
  	* mouse().move(partyLocator.clickEditButton).click()
 		* delay(5000)
 		* input(partyLocator.updateContactPersonName, 'test')
    * click(partyLocator.updateButton)
    * delay(5000)
    * match text(partyLocator.confirmDialogTxtL) == partyConstant.confirmDialogTxt
    * click(partyLocator.dailogBoxContinue)
    * delay(5000)
    * match driver.url == partyConstant.afterClickUpdateNavigationLink
    
    