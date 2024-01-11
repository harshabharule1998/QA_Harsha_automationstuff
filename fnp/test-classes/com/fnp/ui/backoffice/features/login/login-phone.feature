Feature: Verify Login with phone functionality of FNP application.

	Background:
	* def usersValue = read('../../data/users.json')
	* def loginConstant = read('../../data/loginPage_constants.json')
	* def loginLocator = read('../../data/loginPage_locator.json')
	* def headerFooterLocator = read('../../data/headerFooterPage_locators.json')
	* def headerFooterConstant = read('../../data/headerFooterPage_constants.json')
 	* configure driver = driverConfig
 	* driver backOfficeUrl
 	And maximize()
 	
 	@login
 	Scenario: Verify login using valid Mobile Number and Password.
 		And match enabled(loginLocator.loginLogo) == true
 		Then match text(loginLocator.loginText) == loginConstant.loginText
		* delay(3000)
		And input(loginLocator.usernameTextArea, usersValue.users.superAdmin.phoneNumber)
		* delay(3000)
		Then match text(loginLocator.continueButtonText) == loginConstant.continueButtonText
		When click(loginLocator.continueButton)
		And input(loginLocator.passwordTextArea, usersValue.users.superAdmin.confirmPassword)
		* delay(3000)
		When click(loginLocator.continueButton)
		* delay(3000)
		* locateAll(headerFooterLocator.userProfileDropdown)[1].click()
		Then match text(headerFooterLocator.userProfileEmail) == headerFooterConstant.userProfileEmailText
		Then match text(headerFooterLocator.UserProfileSignOut) == headerFooterConstant.UserProfileSignOutText
		And match enabled(headerFooterLocator.UserProfileSignOut) == true
		When click(headerFooterLocator.UserProfileSignOut)
		* delay(3000)
		
	@login
 	Scenario: Verify login functionality with valid email,invalid password.
 		And match enabled(loginLocator.loginLogo) == true
 		Then match text(loginLocator.loginText) == loginConstant.loginText
		* delay(3000)
		And input(loginLocator.usernameTextArea, usersValue.users.superAdmin.phoneNumber)
		* delay(3000)
		Then match text(loginLocator.continueButtonText) == loginConstant.continueButtonText
		When click(loginLocator.continueButton)
		And input(loginLocator.passwordTextArea,"Invalid Password")
		* delay(3000)
		When click(loginLocator.continueButton)
		* delay(3000)
		Then match text(loginLocator.invalidCredential) == loginConstant.invalidCredential
		
	@login
 	Scenario: Verify login functionality with invalid phone number.
 		And match enabled(loginLocator.loginLogo) == true
 		Then match text(loginLocator.loginText) == loginConstant.loginText
		* delay(3000)
		And input(loginLocator.usernameTextArea,"Invalid Phone Number")
		* delay(3000)
		Then match text(loginLocator.continueButtonText) == loginConstant.continueButtonText
		When click(loginLocator.continueButton)
		* delay(3000)
		Then match text(loginLocator.invalidCredential) == loginConstant.invlaidUsername
		
	@login
 	Scenario: Verify Reset password link from phone number.
 		And match enabled(loginLocator.loginLogo) == true
 		Then match text(loginLocator.loginText) == loginConstant.loginText
 		* delay(3000)
 		And input(loginLocator.usernameTextArea,usersValue.users.superAdmin.phoneNumber)
		* delay(3000)
		Then match text(loginLocator.continueButtonText) == loginConstant.continueButtonText
		When click(loginLocator.continueButton)
		* delay(3000)
		When click(loginLocator.forgotPasswordLink)
		* delay(3000)
 		And match enabled(loginLocator.resetPasswordButton) == true
 		Then match text(loginLocator.resetPasswordButton) == loginConstant.resetPassword
 		
 	@login
 	Scenario: Forgot Password with Invalid mobile number.
 		And match enabled(loginLocator.loginLogo) == true
 		Then match text(loginLocator.loginText) == loginConstant.loginText
 		* delay(3000)
 		And input(loginLocator.usernameTextArea,usersValue.users.superAdmin.phoneNumber)
		* delay(3000)
		Then match text(loginLocator.continueButtonText) == loginConstant.continueButtonText
		When click(loginLocator.continueButton)
		* delay(3000)
		When click(loginLocator.forgotPasswordLink)
		* delay(3000)
		And input(loginLocator.forgotPasswordUsername, "Invalid Phone Number")
		And match enabled(loginLocator.resetPasswordButton) == true
 		Then match text(loginLocator.resetPasswordButton) == loginConstant.resetPassword
 		When click(loginLocator.resetPasswordButton)
 		Then match text(loginLocator.forgotPasswordError) == loginConstant.forgotPasswordInvalidError
 		
 	@login
 	Scenario: Validate the Mobile Number string for correct format.
 		And match enabled(loginLocator.loginLogo) == true
 		Then match text(loginLocator.loginText) == loginConstant.loginText
 		* delay(3000)
 		And input(loginLocator.usernameTextArea,"9665563ab3")
 		* delay(3000)
		Then match text(loginLocator.continueButtonText) == loginConstant.continueButtonText
		When click(loginLocator.continueButton)
		* delay(3000)
		Then match text(loginLocator.invalidCredential) == loginConstant.invlaidUsername
		
	@login
 	Scenario: Verify login functionality with expired phone number.
 		And match enabled(loginLocator.loginLogo) == true
 		Then match text(loginLocator.loginText) == loginConstant.loginText
		* delay(3000)
		And input(loginLocator.usernameTextArea, "<Phone number expired>")
		* delay(3000)
		Then match text(loginLocator.continueButtonText) == loginConstant.continueButtonText
		When click(loginLocator.continueButton)
		And input(loginLocator.passwordTextArea, "<Valid password>")
		* delay(3000)
		When click(loginLocator.continueButton)
		* delay(3000)
		Then match text(loginLocator.invalidCredential) == loginConstant.invlaidUsername
		
		
		
		
		
		
		
		
		
		
		
		