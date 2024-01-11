Feature: List Party UI scenarios for Super Admin

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
    
   
	#REV2-20004
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

  
	#REV2-20005
	Scenario: Verify fields present in search party form with super admin access
	  
	  * delay(1000)
	  * def searchPageInputs = locateAll(searchLocator.searchPageInputs)
    * delay(1000)
    * assert karate.sizeOf(searchPageInputs) > 5
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
    * delay(3000)
    
  
	#REV2-20006
	Scenario: Verify the search party list if user search with any one field for super admin access
	  
	  * delay(1000)
	  * input(searchLocator.typePartyId,searchConstant.lablePartyIdText)
    * delay(1000)
    * click(searchLocator.clickOnApply)
    * delay(1000)
    * click(searchLocator.clickOnPartyId)
    * delay(1000)
    * match text(searchLocator.lableOfPartyId) == searchConstant.lablePartyIdText
    * delay(2000)
    

	#REV2-20007
	Scenario: Verify super admin can sort the search party list
	  
	  * def ArrayList = Java.type('java.util.ArrayList')
		* def Collections = Java.type('java.util.Collections')
		
		* def partyIdList = new ArrayList()
		* def partyIdSortedList = new ArrayList()
		
	  * delay(1000)
	  * input(searchLocator.partyNameInput, "cybage")
    * delay(1000)
    * click(searchLocator.clickOnApply)
    * delay(1000)
    
    * def partyIds = scriptAll(searchLocator.partyIdList, '_.textContent')
   		 
		* karate.repeat(partyIds.length, function(i){ partyIdList.add(partyIds[i]) })
		* karate.log('partyId Before Sort List : ', partyIdList)
		
    * Collections.sort(partyIdList)
    * karate.log('partyIdList  after sort : ', partyIdList)
         
    * click(searchLocator.partyIdSortButton) 
    * delay(1000)    
    
    * def partyIdListAfterSort = scriptAll(searchLocator.partyIdList, '_.textContent')
    
    * karate.repeat(partyIdListAfterSort.length, function(i){ partyIdSortedList.add(partyIdListAfterSort[i]) })
		* karate.log('partyIdSortedList : ', partyIdSortedList)
		    
    * match partyIdListAfterSort == partyIdList 
    * delay(2000)
    

	#REV2-20008 and REV2-20009
	Scenario: Verify the functionality of the grid button for super admin access
	  
	  * delay(1000)
	  * input(searchLocator.typePartyId,searchConstant.lablePartyIdText)
    * delay(1000)
    * click(searchLocator.clickOnApply)
    * delay(1000)
    * def createdByColumn = locateAll(searchLocator.createdByColumn)
    * delay(1000)
    * assert karate.sizeOf(createdByColumn) == 1
    * click(searchLocator.gridButton)
    * delay(1000)
    * click(searchLocator.createdByCheckBox)
    * delay(1000)
    * click(searchLocator.configurationCloseButton)
    * delay(1000)
    * def createdByColumn = locateAll(searchLocator.createdByColumn)
    * delay(1000)
    * assert karate.sizeOf(createdByColumn) == 0
    * delay(2000)


	#REV2-20010
	Scenario: Verify the visibility of the Add Filter button and its options for super admin access
	  
	  * delay(1000)
	  * input(searchLocator.typePartyId,searchConstant.lablePartyIdText)
    * delay(1000)
    * click(searchLocator.clickOnApply)
    * delay(1000)
    * click(searchLocator.addFilterButton)
    * delay(1000)
    * def filterOptionLoginId = locateAll(searchLocator.filterOptionLoginId)
    * def filterOptionContactPurpose = locateAll(searchLocator.filterOptionContactPurpose)
    * def filterOptionStatus = locateAll(searchLocator.filterOptionStatus)
    * delay(1000)
    * assert karate.sizeOf(filterOptionLoginId) == 1
    * assert karate.sizeOf(filterOptionContactPurpose) == 1
    * assert karate.sizeOf(filterOptionStatus) == 1
    * delay(2000)
    

	#REV2-20011
	Scenario: Verify Contact Purpose filter option added after selecting from Add Filter drop-down
	  
	  * delay(1000)
	  * input(searchLocator.typePartyId,searchConstant.lablePartyIdText)
    * delay(1000)
    * click(searchLocator.clickOnApply)
    * delay(1000)
    * click(searchLocator.addFilterButton)
    * delay(1000)
    * click(searchLocator.filterOptionContactPurpose)
    * delay(1000)
    * def contactPurposeInput = locateAll(searchLocator.contactPurposeInput)
    * delay(1000)
    * assert karate.sizeOf(contactPurposeInput) == 1
    * delay(2000)
    

	#REV2-20012
	Scenario: Verify Status filter option added after selecting from Add Filter drop-down for super admin
	  
	  * delay(1000)
	  * input(searchLocator.typePartyId,searchConstant.lablePartyIdText)
    * delay(1000)
    * click(searchLocator.clickOnApply)
    * delay(1000)
    * click(searchLocator.addFilterButton)
    * delay(1000)
    * click(searchLocator.filterOptionStatus)
    * delay(1000)
    * def statusInput = locateAll(searchLocator.statusInput)
    * delay(1000)
    * assert karate.sizeOf(statusInput) == 1
    * delay(2000)
    
	
	#REV2-20013
	Scenario: Verify Search text-box present in the search result page for super admin
	  
	  * delay(1000)
	  * input(searchLocator.typePartyId,searchConstant.lablePartyIdText)
    * delay(1000)
    * click(searchLocator.clickOnApply)
    * delay(1000)
    * def searchInput = locateAll(searchLocator.searchInput)
    * delay(1000)
    * assert karate.sizeOf(searchInput) == 1
    * delay(2000)
    

	#REV2-20014
	Scenario: Verify LoginId filter option added after selecting from Add Filter drop-down for super admin
	  
	  * delay(1000)
	  * input(searchLocator.typePartyId,searchConstant.lablePartyIdText)
    * delay(1000)
    * click(searchLocator.clickOnApply)
    * delay(1000)
    * click(searchLocator.addFilterButton)
    * delay(1000)
    * click(searchLocator.filterOptionLoginId)
    * delay(1000)
    * def loginIdInput = locateAll(searchLocator.loginIdInput)
    * delay(1000)
    * assert karate.sizeOf(loginIdInput) == 1
    * delay(2000)
    

	#REV2-20015 and REV2-20016
	Scenario: Verify the functionality of the remove filter button for super admin
	  
	  * delay(1000)
	  * input(searchLocator.typePartyId,searchConstant.lablePartyIdText)
    * delay(1000)
    * click(searchLocator.clickOnApply)
    * delay(1000)
    * click(searchLocator.addFilterButton)
    * delay(1000)
    * click(searchLocator.filterOptionLoginId)
    * delay(1000)
    * click(searchLocator.addFilterButton)
    * delay(1000)
    * click(searchLocator.filterOptionContactPurpose)
    * delay(1000)
    * click(searchLocator.addFilterButton)
    * delay(1000)
    * click(searchLocator.filterOptionStatus)
    * delay(1000)
    * click(searchLocator.removeFilterLoginId)
    * delay(1000)
    * click(searchLocator.removeFilterContactPurpose)
    * delay(1000)
    * click(searchLocator.removeFilterOptionStatus)
    * delay(1000)
    * click(searchLocator.addFilterButton)
    * delay(1000)
    * def filterOptionLoginId = locateAll(searchLocator.filterOptionLoginId)
    * def filterOptionContactPurpose = locateAll(searchLocator.filterOptionContactPurpose)
    * def filterOptionStatus = locateAll(searchLocator.filterOptionStatus)
    * delay(1000)
    * assert karate.sizeOf(filterOptionLoginId) == 1
    * assert karate.sizeOf(filterOptionContactPurpose) == 1
    * assert karate.sizeOf(filterOptionStatus) == 1
    * delay(2000)

   
	#REV2-20017
	Scenario: Verify pagination on Search Party list page for super admin
	  
	  * delay(1000)
	  * input(searchLocator.partyNameInput, "test")
    * delay(1000)
    * click(searchLocator.clickOnApply)
    * delay(1000)
    * scroll(searchLocator.rowsInput)
    * delay(1000)
    * mouse().move(searchLocator.rowsInput).click()
    * delay(1000)
    * click(searchLocator.rowsPerPageOption)
    * delay(1000)
    * def partyIds = scriptAll(searchLocator.partyIdList, '_.textContent')
   	* delay(1000)	 
		* assert partyIds.length == 5
    * delay(2000)
    
	   
	#REV2-20018
	Scenario: Verify three dots button and its options visible for super admin
	  
	  * delay(1000)
	  * input(searchLocator.partyNameInput, "test")
    * delay(1000)
    * click(searchLocator.clickOnApply)
    * delay(1000)
    * def partyIds = scriptAll(searchLocator.partyIdList, '_.textContent')
    * delay(1000)
    * def partyOrderButtons = locateAll(searchLocator.partyOrderButton)
    * delay(1000)
    * partyOrderButtons[0].click()
    * delay(1000)
    * def partyOrderLocator = "a[data-at-id*='Orders_" + partyIds[0] + "']"
    * def partyOrderOptionsList = scriptAll(partyOrderLocator, '_.textContent')
    * delay(1000)
    * match partyOrderOptionsList[0] contains 'View Orders'
    * match partyOrderOptionsList[1] contains 'Create Orders'
    * delay(2000)
	
	   
	#REV2-20023
	Scenario: Verify New Party button navigates to party create page for super admin
	  
	  * delay(1000)
	  * input(searchLocator.partyNameInput, "test")
    * delay(1000)
    * click(searchLocator.clickOnApply)
    * delay(1000)
    * click(searchLocator.newPartyButton)
    * delay(1000)
    * match driver.url contains searchConstant.partyCreateUrl
	  * delay(2000)
	
  
	#REV2-20026
	Scenario: Verify whether Party dashboard is opening when super admin clicks on Party ID
	  
	  * delay(1000)
	  * input(searchLocator.typePartyId,searchConstant.lablePartyIdText)
    * delay(1000)
    * click(searchLocator.clickOnApply)
    * delay(1000)
    * click(searchLocator.clickOnPartyId)
    * delay(1000)
    * match text(searchLocator.lableOfPartyId) == searchConstant.lablePartyIdText
    * delay(3000)
