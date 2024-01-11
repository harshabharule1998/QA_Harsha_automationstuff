Feature: Assigned Security Group Listing Page UI scenarios for Super Admin

  Background: 
    * def loginLocator = read('../../data/loginPage_locator.json')
    * def usersValue = read('../../data/users.json')
    * def dashBoardLocator = read('../../data//dashboard_locators.json')
    * def securityGroupLocator = read('../../data/party/securityGroupPage_locators.json')
    * def securityGroupConstant = read('../../data/party/securityGroupPage_constants.json')
    
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
		* mouse().move(securityGroupLocator.partyTypeDropdownTxt).click()

    * delay(1000)
    * def dropdownTxt = scriptAll(securityGroupLocator.partyTypeDropdownMenu, '_.textContent')
    * print 'Dropdown', dropdownTxt
    * delay(1000)
    * match dropdownTxt[0] contains 'Individual'
    * match dropdownTxt[1] contains 'Organization'
    * delay(1000)
    
    * def optionOnDropDown = locateAll(securityGroupLocator.partyTypeDropdownMenu)
    * delay(1000)
    * match karate.sizeOf(optionOnDropDown) == 2
    * optionOnDropDown[0].click()
    * delay(1000) 
    
    * input(securityGroupLocator.typePartyId,securityGroupConstant.lablePartyIdText)
    * delay(1000)
    * click(securityGroupLocator.clickOnApply)
    * delay(1000)
    * click(securityGroupLocator.clickOnPartyId)
    * delay(1000)
    
  
  #REV2-19586
  Scenario: Verify 'Usernames' tab present inside the party dashboard.
  
  	* click(securityGroupLocator.usernamesTab)
    * delay(1000)
    * match text(securityGroupLocator.usernamesTabLabel) == securityGroupConstant.usernamesTabText
    * delay(3000)
  
    
  #REV2-19587
  Scenario: Verify Usernames List when back office user clicks on 'Usernames' tab.
  
  	* click(securityGroupLocator.usernamesTab)
    * delay(1000)
    * def columnNameOnList = scriptAll(securityGroupLocator.usernamesColumnList, '_.textContent')
    * delay(2000)
    * print "usernames column list..." , columnNameOnList    
    * delay(2000)
    
  
  #REV2-19588
  Scenario: Verify the Label after the back office user select the party in which user wants to view assign security group list.
  
  	* click(securityGroupLocator.usernamesTab)
    * delay(1000)
    * match text(securityGroupLocator.partyIdLabel) == securityGroupConstant.partyIdLabelText
    * delay(3000)
    
  
  #REV2-19589
  Scenario: Verify three dots button present along each User Login ID and its options.
  
  	* click(securityGroupLocator.usernamesTab)
    * delay(1000)
    * match enabled(securityGroupLocator.threeDots) == true
    * delay(1000)
    * click(securityGroupLocator.threeDots)
    * def optionOnThreeDots = scriptAll(securityGroupLocator.optionOnThreeDots, '_.textContent')
    * delay(1000)
    * print '---option On Three Dots---', optionOnThreeDots   
    * match optionOnThreeDots[0] contains securityGroupConstant.editText
    * match optionOnThreeDots[1] contains securityGroupConstant.assignSecurityGroupText
    * match optionOnThreeDots[2] contains securityGroupConstant.permissionsText
    * delay(3000)
  
  
  #REV2-19590/REV2-19591
  Scenario: Verify the list of assigned security group and columns present in the list.
  
  	* click(securityGroupLocator.usernamesTab)
    * delay(1000)
    * click(securityGroupLocator.threeDots)
    * delay(1000)
    * click(securityGroupLocator.assignSecGrpOption)
    * delay(1000)
    * def columnNameOnList = scriptAll(securityGroupLocator.secGrpColumnList, '_.textContent')
    * delay(2000)
    * print "security group column list..." , columnNameOnList    
    * delay(2000)
    
  
  #REV2-19593
  Scenario: Verify the Label after the back office user views the list of assigned security group.
  
  	* click(securityGroupLocator.usernamesTab)
    * delay(1000)
    * click(securityGroupLocator.threeDots)
    * delay(1000)
    * click(securityGroupLocator.assignSecGrpOption)
    * delay(1000)
  	* match text(securityGroupLocator.assignSecGrpLabel) == securityGroupConstant.assignSecGrpLabelText
    * delay(3000)
  
  
  #REV2-19595
  Scenario: Verify the various functionalities for back office user with super admin access.
  
  	* click(securityGroupLocator.usernamesTab)
    * delay(1000)
    * click(securityGroupLocator.threeDots)
    * delay(1000)
    * click(securityGroupLocator.assignSecGrpOption)
    * delay(1000)
    * click(securityGroupLocator.secGrpThreeDots)
    * delay(1000)
    * def secGrpThreeDotsOptions = scriptAll(securityGroupLocator.secGrpThreeDotsOptions, '_.textContent')
    * delay(1000)
    * print '---option On security group Three Dots---', secGrpThreeDotsOptions  
    * match secGrpThreeDotsOptions[0] contains securityGroupConstant.deleteText
    
  
  #REV2-19596
  Scenario: Verify that the back office user can sort the list by the 'Security Group ID'.
  
  	* click(securityGroupLocator.usernamesTab)
    * delay(1000)
    * click(securityGroupLocator.threeDots)
    * delay(1000)
    * click(securityGroupLocator.assignSecGrpOption)
    * delay(1000)
    
    * def secGrpIdsBeforeSort = scriptAll(securityGroupLocator.securityGroupIdList, '_.textContent')
    * delay(1000)
    * karate.log('Before Sort security group IDs : ', secGrpIdsBeforeSort)
    * karate.log('*** Sort by security group Id ****')
    * click(securityGroupLocator.secGrpIdSortHeader)
		* delay(1000)
		* def secGrpIdsAfterSort = scriptAll(securityGroupLocator.securityGroupIdList, '_.textContent')
    * delay(1000)
		* karate.log('After Sort security group IDs : ', secGrpIdsAfterSort)
		* match secGrpIdsAfterSort != secGrpIdsBeforeSort
		
	
	#REV2-19597
  Scenario: Verify that the back office user can sort the list by the 'Security Group Name'.
  
  	* click(securityGroupLocator.usernamesTab)
    * delay(1000)
    * click(securityGroupLocator.threeDots)
    * delay(1000)
    * click(securityGroupLocator.assignSecGrpOption)
    * delay(1000)
    
    * def secGrpNamesBeforeSort = scriptAll(securityGroupLocator.securityGroupNameList, '_.textContent')
    * delay(1000)
    * karate.log('Before Sort security group names : ', secGrpNamesBeforeSort)
    * karate.log('*** Sort by security group name ****')
    * click(securityGroupLocator.secGrpNamSortHeader)
		* delay(1000)
		* def secGrpNamesAfterSort = scriptAll(securityGroupLocator.securityGroupNameList, '_.textContent')
    * delay(1000)
		* karate.log('After Sort security group names : ', secGrpNamesAfterSort)
		* match secGrpNamesAfterSort != secGrpNamesBeforeSort
  
  
  #REV2-19598
  Scenario: Verify the visibility of the grid button and its options present in drop-down.
  
  	* click(securityGroupLocator.usernamesTab)
    * delay(1000)
    * click(securityGroupLocator.threeDots)
    * delay(1000)
    * click(securityGroupLocator.assignSecGrpOption)
    * delay(1000)
  
  	* match enabled(securityGroupLocator.gridOnPage) == true
  	* click(securityGroupLocator.gridOnPage)
  	* delay(1000)
  	* def columnNameOnGrid = scriptAll(securityGroupLocator.columnNameOnGrid, '_.textContent')
    * delay(1000)
    * print '---column Name On Grid---', columnNameOnGrid
  	* match  columnNameOnGrid[0] == securityGroupConstant.securityGroupIdText
    * match  columnNameOnGrid[1] == securityGroupConstant.securityGroupNameText
  
  
  #REV2-19599
  Scenario: Verify the functionality of the grid button.
  
  	* click(securityGroupLocator.usernamesTab)
    * delay(1000)
    * click(securityGroupLocator.threeDots)
    * delay(1000)
    * click(securityGroupLocator.assignSecGrpOption)
    * delay(1000)
  
  	* click(securityGroupLocator.gridOnPage)
  	* delay(1000)
  	* def columnNameOnGrid = scriptAll(securityGroupLocator.columnNameOnGrid, '_.textContent')
    * delay(1000)
    * print '---column Name On Grid---', columnNameOnGrid
  	* def chkBox = locateAll(securityGroupLocator.checkkBoxOnGrid)
    * delay(1000)
    * chkBox[1].click()
    * delay(1000)
    * click(securityGroupLocator.closeButtonOnPopup)
    * delay(1000)
    * def columnNameOnList = scriptAll(securityGroupLocator.secGrpColumnList, '_.textContent')
    * delay(1000)
    * print "security group column list..." , columnNameOnList    
    * delay(1000)
    * match  columnNameOnGrid[1] != securityGroupLocator.secGrpColumnList
  
  
  #REV2-19600
  Scenario: Verify pagination and page per records at the bottom of the assign security group list.
  
  	* click(securityGroupLocator.usernamesTab)
    * delay(1000)
    * click(securityGroupLocator.threeDots)
    * delay(1000)
    * click(securityGroupLocator.assignSecGrpOption)
    * delay(1000)
    
    * scroll(securityGroupLocator.paginationOnList)
    * delay(2000)
  	* karate.log('*** Set rows per page count to 5 ****')
    * def paginationTxt = scriptAll(securityGroupLocator.paginationTxtOnList, '_.textContent')
    * print 'Pagination txt', paginationTxt
    * match paginationTxt[0] contains 'Rows per page'
    * delay(1000)
  	* mouse().move(securityGroupLocator.paginationDropdown).click()
    * delay(2000)
    * def optionOnPagination = scriptAll(securityGroupLocator.paginationDropDownOption, '_.textContent')
    * print 'Pagination Options', optionOnPagination
    * def optionOnPagin = locateAll(securityGroupLocator.paginationDropDownOption)
    * delay(2000)
    * optionOnPagin[0].click()
    * delay(2000)
  	* def securityGroupIds = scriptAll(securityGroupLocator.secGrpListAfterSort, '_.textContent')
    * delay(1000)
    * karate.log('security group IDs after pagination : ', securityGroupIds)
    * delay(1000)
    * match karate.sizeOf(securityGroupIds) == 5
    * delay(2000)
  
  
  
  