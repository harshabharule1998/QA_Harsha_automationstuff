Feature: List & View Party Expired Contacts UI scenarios for super admin role

  Background: 
		* def loginLocator = read('../../data/loginPage_locator.json')
    * def usersValue = read('../../data/users.json')
    * def dashBoardLocator = read('../../data//dashboard_locators.json')
    * def contactLocator = read('../../data/party/contactPage_locators.json')
    * def contactConstant = read('../../data/party/contactPage_constants.json')
    * def expiredContactLocator = read('../../data/party/expiredContactPage_locators.json')
    * def expiredContactConstant = read('../../data/party/expiredContactPage_constants.json') 
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
		* mouse().move(contactLocator.partyTypeDropdownTxt).click()
    * delay(2000)
    * def dropdownTxt = scriptAll(contactLocator.partyTypeDropdownMenu, '_.textContent')
    * print 'Dropdown', dropdownTxt
    * delay(2000)
    * match dropdownTxt[0] contains 'Individual'
    * match dropdownTxt[1] contains 'Organization'
    * delay(1000)
    * def optionOnDropDown = locateAll(contactLocator.partyTypeDropdownMenu)
    * delay(1000)
    * match karate.sizeOf(optionOnDropDown) == 2
    * optionOnDropDown[0].click()
    * delay(1000) 
    * input(contactLocator.typePartyId,expiredContactConstant.labelPartyIdText)
    * delay(1000)
    * click(contactLocator.clickOnApply)
    * delay(1000)
    * click(contactLocator.clickOnPartyId)
    * delay(5000)
    * match enabled(expiredContactLocator.personalInfoTab) == true
   	* delay(2000)
   
   
	#REV2-22278/REV2-22282
	Scenario: Verify the Label and Navigation Link after Super Admin select the party in which he wants to view list of expired contacts
	
		* match text(contactLocator.lableOfPartyId) == expiredContactConstant.labelPartyIdText
    * delay(5000)
    * click(contactLocator.contactInfoTab)
  	* delay(1000)
  	* click(expiredContactLocator.expiredContactButton)
		* delay(1000)
		* match text(expiredContactLocator.expiredContactLabel) == expiredContactConstant.expiredContactLabelTxt
    * delay(1000)
		* match driver.url contains '/expired-contacts'
	
	   
	#REV2-22279
	Scenario: Verify whether Contact Information tab is present or not for Super Admin
	
	 	* def navBarModules = scriptAll(contactLocator.navBarTab, '_.textContent')
    * print ' navBarModules : ' , navBarModules
    * delay(1000)
    * match karate.sizeOf(navBarModules) == 5
		* match navBarModules[2] == contactConstant.contactInfoTabText 
		* karate.log("Contact Information tab is present")
    * delay(3000)
  
 
	#REV-22289/REV2-22292/REV2-22281
	Scenario: Verify search functionality and fields present in Expired Contact Info if contact type is Postal Address for Super Admin
	
		* click(contactLocator.contactInfoTab)
  	* delay(1000)
  	* exists(expiredContactLocator.expiredContactButton)
  	* delay(1000)
  	* click(expiredContactLocator.expiredContactButton)
		* delay(1000)
		* click(expiredContactLocator.searchBox)
    * input(expiredContactLocator.searchBox,'Postal Address')
    * delay(5000)
		* def expContactTableColumnNames = scriptAll(expiredContactLocator.expContactListTableHeading, '_.textContent')
		* print "expContactTableColumnNames : " , expContactTableColumnNames
		* delay(3000)
		* match expContactTableColumnNames[1] == expiredContactConstant.contactTypeTableColumnName
		* match expContactTableColumnNames[3] == expiredContactConstant.contactPurposeTableColumnName
		* match expContactTableColumnNames[5] == expiredContactConstant.conInfoTableColumnName
		* match expContactTableColumnNames[6] == expiredContactConstant.statusTableColumnName
    * def expiredContactList = scriptAll(contactLocator.contactTypeList, '_.textContent')
		* print "expired Contact Information Column List..." , expiredContactList  
		* delay(3000)
    * click(expiredContactLocator.threeDots)
    * delay(3000)
    * def veiwOptionsList = locateAll(expiredContactLocator.viewOptions)
   	* delay(3000)
   	* veiwOptionsList[0].click()
		* delay(5000)
		* match text(expiredContactLocator.postalAddressLabel) == expiredContactConstant.postalAddressTxt
		* def postalAddInfoDetails = scriptAll(expiredContactLocator.postalAddDetailsLabel, '_.textContent')
		* print "postalAddInfoDetails : " , postalAddInfoDetails  
		* delay(3000)
		* match postalAddInfoDetails[0] == expiredContactConstant.contactTypeLabelTxt
		* match postalAddInfoDetails[1] == expiredContactConstant.contactPurposeLabelTxt
		* match postalAddInfoDetails[2] == expiredContactConstant.statusLabelTxt
		* match postalAddInfoDetails[3] == expiredContactConstant.toNameLabelTxt
		* match postalAddInfoDetails[4] == expiredContactConstant.attentionNameLabelTxt
		* match postalAddInfoDetails[5] == expiredContactConstant.doorbellLabelTxt
		* match postalAddInfoDetails[6] == expiredContactConstant.addressLine1LabelTxt
		* match postalAddInfoDetails[7] == expiredContactConstant.addressLine2LabelTxt
		* match postalAddInfoDetails[8] == expiredContactConstant.cityLabelTxt
		* match postalAddInfoDetails[9] == expiredContactConstant.stateLabelTxt
		* match postalAddInfoDetails[10] == expiredContactConstant.pincodeLabelTxt
		* match postalAddInfoDetails[11] == expiredContactConstant.countryLabelTxt
		* match postalAddInfoDetails[13] == expiredContactConstant.backButtonTxt
		* delay(1000)
		* exists(expiredContactLocator.backButton)
	
 
	#REV2-22291
	Scenario: Verify Expired Contact Information fields if contact type is Email Address for Super Admin
	
		* click(contactLocator.contactInfoTab)
  	* delay(1000)
  	* click(expiredContactLocator.expiredContactButton)
		* delay(1000)
		* click(expiredContactLocator.searchBox)
    * input(expiredContactLocator.searchBox,'Email Address')
    * delay(5000)
    * def expiredContactList = scriptAll(contactLocator.contactTypeList, '_.textContent')
		* print "expired Contact Information Column List..." , expiredContactList  
		* delay(3000)
    * click(expiredContactLocator.threeDots)
    * delay(3000)
    * def veiwOptionsList = locateAll(expiredContactLocator.viewOptions)
   	* delay(3000)
   	* veiwOptionsList[0].click()
		* delay(10000)
		* match text(expiredContactLocator.emailAddressLabel) == expiredContactConstant.emailAddressTxt
		* def emailAddInfoDetails = scriptAll(expiredContactLocator.InfoDetailsLabel, '_.textContent')
		* print "emailAddInfoDetails : " , emailAddInfoDetails  
		* delay(3000)
		* match emailAddInfoDetails[0] == expiredContactConstant.contactTypeLabelTxt
		* match emailAddInfoDetails[1] == expiredContactConstant.contactPurposeLabelTxt
		* match emailAddInfoDetails[3] == expiredContactConstant.statusLabelTxt
		* match emailAddInfoDetails[2] == expiredContactConstant.contactEmailAddTxt
		* match emailAddInfoDetails[5] == expiredContactConstant.backButtonTxt
		* delay(1000)
		* exists(expiredContactLocator.backButton)
	

	#REV2-22290
	Scenario: Verify Expired Contact Information fields if contact type is Phone Number for Super Admin
	
		* click(contactLocator.contactInfoTab)
  	* delay(1000)
  	* click(expiredContactLocator.expiredContactButton)
		* delay(1000)
		* click(expiredContactLocator.searchBox)
    * input(expiredContactLocator.searchBox,'Phone Number')
    * delay(5000)
    * def expiredContactList = scriptAll(contactLocator.contactTypeList, '_.textContent')
		* print "expired Contact Information Column List..." , expiredContactList  
		* delay(3000)
		* match each expiredContactList contains 'Phone Number'
    * click(expiredContactLocator.threeDots)
    * delay(3000)
    * def veiwOptionsList = locateAll(expiredContactLocator.viewOptions)
   	* delay(3000)
   	* veiwOptionsList[0].click()
		* delay(10000)
		* match text(expiredContactLocator.phoneNumberLabel) == expiredContactConstant.phoneNumberLabelTxt
		* def phoneNumberInfoDetails = scriptAll(expiredContactLocator.InfoDetailsLabel, '_.textContent')
		* print "phoneNumberInfoDetails : " , phoneNumberInfoDetails  
		* delay(3000)
		* match phoneNumberInfoDetails[0] == expiredContactConstant.contactTypeLabelTxt
		* match phoneNumberInfoDetails[1] == expiredContactConstant.contactPurposeLabelTxt
		* match phoneNumberInfoDetails[3] == expiredContactConstant.statusLabelTxt
		* match phoneNumberInfoDetails[2] == expiredContactConstant.contactPhoneNumber
		* match phoneNumberInfoDetails[5] == expiredContactConstant.backButtonTxt
		* delay(1000)
		* exists(expiredContactLocator.backButton)
	
	
	#REV2-22287
	Scenario: Verify Super Admin can sort the Expired Contact List by the Contact Purpose
	
	 	* karate.log('*** Sort Contact Purpose list in ascending order ****')  
    * def ArrayList = Java.type('java.util.ArrayList')
		* def Collections = Java.type('java.util.Collections')
		* def expContactPurposeSortedList = new ArrayList()
		* def expContactPurposeListLables = new ArrayList()
    * click(contactLocator.contactInfoTab)
  	* delay(1000)
  	* click(expiredContactLocator.expiredContactButton)
		* delay(1000)
    * def expContactPurposeList = scriptAll(expiredContactLocator.expiredContactPurposeList, '_.textContent')
		* karate.repeat(expContactPurposeList.length, function(i){ expContactPurposeListLables.add(expContactPurposeList[i]) })
		* karate.log('expiredContactPurposeListLables  before sort : ', expContactPurposeListLables)
		* delay(100)
    * Collections.sort(expContactPurposeListLables)
    * karate.log('expiredContactPurposeListLables  after sort : ', expContactPurposeListLables)
    * delay(100)     
    * click(expiredContactLocator.expiredContactPurposeSortingIndex) 
    * delay(1000)    
    * def expContactPurposeList = scriptAll(expiredContactLocator.expiredContactPurposeList, '_.textContent')
    * karate.repeat(expContactPurposeList.length, function(i){ expContactPurposeSortedList.add(expContactPurposeList[i]) })
		* karate.log('expiredContactPurposeSortedList  after sort : ', expContactPurposeSortedList)
    * match expContactPurposeListLables == expContactPurposeSortedList
    * delay(5000)          
    
	
	#REV2-22286
	Scenario: Verify Super Admin can sort the Expired Contact List by the Contact Type.
	
		* karate.log('*** Sort Contact Type list in ascending order ****')
    * def ArrayList = Java.type('java.util.ArrayList')
		* def Collections = Java.type('java.util.Collections')
		* def expContactTypeSortedList = new ArrayList()
		* def expContactTypeListLables = new ArrayList()
    * click(contactLocator.contactInfoTab)
  	* delay(1000)
  	* click(expiredContactLocator.expiredContactButton)
		* delay(1000)
    * def expContactTypeList = scriptAll(expiredContactLocator.expiredContactTypeList, '_.textContent') 
		* karate.repeat(expContactTypeList.length, function(i){ expContactTypeListLables.add(expContactTypeList[i]) })
		* karate.log('expiredContactTypeListLables  before sort : ', expContactTypeListLables)
    * Collections.sort(expContactTypeListLables)
    * karate.log('expiredContactTypeListLables  after sort : ', expContactTypeListLables)   
    * click(expiredContactLocator.expiredContactTypeSortingIndex) 
    * delay(2000)    
    * def expContactTypeList = scriptAll(expiredContactLocator.expiredContactTypeList, '_.textContent')
    * karate.repeat(expContactTypeList.length, function(i){ expContactTypeSortedList.add(expContactTypeList[i]) })
		* karate.log('expiredContactTypeSortedList  after sort : ', expContactTypeSortedList)  
    * match expContactTypeListLables == expContactTypeSortedList
    * delay(4000)    
    
   
	#REV2-22285/REV2-22284
	Scenario: Verify functionality and visibility of the grid button and its options present in drop-down for Super Admin
    
    * click(contactLocator.contactInfoTab)
  	* delay(1000)
  	* click(expiredContactLocator.expiredContactButton)
		* delay(1000)
    * delay(4000)
   	* def columnNamesOnGrid = scriptAll(expiredContactLocator.columnNamesPresentOnPage, '_.textContent')
   	* print 'columnNamesOnGrid : ', columnNamesOnGrid
    * delay(4000)
    * def gridButtonExists = exists(expiredContactLocator.gridButton)
    * if (gridButtonExists) karate.log("Grid functionality is present")
    * match enabled(expiredContactLocator.gridButton) == true
 	 	* delay(2000)
    * click(expiredContactLocator.gridButton)
    * def optionsOnGrid = scriptAll(expiredContactLocator.optionOnGrid, '_.textContent')
    * print 'options On Grid : ', optionsOnGrid
    * delay(1000)
    * match optionsOnGrid[0] == expiredContactConstant.contactTypeTableColumnName
    * match optionsOnGrid[1] == expiredContactConstant.contactPurposeTableColumnName
    * match optionsOnGrid[2] == expiredContactConstant.conInfoTableColumnName
    * match optionsOnGrid[3] == expiredContactConstant.statusTableColumnName
    * delay(1000)
    * def chkBox = locateAll(expiredContactLocator.checkBoxOnGrid)
    * print 'checkBox on grid : ', chkBox
    * delay(3000)
    * chkBox[1].click()
    * delay(1000)
    * chkBox[2].click()
    * delay(3000)
    * click(expiredContactLocator.closeButtonOnGrid)
    * delay(3000)
    * def columnNamesOnGrid = scriptAll(expiredContactLocator.columnNamesPresentOnPage, '_.textContent')
    * print 'columnNamesOnGrid : ', columnNamesOnGrid
    * delay(4000)
    * match columnNamesOnGrid[1] != expiredContactConstant.contactPurposeColumnName
	
	  
	#REV2-22283
	Scenario: Verify pagination and page per records at the bottom of the Expired Contact list for Super Admin
		
		* karate.log('***list pagination detail on Expired Contact List****')
  	* click(contactLocator.contactInfoTab)
  	* delay(1000)
  	* click(expiredContactLocator.expiredContactButton)
		* delay(1000)
    * scroll(contactLocator.paginationOnList)
    * delay(100)
    * def paginationTxt = scriptAll(contactLocator.paginationTxtOnList, '_.textContent')
    * print 'Pagination txt', paginationTxt
    * match paginationTxt[0] contains 'Rows per page'
    * delay(1000)
    * mouse().move(contactLocator.paginationDropdownTxt).click()
    * delay(3000)
    * def dropDownOptions = scriptAll(contactLocator.paginationDropDownOption, '_.textContent')
    * print 'dropDown---', dropDownOptions
    * match dropDownOptions[0] == '5'
    * match dropDownOptions[1] == '10'
    * match dropDownOptions[2] == '25'
    * match dropDownOptions[3] == '50'
    * def optionOnPagin = locateAll(contactLocator.paginationDropDownOption)
    * delay(5000)
    * optionOnPagin[0].click()
    * delay(2000)
    * def expiredContactList = locateAll(expiredContactLocator.expiredContactList)
    * match karate.sizeOf(expiredContactList) == 5
   
   
  #REV2-22288
	Scenario: Verify visibility of three dots button and options present in it for Super Admin
    
    * click(contactLocator.contactInfoTab)
  	* delay(1000)
  	* click(expiredContactLocator.expiredContactButton)
		* delay(1000)
    * karate.log('***view icon on three dots****')
    * delay(5000)
    * def contactInfoColumnList = scriptAll(expiredContactLocator.contactInfoColumn, '_.textContent')
		* def threeDotsExists = exists(expiredContactLocator.threeDots)
    * if (threeDotsExists) karate.log("Three Dots are visible and present")
    * click(expiredContactLocator.threeDots)
    * delay(2000)
    * def options = scriptAll(expiredContactLocator.optionsOnThreeDots, '_.textContent')
    * match options[0] contains 'VIEW'
    * delay(2000)
 
   	
	Scenario: Verify functionality of Add Filter and Contact Info button on Expired Contact Page for Super Admin
  
   	* click(contactLocator.contactInfoTab)
  	* delay(1000)
  	* click(expiredContactLocator.expiredContactButton)
		* delay(1000)
    * karate.log('***add filter on expired contact page****')
    * click(expiredContactLocator.addFilterButton)
    * delay(1000)
    * click(expiredContactLocator.contactPurposeOnFilter)
   	* delay(1000)
   	* mouse().move(expiredContactLocator.contactPurposeSelectBox).click()
   	* delay(3000)
   	* def contactPurposeDropDown = locateAll(expiredContactLocator.contactPurposeDropDown)
   	* delay(3000)
   	* print 'contactPurposeDropDown : ' ,contactPurposeDropDown
   	* delay(1000)
   	* contactPurposeDropDown[2].click()
   	* delay(1000)
   	* click(expiredContactLocator.addFilterButton)
    * delay(4000)
    * click(expiredContactLocator.contactTypeOnFilter)
   	* delay(3000)
   	* mouse().move(expiredContactLocator.contactTypeSelectBox).click()
   	* delay(3000)
   	* def contactTypeDropDown = locateAll(expiredContactLocator.contactTypeDropDown)
   	* delay(3000)
   	* print 'contactTypeDropDown : ' ,contactTypeDropDown
   	* delay(1000)
   	* contactTypeDropDown[1].click()
   	* delay(3000)
   	* def expContactTypeList = scriptAll(expiredContactLocator.expiredContactTypeList, '_.textContent')
   	* print 'expContactTypeList : ' ,expContactTypeList
  	* match each expContactTypeList contains 'Postal Address'
    * def expContactPurposeList = scriptAll(expiredContactLocator.expiredContactPurposeList, '_.textContent')
   	* print 'expContactPurposeList : ' , expContactPurposeList
  	* match each expContactPurposeList contains 'Sender Address'
    * delay(2000)
    * def removeFilters = locateAll(expiredContactLocator.removeFilter)
    * delay(3000)
    * karate.sizeOf(removeFilters) == 2
    * delay(3000)
    * highlight(expiredContactLocator.removeFilter)
    * delay(3000)
    * removeFilters[1].click()
    * delay(3000)
    * highlight(expiredContactLocator.removeFilter)
    * delay(3000)
    * delay(3000)
    * removeFilters[0].click()
    * delay(5000)
    * karate.log("******Contact Info Button*********")
    * match enabled(expiredContactLocator.contactInfoButton) == true
    * delay(1000)
    * click(expiredContactLocator.contactInfoButton)
    * delay(2000)
    * match driver.url contains '/show/contact-info'
    * delay(2000)
 
     
	#REV2-22293
	Scenario: Verify functionality of the Back button for Super Admin
	
		* click(contactLocator.contactInfoTab)
  	* delay(1000)
  	* click(expiredContactLocator.expiredContactButton)
		* delay(1000)
    * karate.log('***Back button on expired contact page****')
		* click(expiredContactLocator.threeDots)
		* def options = scriptAll(expiredContactLocator.optionsOnThreeDots, '_.textContent')
    * match options[0] contains 'VIEW'
    * delay(2000)
		* def veiwOptionsList = locateAll(expiredContactLocator.viewOptions)
   	* delay(3000)
   	* veiwOptionsList[0].click()
		* delay(10000)
    * click(expiredContactLocator.backButton)
    * delay(2000)
    * match driver.url contains 'expired-contacts'
    * delay(1000)
    * match text(expiredContactLocator.expiredContactLabel) == expiredContactConstant.expiredContactLabelTxt
    * delay(1000)
    
  
  #REV2-22280
	Scenario: Verify whether Super Admin can view the list of contact information
    
    * click(contactLocator.contactInfoTab)
  	* delay(1000)
    * def listOfContactsInfo = scriptAll(expiredContactLocator.listOfContactInfo, '_.textContent')
    * delay(3000)
    * def listExists = exists(expiredContactLocator.listOfContactInfo)
    * delay(3000)
    * if (listExists) karate.log("list of contact information is present")
    * delay(3000)
    * assert karate.sizeOf(listOfContactsInfo) > 0
    * delay(3000)
    
    