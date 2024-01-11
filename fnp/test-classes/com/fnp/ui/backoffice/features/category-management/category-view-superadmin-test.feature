Feature: Category Management Super Admin View feature

  Background: 
    * def loginLocator = read('../../data/loginPage_locator.json')
    * def usersValue = read('../../data/users.json')
    * def dashBoardLocator = read('../../data//dashboard_locators.json')
    * def categoryLocater = read('../../data/categoryPage_locators.json')
    * def categoryConstant = read('../../data/categoryPage_constants.json')
    * def today = new java.util.Date().time
    * def num = today + ""
    * def num = num.substring(8)
    * def date = "25"
    * def month = "07"
    * def year = "2022"
    * configure driver = driverConfig
    * driver backOfficeUrl
    * print '***backofficeurl***' backOfficeUrl
    And maximize()
    * karate.log('***Logging into the application****')
    And input(loginLocator.usernameTextArea, usersValue.users.superAdmin.email)
    * delay(3000)
    And input(loginLocator.passwordTextArea, usersValue.users.superAdmin.password)
    * delay(3000)
    When click(loginLocator.loginButton)
    * karate.log('***Logging into the application****')
    * delay(3000)
    And click(dashBoardLocator.switchMenu)
    * delay(3000)
    And click(dashBoardLocator.galleriaMenu)
    * delay(4000)
    * def categoryName = scriptAll(categoryLocater.categoryNameList, '_.textContent')
    * delay(3000)
    * def options = scriptAll(categoryLocater.optionOnThreeDots, '_.textContent')
    * def elements = locateAll(categoryLocater.optionOnThreeDots)


  Scenario: Verify view icon on three dots of category Id for Super Admin.
    * karate.log('***view icon on three dots****')
    * delay(5000)
    * def categoryName = scriptAll(categoryLocater.categoryNameList, '_.textContent')
    * match karate.sizeOf(categoryName) == 10
    * click(categoryLocater.dots)
    And match options[0] contains 'View'


  Scenario: Verify all tab on view page of categoryId for Super Admin.
    * karate.log('***Mandatory field on Basic details page****')
    * delay(2000)
    * click(categoryLocater.dots)
    * delay(2000)
    * elements[0].click()
    * delay(4000)
    * def allTabName = scriptAll(categoryLocater.tabDetails, '_.textContent')
    * print 'allTabName', allLabelName
    * match  allTabName[0] == categoryConstant.categoryTabTxt
	  * match  allTabName[1] == categoryConstant.attributesTabTxt
	  * match  allTabName[2] == categoryConstant.contentTabTxt
    * match  allTabName[3] == categoryConstant.seoTabTxt
    * match  allTabName[4] == categoryConstant.confiTabTxt
    * match  allTabName[5] == categoryConstant.relationTabTxt


  Scenario: Verify History button on view page for Super Admin.
    * karate.log('***Mandatory field on Basic details page****')
    * delay(2000)
    * click(categoryLocater.dots)
    * delay(2000)
    * elements[0].click()
    And match enabled(categoryLocater.isEnableToggle) == true
    And match text(categoryLocater.viewHistoryButton) == categoryConstant.viewHistoryButtonTxt


  Scenario: Verify Taxonomy labels on view page for Super Admin
    * karate.log('***Mandatory field on Basic details page****')
    * delay(2000)
    * click(categoryLocater.dots)
    * delay(2000)
    * elements[0].click()
    * delay(4000)
    * def allLabelName = scriptAll(categoryLocater.allLabelOnView, '_.textContent')
    * delay(20000)
    * print 'allLabelName', allLabelName
    
    * match  allLabelName[12] == categoryConstant.categoryIdTxt
    * match  allLabelName[13] == categoryConstant.nameLabeltxt
    * match  allLabelName[14] == categoryConstant.classificationLabelTxt
    * match  allLabelName[15] == categoryConstant.typeLabelTxt
    * match  allLabelName[16] == categoryConstant.fromDateLabel
    * match  allLabelName[17] == categoryConstant.toDateLabel
    * match  allLabelName[18] == categoryConstant.urlLabel
    * match  allLabelName[19] == categoryConstant.domainNameLabel
    * match  allLabelName[20] == categoryConstant.GeoLabelLabel
    * match  allLabelName[21] == categoryConstant.partyLabel
    * match  allLabelName[22] == categoryConstant.productLabel
    * match  allLabelName[23] == categoryConstant.ocsasionLabel
    * match  allLabelName[24] == categoryConstant.cityLabel
    * match  allLabelName[25] == categoryConstant.recipientLabel
    * match  allLabelName[26] == categoryConstant.createdByLabel
    * match  allLabelName[27] == categoryConstant.createLabel
    * match  allLabelName[28] == categoryConstant.lastModifiedByLabel
    * match  allLabelName[29] == categoryConstant.lastModifiedDateLabel


  Scenario: Verify Taxonomy values on view page for Super Admin
    * karate.log('***Taxonomy Details on view page****')
    * delay(4000)
    * def categoryDetails = scriptAll(categoryLocater.categoryIdDetails, '_.textContent')
    * delay(2000)
    * click(categoryLocater.dots)
    * delay(2000)
    * elements[0].click()
    * delay(4000)
    * def taxonomyValue = scriptAll(categoryLocater.allLabelValueonView, '_.textContent')
    * match  categoryDetails[0] == taxonomyValue[1]
    * match  categoryDetails[1] == taxonomyValue[7]
    * match  categoryDetails[2] == taxonomyValue[2]
    * match  categoryDetails[3] == taxonomyValue[4]
    * match  categoryDetails[1] contains taxonomyValue[9]
    * match  categoryDetails[1] contains taxonomyValue[10]
    * match  categoryDetails[1] contains taxonomyValue[12]
