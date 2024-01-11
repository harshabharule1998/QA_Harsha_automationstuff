Feature: Category Management Super Admin search feature

  Background: 
    * def loginLocator = read('../../data/loginPage_locator.json')
    * def usersValue = read('../../data/users.json')
    * def dashBoardLocator = read('../../data//dashboard_locators.json')
    * def categoryLocater = read('../../data/categoryPage_locators.json')
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


  #REV2-7296/REV2-7297
  Scenario: Verify Category search input box available on Category Management List screen for Super admin
    * karate.log('***search input box****')
    * delay(1000)
    * match enabled(categoryLocater.searchInputBox) == true
    * match enabled(categoryLocater.searchIconOnListPage) == true


  Scenario: Verify Search functionality Category management as Super Admin Valid category Name
    * karate.log('***search input box with valid value****')
    * delay(1000)
    * def categoryName = scriptAll(categoryLocater.categoryNameList, '_.textContent')
    * def totalRecordOnListBeforeSerach = locateAll(categoryLocater.categoryNameList)
    * delay(1000)
    * input(categoryLocater.searchInputBox, categoryName[1])
    * delay(4000)
    * def categoryNameAfterSearch = scriptAll(categoryLocater.categoryNameList, '_.textContent')
    * delay(4000)
    * def totalRecordOnListAfterSerach = locateAll(categoryLocater.categoryNameList)
    * delay(1000)
    * match  categoryName[1] == categoryNameAfterSearch[0]
    * match karate.sizeOf(totalRecordOnListBeforeSerach) != karate.sizeOf(totalRecordOnListAfterSerach)


  Scenario: Verify Search functionality Category management as Super Admin Valid category Type
    * karate.log('***search input box with valid value****')
    * delay(1000)
    * def categoryType = scriptAll(categoryLocater.categoryTypeColumnOnListPage, '_.textContent')
    * def totalRecordOnListBeforeSerach = locateAll(categoryLocater.categoryTypeColumnOnListPage)
    * delay(1000)
    * input(categoryLocater.searchInputBox, categoryType[1])
    * delay(4000)
    * def categoryTypeAfterSearch = scriptAll(categoryLocater.categoryTypeColumnOnListPage, '_.textContent')
    * delay(4000)
    * def totalRecordOnListAfterSerach = locateAll(categoryLocater.categoryTypeColumnOnListPage)
    * delay(1000)
    * match  categoryType[1] == categoryTypeAfterSearch[0]
    * match karate.sizeOf(totalRecordOnListBeforeSerach) == karate.sizeOf(totalRecordOnListAfterSerach)


  Scenario: Verify Search functionality Category management as Super Admin Valid Parent category Name
    * karate.log('***Search functionality Category management****')
    * delay(1000)
    * def parentCategoryName = scriptAll(categoryLocater.parentCategoryColumnOnListPage, '_.textContent')
    * def totalRecordOnListBeforeSerach = locateAll(categoryLocater.parentCategoryColumnOnListPage)
    * delay(1000)
    * input(categoryLocater.searchInputBox, parentCategoryName[1])
    * delay(4000)
    * def parentCategoryNameAfterSearch = scriptAll(categoryLocater.parentCategoryColumnOnListPage, '_.textContent')
    * delay(4000)
    * def totalRecordOnListAfterSerach = locateAll(categoryLocater.parentCategoryColumnOnListPage)
    * delay(1000)
    * match  parentCategoryName[1] == parentCategoryNameAfterSearch[0]
    * match karate.sizeOf(totalRecordOnListBeforeSerach) == karate.sizeOf(totalRecordOnListAfterSerach)


  Scenario: Verify Search functionality Category management as Super Admin Valid category Id
    * karate.log('***search input box with valid category Id****')
    * delay(1000)
    * def categoryID = scriptAll(categoryLocater.categoryIdColumnOnListPage, '_.textContent')
    * def totalRecordOnListBeforeSerach = locateAll(categoryLocater.categoryIdColumnOnListPage)
    * delay(1000)
    * input(categoryLocater.searchInputBox, categoryID[1])
    * delay(4000)
    * def categoryIDAfterSearch = scriptAll(categoryLocater.categoryIdColumnOnListPage, '_.textContent')
    * delay(4000)
    * def totalRecordOnListAfterSerach = locateAll(categoryLocater.categoryIdColumnOnListPage)
    * delay(1000)
    * match  categoryID[1] == categoryIDAfterSearch[0]
    * match karate.sizeOf(totalRecordOnListBeforeSerach) != karate.sizeOf(totalRecordOnListAfterSerach)


  Scenario: Verify Search functionality Category management as Super Admin InValid category Id
    * karate.log('***search input box with Invalid value****')
    * delay(1000)
    * def inValidCategoryID = "1234567"
    * delay(1000)
    * input(categoryLocater.searchInputBox, inValidCategoryID)
    * delay(4000)
    * match text(categoryLocater.categoryListPageInvalidValueTxt) == 'No results found'


  #REV2-7299
  Scenario: Verify Clear search Icon(X) available on search input box Category Management List screen Super admin
    * karate.log('***search input box with Invalid value****')
    * delay(1000)
    * def inValidCategoryID = "1234567"
    * def totalRecordOnListBeforeSerach = locateAll(categoryLocater.categoryIdColumnOnListPage)
    * delay(1000)
    * input(categoryLocater.searchInputBox, inValidCategoryID)
    * delay(2000)
    * match text(categoryLocater.categoryListPageInvalidValueTxt) == 'No results found'
    * match enabled(categoryLocater.clearButtonIcon) == true
