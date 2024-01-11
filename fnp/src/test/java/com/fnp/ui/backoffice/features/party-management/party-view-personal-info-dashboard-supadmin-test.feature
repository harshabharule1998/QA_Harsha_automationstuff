Feature: Party View Personal Information on Dashboard for Super Admin Role

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
    * delay(5000)
    * match text(partyLocator.partyManagementText) == partyConstant.titleText
		* delay(3000)
 		* mouse().move(partyLocator.partyTypeDropdownTxt).click()
		* delay(200)
    * def dropdownTxt = scriptAll(partyLocator.partyTypeDropdownMenu, '_.textContent')
    * print 'Dropdown', dropdownTxt
    * match dropdownTxt[0] contains 'Individual'
    * match dropdownTxt[1] contains 'Organization'
    * delay(100)
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
	 
	#REV2-19660
	Scenario: Verify Super Admin can View Personal Information on Dashboard
		
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
    * match text(partyLocator.lableOfPartyId) == partyConstant.labelPartyIdText
   	* karate.log("label match")
   	* karate.log(partyLocator.lableOfPartyId.textContent)
    * delay(100) 
    * karate.log("******Verifying above Navigation bar info for Individual party type*******")
		* def aboveNavInfo = scriptAll(partyLocator.aboveNavigationInfo, '_.textContent')
 		* delay(1000)
    * print 'aboveNavTxt', aboveNavInfo
    * delay(1000)
    * match karate.sizeOf(aboveNavInfo) == 4
    * match aboveNavInfo[0] == partyConstant.aboveNavInfoOne
    * match aboveNavInfo[1] == partyConstant.aboveNavInfoTwo
    * match aboveNavInfo[2] == partyConstant.aboveNavInfoThree
    * match aboveNavInfo[3] == partyConstant.aboveNavInfoFour
    * delay(1000)  
    * karate.log("*********Verifying tabs on Navigation bar*************")
    * def navBarModules = scriptAll(partyLocator.navBarModules, '_.textContent')
    * delay(100)
    * print 'navBarModules', navBarModules
    * match karate.sizeOf(navBarModules) == 5
   	* match navBarModules[0] == partyConstant.navBarModulesOneTxt
    * match navBarModules[1] == partyConstant.navBarModulesTwoTxt
    * match navBarModules[2] == partyConstant.navBarModulesThreeTxt
    * match navBarModules[3] == partyConstant.navBarModulesFourTxt
    * match navBarModules[4] == partyConstant.navBarModulesFiveTxt
    * delay(100)
   

	#REV2-19668/REV2-19666/REV2-19663/REV2-19661/REV2-19667
	Scenario: Verify personal info, Edit icon, party type is visible on personal information dashboard for Super Admin

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
    * karate.log("*********Verifying personal info fields*************")
    * def namegenderdobdoaLabel = scriptAll(partyLocator.namegenderdobdoaLabel, '_.textContent')
    * print 'PersonalInfoTabDetails', namegenderdobdoaLabel
    * match namegenderdobdoaLabel[0] == partyConstant.nameLabelTxt
    * match namegenderdobdoaLabel[1] == partyConstant.genderLabelTxt
    * match namegenderdobdoaLabel[3] == partyConstant.dobTxt
    * match namegenderdobdoaLabel[4] == partyConstant.doanniversayTxt
    * def namegenderdobdoaLabelvalues = scriptAll(partyLocator.dateOfBirth, '_.textContent')
    * print 'Name,Gender,DOB,DOA', namegenderdobdoaLabelvalues
    * match namegenderdobdoaLabelvalues[0] == '#present'
    * match namegenderdobdoaLabelvalues[1] == '#present'
    * match namegenderdobdoaLabelvalues[2] == '#present'
    * match namegenderdobdoaLabelvalues[3] == '#present'  
    * karate.log("*********Verifying edit button link for Individual party type*************")
  	* def buttonExists = exists(partyLocator.editButton)
    * if (buttonExists) karate.log("Edit button is present") 
    
     
	#REV2-19662/REV2-19667
	Scenario: Verify date format and partyId label on Personal Info tab for Super Admin

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
   	* delay(1000)
    * match text(partyLocator.lableOfPartyId) == partyConstant.partyIndiviualLabelTxt
   	* karate.log("label match")
   	* delay(100)	
   	* karate.log("*********Verifying partyId as page label*************")
   	* print 'PartyId Label' ,partyLocator.lableOfPartyId.textContent
   	* def partyTypeLabel = scriptAll(partyLocator.partyTypeLabel, '_.textContent')
    * print 'partyTypeLabel', partyTypeLabel
    * match partyTypeLabel[0] contains partyConstant.partyTypeLabelTxt
    * def partyTypeValue = scriptAll(partyLocator.partyTypeValue, '_.textContent')
    * print 'partyTypeValue', partyTypeValue
    * match partyTypeValue[0] contains partyConstant.partyTypeValueTxt
    * karate.log("*********Verifying date format*************") 
    * def getDates = scriptAll(partyLocator.dateOfBirth, '_.textContent')
    * print 'DOB and DOA', getDates					
		* def doadate = getDates[3]
		* karate.log(doadate)				
		* def isValid = isValidDateFormat(doadate)
		* karate.log("Date of Anniversary in DD/MM/YYYY format is : ", isValid)
		* def dobdate = getDates[2]
		* karate.log(dobdate)	
		* def isValid = isValidDateFormat(dobdate)
		* karate.log("Date of Birth in DD/MM/YYYY format is : ", isValid)
		
 
	#REV2-19666/REV2-19661
	Scenario: Verify Super Admin can click on Edit link and View Personal Information on Dashboard for organization party type 
	
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
    * match text(partyLocator.lableOfPartyId) == partyConstant.labelPartyIdText
   	* karate.log("label match")
   	* karate.log(partyLocator.lableOfPartyId.textContent)
    * delay(100)
    * karate.log("*********Verifying above Navigation bar info for Organization party type*************")
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
    * karate.log("*********Verifying below Navigation bar info for Organization party type*************")
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
    * karate.log("*********Verifying edit button link for Organization party type*************") 
    * def buttonExists = exists(partyLocator.clickEditButton)
  	* if(buttonExists) karate.log("Edit button is present") 
  	* match enabled(partyLocator.clickEditButton) == true
 	 	* delay(2000)
 	 	* mouse().move(partyLocator.clickEditButton).click()
 		* delay(5000) 
    * karate.log("*********Verifying update page for Organization party type*************") 
    * match driver.url contains partyConstant.editPartyOrganizationURL
    * delay(1000)
		* def updatePartyOrganizationPageFields = scriptAll(partyLocator.updateOrgInfoPageLabel, '_.textContent')
		* print 'updatePartyOrganizationPageFields : ', updatePartyOrganizationPageFields
		* delay(1000)
    * match updatePartyOrganizationPageFields[0] == partyConstant.editContactNameTxt
    * match updatePartyOrganizationPageFields[1] == partyConstant.editDesignationTxt
    * match updatePartyOrganizationPageFields[2] == partyConstant.editOrgNameTxt
    * match updatePartyOrganizationPageFields[3] == partyConstant.editTaxNoTxt
    * match updatePartyOrganizationPageFields[4] == partyConstant.editFaxNoTxt
    * match text(partyLocator.updateOrganizationInfoLabel) == partyConstant.updateOrganizationInfoTxt
    * match text(partyLocator.updateBusinessInfoLabel) == partyConstant.updateBusinessInfoLabel

 
	#REV2-19664/REV2-19669
	Scenario: Verify edit button link is activated on personal info dashboard with Indiviual party type for Super Admin
	
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
    * karate.log("*********Verifying update page for  Individual party type*************")
	 	* def buttonExists = exists(partyLocator.clickEditButton)
  	* if(buttonExists) karate.log("Edit button is present") 
 	 	* match enabled(partyLocator.clickEditButton) == true
 	 	* karate.log("Edit button is activated")
 	 	* delay(2000)
 	 	* mouse().move(partyLocator.clickEditButton).click()
 		* delay(5000)
		* match driver.url contains partyConstant.editPartyIndiviualPageURL
		* delay(1000)
		* def updatePageFields = scriptAll(partyLocator.updatePageLabel, '_.textContent')
		* delay(1000)
		* print 'updatePageFields : ', updatePageFields
    * match updatePageFields[0] == partyConstant.updateNameLabelTxt
    * match updatePageFields[1] == partyConstant.updateGenderLabelTxt
    * match updatePageFields[2] == partyConstant.updateDobTxt
    * match updatePageFields[3] == partyConstant.updateDoanniversayTxt
	
	