Feature: Verify header footer of FNP application

  Background: 
    * def headerFooterLocator = read('../../data/headerFooterPage_locators.json')
    * def headerFooterConstant = read('../../data/headerFooterPage_constants.json')
    * def loginConstant = read('../../data/loginPage_constants.json')
    * def loginLocator = read('../../data/loginPage_locator.json')
    * def dashBoardLocator = read('../../data//dashboard_locators.json')
    * def usersValue = read('../../data/users.json')
    * configure driver = driverConfig
    * driver backOfficeUrl
    * maximize()
    * match text(loginLocator.loginText) == loginConstant.loginText
    * karate.log('***Logging into the application****')
    * input(loginLocator.usernameTextArea, usersValue.users.superAdmin.email)
    * delay(3000)
    * input(loginLocator.passwordTextArea, usersValue.users.superAdmin.password)
    * delay(3000)
    * click(loginLocator.loginButton)
    * karate.log('***Logging into the application****')
    * delay(3000)


  #REV2-16135/REV2-16133
  Scenario: Verify all the labels and text displayed on header and footer.
    * karate.log('***Logging into the application****')
    * match text(headerFooterLocator.quotation) == headerFooterConstant.quotationTxt
    * match text(headerFooterLocator.dashboardText) == headerFooterConstant.dashboradText
    * delay(3000)
    * scroll(headerFooterLocator.copyRight)
    * delay(3000)
    * match text(headerFooterLocator.copyRight) contains headerFooterConstant.copyRightTxt1
    * match text(headerFooterLocator.copyRight) contains headerFooterConstant.copyRightTxt2


  #BugId-REV2-16307
  #REV2-16131
  Scenario: Verify User Profile menu is present on Header.
    * karate.log('***Logging into the application****')
    * delay(1000)
    * match enabled(headerFooterLocator.userProfileDropdown) == true
    * delay(2000)
    * match text(headerFooterLocator.userProfileTxt) contains 'Welcome'
    * delay(2000)
    * match enabled(headerFooterLocator.userProfileIcon) == true
    * delay(2000)
    * match enabled(headerFooterLocator.userProfileDropDownIcon) == true
    * delay(5000)
    * click(headerFooterLocator.userProfileDropdown)
    * def userProfilePopText = scriptAll(headerFooterLocator.userProfilePopupTxt, '_.textContent')
    * match userProfilePopText[0] == 'TESTUSER-N0260919@fnp.com'
    * match userProfilePopText[1] == "Ferns N Petals Pvt. Ltd. [fnp]"
    * match text(headerFooterLocator.UserProfileSignOut) == headerFooterConstant.UserProfileSignOutText


  Scenario: Verify User Profile menu and SIGN OUT functionality on Header
    * karate.log('***Logging into the application****')
    * delay(1000)
    * click(headerFooterLocator.userProfileDropdown)
    * delay(1000)
    * click(headerFooterLocator.UserProfileSignOut)
    * match driver.url == 'https://zeus-test-r2.fnp.com/#/login'
    * match text(headerFooterLocator.loginButton) == 'Login'


  #REV2-16130
  Scenario: Verify Help menu is present on Header.
    * karate.log('***Logging into the application****')
    * delay(3000)
    * match enabled(headerFooterLocator.helpMenu) == true

  
  #REV2-16129
  Scenario: Verify Notification icon is present on Header
    * karate.log('***Logging into the application****')
    * delay(3000)
    * match enabled(headerFooterLocator.notificationIcon) == true


  # REV2-16128
  Scenario: Verify Quick Link is present on Header.
    * karate.log('***Logging into the application****')
    * delay(3000)
    * match enabled(headerFooterLocator.quickLinks) == true
    * click(headerFooterLocator.quickLinks)
    * def quicklinkOption = scriptAll(headerFooterLocator.quickLinkPopupTxt, '_.textContent')
    * match quicklinkOption[0] == headerFooterConstant.quickLinksRecentVisitedText
    * match quicklinkOption[1] == headerFooterConstant.quickLinksQuickLinksText

  
  #REV2-16124
  Scenario: Verify Switch Menu is displayed on the header of all the pages.
    * karate.log('***Logging into the application****')
    * delay(3000)
    * match enabled(headerFooterLocator.switchMenu) == true
    * click(headerFooterLocator.switchMenu)
    * delay(3000)

  
  #REV2-16123
  Scenario: Verify Logo is displayed on the header of all the pages.
    * karate.log('***Logging into the application****')
    * delay(3000)
    * match enabled("[data-at-id='logo']") == true

  
  #REV2-16125
  Scenario: Verify Mega menu is displayed on the Header of the page.
    * karate.log('***Logging into the application****')
    * delay(3000)
    * click(headerFooterLocator.switchMenu)
    * def megaMenu = locateAll(headerFooterLocator.megaMenuList)
    * assert karate.sizeOf(megaMenu) >= 9

  
  #REV2-16134
  Scenario: Verify Header placeholder displaying the title Category Management of selected Menu
    * karate.log('***Logging into the application****')
    * delay(3000)
    * click(headerFooterLocator.switchMenu)
    * def megaMenu = locateAll(headerFooterLocator.megaMenuList)
    * def megaMenuName = scriptAll(headerFooterLocator.megaMenuList, '_.textContent')
    * match megaMenuName[0] contains 'GALLERIA'
    * megaMenu[0].click()
    * match text(headerFooterLocator.galleriaMenu) == 'Category Management'


  #REV2-16134
  Scenario: Verify Header placeholder displaying the title Redirect Search of selected Menu
    * karate.log('***Logging into the application****')
    * delay(3000)
    * click(headerFooterLocator.switchMenu)
    * def megaMenu = locateAll(headerFooterLocator.megaMenuList)
    * def megaMenuName = scriptAll(headerFooterLocator.megaMenuList, '_.textContent')
    * match megaMenuName[1] contains 'Redirect'
    * megaMenu[1].click()
    * match text(headerFooterLocator.galleriaMenu) == 'Redirect Search'
