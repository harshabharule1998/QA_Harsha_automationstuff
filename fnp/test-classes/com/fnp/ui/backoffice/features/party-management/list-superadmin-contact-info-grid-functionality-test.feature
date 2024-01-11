Feature: UI scenarios for List Contact Information with Grid functionality for super admin

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
    And input(loginLocator.usernameTextArea, usersValue.users.superAdmin.email)
    * delay(10)
    And input(loginLocator.passwordTextArea, usersValue.users.superAdmin.password)
    * delay(10)
    
    When click(loginLocator.loginButton)
    * karate.log('***Logging into the application****')
    * delay(10)
    And click(dashBoardLocator.switchMenu)
    * delay(10)
    And click(dashBoardLocator.partyMenu)
    * delay(1020)
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
    
    * input(contactLocator.typePartyId,contactConstant.lablePartyIdText)
    * delay(1000)
    * click(contactLocator.clickOnApply)
    * delay(1000)
    * click(contactLocator.clickOnPartyId)
    * delay(100)
		
    
	#REV2-22250
	Scenario: Verify the Label after the super admin access user select the party in which user wants to view list of contact information.
	  
	  * click(contactLocator.contactInfoTab)
    * delay(100)
    * match text(contactLocator.lableOfPartyId) == contactConstant.lablePartyIdText
    * delay(5000)
    
    
	#REV2-22251
  Scenario: Verify whether Contact Information tab is present or not for super admin access user.  
   	 
    * def navBarTab = scriptAll(contactLocator.navBarTab, '_.textContent')
    * print ' navBar tabs---' , navBarTab
    * delay(100)
    
    * match karate.sizeOf(navBarTab) == 5
   	* match navBarTab[0] == contactConstant.personalInfoTabText
    * match navBarTab[1] == contactConstant.usernamesTabText
    * match navBarTab[2] == contactConstant.contactInfoTabText
    * match navBarTab[3] == contactConstant.relationshipTabText
    * match navBarTab[4] == contactConstant.rolesTabText  
    * delay(5000)
   
   
  #REV2-22252 and REV2-22253
  Scenario: Verify whether list of Contact Information is displaying or not for super admin access user
  
    * click(contactLocator.contactInfoTab)
    * delay(100)
   
    * def columnNameOnGrid = scriptAll(contactLocator.contactInfoColList, '_.textContent')
    * delay(300)
    * print "contact information column list..." , columnNameOnGrid    
    * delay(3000)
 		
   
  #REV2-22256
  Scenario: Verify the various functionalities for super admin access user
      
    * click(contactLocator.contactInfoTab)
    * delay(100)
  
    * def columnNameOnGrid = scriptAll(contactLocator.columnNameOnGrid, '_.textContent')
    * delay(300)
    
    * click(contactLocator.dots)
    * delay(100)
    * def optionOnThreeDots = scriptAll(contactLocator.optionOnThreeDots, '_.textContent')
    * delay(100)
    * print 'option On Three Dots---', optionOnThreeDots   
    * delay(100)
    
    * match enabled(contactLocator.newContactButton) == true
    * delay(3000)
     
 
  #REV2-22257   
  Scenario: Verify pagination and page per records at the bottom of the Contact Information list for super admin access user.
  	  
    * karate.log('***list pagination detail on  contact information list****')
  	
  	* click(contactLocator.contactInfoTab)    
    * delay(1000)
    
    * scroll(contactLocator.paginationOnList)
    * delay(100)
    * def paginationTxt = scriptAll(contactLocator.paginationTxtOnList, '_.textContent')
    * print 'Pagination txt', paginationTxt
    * match paginationTxt[0] contains 'Rows per page'
    * delay(1000)
    * mouse().move(contactLocator.paginationDropdownTxt).click()
    * delay(3000)
    
    * def dropDownPrint = scriptAll(contactLocator.paginationDropDownOption, '_.textContent')
    * print 'dropDown---', dropDownPrint
    * match dropDownPrint[0] == '5'
    * match dropDownPrint[1] == '10'
    * match dropDownPrint[2] == '25'
    * match dropDownPrint[3] == '50'
    * def optionOnPagin = locateAll(contactLocator.paginationDropDownOption)
    * delay(5000)
    * optionOnPagin[0].click()
    * delay(2000)
     
     
	#REV2-22258 and REV2-22259
  Scenario: Verify the visibility of the grid button and its options present in drop-down for super admin access user.  
      
    * karate.log('***List the option on checkbox after click on grid button****')
    
    * click(contactLocator.contactInfoTab)
    * delay(100)
   
    * match enabled(contactLocator.gridOnPage) == true
    * click(contactLocator.gridOnPage)
    * match text(contactLocator.titleOnGrid) == contactConstant.titleOnGridTxt
    * delay(400)
    * def columnNameOnGrid = scriptAll(contactLocator.columnNameOnGrid, '_.textContent')
    * delay(300)
    * print "checkBoxList..." , columnNameOnGrid
    * match  columnNameOnGrid[0] == contactConstant.contactTypeText
    * match  columnNameOnGrid[1] == contactConstant.contactPurposeColText
    * match  columnNameOnGrid[2] == contactConstant.contactInfoColText
    * match  columnNameOnGrid[3] == contactConstant.statusColText
    * match  columnNameOnGrid[4] == contactConstant.createdByColText
    * match  columnNameOnGrid[5] == contactConstant.createdDateColText
    * match  columnNameOnGrid[6] == contactConstant.modifiedByColText
    * match  columnNameOnGrid[7] == contactConstant.modifiedDateColText
    * delay(100)
    * def chkBox = locateAll(contactLocator.columnNameOnGrid)
    * print 'all chkboxes', chkBox
    * delay(4000)
    * chkBox[1].click()
    * delay(100)
    * click(contactLocator.closeButtonOnPopup)
    * delay(4000)
    * def columnNameOnGrid = scriptAll(contactLocator.historyPageColumnName, '_.textContent')
    * delay(4000)
    * match  columnNameOnGrid[1] != contactConstant.contactPurposeColText 
    * delay(100)
    
   
  #REV2-22260
  Scenario: Verify that the super admin access user can sort the list by the Contact Type.
     
     * karate.log('*** Sort Contact Type list in ascending order ****')
     
    * def ArrayList = Java.type('java.util.ArrayList')
		* def Collections = Java.type('java.util.Collections')
		
		* def contactTypeSortedList = new ArrayList()
		* def contactTypeListLables = new ArrayList()
    
    * click(contactLocator.contactInfoTab)
    * delay(1000)
   
    * def contactTypeList = scriptAll(contactLocator.contactTypeList, '_.textContent')
   		 
		* karate.repeat(contactTypeList.length, function(i){ contactTypeListLables.add(contactTypeList[i]) })
		* karate.log('contactTypeListLables  before sort : ', contactTypeListLables)
		
    * Collections.sort(contactTypeListLables)
    * karate.log('contactTypeListLables  after sort : ', contactTypeListLables)
         
    * click(contactLocator.ContactTypeSortingIndex) 
    * delay(1000)    
    
    * def contactTypeList = scriptAll(contactLocator.contactTypeList, '_.textContent')
    
    * karate.repeat(contactTypeList.length, function(i){ contactTypeSortedList.add(contactTypeList[i]) })
		* karate.log('contactTypeSortedList  after sort : ', contactTypeSortedList)
		    
    * match contactTypeListLables == contactTypeSortedList
    * delay(1000)     
    
    
  #REV2-22261
 	Scenario: Verify that the super admin access user can sort the list by the Contact Purpose.
    
    * karate.log('*** Sort Contact Purpose list in ascending order ****')
    
    * def ArrayList = Java.type('java.util.ArrayList')
		* def Collections = Java.type('java.util.Collections')
		
		* def contactPurposeSortedList = new ArrayList()
		* def contactPurposeListLables = new ArrayList()
    
    * click(contactLocator.contactInfoTab)
    * delay(1000)
   
    * def contactPurposeList = scriptAll(contactLocator.contactPurposeList, '_.textContent')
   		 
		* karate.repeat(contactPurposeList.length, function(i){ contactPurposeListLables.add(contactPurposeList[i]) })
		* karate.log('contactPurposeListLables  before sort : ', contactPurposeListLables)
		* delay(100)
		
    * Collections.sort(contactPurposeListLables)
    * karate.log('contactPurposeListLables  after sort : ', contactPurposeListLables)
    * delay(100)     
    * click(contactLocator.ContactPurposeSortingIndex) 
    * delay(1000)    
    
    * def contactPurposeList = scriptAll(contactLocator.contactPurposeList, '_.textContent')
    
    * karate.repeat(contactPurposeList.length, function(i){ contactPurposeSortedList.add(contactPurposeList[i]) })
		* karate.log('contactPurposeSortedList  after sort : ', contactPurposeSortedList)
		    
    * match contactPurposeListLables == contactPurposeSortedList
    * delay(1000)          
     
    
 
   
    
  
  
    
    
    
    
    
    
    