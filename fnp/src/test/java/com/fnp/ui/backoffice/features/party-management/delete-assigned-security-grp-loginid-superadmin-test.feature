Feature: UI scenarios for delete assigned security group from party loginid for super admin

  Background: 
    * def loginLocator = read('../../data/loginPage_locator.json')
    * def usersValue = read('../../data/users.json')
    * def dashBoardLocator = read('../../data//dashboard_locators.json')
    * def deleteSecurityGrouplocators = read('../../data/party/deleteSecurityGroupPage_locators.json')
    * def deleteSecurityGroupConstant = read('../../data/party/deleteSecurityGroupPage_constants.json')
    
    * configure driver = driverConfig
    * driver backOfficeUrl
    * print '***backofficeurl***' backOfficeUrl
    And maximize()
    
    * karate.log('***Logging into the application****')
    And input(loginLocator.usernameTextArea, usersValue.users.superAdmin.email)
    * delay(10)
    And input(loginLocator.passwordTextArea, usersValue.users.superAdmin.password)
    * delay(10)
    
    When click(loginLocator.loginButton)
    * karate.log('***Logging into the application****')
    * delay(10)
    And click(dashBoardLocator.switchMenu)
    * delay(10)
    And click(dashBoardLocator.partyMenu)
    * delay(1020)
		* mouse().move(deleteSecurityGrouplocators.partyTypeDropdownTxt).click()

    * delay(2000)
    * def dropdownTxt = scriptAll( deleteSecurityGrouplocators.partyTypeDropdownMenu, '_.textContent')
    * print 'Dropdown', dropdownTxt
    * delay(2000)
    * match dropdownTxt[0] contains 'Individual'
    * match dropdownTxt[1] contains 'Organization'
    * delay(1000)
    
    * def optionOnDropDown = locateAll( deleteSecurityGrouplocators.partyTypeDropdownMenu)
    * delay(1000)
    * match karate.sizeOf(optionOnDropDown) == 2
    * optionOnDropDown[0].click()
    * delay(2000) 
    
    * input(deleteSecurityGrouplocators.typePartyId,deleteSecurityGroupConstant.lablePartyIdText)
    * delay(1000)
    * click(deleteSecurityGrouplocators.apply)
    * delay(1000)
    * click(deleteSecurityGrouplocators.typePartyIds)
    * delay(100)
    
   
  #REV2-19939
	Scenario: Verify Usernames tab for Super Admin
    
    * karate.log('***Usernames tab info****')
    * match text(deleteSecurityGrouplocators.partyLabel) == deleteSecurityGroupConstant.lablePartyIdText
    * delay(2000)
    * exists(deleteSecurityGrouplocators.usernameTab)
    * delay(2000)
    * click(deleteSecurityGrouplocators.usernameTab)
    * delay(3000)
    
     
  #REV2-19940
	Scenario: Verify Usernames tab and party label for Super Admin
    
    * karate.log('***Usernames tab list****')
    * match text(deleteSecurityGrouplocators.partyLabel) == deleteSecurityGroupConstant.lablePartyIdText
    * delay(2000)
    * exists(deleteSecurityGrouplocators.usernameTab)
    * delay(2000)
    * click(deleteSecurityGrouplocators.usernameTab)
    * delay(3000)
    
    
  #REV2-19941
	Scenario: Verify Usernames tab and label for Super Admin
    
    * karate.log('***Verify Username tab info and label****')
    * match text(deleteSecurityGrouplocators.partyLabel) == deleteSecurityGroupConstant.lablePartyIdText
    * delay(2000)
    * exists(deleteSecurityGrouplocators.usernameTab)
    * delay(2000)
    * click(deleteSecurityGrouplocators.usernameTab)
    * delay(3000)
    * match text(deleteSecurityGrouplocators.partyLabel) == deleteSecurityGroupConstant.lablePartyIdText
    * delay(2000)
   
 	
  #REV2-19942
	Scenario: Verify three dots along each user in Usernames tab for Super Admin
    
    * karate.log('***Verify options in Username tab list****')
    * match text(deleteSecurityGrouplocators.partyLabel) == deleteSecurityGroupConstant.lablePartyIdText
    * delay(2000)
    * exists(deleteSecurityGrouplocators.usernameTab)
    * delay(2000)
    * click(deleteSecurityGrouplocators.usernameTab)
    * delay(3000)
    * exists(deleteSecurityGrouplocators.threeDots)
    * delay(2000)
    * click(deleteSecurityGrouplocators.threeDots)
    * delay(3000)
    * exists(deleteSecurityGrouplocators.editOption)
    * delay(2000)
    * exists(deleteSecurityGrouplocators.assignOption)
    * delay(2000)
    * exists(deleteSecurityGrouplocators.permissionOption)
    * delay(2000)
   

  #REV2-19943
	Scenario: Verify list assigned in security group for Super Admin
    
    * karate.log('***Verify assigned list in security group****')
    * match text(deleteSecurityGrouplocators.partyLabel) == deleteSecurityGroupConstant.lablePartyIdText
    * delay(2000)
    * exists(deleteSecurityGrouplocators.usernameTab)
    * delay(2000)
    * click(deleteSecurityGrouplocators.usernameTab)
    * delay(3000)
    * click(deleteSecurityGrouplocators.threeDots)
    * delay(3000)
    * mouse().move(deleteSecurityGrouplocators.assignOption).click()
    * delay(2000)
    
	
  #REV2-19944
	Scenario: Verify Usernames tab and security group for Super Admin
    
    * karate.log('***Verify assinged Security group list****')
    * match text(deleteSecurityGrouplocators.partyLabel) == deleteSecurityGroupConstant.lablePartyIdText
    * delay(2000)
    * exists(deleteSecurityGrouplocators.usernameTab)
    * delay(2000)
    * click(deleteSecurityGrouplocators.usernameTab)
    * delay(3000)
    * click(deleteSecurityGrouplocators.threeDots)
    * delay(3000)
    * mouse().move(deleteSecurityGrouplocators.assignOption).click()
    * delay(2000)
   	* exists(deleteSecurityGrouplocators.assignSecurityLabel)
    * delay(2000)
    
	
  #REV2-19947
	Scenario: Verify functionalities in security group list for Super Admin
    
    * karate.log('***Verify Assign user login button****')
    * match text(deleteSecurityGrouplocators.partyLabel) == deleteSecurityGroupConstant.lablePartyIdText
    * delay(2000)
    * exists(deleteSecurityGrouplocators.usernameTab)
    * delay(2000)
    * click(deleteSecurityGrouplocators.usernameTab)
    * delay(3000)
    * click(deleteSecurityGrouplocators.threeDots)
    * delay(3000)
    * mouse().move(deleteSecurityGrouplocators.assignOption).click()
    * delay(2000)
   	* exists(deleteSecurityGrouplocators.assignSecurityLabel)
    * delay(2000)
    * exists(deleteSecurityGrouplocators.assignSecurityLabel)
    * delay(2000)
    
 
  #REV2-19948
	Scenario: Verify Cancel and Delete button in delete confirmation window for Super Admin
    
    * karate.log('***Verify confirmation window on security group list****')
    * match text(deleteSecurityGrouplocators.partyLabel) == deleteSecurityGroupConstant.lablePartyIdText
    * delay(2000)
    * exists(deleteSecurityGrouplocators.usernameTab)
    * delay(2000)
    * click(deleteSecurityGrouplocators.usernameTab)
    * delay(3000)
    * click(deleteSecurityGrouplocators.threeDots)
    * delay(3000)
    * mouse().move(deleteSecurityGrouplocators.assignOption).click()
    * delay(2000)
   	* exists(deleteSecurityGrouplocators.assignSecurityLabel)
    * delay(2000)
    * exists(deleteSecurityGrouplocators.assignSecurityLabel)
    * delay(2000)
    * click(deleteSecurityGrouplocators.threeDots)
    * delay(3000)
    * karate.log('*****Verify delete confirmation window when clicked on Delete button*****')
    * mouse().move(deleteSecurityGrouplocators.deleteOption).click()
    * delay(2000)
    * waitForText('body','Are you sure you want to delete Security Group?')
    * delay(2000)
    * exists(deleteSecurityGrouplocators.cancelActionButton)
    * delay(2000)
    * exists(deleteSecurityGrouplocators.deleteActionButton)
    * delay(2000)
    

  #REV2-19949
	Scenario: Verify Cancel button in confirmation window for Super Admin
    
    * karate.log('***Verify cancel button in confirmation window on security group list****')
    * match text(deleteSecurityGrouplocators.partyLabel) == deleteSecurityGroupConstant.lablePartyIdText
    * delay(2000)
    * exists(deleteSecurityGrouplocators.usernameTab)
    * delay(2000)
    * click(deleteSecurityGrouplocators.usernameTab)
    * delay(3000)
    * click(deleteSecurityGrouplocators.threeDots)
    * delay(3000)
    * mouse().move(deleteSecurityGrouplocators.assignOption).click()
    * delay(2000)
   	* exists(deleteSecurityGrouplocators.assignSecurityLabel)
    * delay(2000)
    * exists(deleteSecurityGrouplocators.assignSecurityLabel)
    * delay(2000)
    * click(deleteSecurityGrouplocators.threeDots)
    * delay(3000)
    * mouse().move(deleteSecurityGrouplocators.deleteOption).click()
    * delay(2000)
    * waitForText('body','Are you sure you want to delete Security Group?')
    * delay(2000)
    * exists(deleteSecurityGrouplocators.cancelActionButton)
    * delay(2000)
    * exists(deleteSecurityGrouplocators.deleteActionButton)
    * delay(2000)
    * click(deleteSecurityGrouplocators.cancelActionButton)
    * delay(3000)
   

  #REV2-19950
	Scenario: Verify Delete button in confirmation window for Super Admin
    
    * karate.log('***Verify delete button on confirmation window in security group list****')
    * match text(deleteSecurityGrouplocators.partyLabel) == deleteSecurityGroupConstant.lablePartyIdText
    * delay(2000)
    * exists(deleteSecurityGrouplocators.usernameTab)
    * delay(2000)
    * click(deleteSecurityGrouplocators.usernameTab)
    * delay(3000)
    * click(deleteSecurityGrouplocators.threeDots)
    * delay(3000)
    * mouse().move(deleteSecurityGrouplocators.assignOption).click()
    * delay(2000)
   	* exists(deleteSecurityGrouplocators.assignSecurityLabel)
    * delay(2000)
    * exists(deleteSecurityGrouplocators.assignSecurityLabel)
    * delay(2000)
    * click(deleteSecurityGrouplocators.threeDots)
    * delay(3000)
    * mouse().move(deleteSecurityGrouplocators.deleteOption).click()
    * delay(2000)
    * waitForText('body','Are you sure you want to delete Security Group?')
    * delay(2000)
    * exists(deleteSecurityGrouplocators.cancelActionButton)
    * delay(2000)
    * exists(deleteSecurityGrouplocators.deleteActionButton)
    * delay(2000)
    * click(deleteSecurityGrouplocators.deleteActionButton)
    * delay(3000)
    
 
  #REV2-19951/19952
	Scenario: Verify Delete confirmation message in security group list for Super Admin
    
    * karate.log('***Verify delete confirmation message in security group list****')
    * match text(deleteSecurityGrouplocators.partyLabel) == deleteSecurityGroupConstant.lablePartyIdText
    * delay(2000)
    * exists(deleteSecurityGrouplocators.usernameTab)
    * delay(2000)
    * click(deleteSecurityGrouplocators.usernameTab)
    * delay(3000)
    * click(deleteSecurityGrouplocators.threeDots)
    * delay(3000)
    * mouse().move(deleteSecurityGrouplocators.assignOption).click()
    * delay(2000)
   	* exists(deleteSecurityGrouplocators.assignSecurityLabel)
    * delay(2000)
    * exists(deleteSecurityGrouplocators.assignSecurityLabel)
    * delay(2000)
    * click(deleteSecurityGrouplocators.threeDots)
    * delay(3000)
    * mouse().move(deleteSecurityGrouplocators.deleteOption).click()
    * delay(2000)
    * waitForText('body','Are you sure you want to delete Security Group?')
    * delay(2000)
    * exists(deleteSecurityGrouplocators.cancelActionButton)
    * delay(2000)
    * exists(deleteSecurityGrouplocators.deleteActionButton)
    * delay(2000)
    * click(deleteSecurityGrouplocators.deleteActionButton)
    * delay(3000)
    * waitForText('body','Security Group Deleted')
    * delay(2000)
    
    
    
    
    
    
    
    