Feature: Category Management Super Admin Create feature

  Background: 
    * def loginLocator = read('../../data/loginPage_locator.json')
    * def usersValue = read('../../data/users.json')
    * def dashBoardLocator = read('../../data//dashboard_locators.json')
    * def categoryLocator = read('../../data/categoryPage_locators.json')
    * def categoryConstant = read('../../data/categoryPage_constants.json')
    * def today = new java.util.Date().time
    * def num = today + ""
    * def num = num.substring(8)
    * def categoryName = "QA_Automation_" + num
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

  
  Scenario: Verify new category button on category management list screen for super admin
    * karate.log('***Verify new category button****')
    * delay(3000)
    Then match text(categoryLocator.categoryManagementText) == categoryConstant.titleText
    * delay(3000)
    And match text(categoryLocator.newCategoryButton) == categoryConstant.newCategoryButtonText


  #REV2-15162
  Scenario: Verify all label on new category page for superadmin
    * karate.log('***User is on new category page ****')
    * delay(3000)
    And match text(categoryLocator.newCategoryButton) == categoryConstant.newCategoryButtonText
    * delay(3000)
    * click(categoryLocator.newCategoryButton)
    * delay(2000)
    And match text(categoryLocator.newCategoryText) == categoryConstant.newCategoryButtonText
    And match text(categoryLocator.basicDetailsTab) == categoryConstant.basicDetailsTabTxt
    And match enabled(categoryLocator.activeBasicTab) == true
    And match text(categoryLocator.microSiteTab) == categoryConstant.micrositeTab
    And match text(categoryLocator.seoConfigurationTab) == categoryConstant.seoConfTab
    And match text(categoryLocator.categoryContentTab) == categoryConstant.catContentTab
    And match text(categoryLocator.productionAssociationTab) == categoryConstant.proAssociateTab
    And match text(categoryLocator.fromDateLabel) == categoryConstant.fromDateLabelTxt
    And match text(categoryLocator.toDateLabel) == categoryConstant.toDateLabelTxt
    And match text(categoryLocator.continueButton) == categoryConstant.continueTxt
    And match text(categoryLocator.taxonomyDetails) == categoryConstant.taxonomyDetailsLabelTxt
    And match text(categoryLocator.categoryClassificationLabel) == categoryConstant.categoryClassificationLabelTxt
    

  #REV2-15162/REV2-15126
  Scenario: Verify all mandatory fields on Basic Details page by entering valid data for Super Admin
    * karate.log('***Mandatory field on Basic details page****')
    * click(categoryLocator.newCategoryButton)
    * delay(1000)
    * input(categoryLocator.categoryNameInputText, categoryName)
    * delay(1000)
    * mouse().move(categoryLocator.categoryTypeDropdownOnBasicPage).click()
    * def categoryTypeValue = locateAll(categoryLocator.categoryTypeDropdownValue)
    * categoryTypeValue[2].click()
    * delay(4000)
    * click(categoryLocator.nonUrlradioButton)
    * delay(1000)
    * input(categoryLocator.fromDateInput, "01/22/2022")
    * delay(1000)
    * input(categoryLocator.toDateInput, "05/22/2022")
    * delay(1000)
    * mouse().move(categoryLocator.domainDropdown).click()
    * delay(1000)
    * def categoryDomainValue = locateAll(categoryLocator.domainDropdownValue)
    * categoryDomainValue[6].click()
    * delay(1000)
    * mouse().move(categoryLocator.geographyDomain).click()
    * delay(1000)
    * def categoryGeographyValue = locateAll(categoryLocator.geographyDomainValue)
    * categoryGeographyValue[6].click()
    * delay(1000)
    * match enabled(categoryLocator.continueButton) == true
    * click(categoryLocator.continueButton)
    * delay(1000)
    * match enabled(categoryLocator.microSiteTab) == true


  #REV2-15133
  Scenario: Verify Microsite/PLP tab is active Super Admin
    * karate.log('***Microsite/PLP tab is active****')
    * click(categoryLocator.newCategoryButton)
    * input(categoryLocator.categoryNameInputText, categoryName)
    * mouse().move(categoryLocator.categoryTypeDropdownOnBasicPage).click()
    * def categoryTypeValue = locateAll(categoryLocator.categoryTypeDropdownValue)
    * categoryTypeValue[6].click()
    * click(categoryLocator.nonUrlradioButton)
    * input(categoryLocator.fromDateInput, "01/22/2022")
    * input(categoryLocator.toDateInput, "05/22/2022")
    * delay(2000)
    * mouse().move(categoryLocator.domainDropdown).click()
    * delay(2000)
    * def categoryDomainValue = locateAll(categoryLocator.domainDropdownValue)
    * categoryDomainValue[6].click()
    * mouse().move(categoryLocator.geographyDomain).click()
    * delay(1000)
    * def categoryGeographyValue = locateAll(categoryLocator.geographyDomainValue)
    * categoryGeographyValue[6].click()
    * delay(1000)
    * match enabled(categoryLocator.continueButton) == true
    * click(categoryLocator.continueButton)
    * match enabled(categoryLocator.microSiteTab) == true


  #REV2-15133
  Scenario: Verify mandatory text present on Microsite/PLP page Super Admin
    * karate.log('***mandatory fields on Microsite/PLP page****')
    * click(categoryLocator.newCategoryButton)
    * delay(1000)
    * input(categoryLocator.categoryNameInputText, categoryName)
    * delay(1000)
    * mouse().move(categoryLocator.categoryTypeDropdownOnBasicPage).click()
    * def categoryTypeValue = locateAll(categoryLocator.categoryTypeDropdownValue)
    * categoryTypeValue[6].click()
    * delay(1000)
    * click(categoryLocator.nonUrlradioButton)
    * delay(1000)
    * input(categoryLocator.fromDateInput, "01/22/2022")
    * delay(1000)
    * input(categoryLocator.toDateInput, "05/22/2022")
    * delay(1000)
    * mouse().move(categoryLocator.domainDropdown).click()
    * delay(1000)
    * def categoryDomainValue = locateAll(categoryLocator.domainDropdownValue)
    * categoryDomainValue[6].click()
    * delay(1000)
    * mouse().move(categoryLocator.geographyDomain).click()
    * delay(1000)
    * def categoryGeographyValue = locateAll(categoryLocator.geographyDomainValue)
    * categoryGeographyValue[6].click()
    * delay(1000)
    * click(categoryLocator.continueButton)
    * match text(categoryLocator.micrositeTxt) == categoryConstant.isMicrositeOrPLPTxt
    * match text(categoryLocator.plpMICROSITE) == categoryConstant.micrositeTxt
    * match text(categoryLocator.templateCategoryLabel) == categoryConstant.templateCategoryTxt
    * match text(categoryLocator.manageContentTxtLabel) == categoryConstant.manageContentTxt
    * match text(categoryLocator.previousButtonOnCategoryPage) == categoryConstant.previousButtonTxt
    * match text(categoryLocator.continueButtonOnCategoryPage) == categoryConstant.continueButtonTxt


  #REV2-15158
  Scenario: Verify PREVIOUS button functionality on Microsite/PLP page Super Admin
    * karate.log('***mandatory fields on Microsite/PLP page****')
    * click(categoryLocator.newCategoryButton)
    * delay(1000)
    * input(categoryLocator.categoryNameInputText, categoryName)
    * delay(1000)
    * mouse().move(categoryLocator.categoryTypeDropdownOnBasicPage).click()
    * def categoryTypeValue = locateAll(categoryLocator.categoryTypeDropdownValue)
    * categoryTypeValue[6].click()
    * delay(1000)
    * click(categoryLocator.nonUrlradioButton)
    * delay(1000)
    * input(categoryLocator.fromDateInput, "01/22/2022")
    * delay(1000)
    * input(categoryLocator.toDateInput, "05/22/2022")
    * delay(1000)
    * mouse().move(categoryLocator.domainDropdown).click()
    * delay(1000)
    * def categoryDomainValue = locateAll(categoryLocator.domainDropdownValue)
    * categoryDomainValue[6].click()
    * delay(1000)
    * mouse().move(categoryLocator.geographyDomain).click()
    * delay(1000)
    * def categoryGeographyValue = locateAll(categoryLocator.geographyDomainValue)
    * categoryGeographyValue[6].click()
    * delay(1000)
    * click(categoryLocator.continueButton)
    * delay(1000)
    * click(categoryLocator.previousButtonOnCategoryPage)
    * delay(1000)
    * match text(categoryLocator.baseCategoryTxt) == 'Base Category'


  #REV2-15138/REV2-15137/REV2-15136/REV2-15133/REV2-15126
  Scenario: Verify continue button enabled on Microsite/PLP page Super Admin
    * karate.log('***mandatory fields on Microsite/PLP page****')
    * click(categoryLocator.newCategoryButton)
    * delay(1000)
    * input(categoryLocator.categoryNameInputText, categoryName)
    * delay(1000)
    * mouse().move(categoryLocator.categoryTypeDropdownOnBasicPage).click()
    * def categoryTypeValue = locateAll(categoryLocator.categoryTypeDropdownValue)
    * categoryTypeValue[6].click()
    * delay(1000)
    * click(categoryLocator.nonUrlradioButton)
    * delay(1000)
    * input(categoryLocator.fromDateInput, "01/22/2022")
    * delay(1000)
    * input(categoryLocator.toDateInput, "05/22/2022")
    * delay(1000)
    * mouse().move(categoryLocator.domainDropdown).click()
    * delay(1000)
    * def elements = locateAll(categoryLocator.domainDropdownValue)
    * elements[6].click()
    * delay(1000)
    * mouse().move(categoryLocator.geographyDomain).click()
    * delay(1000)
    * def elements = locateAll(categoryLocator.geographyDomainValue)
    * elements[6].click()
    * delay(1000)
    * click(categoryLocator.continueButton)
    * click(categoryLocator.micrositeplpMICROSITE)
    * delay(5000)
    * match enabled(categoryLocator.continueButton) == true


  #REV2-15142
  Scenario: Verify seo Configuration Tab is enabled for Super Admin
    * karate.log('***seo Configuration Tab is enabled****')
    * click(categoryLocator.newCategoryButton)
    * delay(1000)
    * input(categoryLocator.categoryNameInputText, categoryName)
    * delay(1000)
    * mouse().move(categoryLocator.categoryTypeDropdownOnBasicPage).click()
    * def categoryTypeValue = locateAll(categoryLocator.categoryTypeDropdownValue)
    * categoryTypeValue[6].click()
    * delay(1000)
    * click(categoryLocator.nonUrlradioButton)
    * delay(1000)
    * input(categoryLocator.fromDateInput, "01/22/2022")
    * delay(1000)
    * input(categoryLocator.toDateInput, "05/22/2022")
    * delay(1000)
    * mouse().move(categoryLocator.domainDropdown).click()
    * delay(1000)
    * def domainDropdownValueTxt = locateAll(categoryLocator.domainDropdownValue)
    * domainDropdownValueTxt[6].click()
    * delay(1000)
    * mouse().move(categoryLocator.geographyDomain).click()
    * delay(1000)
    * def geographyDomainValuetxt = locateAll(categoryLocator.geographyDomainValue)
    * geographyDomainValuetxt[6].click()
    * delay(1000)
    * click(categoryLocator.continueButton)
    * click(categoryLocator.micrositeplpPLP)
    * delay(1000)
    * click(categoryLocator.continueButton)
    * match text(categoryLocator.createCanonicalUrl) == 'Canonical URL *'
    * match enabled(categoryLocator.seoConfigurationTab) == true


  #REV2-15146/REV2-15145/REV2-15144/REV2-15143
  Scenario: Verify label present on seo Configuration Tab for Super Admin
    * karate.log('***seo Configuration Tab is enabled****')
    * click(categoryLocator.newCategoryButton)
    * delay(1000)
    * input(categoryLocator.categoryNameInputText, categoryName)
    * delay(1000)
    * mouse().move(categoryLocator.categoryTypeDropdownOnBasicPage).click()
    * def categoryTypeValue = locateAll(categoryLocator.categoryTypeDropdownValue)
    * categoryTypeValue[0].click()
    * delay(1000)
    * click(categoryLocator.nonUrlradioButton)
    * delay(1000)
    * input(categoryLocator.fromDateInput, "01/22/2022")
    * delay(1000)
    * input(categoryLocator.toDateInput, "05/22/2022")
    * delay(1000)
    * mouse().move(categoryLocator.domainDropdown).click()
    * delay(1000)
    * def domainType = locateAll(categoryLocator.domainDropdownValue)
    * domainType[5].click()
    * delay(1000)
    * mouse().move(categoryLocator.geographyDomain).click()
    * delay(1000)
    * def geoType = locateAll(categoryLocator.geographyDomainValue)
    * geoType[50].click()
    * delay(1000)
    * mouse().move(categoryLocator.ptValueDropdown).click()
    * delay(1000)
    * def PtValue = locateAll(categoryLocator.categoryProductPopupValue)
    * PtValue[97].click()
    * delay(1000)
    * click(categoryLocator.continueButton)
    * delay(1000)
    * click(categoryLocator.micrositeplpPLP)
    * delay(1000)
    * click(categoryLocator.continueButton)
    * match text(categoryLocator.createCanonicalUrl) == 'Canonical URL *'
    * delay(1000)
    * match text(categoryLocator.canonicalTypLabel) == 'Canonical Type *'
    * match text(categoryLocator.categorySeoContentTxt) == 'Please click on this button to manage the SEO content for this category'
    * match text(categoryLocator.manageContentTxtLabel) == categoryConstant.manageContentTxt
    * match text(categoryLocator.previousButtonOnCategoryPage) == categoryConstant.previousButtonTxt
    * match text(categoryLocator.continueButtonOnCategoryPage) == categoryConstant.continueButtonTxt
    * delay(1000)
    * mouse().move(categoryLocator.canonicalTypDropdown).click()
    * delay(1000)
    * def canonicalValue = scriptAll(categoryLocator.canonicalTypUrl, '_.textContent')
    * def canonicalLabel = locateAll(categoryLocator.canonicalTypUrl)
    * match canonicalValue[0] == 'SELF'
    * match canonicalValue[1] == 'REFERENCE'
    * match karate.sizeOf(canonicalLabel) == 2


  #REV2-15155/REV2-15154/REV2-15153/REV2-15152/REV2-15151/REV2-15150/REV2-15149/REV2-15148/REV2-15147
  Scenario: Verify Category Content Tab for Super Admin
    * karate.log('***seo Configuration Tab is enabled****')
    * click(categoryLocator.newCategoryButton)
    * delay(1000)
    * input(categoryLocator.categoryNameInputText, categoryName)
    * print 'categoryName', categoryName
    * delay(1000)
    * mouse().move(categoryLocator.categoryTypeDropdownOnBasicPage).click()
    * def categoryTypeValue = locateAll(categoryLocator.categoryTypeDropdownValue)
    * categoryTypeValue[0].click()
    * delay(1000)
    * click(categoryLocator.nonUrlradioButton)
    * delay(1000)
    * input(categoryLocator.fromDateInput, "01/22/2022")
    * delay(1000)
    * input(categoryLocator.toDateInput, "05/22/2022")
    * delay(1000)
    * mouse().move(categoryLocator.domainDropdown).click()
    * delay(1000)
    * def domainType = locateAll(categoryLocator.domainDropdownValue)
    * domainType[5].click()
    * delay(1000)
    * mouse().move(categoryLocator.geographyDomain).click()
    * delay(1000)
    * def geoType = locateAll(categoryLocator.geographyDomainValue)
    * geoType[50].click()
    * delay(1000)
    * mouse().move(categoryLocator.ptValueDropdown).click()
    * delay(1000)
    * def PtValue = locateAll(categoryLocator.categoryProductPopupValue)
    * PtValue[97].click()
    * delay(1000)
    * click(categoryLocator.continueButton)
    * delay(1000)
    * click(categoryLocator.micrositeplpPLP)
    * delay(1000)
    * click(categoryLocator.continueButton)
    * match text(categoryLocator.createCanonicalUrl) == 'Canonical URL *'
    * delay(1000)
    * match text(categoryLocator.canonicalTypLabel) == 'Canonical Type *'
    * match text(categoryLocator.categorySeoContentTxt) == 'Please click on this button to manage the SEO content for this category'
    * match text(categoryLocator.manageContentTxtLabel) == categoryConstant.manageContentTxt
    * match text(categoryLocator.previousButtonOnCategoryPage) == categoryConstant.previousButtonTxt
    * match text(categoryLocator.continueButtonOnCategoryPage) == categoryConstant.continueButtonTxt
    * delay(1000)
    * mouse().move(categoryLocator.canonicalTypDropdown).click()
    * delay(1000)
    * def canonicalValue = scriptAll(categoryLocator.canonicalTypUrl, '_.textContent')
    * def canonicalLabel = locateAll(categoryLocator.canonicalTypUrl)
    * match canonicalValue[0] == 'SELF'
    * match canonicalValue[1] == 'REFERENCE'
    * match karate.sizeOf(canonicalLabel) == 2
    * click(categoryLocator.continueButton)
    * match text(categoryLocator.categoryContentPageTxt) == 'Please click on this button to manage content for this category'
    * match text(categoryLocator.manageContentTxtLabel) == categoryConstant.manageContentTxt
    * match text(categoryLocator.previousButtonOnCategoryPage) == categoryConstant.previousButtonTxt
    * match text(categoryLocator.continueButtonOnCategoryPage) == categoryConstant.continueButtonTxt


  #REV2-15157/REV2-15156
  Scenario: Verify Product Association Tab for Super Admin
    * karate.log('***seo Configuration Tab is enabled****')
    * click(categoryLocator.newCategoryButton)
    * delay(1000)
    * input(categoryLocator.categoryNameInputText, categoryName)
    * print 'categoryName', categoryName
    * delay(1000)
    * mouse().move(categoryLocator.categoryTypeDropdownOnBasicPage).click()
    * def categoryTypeValue = locateAll(categoryLocator.categoryTypeDropdownValue)
    * categoryTypeValue[0].click()
    * delay(1000)
    * click(categoryLocator.nonUrlradioButton)
    * delay(1000)
    * input(categoryLocator.fromDateInput, "01/22/2022")
    * delay(1000)
    * input(categoryLocator.toDateInput, "05/22/2022")
    * delay(1000)
    * mouse().move(categoryLocator.domainDropdown).click()
    * delay(1000)
    * def domainType = locateAll(categoryLocator.domainDropdownValue)
    * domainType[5].click()
    * delay(1000)
    * mouse().move(categoryLocator.geographyDomain).click()
    * delay(1000)
    * def geoType = locateAll(categoryLocator.geographyDomainValue)
    * geoType[50].click()
    * delay(1000)
    * mouse().move(categoryLocator.ptValueDropdown).click()
    * delay(1000)
    * def PtValue = locateAll(categoryLocator.categoryProductPopupValue)
    * PtValue[97].click()
    * delay(1000)
    * click(categoryLocator.continueButton)
    * delay(1000)
    * click(categoryLocator.micrositeplpPLP)
    * delay(1000)
    * click(categoryLocator.continueButton)
    * match text(categoryLocator.createCanonicalUrl) == 'Canonical URL *'
    * delay(1000)
    * match text(categoryLocator.canonicalTypLabel) == 'Canonical Type *'
    * match text(categoryLocator.categorySeoContentTxt) == 'Please click on this button to manage the SEO content for this category'
    * match text(categoryLocator.manageContentTxtLabel) == categoryConstant.manageContentTxt
    * match text(categoryLocator.previousButtonOnCategoryPage) == categoryConstant.previousButtonTxt
    * match text(categoryLocator.continueButtonOnCategoryPage) == categoryConstant.continueButtonTxt
    * delay(1000)
    * mouse().move(categoryLocator.canonicalTypDropdown).click()
    * delay(1000)
    * def canonicalValue = scriptAll(categoryLocator.canonicalTypUrl, '_.textContent')
    * def canonicalLabel = locateAll(categoryLocator.canonicalTypUrl)
    * match canonicalValue[0] == 'SELF'
    * match canonicalValue[1] == 'REFERENCE'
    * match karate.sizeOf(canonicalLabel) == 2
    * click(categoryLocator.continueButton)
    * match text(categoryLocator.categoryContentPageTxt) == 'Please click on this button to manage content for this category'
    * match text(categoryLocator.manageContentTxtLabel) == categoryConstant.manageContentTxt
    * match text(categoryLocator.previousButtonOnCategoryPage) == categoryConstant.previousButtonTxt
    * match text(categoryLocator.continueButtonOnCategoryPage) == categoryConstant.continueButtonTxt
    * click(categoryLocator.continueButton)
    * delay(1000)
    * match enabled(categoryLocator.associationChkBox) == true
    * click(categoryLocator.associationChkBox)
    * delay(1000)
    * match text(categoryLocator.categoryAssoPageTxt) == 'Association Product and base category sequencing or not'
    * match text(categoryLocator.previousButtonOnCategoryPage) == categoryConstant.previousButtonTxt
    * delay(1000)
    * match text(categoryLocator.continueButtonOnCategoryPage) == 'CREATE'


  #REV2-15161/REV2-15159/REV2-15160/REV2-15139
  Scenario: Verify Super Admin can create category with valid value
    * karate.log('***seo Configuration Tab is enabled****')
    * click(categoryLocator.newCategoryButton)
    * delay(1000)
    * input(categoryLocator.categoryNameInputText, categoryName)
    * print 'categoryName', categoryName
    * delay(1000)
    * mouse().move(categoryLocator.categoryTypeDropdownOnBasicPage).click()
    * def categoryTypeValue = locateAll(categoryLocator.categoryTypeDropdownValue)
    * categoryTypeValue[0].click()
    * delay(1000)
    * click(categoryLocator.nonUrlradioButton)
    * delay(1000)
    * input(categoryLocator.fromDateInput, "01/22/2022")
    * delay(1000)
    * input(categoryLocator.toDateInput, "05/22/2022")
    * delay(1000)
    * mouse().move(categoryLocator.domainDropdown).click()
    * delay(1000)
    * def domainType = locateAll(categoryLocator.domainDropdownValue)
    * domainType[7].click()
    * delay(1000)
    * mouse().move(categoryLocator.geographyDomain).click()
    * delay(1000)
    * def geoType = locateAll(categoryLocator.geographyDomainValue)
    * geoType[50].click()
    * delay(1000)
    * mouse().move(categoryLocator.ptValueDropdown).click()
    * delay(1000)
    * def PtValue = locateAll(categoryLocator.categoryProductPopupValue)
    * PtValue[45].click()
    * mouse().move(categoryLocator.categoryOccDropdown).click()
    * delay(1000)
    * def occassionValue = locateAll(categoryLocator.categoryOccPopupValue)
    * occassionValue[5].click()
    * delay(1000)
    * click(categoryLocator.continueButton)
    * delay(1000)
    * click(categoryLocator.micrositeplpPLP)
    * delay(1000)
    * click(categoryLocator.continueButton)
    * match text(categoryLocator.createCanonicalUrl) == 'Canonical URL *'
    * delay(1000)
    * match text(categoryLocator.canonicalTypLabel) == 'Canonical Type *'
    * match text(categoryLocator.categorySeoContentTxt) == 'Please click on this button to manage the SEO content for this category'
    * match text(categoryLocator.manageContentTxtLabel) == categoryConstant.manageContentTxt
    * match text(categoryLocator.previousButtonOnCategoryPage) == categoryConstant.previousButtonTxt
    * match text(categoryLocator.continueButtonOnCategoryPage) == categoryConstant.continueButtonTxt
    * delay(1000)
    * mouse().move(categoryLocator.canonicalTypDropdown).click()
    * delay(1000)
    * def canonicalValue = scriptAll(categoryLocator.canonicalTypUrl, '_.textContent')
    * def canonicalLabel = locateAll(categoryLocator.canonicalTypUrl)
    * match canonicalValue[0] == 'SELF'
    * match canonicalValue[1] == 'REFERENCE'
    * match karate.sizeOf(canonicalLabel) == 2
    * click(categoryLocator.continueButton)
    * match text(categoryLocator.categoryContentPageTxt) == 'Please click on this button to manage content for this category'
    * match text(categoryLocator.manageContentTxtLabel) == categoryConstant.manageContentTxt
    * match text(categoryLocator.previousButtonOnCategoryPage) == categoryConstant.previousButtonTxt
    * match text(categoryLocator.continueButtonOnCategoryPage) == categoryConstant.continueButtonTxt
    * click(categoryLocator.continueButton)
    * delay(1000)
    * match enabled(categoryLocator.associationChkBox) == true
    * click(categoryLocator.associationChkBox)
    * delay(1000)
    * match text(categoryLocator.categoryAssoPageTxt) == 'Association Product and base category sequencing or not'
    * match text(categoryLocator.previousButtonOnCategoryPage) == categoryConstant.previousButtonTxt
    * delay(1000)
    * match text(categoryLocator.continueButtonOnCategoryPage) == 'CREATE'
    * click(categoryLocator.continueButtonOnCategoryPage)
    * waitForText('body', 'Category created successfully')
    * karate.log('*** Category created successfully ****')


  Scenario: Verify Super Admin can create category with duplicate value
    * karate.log('***seo Configuration Tab is enabled****')
    * click(categoryLocator.newCategoryButton)
    * delay(1000)
    * input(categoryLocator.categoryNameInputText, categoryName)
    * print 'categoryName', categoryName
    * delay(1000)
    * mouse().move(categoryLocator.categoryTypeDropdownOnBasicPage).click()
    * def categoryTypeValue = locateAll(categoryLocator.categoryTypeDropdownValue)
    * categoryTypeValue[0].click()
    * delay(1000)
    * click(categoryLocator.nonUrlradioButton)
    * delay(1000)
    * input(categoryLocator.fromDateInput, "01/22/2022")
    * delay(1000)
    * input(categoryLocator.toDateInput, "05/22/2022")
    * delay(1000)
    * mouse().move(categoryLocator.domainDropdown).click()
    * delay(1000)
    * def domainType = locateAll(categoryLocator.domainDropdownValue)
    * domainType[5].click()
    * delay(1000)
    * mouse().move(categoryLocator.geographyDomain).click()
    * delay(1000)
    * def geoType = locateAll(categoryLocator.geographyDomainValue)
    * geoType[3].click()
    * delay(1000)
    * mouse().move(categoryLocator.ptValueDropdown).click()
    * delay(1000)
    * def PtValue = locateAll(categoryLocator.categoryProductPopupValue)
    * PtValue[45].click()
    * mouse().move(categoryLocator.categoryOccDropdown).click()
    * delay(1000)
    * def occassionValue = locateAll(categoryLocator.categoryOccPopupValue)
    * occassionValue[5].click()
    * delay(1000)
    * click(categoryLocator.continueButton)
    * delay(1000)
    * click(categoryLocator.micrositeplpPLP)
    * delay(1000)
    * click(categoryLocator.continueButton)
    * match text(categoryLocator.createCanonicalUrl) == 'Canonical URL *'
    * delay(1000)
    * match text(categoryLocator.canonicalTypLabel) == 'Canonical Type *'
    * match text(categoryLocator.categorySeoContentTxt) == 'Please click on this button to manage the SEO content for this category'
    * match text(categoryLocator.manageContentTxtLabel) == categoryConstant.manageContentTxt
    * match text(categoryLocator.previousButtonOnCategoryPage) == categoryConstant.previousButtonTxt
    * match text(categoryLocator.continueButtonOnCategoryPage) == categoryConstant.continueButtonTxt
    * delay(1000)
    * mouse().move(categoryLocator.canonicalTypDropdown).click()
    * delay(1000)
    * def canonicalValue = scriptAll(categoryLocator.canonicalTypUrl, '_.textContent')
    * def canonicalLabel = locateAll(categoryLocator.canonicalTypUrl)
    * match canonicalValue[0] == 'SELF'
    * match canonicalValue[1] == 'REFERENCE'
    * match karate.sizeOf(canonicalLabel) == 2
    * click(categoryLocator.continueButton)
    * match text(categoryLocator.categoryContentPageTxt) == 'Please click on this button to manage content for this category'
    * match text(categoryLocator.manageContentTxtLabel) == categoryConstant.manageContentTxt
    * match text(categoryLocator.previousButtonOnCategoryPage) == categoryConstant.previousButtonTxt
    * match text(categoryLocator.continueButtonOnCategoryPage) == categoryConstant.continueButtonTxt
    * click(categoryLocator.continueButton)
    * delay(1000)
    * match enabled(categoryLocator.associationChkBox) == true
    * click(categoryLocator.associationChkBox)
    * delay(1000)
    * match text(categoryLocator.categoryAssoPageTxt) == 'Association Product and base category sequencing or not'
    * match text(categoryLocator.previousButtonOnCategoryPage) == categoryConstant.previousButtonTxt
    * delay(1000)
    * match text(categoryLocator.continueButtonOnCategoryPage) == 'CREATE'
    * click(categoryLocator.continueButtonOnCategoryPage)
    * waitForText('body', 'Category already exists with same combination of D/G/P/PT/O/C/R')
    * karate.log('***Category already exists with same combination of D/G/P/PT/O/C/R****')

    
 
  Scenario: Verify Super Admin can nott create category with Invalid taxonomy attributes
  
    * karate.log('***seo Configuration Tab is enabled****')
    * click(categoryLocator.newCategoryButton)
    * delay(1000)
    * input(categoryLocator.categoryNameInputText, categoryName)
    * print 'categoryName', categoryName
    * delay(1000)
    * mouse().move(categoryLocator.categoryTypeDropdownOnBasicPage).click()
    * def categoryTypeValue = locateAll(categoryLocator.categoryTypeDropdownValue)
    * categoryTypeValue[0].click()
    * delay(1000)
    * click(categoryLocator.nonUrlradioButton)
    * delay(1000)
    * input(categoryLocator.fromDateInput, "01/22/2022")
    * delay(1000)
    * input(categoryLocator.toDateInput, "05/22/2022")
    * delay(1000)
    * mouse().move(categoryLocator.domainDropdown).click()
    * delay(1000)
    * def domainType = locateAll(categoryLocator.domainDropdownValue)
    * domainType[1].click()
    * delay(1000)
    * mouse().move(categoryLocator.geographyDomain).click()
    * delay(1000)
    * def geoType = locateAll(categoryLocator.geographyDomainValue)
    * geoType[4].click()
    * delay(1000)
    * mouse().move(categoryLocator.ptValueDropdown).click()
    * delay(1000)
    * def PtValue = locateAll(categoryLocator.categoryProductPopupValue)
    * PtValue[4].click()
    * mouse().move(categoryLocator.categoryOccDropdown).click()
    * delay(1000)
    * def occassionValue = locateAll(categoryLocator.categoryOccPopupValue)
    * occassionValue[5].click()
    * delay(1000)
    * click(categoryLocator.continueButton)
    * delay(1000)
    * click(categoryLocator.micrositeplpPLP)
    * delay(1000)
    * click(categoryLocator.continueButton)
    * delay(1000)
    * clear(categoryLocator.clearCanonicalUrl)
    * delay(1000)
    * click(categoryLocator.continueButton)
    * delay(1000)
    * click(categoryLocator.continueButton)
    * delay(1000)  
    * click(categoryLocator.associationChkBox)
    * delay(1000)
    * delay(1000)
    * click(categoryLocator.continueButtonOnCategoryPage)
    * waitForText('body', 'Invalid taxonomy attributes')
    * karate.log('***Invalid taxonomy attributes****')