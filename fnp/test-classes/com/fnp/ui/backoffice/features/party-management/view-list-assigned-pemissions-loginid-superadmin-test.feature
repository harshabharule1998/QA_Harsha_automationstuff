Feature: View and listing of the assigned Permissions to the Login id of respective Party User for superadmin

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
    And click(dashBoardLocator.partyMenu)
    * delay(1000)
		* mouse().move(usernameLocator.partyTypeDropdownTxt).click()

    * delay(1000)
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
    
   
	#REV2-20170/REV2-20171/REV2-20172/REV2-20173/REV2-20174/REV2-20175/REV2-20176//REV2-20178/REV2-20179
	Scenario: Verify Username tab is present on the dashboard navigation bar for back office users
	 with superadmin permission.
	
		* karate.log('***Usernames tab will get open by default****') 
    And match enabled(usernameLocator.usernamesLabel) == true
		* match usernameLocator.usernamesLabel == "#present"  
		* karate.log('***Verify label on username tab****') 
		* match text(usernameLocator.usernamesLabel) == usernameConstant.usernamesTabText  				
 		* delay(1000) 
	  * click(usernameLocator.usernamesLabel)
	  * delay(1000) 
		* karate.log('***Verify label on userLoginIdLable column****')   
		* match text(usernameLocator.userLoginIdLable) == usernameConstant.userLoginIdLabelTxt  
		* karate.log('***List all userLoginId on column ****')   
    * def userLoginIdList = scriptAll(usernameLocator.userLoginIdList, '_.textContent')
    * print 'userLoginIdList--', userLoginIdList
	  * delay(2000)  				
		* karate.log("***List status of all userLoginId's active or inactive ****")   
		* match text(usernameLocator.status) == usernameConstant.statusTxt  		
    * def statusList = scriptAll(usernameLocator.statusList, '_.textContent')
    * print 'statusList--', statusList
	  * delay(2000)		
	  * karate.log("***Verify usernametab page Url ****")    		
	  * delay(1000) 
	  * waitForUrl('/show/usernames')	
	  * delay(2000) 
	  * karate.log("***List all threeDots on username page for all userloginId ****")    		
    * def threeDots = scriptAll(usernameLocator.usernameThreeDots, '_.textContent')
    * print 'threeDots--', threeDots
	  * delay(2000)
	  * scroll(usernameLocator.paginationOnList)
    * delay(1000)
    * mouse().move(usernameLocator.paginationDropdownTxt).click()
    * delay(1000) 
    * def optionOnPagin = locateAll(usernameLocator.paginationDropDownOption)
    * delay(1000)
    * optionOnPagin[3].click()
    * delay(2000)
 	  * karate.log("***Click on permissions option from dropdown ****")    		
	  * mouse().move(usernameLocator.usrnmThreeDotLast).click()
	  * delay(1000)  
	  * def dropdownTxt = scriptAll(usernameLocator.usrnmDropdwnlast, '_.textContent')
    * print 'Dropdown...', dropdownTxt   
	  * click(usernameLocator.usrnmDropdwnlastOption)
	  * delay(3000)	 
    * def permissionsList = scriptAll(usernameLocator.permissionsList, '_.textContent')
    * print 'permissionsList--', permissionsList
    * delay(1000)
    * karate.log("***Match the label on permissions page****")    		
    * match text(usernameLocator.permissionsLabel) == usernameConstant.permissionsLabelTxt  	
    * delay(1000)  			
    * karate.log("***Match the Url on permissions page****")    		
    * waitForUrl("/permissions")	 
    * delay(1000)  			
    * karate.log("***Match the Label on permissionsName column****")    		
    * match text(usernameLocator.permissionNameField) == usernameConstant.permissionNameTxt  	  
    * delay(1000)  			
    * karate.log("***Match the Label on Assign User Login button & verify its present and enable****")    		
    And match enabled(usernameLocator.assignUserLogin) == true
    * delay(1000)  		 
		* match usernameLocator.assignUserLogin == "#present"
    * delay(1000)  			
	  * match text(usernameLocator.assignUserLogin) == usernameConstant.assignUserLogin
    * delay(2000)
 	  * karate.log("***List all threeDots on Permissions page for all Permission Name ****")    		
    * def threeDotsPermissionNm = scriptAll(usernameLocator.usernameThreeDots, '_.textContent')
    * print 'threeDotsPermissionNm--', threeDotsPermissionNm
	  * delay(2000)
	  * def threeDotsPermissionNm = locateAll(usernameLocator.usernameThreeDots)
	  * mouse().move(threeDotsPermissionNm[0]).click()
	  * delay(2000)  
    * def permissionNmDropdown = scriptAll(usernameLocator.usrnmDropdown, '_.textContent')
    * print 'permissionNmDropdown--', permissionNmDropdown 
    * delay(20000)
    
 
	#REV2-20177
	Scenario: Verify the functionality of "Assign User Login" button for back office users with
	 superadmin permission.
		
		* karate.log("***Verify the functionality of 'Assign User Login' button'****")    		
		* click(usernameLocator.usernamesLabel)
	  * delay(2000)
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
	  * click(usernameLocator.usrnmDropdwnlastOption)
	  * delay(3000)	 
	  * karate.log("***Click on assign user login button ****")    		
	  * click(usernameLocator.assignUserLogin)
		* delay(2000)   
    * karate.log("***Match the Url on assign user login page****")    			
	  * waitForUrl("/create")
	  * delay(2000)    
	  
	
	#REV2-20180
  Scenario: Verify Grid icon is present or not in the listing page of the assigned Permissions to the 
  login id of the respective party/user for back office users with superadmin permission
 		    
 		* karate.log('*** Verify Grid icon is present  ****')
 		* click(usernameLocator.usernamesLabel)
 	  * delay(3000)	
    * def threeDotsUsrnm = locateAll(usernameLocator.usernameThreeDots)
	  * mouse().move(threeDotsUsrnm[3]).click()
	  * delay(1000)
		* def gridIconExists = exists(usernameLocator.gridButton)
    * if (gridIconExists) karate.log("gridIconExists is present")  
    And match enabled(usernameLocator.gridButton) == true
	  * match usernameLocator.gridButton == "#present" 
 	  * delay(2000)    
    * match enabled(usernameLocator.gridOnPage) == true
    * click(usernameLocator.gridOnPage)
    * match text(usernameLocator.titleOnGrid) == usernameConstant.titleOnGridTxt
    * delay(1000)
    * def columnNameOnGrid = scriptAll(usernameLocator.columnNameOnGrid, '_.textContent')
    * delay(1000)
    * print "checkBoxList..." , columnNameOnGrid
    * match  columnNameOnGrid[0] == usernameConstant.userLoginId
    * match  columnNameOnGrid[1] == usernameConstant.status
    * delay(1000)
    * def chkBox = locateAll(usernameLocator.columnNameOnGrid)
    * print 'all chkboxes', chkBox
    * delay(4000)
    * chkBox[1].click()
    * delay(100)
    * click(usernameLocator.closeButtonOnPopup)
    * delay(4000)
    * def columnNameOnGrid = scriptAll(usernameLocator.historyPageColumnName, '_.textContent')
    * delay(4000)
    
  
	#REV2-20182
  Scenario: Verify the sorting functionality of the field "Permissions Name" for back office users with superadmin permission.

    * karate.log('*** Sort permission Name list in ascending order ****')
    * def ArrayList = Java.type('java.util.ArrayList')
		* def Collections = Java.type('java.util.Collections')     
		* def permissionNameSortedList = new ArrayList()
		* def permissionNameListLables = new ArrayList()
    * click(usernameLocator.usernamesLabel)
	  * delay(2000)
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
	  * click(usernameLocator.usrnmDropdwnlastOption)
	  * delay(3000)	 
    * def permissionNameList = scriptAll(usernameLocator.permissionsList, '_.textContent')	 
		* karate.repeat(permissionNameList.length, function(i){ permissionNameListLables.add(permissionNameList[i]) })
		* karate.log('permissionNameListLables  before sort : ', permissionNameListLables)
		* delay(3000) 	
	  * delay(1000) 	
    * Collections.sort(permissionNameListLables, Collections.reverseOrder())
    * delay(1000)
    * karate.log('permissionNameListLables  after sort : ', permissionNameListLables)
   	* delay(3000) 	        
    * mouse().move(usernameLocator.sortingArrow).click()
    * delay(1000)    
    * def permissionNameList = scriptAll(usernameLocator.permissionsList, '_.textContent')
    * karate.repeat(permissionNameList.length, function(i){ permissionNameSortedList.add(permissionNameList[i]) })
		* karate.log('permissionNameSortedList  after sort : ', permissionNameSortedList)   
	  * delay(3000) 	
    * match permissionNameListLables == permissionNameSortedList
    * delay(10000) 
    

	#REV2-20181
	Scenario: Verify the functionality of pagination page per records for back office users with superadmin permission. 
  
  	* karate.log('***list pagination detail on  contact information list****')
  	* click(usernameLocator.usernamesLabel)    
    * delay(1000)
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
	  * click(usernameLocator.usrnmDropdwnlastOption)
	  * delay(3000)	 
    * scroll(usernameLocator.paginationOnList)
    * delay(100)
    * def paginationTxt = scriptAll(usernameLocator.paginationTxtOnList, '_.textContent')
    * print 'Pagination txt', paginationTxt
    * match paginationTxt[0] contains 'Rows per page'
    * delay(1000)
    * mouse().move(usernameLocator.paginationDropdownTxt).click()
    * delay(3000)  
    * def dropDownPrint = scriptAll(usernameLocator.paginationDropDownOption, '_.textContent')
    * print 'dropDown---', dropDownPrint
    * match dropDownPrint[0] == '5'
    * match dropDownPrint[1] == '10'
    * match dropDownPrint[2] == '25'
    * match dropDownPrint[3] == '50'
    * def optionOnPagin = locateAll(usernameLocator.paginationDropDownOption)
    * delay(5000)
    * optionOnPagin[0].click()
    * delay(2000)
 
  
  
  
  
  
  
  
  
  
  
  