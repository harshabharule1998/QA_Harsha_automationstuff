Feature: Category Configurations Super Admin CRUD feature

  Background: 
    * def loginLocator = read('../../data/loginPage_locator.json')
    * def usersValue = read('../../data/users.json')
    * def dashBoardLocator = read('../../data//dashboard_locators.json')
    * def categoryLocator = read('../../data/categoryPage_locators.json')
    * def categoryConstant = read('../../data/categoryPage_constants.json')
    * def today = new java.util.Date().time
    * def num = today + ""
    * def num = num.substring(14)
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
    * tabsNameOnCategoryViewPage[4].click()


  Scenario: Verify Configurations tab on view page of categoryId for Super Admin.
    * karate.log('***Mandatory field on Basic details page****')
    * delay(2000)
    * def tabsNameOnCategoryViewPage = scriptAll(categoryLocator.tabDetails, '_.textContent')
    * delay(1000)
    * match tabsNameOnCategoryViewPage[4] == categoryConstant.confiTabTxt


  Scenario: Verify is Enable after click on Configurations tab of categoryId for Super Admin.
    * karate.log('***Mandatory field on Basic details page****')
    * delay(2000)
    * def tabsNameOnCategoryViewPage = scriptAll(categoryLocator.tabDetails, '_.textContent')
    * delay(1000)
    * match tabsNameOnCategoryViewPage[4] == categoryConstant.confiTabTxt
    * def tabsNameOnCategoryViewPage = locateAll(categoryLocator.tabDetails)
    * tabsNameOnCategoryViewPage[4].click()
    * delay(1000)
    * match enabled(categoryLocator.configurationTab) == true


  Scenario: Verify edit icon on Configurations tab of categoryId for Super Admin.
    * karate.log('***Mandatory field on Basic details page****')
    * delay(2000)
    * def tabsNameOnCategoryViewPage = locateAll(categoryLocator.tabDetails)
    * tabsNameOnCategoryViewPage[4].click()
    * delay(1000)
    * match enabled(categoryLocator.editIconOnConfigPage) == true


  Scenario: Verify functionality of edit icon on Configurations tab of categoryId for Super Admin.
    * karate.log('***Mandatory field on Basic details page****')
    * delay(1000)
    * click(categoryLocator.editIconOnConfigPage)
    * delay(4000)
    * match enabled(categoryLocator.cancelButtonOnConfigUpdatePage) == true
    * match enabled(categoryLocator.updateButtonOnConfigUpdatePage) == true


  #REV2-8842
  Scenario: Verify view page label text on Configurations tab of categoryId for Super Admin.
    * karate.log('***Mandatory field on Basic details page****')
    * delay(3000)
    * def labelTxtOnConfigViewPage = scriptAll(categoryLocator.LabelTxtOnConfigViewPage, '_.textContent')
    * print 'labelTxtOnConfigEditPage', labelTxtOnConfigViewPage
    * delay(2000)
    * match  labelTxtOnConfigViewPage[1] == categoryConstant.isSearchableLabelTxt
    * match  labelTxtOnConfigViewPage[2] == categoryConstant.includeSearchDropdownLabelTxt
    * match  labelTxtOnConfigViewPage[9] == categoryConstant.standardPLPLabelTxt
    * match  labelTxtOnConfigViewPage[10] == categoryConstant.sitemapLabelTxt
    * match  labelTxtOnConfigViewPage[11] == categoryConstant.productMappingLabelTxt
    * match  labelTxtOnConfigViewPage[12] == categoryConstant.autoSequencingLabelTxt
    * match  labelTxtOnConfigViewPage[13] == categoryConstant.mappingOverrideLabelTxt
    * match  labelTxtOnConfigViewPage[14] == categoryConstant.allowSequencingLabelTxt
    * match  labelTxtOnConfigViewPage[15] == categoryConstant.InherSequencingLabelTxt
    * match  labelTxtOnConfigViewPage[16] == categoryConstant.searchSequenceLabelTxt
    * match  labelTxtOnConfigViewPage[17] == categoryConstant.isFeaturedInSearchLabelTxt
    * match  labelTxtOnConfigViewPage[18] == categoryConstant.displayNameLabelTxt
    * match text(categoryLocator.categoryTypeLabelOnConfigPage) == categoryConstant.categoryTypeLabelTxt


  Scenario: Verify edit page label text on Configurations tab of categoryId for Super Admin.
    * karate.log('***Mandatory field on Basic details page****')
    * delay(1000)
    * click(categoryLocator.editIconOnConfigPage)
    * delay(2000)
    * def labelTxtOnConfigEditPage = scriptAll(categoryLocator.LabelTxtOnConfigEditPage, '_.textContent')
    * delay(2000)
    * match  labelTxtOnConfigEditPage[0] == categoryConstant.isSearchableLabelTxt
    * match  labelTxtOnConfigEditPage[1] == categoryConstant.includeSearchDropdownLabelTxt
    * match  labelTxtOnConfigEditPage[2] == categoryConstant.standardPLPLabelTxt
    * match  labelTxtOnConfigEditPage[3] == categoryConstant.sitemapLabelTxt
    * match  labelTxtOnConfigEditPage[4] == categoryConstant.productMappingLabelTxt
    * match  labelTxtOnConfigEditPage[5] == categoryConstant.autoSequencingLabelTxt
    * match  labelTxtOnConfigEditPage[6] == categoryConstant.mappingOverrideLabelTxt
    * match  labelTxtOnConfigEditPage[7] == categoryConstant.allowSequencingLabelTxt
    * match  labelTxtOnConfigEditPage[8] == categoryConstant.InherSequencingLabelTxt
    * match  labelTxtOnConfigEditPage[9] == categoryConstant.isFeaturedInSearchLabelTxt
    * match  labelTxtOnConfigEditPage[10] == categoryConstant.displayNameLabelTxt
    * match text(categoryLocator.categoryTypeLabelTxt) == categoryConstant.categoryTypeLabelTxt
    * match text(categoryLocator.featuredSearchSequenceconfigEditPage) == categoryConstant.searchSequenceLabelTxt


  #REV2-8830/REV2-8844
  Scenario: Verify super admin can Edit category Configurations page
    * karate.log('***Update category configuration page****')
    * delay(1000)
    * def ValueOnConfigViewPageBeforeEdit = scriptAll(categoryLocator.ValueOfAllFieldOnConfigViewPage, '_.textContent')
    * click(categoryLocator.editIconOnConfigPage)
    * delay(2000)
    * clear(categoryLocator.featurSequenceField)
    * input(categoryLocator.featurSequenceField, 1)
    * delay(2000)
    * click(categoryLocator.updateButtonOnConfigUpdatePage)
    * match text(categoryLocator.confirmationOnDialog) == 'Are you sure you want to update this configurations?'
    * match text(categoryLocator.cancelButtonOnPopup) == 'Cancel'
    * match text(categoryLocator.continueButtonOnPopup) == 'Continue'
    * delay(2000)
    * click(categoryLocator.continueButtonOnPopup)
    * delay(1000)
    * waitForText('body', 'Category configuration updated successfully')


  Scenario: Verify super admin can not update category configuration page with duplicate data
    * karate.log('***Update category configuration page****')
    * delay(1000)
    * def ValueOnConfigViewPageBeforeEdit = scriptAll(categoryLocator.ValueOfAllFieldOnConfigViewPage, '_.textContent')
    * click(categoryLocator.editIconOnConfigPage)
    * delay(2000)
    * click(categoryLocator.updateButtonOnConfigUpdatePage)
    * match text(categoryLocator.confirmationOnDialog) == 'Are you sure you want to update this configurations?'
    * match text(categoryLocator.cancelButtonOnPopup) == 'Cancel'
    * match text(categoryLocator.continueButtonOnPopup) == 'Continue'
    * delay(2000)
    * click(categoryLocator.continueButtonOnPopup)
    * delay(1000)
    * waitForText('body', 'There is nothing to update')


  Scenario: Verify super admin can not update category configuration page with Invalid data
    * karate.log('***Update category configuration page****')
    * delay(1000)
    * def ValueOnConfigViewPageBeforeEdit = scriptAll(categoryLocator.ValueOfAllFieldOnConfigViewPage, '_.textContent')
    * click(categoryLocator.editIconOnConfigPage)
    * delay(2000)
    * clear(categoryLocator.featurSequenceField)
    * input(categoryLocator.featurSequenceField, 123456789)
    * delay(2000)
    * click(categoryLocator.updateButtonOnConfigUpdatePage)
    * match text(categoryLocator.confirmationOnDialog) == 'Are you sure you want to update this configurations?'
    * match text(categoryLocator.cancelButtonOnPopup) == 'Cancel'
    * match text(categoryLocator.continueButtonOnPopup) == 'Continue'
    * delay(2000)
    * click(categoryLocator.continueButtonOnPopup)
    * delay(1000)
    * waitForText('body', 'Invalid input data')


  #REV2-8828
  Scenario: Verify that Super Admin User navigates to Cancel Edit the category configurations
    * karate.log('***Update category configuration page****')
    * delay(1000)
    * def valueOnConfigViewPageBeforeEdit = scriptAll(categoryLocator.ValueOfAllFieldOnConfigViewPage, '_.textContent')
    * click(categoryLocator.editIconOnConfigPage)
    * delay(2000)
    * clear(categoryLocator.featurSequenceField)
    * input(categoryLocator.featurSequenceField, 1)
    * delay(2000)
    * click(categoryLocator.updateButtonOnConfigUpdatePage)
    * match text(categoryLocator.confirmationOnDialog) == 'Are you sure you want to update this configurations?'
    * match text(categoryLocator.cancelButtonOnPopup) == 'Cancel'
    * match text(categoryLocator.continueButtonOnPopup) == 'Continue'
    * delay(2000)
    * click(categoryLocator.cancelButtonOnPopup)
    * delay(4000)
    * click(categoryLocator.seoTab)
    * click(categoryLocator.configurationTab)
    * delay(4000)
    * def valueOnConfigViewPageAfterEdit = scriptAll(categoryLocator.ValueOfAllFieldOnConfigViewPage, '_.textContent')
    * delay(2000)
    * match valueOnConfigViewPageBeforeEdit[11] == valueOnConfigViewPageAfterEdit[11]
