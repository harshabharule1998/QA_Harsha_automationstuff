Feature: Category SEO Super Admin Update and View feature

  Background: 
    * def loginLocator = read('../../data/loginPage_locator.json')
    * def usersValue = read('../../data/users.json')
    * def dashBoardLocator = read('../../data//dashboard_locators.json')
    * def categoryLocator = read('../../data/categoryPage_locators.json')
    * def categoryConstant = read('../../data/categoryPage_constants.json')
    * def today = new java.util.Date().time
    * def num = today + ""
    * def num = num.substring(14)
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
    * def categoryName = scriptAll(categoryLocator.categoryNameList, '_.textContent')
    * delay(3000)
    * def options = scriptAll(categoryLocator.optionOnThreeDots, '_.textContent')
    * def optionValueOnThreeDots = locateAll(categoryLocator.optionOnThreeDots)
    * click(categoryLocator.dots)
    * delay(2000)
    * optionValueOnThreeDots[0].click()
    * delay(1000)
    * def tabsNameOnCategoryViewPage = scriptAll(categoryLocator.tabDetails, '_.textContent')
    * delay(1000)
    * def tabsNameOnCategoryViewPage = locateAll(categoryLocator.tabDetails)
    * tabsNameOnCategoryViewPage[3].click()


  #REV2-13434/REV2-13433
  Scenario: Verify SEO tab on view page of categoryId for Super Admin
    * karate.log('***Mandatory field on Basic details page****')
    * delay(1000)
    * def tabsNameOnCategoryViewPage = scriptAll(categoryLocator.tabDetails, '_.textContent')
    * delay(1000)
    * match tabsNameOnCategoryViewPage[3] == categoryConstant.seoTabTxt
    * delay(1000)
    * match enabled(categoryLocator.editIconSEOPage) == true
    * match text(categoryLocator.seoManagementTxt) == categoryConstant.categorySEOManagementTxt
    * match text(categoryLocator.canonicalUrlLabelOnSEO) == categoryConstant.canonicalURLTxt
    * match text(categoryLocator.canonicalTypeLabel) == categoryConstant.canonicalTypeTxt

  Scenario: Verify isEnable seo tab after click on seo tab of categoryId for Super Admin
    * karate.log('***Mandatory field on Basic details page****')
    * delay(2000)
    * def tabsNameOnCategoryViewPage = scriptAll(categoryLocator.tabDetails, '_.textContent')
    * delay(1000)
    * match enabled(categoryLocator.seoTab) == true


  #REV2-13435
  Scenario: Verify edit icon on seo tab of categoryId for Super Admin
    * karate.log('***Mandatory field on Basic details page****')
    * delay(2000)
    * match enabled(categoryLocator.editIconSEOPage) == true


  #REV2-13436
  Scenario: Verify edit icon functionality for category seo tab
    * karate.log('***Mandatory field on Basic details page****')
    * delay(1000)
    * click(categoryLocator.editIconSEOPage)
    * delay(1000)
    * mouse().move("[id='canonical.type']").click()
    * delay(1000)
    * def canonicalValueOnDropDownValue = scriptAll(categoryLocator.canonicalTypeLabelUrlDropDownvalue, '_.textContent')
    * def canonicalValueOnDropDownValueSize = locateAll(categoryLocator.canonicalTypeLabelUrlDropDownvalue)
    * match canonicalValueOnDropDownValue[0] == 'SELF'
    * match canonicalValueOnDropDownValue[1] == 'REFERENCE'
    * match karate.sizeOf(canonicalValueOnDropDownValueSize) == 2
    * match text(categoryLocator.seoCancelbtn) == categoryConstant.seoCancelbtntxt
    * delay(4000)
    * match text(categoryLocator.seoCancelbtn) == categoryConstant.seoCancelbtntxt
    * match text(categoryLocator.seoUpdatebtn) == categoryConstant.seoUpdatebtntxt
    * click(categoryLocator.seoUpdatebtn)
    * delay(4000)
    * match text(categoryLocator.confirmationOnDialog) == 'Are you sure you want to update this SEO details'
    * match text(categoryLocator.cancelButtonOnPopup) == 'Cancel'
    * match text(categoryLocator.continueButtonOnPopup) == 'Continue'
    * click(categoryLocator.continueButtonOnPopup)
    * delay(1000)
    * waitForText('body', 'There is nothing to update')
    * delay(2000)


  Scenario: Verify category seo with invalid data for super admin
    * karate.log('***Mandatory field on Basic details page****')
    * delay(1000)
    * click(categoryLocator.editIconSEOPage)
    * delay(1000)
    * mouse().move("[id='canonical.type']").click()
    * delay(1000)
    * def canonicalValueOnDropDownValue = scriptAll(categoryLocator.canonicalTypeLabelUrlDropDownvalue, '_.textContent')
    * def canonicalValueOnDropDownValueSize = locateAll(categoryLocator.canonicalTypeLabelUrlDropDownvalue)
    * match canonicalValueOnDropDownValue[0] == 'SELF'
    * match canonicalValueOnDropDownValue[1] == 'REFERENCE'
    * canonicalValueOnDropDownValueSize[0].click()
    * match karate.sizeOf(canonicalValueOnDropDownValueSize) == 2
    * match text(categoryLocator.seoCancelbtn) == categoryConstant.seoCancelbtntxt
    * delay(4000)
    * match text(categoryLocator.seoCancelbtn) == categoryConstant.seoCancelbtntxt
    * match text(categoryLocator.seoUpdatebtn) == categoryConstant.seoUpdatebtntxt
    * click(categoryLocator.seoUpdatebtn)
    * delay(4000)
    * match text(categoryLocator.confirmationOnDialog) == 'Are you sure you want to update this SEO details'
    * match text(categoryLocator.cancelButtonOnPopup) == 'Cancel'
    * match text(categoryLocator.continueButtonOnPopup) == 'Continue'
    * click(categoryLocator.continueButtonOnPopup)
    * delay(1000)
    * waitForText('body', 'canonical URL should match with category URL for self canonical type')
    * delay(2000)


  Scenario: Verify category seo with valid data for super admin
    * karate.log('***Mandatory field on Basic details page****')
    * delay(1000)
    * click(dashBoardLocator.switchMenu)
    * delay(3000)
    * click(dashBoardLocator.galleriaMenu)
    * refresh()
    * delay(4000)
    * input(categoryLocator.searchInputBox, "10000077")
    * delay(4000)
    * def optionValueOnThreeDots = locateAll(categoryLocator.optionOnThreeDots)
    * click(categoryLocator.dots)
    * delay(2000)
    * optionValueOnThreeDots[0].click()
    * def tabsNameOnCategoryViewPage = locateAll(categoryLocator.tabDetails)
    * tabsNameOnCategoryViewPage[2].click()
    * click(categoryLocator.editIconSEOPage)
    * delay(1000)
    * mouse().move("[id='canonical.type']").click()
    * delay(1000)
    * def canonicalValueOnDropDownValue = scriptAll(categoryLocator.canonicalTypeLabelUrlDropDownvalue, '_.textContent')
    * def canonicalValueOnDropDownValueSize = locateAll(categoryLocator.canonicalTypeLabelUrlDropDownvalue)
    * match canonicalValueOnDropDownValue[0] == 'SELF'
    * match canonicalValueOnDropDownValue[1] == 'REFERENCE'
    * canonicalValueOnDropDownValueSize[1].click()
    * match karate.sizeOf(canonicalValueOnDropDownValueSize) == 2
    * match text(categoryLocator.seoCancelbtn) == categoryConstant.seoCancelbtntxt
    * delay(4000)
    * match text(categoryLocator.seoCancelbtn) == categoryConstant.seoCancelbtntxt
    * match text(categoryLocator.seoUpdatebtn) == categoryConstant.seoUpdatebtntxt
    * click(categoryLocator.seoUpdatebtn)
    * delay(4000)
    * match text(categoryLocator.confirmationOnDialog) == 'Are you sure you want to update this SEO details'
    * match text(categoryLocator.cancelButtonOnPopup) == 'Cancel'
    * match text(categoryLocator.continueButtonOnPopup) == 'Continue'
    * click(categoryLocator.continueButtonOnPopup)
    * delay(1000)
    * waitForText('body', 'Category SEO updated successfully')
    * delay(2000)
