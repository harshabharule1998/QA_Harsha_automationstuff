Feature: Category Management Super Admin List feature

  Background: 
    * def loginLocator = read('../../data/loginPage_locator.json')
    * def usersValue = read('../../data/users.json')
    * def dashBoardLocator = read('../../data//dashboard_locators.json')
    * def categoryLocator = read('../../data/categoryPage_locators.json')
    * def categoryConstant = read('../../data/categoryPage_constants.json')
    * configure driver = driverConfig
    * driver backOfficeUrl
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
    And click(dashBoardLocator.galleriaMenu)
    * delay(5000)


  #REV2-6733/REV2-7295
  Scenario: Verify all text ,inputfield and button on category manangement list screen for superadmin
    * karate.log('***list screen****')
    * delay(1000)
    * match driver.url == categoryConstant.categoryListPageUrl
    * delay(1000)
    * match text(categoryLocator.categoryManagementText) == categoryConstant.titleText
    * delay(1000)
    * match text(categoryLocator.newCategoryButton) == categoryConstant.newCategoryButtonText
    * delay(1000)
    * match text(categoryLocator.importButton) == categoryConstant.importButtonTxt
    * match text(categoryLocator.exportButton) == categoryConstant.exportButtonTxt
    * match text(categoryLocator.advanceSearch) == categoryConstant.advanceSearchTxt
    
    * match enabled(categoryLocator.searchInputBox) == true
    * match enabled(categoryLocator.gridOnPage) == true

  
  #REV2-6749
  Scenario: Verify column name on category manangement list screen for superadmin
    * karate.log('***column details on list page****')
    * delay(4000)
    * def columnNameOnGrid = scriptAll(categoryLocator.historyPageColumnName, '_.textContent')
    * match  columnNameOnGrid[0] == categoryConstant.categoryIdColumn
    * match  columnNameOnGrid[1] == categoryConstant.categoryUrlColumn
    * match  columnNameOnGrid[2] == categoryConstant.categoryNameColumn
    * match  columnNameOnGrid[3] == categoryConstant.categoryTypeColumn
	  * match  columnNameOnGrid[4] == categoryConstant.categoryClassification
    * match  columnNameOnGrid[5] == categoryConstant.parentCatColumn
    * match  columnNameOnGrid[6] == categoryConstant.enabledColumn
	  * match  columnNameOnGrid[7] == categoryConstant.fromDateLabelTxt
    * match  columnNameOnGrid[8] == categoryConstant.toDateLabelTxt
    * match  columnNameOnGrid[9] == categoryConstant.createdByLabel
    * match  columnNameOnGrid[10] == categoryConstant.createLabel
	  * match  columnNameOnGrid[11] == categoryConstant.modifiedByCol
    * match  columnNameOnGrid[12] == categoryConstant.lastModifiedDateLabel

  
  Scenario: Verify columnNameOnGrid present on grid Pop-up on list screen for superadmin
    * delay(4000)
    * match enabled(categoryLocator.gridOnPage) == true
    * click(categoryLocator.gridOnPage)
    * match text(categoryLocator.titleOnGrid) == categoryConstant.titleOnGridTxt
    * delay(4000)
    * def columnNameOnGrid = scriptAll(categoryLocator.columnNameOnGrid, '_.textContent')
    * delay(3000)
    * print 'columnNameOnGrid', columnNameOnGrid
    * match  columnNameOnGrid[0] == categoryConstant.categoryIdColumn
    * match  columnNameOnGrid[1] == categoryConstant.categoryUrlColumn
    * match  columnNameOnGrid[2] == categoryConstant.categoryNameColumn
    * match  columnNameOnGrid[3] == categoryConstant.categoryTypeColumn
	  * match  columnNameOnGrid[4] == categoryConstant.categoryClassification
    * match  columnNameOnGrid[5] == categoryConstant.parentCatColumn
    * match  columnNameOnGrid[6] == categoryConstant.enabledColumn
	  * match  columnNameOnGrid[7] == categoryConstant.fromDateLabelTxt
    * match  columnNameOnGrid[8] == categoryConstant.toDateLabelTxt
    * match  columnNameOnGrid[9] == categoryConstant.createdByLabel
    * match  columnNameOnGrid[10] == categoryConstant.createLabel
	  * match  columnNameOnGrid[11] == categoryConstant.modifiedByCol
    * match  columnNameOnGrid[12] == categoryConstant.lastModifiedDateLabel
    * click(categoryLocator.closeButtonOnPopup)


  #REV2-6746/REV2-6739
  Scenario: Verify grid functionality on list screen for superadmin
    * delay(4000)
    * def columnNameOnGrid = scriptAll(categoryLocator.historyPageColumnName, '_.textContent')
    * delay(4000)
    * click(categoryLocator.gridOnPage)
    * def chkBox = locateAll(categoryLocator.chkBoxOnGrid)
    * delay(4000)
    * chkBox[1].click()
    * delay(4000)
    * click(categoryLocator.closeButtonOnPopup)
    * delay(4000)
    * def columnNameOnGrid = scriptAll(categoryLocator.historyPageColumnName, '_.textContent')
    * delay(4000)
    * match  columnNameOnGrid[1] != categoryConstant.categoryUrlColumn


  #REV2-6738
  Scenario: Verify sorting fuctionality on category manangement list screen for superadmin
    * delay(4000)
    * def categoryId = scriptAll(categoryLocator.categoryNameList, '_.textContent')
    * delay(3000)
    * def elements = locateAll(categoryLocator.sortingIndex)
    * delay(5000)
    * elements[0].click()
    * delay(4000)
    * def categoryIdAfterSort = scriptAll(categoryLocator.categoryNameList, '_.textContent')
    * delay(4000)
    * match  categoryId[0] != categoryIdAfterSort[0]
    * elements[1].click()
    * match  categoryId[1] != categoryIdAfterSort[1]
    * elements[2].click()
    * match  categoryId[2] != categoryIdAfterSort[2]
    * elements[3].click()
    * match  categoryId[3] != categoryIdAfterSort[3]
    * elements[4].click()
    * match  categoryId[4] != categoryIdAfterSort[4]
    * elements[5].click()
    * match  categoryId[5] != categoryIdAfterSort[5]
    * elements[6].click()
    * match  categoryId[6] != categoryIdAfterSort[6]


  Scenario: Verify next and previous button functionality on list screen for superadmin
    * delay(4000)
    * def categoryIdBefore = scriptAll(categoryLocator.categoryNameList, '_.textContent')
    * delay(3000)
    * click('{^}Next')
    * delay(4000)
    * def categoryIdAfter = scriptAll(categoryLocator.categoryNameList, '_.textContent')
    * match categoryIdBefore[0] != categoryIdAfter[0]
    * delay(3000)
    * click('{^}Prev')
    * delay(4000)
    * def categoryIdAfterPre = scriptAll(categoryLocator.categoryNameList, '_.textContent')
    * delay(2000)
    * match categoryIdBefore[0] == categoryIdAfterPre[0]


  #REV2-6747
  Scenario: Verify pagination functionality on list screen for superadmin
    * delay(1000)
    * scroll(categoryLocator.paginationOnList)
    * delay(2000)
    * def paginationTxt = scriptAll(categoryLocator.paginationTxtOnList, '_.textContent')
    * print 'Pagination txt', paginationTxt
    * match paginationTxt[0] contains 'Rows per page'
    * delay(1000)
    * mouse().move(categoryLocator.paginationDropdownTxt).click()
    * delay(3000)
    * def optionOnPagin = locateAll(categoryLocator.paginationDropDownOption)
    * delay(5000)
    * optionOnPagin[0].click()
    * delay(2000)
    * def categoryId = locateAll(categoryLocator.categoryNameList)
    * match karate.sizeOf(categoryId) == 5
