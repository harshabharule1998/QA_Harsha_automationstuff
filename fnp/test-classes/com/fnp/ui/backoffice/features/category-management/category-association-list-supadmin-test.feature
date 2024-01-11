Feature: Category Association List Page Super Admin feature

  Background: 
    
    * def loginLocator = read('../../data/loginPage_locator.json')
    * def usersValue = read('../../data/users.json')
    * def dashBoardLocator = read('../../data//dashboard_locators.json')
    * def categoryLocator = read('../../data/categoryPage_locators.json')
    * def categoryConstant = read('../../data/categoryPage_constants.json')
    * configure driver = driverConfig
    * driver backOfficeUrl
    * maximize()
    * karate.log('***Logging into the application****')
    * input(loginLocator.usernameTextArea, usersValue.users.superAdmin.email)
    * delay(1000)
    * input(loginLocator.passwordTextArea, usersValue.users.superAdmin.password)
    * delay(1000)
    * click(loginLocator.loginButton)
    * karate.log('***Logging into the application****')
    * delay(1000)
    * click(dashBoardLocator.switchMenu)
    * delay(1000)
    * click(dashBoardLocator.galleriaMenu)
    * delay(4000)
    * def categoryName = scriptAll(categoryLocator.categoryNameList, '_.textContent')
    * delay(3000)
    * def options = scriptAll(categoryLocator.optionOnThreeDots, '_.textContent')
    * def elements = locateAll(categoryLocator.optionOnThreeDots)
    * karate.log('*** Open Category View Page ****')
    * click(categoryLocator.dots)
    * delay(2000)
    * elements[0].click()
    * delay(2000)
    * karate.log('*** Open Category Relationship Tab ****')
    * def allLabelName = scriptAll(categoryLocator.tabDetails, '_.textContent')
    * match allLabelName[5] == categoryConstant.relationTabTxt
    * click(categoryLocator.relationshipTabLink)
    * delay(1000)

	
  #REV2-9019
  Scenario: Verify Super Admin can view Category Relationship List page
    
    * karate.log('*** Verify table headers on Category Relationship list page ****')
    * def headerNames = scriptAll(categoryLocator.categoryRelationHeaderList, '_.textContent')
    * print 'headerNamesv', headerNames
    * delay(1000)
    * match headerNames[0] == "Category ID"
    * match headerNames[1] == "Category Name"
    * match headerNames[2] == "Relation Type"
    * match headerNames[3] == "Primary"
    * match headerNames[4] == "Sequence"
    * match headerNames[5] == "Is Enabled"
    * match headerNames[6] == "Created By"
    * match headerNames[7] == "Created Date"
    * match headerNames[8] == "Modified By"
    * match headerNames[9] == "Last Modified Date"
    
    
    

	#REV2-9026
  Scenario: Verify Super Admin can goto Category Relationship Edit page from List page
    
    * karate.log('*** Open Category Relationship ****')
    * click(categoryLocator.nextAssociationPageButton)
		* delay(1000)
		* click(categoryLocator.latestAssociation)
		* delay(1000)
		* karate.log('*** Open Edit Category Relation Page ****')
		* def elements = locateAll(categoryLocator.editAssociationOption)
		* eval lastIndex = karate.sizeOf(elements) - 1
		* elements[lastIndex].click()
		* delay(1000)
		* waitFor(categoryLocator.updateAssociationButton)
    
    
  #REV2-9027  
  Scenario: Verify Sort functionality for Category Relationship management for Super Admin
    
    * def categoryIdsBeforeSort = scriptAll(categoryLocator.associationCategoryIdList, '_.textContent')
    * delay(1000)
    * karate.log('*** Sort by category Id ****')
    * click(categoryLocator.categoryRelationSortHeader)
		* delay(2000)
		* def categoryIdsAfterSort = scriptAll(categoryLocator.associationCategoryIdList, '_.textContent')
    * delay(1000)
    * karate.log('Before Sort categoryIdsBeforeSort : ', categoryIdsBeforeSort)
		* karate.log('After Sort categoryIdsAfterSort : ', categoryIdsAfterSort)
		* match categoryIdsAfterSort != categoryIdsBeforeSort

	  
  #REV2-9029  
  Scenario: Verify Super Admin is able to set record count per page on Category Relationship List Page
    
    * scroll(categoryLocator.paginationOnList)
    * delay(2000)
    * karate.log('*** Set rows per page count to 5 ****')
    * def paginationTxt = scriptAll(categoryLocator.paginationTxtOnList, '_.textContent')
    * print 'Pagination txt', paginationTxt
    * match paginationTxt[0] contains 'Rows per page'
    * delay(1000)
    * mouse().move(categoryLocator.paginationDropdownTxt).click()
    * delay(3000)
    * def optionOnPagin = locateAll(categoryLocator.paginationDropDownOption)
    * delay(3000)
    * optionOnPagin[0].click()
    * delay(2000)
		* def categoryIds = scriptAll(categoryLocator.associationCategoryIdList, '_.textContent')
    * delay(1000)
    * match karate.sizeOf(categoryIds) == 5
    
	
	#REV2-9031  
  Scenario: Verify Super Admin is able to search category on Category Relationship List Page
    
    * karate.log('***search with category name****')
    * def searchText = "Send Birthday Gifts"
    * input(categoryLocator.searchInputBox, searchText)
    * delay(3000)
    * def categoryNames = scriptAll(categoryLocator.associationCategoryNameList, '_.textContent')
    * delay(1000)
    * match each categoryNames[*] contains searchText
    * assert karate.sizeOf(categoryNames) > 0


	#REV2-9032
  Scenario: Verify Super Admin have access to Edit and Delete a particular category Relationship from list page
    
    * karate.log('*** Open Category Association options ****')
  	* click(categoryLocator.dots)
  	* karate.log('*** Verify Category Relation visible options ****')
		* def options = scriptAll(categoryLocator.categoryRelationVisibleOptions, '_.textContent')
		* match options[0] contains "View"
		* match options[1] contains "Edit"
		* match options[2] contains "Delete"
		