Feature: Listing page Relationship Super Admin User feature

 	Background: 
		* def loginLocator = read('../../data/loginPage_locator.json')
    * def usersValue = read('../../data/users.json')
    * def dashBoardLocator = read('../../data//dashboard_locators.json')
    * def listRelationshipLocators = read('../../data/party/listRelationship_Page_locators.json')
    * def listRelationshipConstants = read('../../data/party/listRelationship_Page_constants.json')
    
    
    * configure driver = driverConfig
    * driver backOfficeUrl
    * print '***backofficeurl***' backOfficeUrl
    And maximize()
    * karate.log('***Logging into the application****')
    And input(loginLocator.usernameTextArea, usersValue.users.superAdmin.email)
    * delay(30)
    And input(loginLocator.passwordTextArea, usersValue.users.superAdmin.password)
    * delay(30)
    When click(loginLocator.loginButton)
    * karate.log('***Logging into the application****')
    * delay(300)
    And click(dashBoardLocator.switchMenu)
    * delay(30)
    And click(dashBoardLocator.partyMenu)
    * delay(400)
    * mouse().move(listRelationshipLocators.partyTypeDropdownTxt).click()
    * delay(200)
    
    * def dropdownTxt = scriptAll(listRelationshipLocators.partyTypeDropdownMenu, '_.textContent')
    * print 'Dropdown', dropdownTxt
    * match dropdownTxt[0] contains 'Individual'
    * match dropdownTxt[1] contains 'Organization'
    * delay(100)
    
    * def optionOnDropDown = locateAll(listRelationshipLocators.partyTypeDropdownMenu)
    * delay(1000)
    * match karate.sizeOf(optionOnDropDown) == 2
    * optionOnDropDown[0].click()
    * delay(1000) 
    
    * input(listRelationshipLocators.typePartyId,listRelationshipConstants.lablePartyIdText)
    * delay(1000)
    * click(listRelationshipLocators.apply)
    * delay(300)
    
    * click(listRelationshipLocators.indiviualPartyId)
    * delay(400)
    
  
	#REV2-22118
	Scenario: Verify relatioship tab and relationship label for Super Admin
    
    * karate.log('***list screen****')
    * match text(listRelationshipLocators.partyLabel) == listRelationshipConstants.lablePartyIdText
    * delay(2000)
    
   
  #REV2-22119
	Scenario: Verify relatioship tab list for Super Admin
    
    * karate.log('***list screen****')
    * match text(listRelationshipLocators.relationshipTab) == listRelationshipConstants.realtionshipTypeText
    * delay(2000)
  
 
  #REV2-22120/22123
	Scenario: Verify relationship tab list for Super Admin 
   
    * karate.log('***list screen****')
    * match text(listRelationshipLocators.relationshipTab) == listRelationshipConstants.realtionshipTypeText
    * delay(2000)
    * click(listRelationshipLocators.relationsTabLink)
    * delay(3000)
    * exists(listRelationshipLocators.inTheRoleOfField)
    * delay(2000)
    * exists(listRelationshipLocators.isAField)
    * delay(2000)
    * exists(listRelationshipLocators.partyIdField)
    * delay(2000)
    * exists(listRelationshipLocators.ofPartyField)
    * delay(2000)
    * exists(listRelationshipLocators.inTheRolesofField)
    * delay(2000)
    * exists(listRelationshipLocators.fromDateField)
    * delay(2000)
    * exists(listRelationshipLocators.toDateField)
    * delay(2000)
    

  #REV2-22121
  Scenario: Verify that the Super admin user can sort the list by the 'Party ID'.
  
  	* karate.log('***list screen****')
    * match text(listRelationshipLocators.relationshipTab) == listRelationshipConstants.realtionshipTypeText
    * delay(2000)
    * click(listRelationshipLocators.relationsTabLink)
    * delay(3000)
    * def idsBeforeSort = scriptAll(listRelationshipLocators.relationGroupIdList, '_.textContent')
    * delay(1000)
    * karate.log('Before Sort relation group IDs : ',idsBeforeSort)
    * karate.log('*** Sort by relation group Id ****')
    * click(listRelationshipLocators.relationgrpIdSortHeader)
		* delay(1000)
		* def idsAfterSort = scriptAll(listRelationshipLocators.relationGroupIdList, '_.textContent')
    * delay(1000)
		* karate.log('After Sort relations group IDs : ', idsAfterSort)
		* match idsAfterSort != idsBeforeSort
    

  #REV2-22122
  Scenario: Verify Super admin user can view newly added relationship displayed at the top of the list.
  
  	* karate.log('***list screen****')
    * match text(listRelationshipLocators.relationshipTab) == listRelationshipConstants.realtionshipTypeText
    * delay(2000)
    * click(listRelationshipLocators.relationsTabLink)
    * delay(3000)
    * click(listRelationshipLocators.newRelationshipTab)
    * delay(3000)
    * mouse().move(listRelationshipLocators.clickOnRole).click()
    * delay(2000)
    * click(listRelationshipLocators.tester)
    * delay(2000)
    * mouse().move(listRelationshipLocators.isA).click()
    * delay(2000)
    * click(listRelationshipLocators.vendor)
    * delay(2000)
    * mouse().move(listRelationshipLocators.fromPartyId).click()
    * delay(2000)
    * input(listRelationshipLocators.fromPartyId, "P_")
		* delay(3000)
		* click(listRelationshipLocators.Id)
    * delay(2000)
    * mouse().move(listRelationshipLocators.clickOnRolePartyOf).click()
    * delay(2000)
    * click(listRelationshipLocators.optionB2C)
    * delay(2000)
		* mouse().move(listRelationshipLocators.date).click()
    * delay(2000)
		* input(listRelationshipLocators.date, "11/18/2021")
		* delay(3000)
		* scroll(listRelationshipLocators.scroll)
    * delay(3000)
    * click(listRelationshipLocators.createButton)
    * delay(3000)
    * click(listRelationshipLocators.confirmationContinueButton)
    * delay(3000)
    * exists(listRelationshipLocators.newRelationshipId)
    * delay(2000)
    
 
  #REV2-22124
	Scenario:  Verify Super admin user can sort relationship list by all fields present. 
   
    * karate.log('***list screen****')
    * match text(listRelationshipLocators.relationshipTab) == listRelationshipConstants.realtionshipTypeText
    * delay(2000)
    * click(listRelationshipLocators.relationsTabLink)
    * delay(3000)
    * click(listRelationshipLocators.inTheRoleOfField)
    * delay(3000)
    * exists(listRelationshipLocators.inTheRoleOfField)
    * delay(2000)
    * exists(listRelationshipLocators.isAField)
    * delay(2000)
    * exists(listRelationshipLocators.partyIdField)
    * delay(2000)
    * exists(listRelationshipLocators.ofPartyField)
    * delay(2000)
    * exists(listRelationshipLocators.inTheRolesofField)
    * delay(2000)
    * exists(listRelationshipLocators.fromDateField)
    * delay(2000)
    * exists(listRelationshipLocators.toDateField)
    * delay(2000)
  
    
  #REV2-22125
  Scenario: Verify pagination and page per records at the bottom of the relationship list.
  
  	* karate.log('***list screen****')
    * match text(listRelationshipLocators.relationshipTab) == listRelationshipConstants.realtionshipTypeText
    * delay(2000)
    * click(listRelationshipLocators.relationsTabLink)
    * delay(3000)  
    * scroll(listRelationshipLocators.paginationOnList)
    * delay(2000)
  	* karate.log('*** Set rows per page count to 5 ****')
    * def paginationTxt = scriptAll(listRelationshipLocators.paginationTxtOnList, '_.textContent')
    * print 'Pagination txt', paginationTxt
    * match paginationTxt[0] contains 'Rows per page'
    * delay(1000)
  	* mouse().move(listRelationshipLocators.paginationDropdown).click()
    * delay(2000)
    * def optionOnPagination = scriptAll(listRelationshipLocators.paginationDropDownOption, '_.textContent')
    * print 'Pagination Options', optionOnPagination
    * def optionOnPagin = locateAll(listRelationshipLocators.paginationDropDownOption)
    * delay(2000)
    * optionOnPagin[0].click()
    * delay(2000)
  	* def GroupIds = scriptAll(listRelationshipLocators.relationGrpListAfterSort, '_.textContent')
    * delay(1000)
    * karate.log('relationship group list after pagination : ', GroupIds)
    * delay(1000)
    * match karate.sizeOf(GroupIds) == 5
    * delay(2000)
  

  #REV2-22126
  Scenario: Verify the visibility of the grid button and its options present in drop-down.
  
  	* karate.log('***list screen****')
    * match text(listRelationshipLocators.relationshipTab) == listRelationshipConstants.realtionshipTypeText
    * delay(2000)
    * click(listRelationshipLocators.relationsTabLink)
    * delay(3000)
  	* match enabled(listRelationshipLocators.gridOnPage) == true
  	* click(listRelationshipLocators.gridOnPage)
  	* delay(1000)
  	* def columnNameOnGrid = scriptAll(listRelationshipLocators.columnNameOnGrid, '_.textContent')
    * delay(1000)
    * print '---column Name On Grid---', columnNameOnGrid
  	* match  columnNameOnGrid[1] == listRelationshipConstants.inTheRoleOfText
    * match  columnNameOnGrid[2] == listRelationshipConstants.isAText
    * match  columnNameOnGrid[3] == listRelationshipConstants.partyIdText
    * match  columnNameOnGrid[4] == listRelationshipConstants.ofPartyIdText
    * match  columnNameOnGrid[5] == listRelationshipConstants.inTheRoleOfTexts
    * match  columnNameOnGrid[6] == listRelationshipConstants.fromDateText
    * match  columnNameOnGrid[7] == listRelationshipConstants.toDateText
    

  #REV2-22127
  Scenario: Verify the functionality of the grid button for Super admin user.
  
  	* karate.log('***list screen****')
    * match text(listRelationshipLocators.relationshipTab) == listRelationshipConstants.realtionshipTypeText
    * delay(2000)
    * click(listRelationshipLocators.relationsTabLink)
    * delay(3000)
  	* match enabled(listRelationshipLocators.gridOnPage) == true
  	* click(listRelationshipLocators.gridOnPage)
  	* delay(1000)
  	* def columnNameOnGrid = scriptAll(listRelationshipLocators.columnNameOnGrid, '_.textContent')
    * delay(1000)
    * print '---column Name On Grid---', columnNameOnGrid
  	* def chkBox = locateAll(listRelationshipLocators.checkkBoxOnGrid)
    * delay(1000)
    * chkBox[1].click()
    * delay(1000)
    * click(listRelationshipLocators.closeButtonOnPopup)
    * delay(1000)
    * def columnNameOnList = scriptAll(listRelationshipLocators.relGrpColumnList, '_.textContent')
    * delay(1000)
    * print "listing Relationship column list..." , columnNameOnList    
    * delay(1000)
    * match  columnNameOnGrid[1] != listRelationshipLocators.relGrpColumnList
    
  
  #REV2-22130
  Scenario: Verify relationship list with view, edit, delete functionalities for Super Admin
  
  	* karate.log('***list screen****')
    * match text(listRelationshipLocators.relationshipTab) == listRelationshipConstants.realtionshipTypeText
    * delay(2000)
    * click(listRelationshipLocators.relationsTabLink)
    * delay(3000)
    * click(listRelationshipLocators.dots)
    * delay(3000)
    * exists(listRelationshipLocators.view)
    * delay(2000)
    * exists(listRelationshipLocators.edit)
    * delay(2000)
    * exists(listRelationshipLocators.delete)
    * delay(2000)
    * exists(listRelationshipLocators.newRelationshipTab)
    * delay(2000)
    
    
    
    
    
    