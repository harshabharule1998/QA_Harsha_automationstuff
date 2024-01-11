Feature: Party list of user with status for admin role

  Background: 
    * def loginLocator = read('../../data/loginPage_locator.json')
    * def usersValue = read('../../data/users.json')
    * def dashBoardLocator = read('../../data//dashboard_locators.json')
    * def pUserListLocator = read('../../data/party/pUserListPage_locators.json')
    * def pUserListConstant = read('../../data/party/pUserListPage_constants.json')
    * configure driver = driverConfig
    * driver backOfficeUrl
    * maximize()
    * karate.log('***Logging into the application****')
    * input(loginLocator.usernameTextArea, usersValue.users.superAdmin.email)
    * delay(1000)
    * input(loginLocator.passwordTextArea, usersValue.users.superAdmin.password)
    * delay(1000)
    * click(loginLocator.loginButton)
    * delay(1000)
    * click(dashBoardLocator.switchMenu)
    * delay(1000)
    * click(dashBoardLocator.partyMenu)
    * delay(1000)
    * delay(3000)
    * mouse().move(pUserListLocator.partyTypeDropdown).click()
    * def optionOnDropDown = locateAll(pUserListLocator.partyTypeDropdownMenu)
    * delay(1000)
    * optionOnDropDown[0].click()
    * delay(1000)
    * input(pUserListLocator.partyName, 'manish')
    * click(pUserListLocator.clickOnApply)
    * delay(1000)
    * click(pUserListLocator.clickOnPartyId)
    And match enabled(pUserListLocator.userNameTab) == true
    * click(pUserListLocator.userNameTab)
    * match driver.url contains '/show/usernames'
    * delay(2000)

  #REV2-19548/REV2-19537
  Scenario: Verify the functionality of pagination page per records for admin
    * scroll(pUserListLocator.paginationOnList)
    * delay(100)
    * def paginationTxt = scriptAll(pUserListLocator.paginationTxtOnList, '_.textContent')
    * match paginationTxt[0] contains 'Rows per page'
    * delay(1000)
    * mouse().move(pUserListLocator.paginationDropdownTxt).click()
    * delay(3000)
    * def dropDownPrint = scriptAll(pUserListLocator.paginationDropDownOption, '_.textContent')
    * match dropDownPrint[0] == '5'
    * match dropDownPrint[1] == '10'
    * match dropDownPrint[2] == '25'
    * match dropDownPrint[3] == '50'
    * def optionOnPagin = locateAll(pUserListLocator.paginationDropDownOption)
    * delay(5000)
    * optionOnPagin[0].click()
    * delay(2000)
    * delay(2000)
    * def userId = scriptAll(pUserListLocator.partyIdList, '_.textContent')
    * delay(1000)
    * match karate.sizeOf(userId) == 5

  #REV2-19547/REV2-19546
  Scenario: Verify the functionality of three dots options Edit for admin
    * delay(3000)
    * def optionsTxt = scriptAll(pUserListLocator.optionOnThreeDots, '_.textContent')
    * def options = locateAll(pUserListLocator.optionOnThreeDots)
    * click(pUserListLocator.dots)
    * delay(2000)
    * options[0].click()
    * karate.log('*** Open Login id edit page ****')
    * match text(pUserListLocator.updateButton) == 'Update'

  #REV2-19545
  Scenario: Verify the functionality of New Username button for admin
    * delay(3000)
    And match enabled(pUserListLocator.newUsernameButton) == true
    * click(pUserListLocator.newUsernameButton)
    * match driver.url contains '/create'
    * match text(pUserListLocator.createButton) == 'CREATE'

  #REV2-19544
  Scenario: Verify grid functionality on list screen for admin
    * match enabled(pUserListLocator.gridOnPage) == true
    * click(pUserListLocator.gridOnPage)
    * match text(pUserListLocator.titleOnGrid) == 'Configuration'
    * delay(4000)
    * def columnNameOnGrid = scriptAll(pUserListLocator.columnNameOnGrid, '_.textContent')
    * delay(3000)
    * match  columnNameOnGrid[0] == "User Login Id"
    * match  columnNameOnGrid[1] == "Status"

  ############## REV2-19538 REV2-19539 REV2-19542 REV2-19543
  #REV2-19533
  Scenario: Verify that the super admin access user can sort the list of userId
    * karate.log('*** Sort Userpe list in ascending order ****')
    * def ArrayList = Java.type('java.util.ArrayList')
    * def Collections = Java.type('java.util.Collections')
    * def userIdSortedList = new ArrayList()
    * def userIdListLables = new ArrayList()
    * def userIdList = scriptAll(pUserListLocator.listOfUser, '_.textContent')
    * karate.repeat(userIdList.length, function(i){ userIdListLables.add(userIdList[i]) })
    * karate.log('userIdListLables  before sort : ', userIdListLables)
    * Collections.sort(userIdListLables)
    * karate.log('userIdListLables  after sort : ', userIdListLables)
    * click(pUserListLocator.userLoginIdIndex)
    * delay(1000)
    * def userIdList = scriptAll(pUserListLocator.listOfUser, '_.textContent')
    * karate.repeat(userIdList.length, function(i){ userIdSortedList.add(userIdList[i]) })
    * karate.log('userIdSortedList  after sort : ', userIdSortedList)
    * match userIdListLables != userIdSortedList
    * delay(1000)

  #REV2-19533
  Scenario: Verify that the super admin access user can sort the list of userId status
    * karate.log('*** Sort Userpe list in ascending order ****')
    * def ArrayList = Java.type('java.util.ArrayList')
    * def Collections = Java.type('java.util.Collections')
    * def userIdSortedList = new ArrayList()
    * def userIdListLables = new ArrayList()
    * def userIdListStatus = scriptAll(pUserListLocator.userStatus, '_.textContent')
    * karate.repeat(userIdListStatus.length, function(i){ userIdListLables.add(userIdListStatus[i]) })
    * karate.log('userIdListLables  before sort : ', userIdListLables)
    * Collections.sort(userIdListLables)
    * karate.log('userIdListLables  after sort : ', userIdListLables)
    * click(pUserListLocator.userStatusIndex)
    * delay(1000)
    * def userIdListStatus = scriptAll(pUserListLocator.userStatus, '_.textContent')
    * karate.repeat(userIdListStatus.length, function(i){ userIdSortedList.add(userIdListStatus[i]) })
    * karate.log('userIdSortedList  after sort : ', userIdSortedList)
    * match userIdListLables != userIdSortedList
    * delay(1000)
