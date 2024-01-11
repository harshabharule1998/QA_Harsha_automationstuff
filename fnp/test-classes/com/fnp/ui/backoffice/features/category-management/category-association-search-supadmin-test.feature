Feature: Category Association Super Admin search feature

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


  #REV2-10396, REV2-10397 and REV2-10398
  Scenario: Verify search input box and icon available on Category Relationship Management List screen for Super admin
    
    * karate.log('*** Category Relationship search input box****')
    * delay(1000)
    * match enabled(categoryLocator.searchInputBox) == true
    * match enabled(categoryLocator.searchIconOnListPage) == true

	
	#REV2-10399
  Scenario: Verify Clear search Icon(X) available on search input box Category Relationship Management List screen for Super admin
    
    * karate.log('***search input box with valid value****')
    * delay(1000)
    * def searchText = "Anniversary"
    * input(categoryLocator.searchInputBox, searchText)
    * delay(2000)
    * match enabled(categoryLocator.clearButtonIcon) == true
    
  
  #REV2-10400  
  Scenario: Verify Search functionality for Category Relationship management as Super Admin with valid category Name
    
    * karate.log('***search input box with valid category name****')
    * def searchText = "Send Birthday Gifts"
    * input(categoryLocator.searchInputBox, searchText)
    * delay(3000)
    * def categoryNames = scriptAll(categoryLocator.associationCategoryNameList, '_.textContent')
    * delay(1000)
    * match each categoryNames[*] contains searchText
    * assert karate.sizeOf(categoryNames) > 0


  Scenario: Verify Search functionality for Category Relationship management as Super Admin with valid category Type
    
    * karate.log('***search input box with valid category type****')
    * def searchText = "Parent"
    * input(categoryLocator.searchInputBox, searchText)
    * delay(3000)
    * def categoryTypes = scriptAll(categoryLocator.associationCategoryTypeList, '_.textContent')
    * delay(1000)
    * match each categoryTypes[*] contains searchText
    * assert karate.sizeOf(categoryTypes) > 0

	
  Scenario: Verify Search functionality for Category Relationship management as Super Admin with valid categoryId
    
    * karate.log('*** search input box with valid categoryId ****')
    * def searchText = "9281176"
    * input(categoryLocator.searchInputBox, searchText)
    * delay(3000)
    * def categoryIds = scriptAll(categoryLocator.associationCategoryIdList, '_.textContent')
    * delay(1000)
    * match each categoryIds[*] contains searchText
    * assert karate.sizeOf(categoryIds) > 0


  Scenario: Verify Search functionality for Category Relationship management as Super Admin with invalid category Name
    
    * karate.log('***search input box with invalid category name****')
    * def invalidSearchText = "test"
    * input(categoryLocator.searchInputBox, invalidSearchText)
    * delay(3000)
    * waitForText('body', 'No results found')

