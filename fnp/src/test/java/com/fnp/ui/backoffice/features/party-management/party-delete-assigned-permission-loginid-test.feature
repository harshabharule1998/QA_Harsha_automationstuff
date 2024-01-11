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
  
		* karate.log('***Usernames tab will get open by default****') 
    And match enabled(usernameLocator.usernamesLabel) == true
		* match usernameLocator.usernamesLabel == "#present"  
		* karate.log('***Verify label on username tab****') 
		* match text(usernameLocator.usernamesLabel) == usernameConstant.usernamesTabText  				
 		* delay(1000) 
	  * click(usernameLocator.usernamesLabel)
	  * delay(1000) 
	 
  
	#REV2-25069
	Scenario: Verify Username tab is present on the dashboard navigation bar for back office users with superadmin permission.
		
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
	  And match enabled(usernameLocator.deleteButton) == true
		* match usernameLocator.deleteButton == "#present"  
		* delay(1000)
		* def deleteButtonExist = exists(usernameLocator.deleteButton)
    * if (deleteButtonExist) karate.log("deleteButton is present")  
    * delay(1000) 
    And match enabled(usernameLocator.gridButton) == true
	  * def deleteButtonOpt = scriptAll(usernameLocator.deleteButton, '_.textContent')
	  * print 'deleteButtonOpt...',deleteButtonOpt   
	  * highlight(usernameLocator.deleteButton)
		* delay(1000)
	  * click(usernameLocator.deleteButton)
	  * delay(1000)  
	  * def deleteButtonPopupWindow = scriptAll(usernameLocator.deleteButtonPopupWindow, '_.textContent')
	  * print 'deleteButtonPopupWindow...',deleteButtonPopupWindow 
  	* delay(1000)   
	  * def deleteIconExist = exists(usernameLocator.deleteIcon)
    * if (deleteIconExist) karate.log("deleteIcon is present")  
    * delay(1000) 
    * match text(usernameLocator.deleteButtonPopupMsg) == usernameConstant.deleteButtonPopupMsgTxt  				
    * match text(usernameLocator.cancelButton) == usernameConstant.cencelButtonTxt  				
    * delay(1000) 
    * match text(usernameLocator.deleteButtonOnPopup) == usernameConstant.deleteButtonTxt  	
    * delay(1000)  	
		* match usernameLocator.deleteButtonOnPopup == "#present"  
		* delay(1000)
		* def crossIconOnPopupExist = exists(usernameLocator.crossIconOnPopup)
    * if (crossIconOnPopupExist) karate.log("crossIconOnPopup is present")  
    * delay(1000)   
    * highlight(usernameLocator.crossIconOnPopup)		
 	  * mouse().move(usernameLocator.crossIconOnPopup).click()     
  	* delay(3000)  
 	  * waitForUrl("/permissions") 	  
	  * delay(10000)
	  
	 
	#REV2-20720
	Scenario: Verify the functionality of pagination page per records for back office users with superadmin permission.
	
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
    * delay(20000)
	
		 
	#REV2-20719
	Scenario: Verify Grid icon is present or not in the listing page of the assigned Permissions to the login id of the respective
	party user for back office users with superadmin permission.
	
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
	  * highlight(usernameLocator.gridIconButton)
	  * click(usernameLocator.gridIconButton)
	  * match text(usernameLocator.titleOnGrid) == usernameConstant.titleOnGridTxt
    * delay(1000)
    * def columnNameOnGrid = scriptAll(usernameLocator.columnNameOnGrid, '_.textContent')
    * print "checkBoxList..." , columnNameOnGrid
    * delay(1000)  
    * match columnNameOnGrid[0] == usernameConstant.permissionNameTxt  
    * print 'columnNameOnGrid[0]',columnNameOnGrid[0]
    * click(usernameLocator.closeButtonOnPopup)
    * delay(4000)
	  * delay(20000)	 
	  
  
	#REV2-20718
  Scenario: Verify what happens if the user click on "CANCEL" button present on the pop-up window message for
  back office users with superadmin permission.
 		
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
	  * click(usernameLocator.deleteButton)
	  * delay(3000)  
	  * def deleteButtonPopupWindow = scriptAll(usernameLocator.deleteButtonPopupWindow, '_.textContent')
	  * print 'deleteButtonPopupWindow...',deleteButtonPopupWindow 
  	* delay(1000) 
  	* highlight(usernameLocator.cancelButton)
  	* delay(3000)
	  * click(usernameLocator.cancelButton)
	  * delay(1000) 
	  * waitForUrl("/permissions") 	  
	  * delay(10000)
	  
	
	#REV2-20717  
	Scenario:  Verify what happens if the user click on "DELETE" button present on the pop-up window message for
	 back office users with superadmin permission. 
	
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
	  * click(usernameLocator.deleteButton)
	  * delay(3000)  
	  * click("[data-at-id='actionButton'] span")
    * highlight(usernameLocator.permissionDeletePopup)
  	* match text(usernameLocator.permissionDeletePopup) contains usernameConstant.deleteSuccessMsgTxt	
	 	* delay(10000) 
	  
	  
	Scenario:	 Verify the sorting functionality of user loginId with superadmin access.
	
 		* scroll(usernameLocator.paginationOnList)
    * delay(1000)
    * mouse().move(usernameLocator.paginationDropdownTxt).click()
    * delay(1000) 
    * def optionOnPagin = locateAll(usernameLocator.paginationDropDownOption)
    * delay(1000)
    * optionOnPagin[3].click()
    * delay(2000)
    * karate.log('*** Sort loginId list in decending order ****')  
    * def ArrayList = Java.type('java.util.ArrayList')
		* def Collections = Java.type('java.util.Collections')
		* def loginIdListLables = new ArrayList()
		* def loginIdSortedList = new ArrayList()
    * def userLoginIdList = scriptAll(usernameLocator.userLoginIdList, '_.textContent')   		 
		* karate.repeat(userLoginIdList.length, function(i){ loginIdListLables.add(userLoginIdList[i]) })
		* karate.log('LoginIdListLables  before sort : ', loginIdListLables)
		* delay(1000)
    * Collections.sort(loginIdListLables,Collections.reverseOrder())
    * karate.log('LoginIdListLables  after sort : ', loginIdListLables)
    * delay(5000)     
    * highlight(usernameLocator.usrLoginIdSortArrow)
  	* delay(3000) 
    * mouse().move(usernameLocator.usrLoginIdSortArrow).click()
    * delay(5000)      
    * def userLoginIdList = scriptAll(usernameLocator.userLoginIdList, '_.textContent')    
    * karate.repeat(userLoginIdList.length, function(i){ loginIdSortedList.add(userLoginIdList[i]) })
		* karate.log('loginIdSortedList  after sort : ', loginIdSortedList)
	  * delay(5000) 
	