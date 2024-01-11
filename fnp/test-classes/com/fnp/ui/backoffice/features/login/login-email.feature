Feature: Verify Login with email functionality of FNP application.

  Background: 
    * def usersValue = read('../../data/users.json')
    * def loginConstant = read('../../data/loginPage_constants.json')
    * def loginLocator = read('../../data/loginPage_locator.json')
    * def headerFooterLocator = read('../../data/headerFooterPage_locators.json')
    * def headerFooterConstant = read('../../data/headerFooterPage_constants.json')
    * configure driver = driverConfig
    * driver backOfficeUrl
    * maximize()

  
  Scenario: Verify login functionality with valid email,valid password and logout.
    * match enabled(loginLocator.loginLogo) == true
    * match text(loginLocator.loginText) == loginConstant.loginText
    * delay(3000)
    * input(loginLocator.usernameTextArea, usersValue.users.superAdmin.email)
    * delay(3000)
    * input(loginLocator.passwordTextArea, usersValue.users.superAdmin.password)
    * delay(3000)
    * click(loginLocator.loginButton)
    * delay(1000)
    * click(headerFooterLocator.userProfileDropdown)
    * delay(1000)
    * click(headerFooterLocator.UserProfileSignOut)
    * match driver.url == 'https://zeus-test-r2.fnp.com/#/login'
    * match text(headerFooterLocator.loginButton) == loginConstant.loginText

  
  Scenario: Verify login functionality with valid email,invalid password.
    * match enabled(loginLocator.loginLogo) == true
    * match text(loginLocator.loginText) == loginConstant.loginText
    * delay(3000)
    * input(loginLocator.usernameTextArea, usersValue.users.superAdmin.invalidUser)
    * delay(3000)
    * input(loginLocator.passwordTextArea, usersValue.users.superAdmin.invalidPass)
    * delay(3000)
    * click(loginLocator.loginButton)
    * match text(loginLocator.invalidCredential) == 'Incorrect Email Address or Password'

  
  Scenario: Verify login functionality with invalid email.
    * match enabled(loginLocator.loginLogo) == true
    * match text(loginLocator.loginText) == loginConstant.loginText
    * delay(3000)
    * input(loginLocator.usernameTextArea, usersValue.users.superAdmin.invalidUser)
    * delay(3000)
    * input(loginLocator.passwordTextArea, usersValue.users.superAdmin.password)
    * delay(3000)
    * click(loginLocator.loginButton)
    * match text(loginLocator.invalidCredential) == 'Incorrect Email Address or Password'

  
  #Need to discuss
  Scenario: Verify Login functionality and User enters a blank email address.
    * match enabled(loginLocator.loginLogo) == true
    * match text(loginLocator.loginText) == loginConstant.loginText
    * delay(3000)
    * input(loginLocator.usernameTextArea, " ")
    * delay(3000)
    * input(loginLocator.passwordTextArea, usersValue.users.superAdmin.password)
    * delay(3000)
    * click(loginLocator.loginButton)
    * match text("[id='my-helper-text']") contains 'Please fill out this field'

  
  #BugId-REV2-16307
  Scenario: Validate if correct user name is displayed after login.
    * match enabled(loginLocator.loginLogo) == true
    * match text(loginLocator.loginText) == loginConstant.loginText
    * delay(3000)
    * input(loginLocator.usernameTextArea, usersValue.users.superAdmin.email)
    * delay(3000)
    * input(loginLocator.passwordTextArea, usersValue.users.superAdmin.password)
    * delay(3000)
    * click(loginLocator.loginButton)
    * delay(1000)
    * match text(headerFooterLocator.userName) == usersValue.users.superAdmin.email

  
  Scenario: Verify forget password link on login Page
    * match enabled(loginLocator.forgotPasswordLink) == true
    * match text(loginLocator.forgotPasswordLink) == loginConstant.forgotPassword
    * click(loginLocator.forgotPasswordLink)
    * match driver.url == 'https://zeus-test-r2.fnp.com/#/forgotpassword'

  
  Scenario: Verify Reset password link from Email.
    * click(loginLocator.forgotPasswordLink)
    * delay(3000)
    * match enabled(loginLocator.resetPasswordButton) == true
    * match text(loginLocator.resetPasswordButton) == loginConstant.resetPassword

  
  Scenario: Verify BackToLogin link functionality
    * click(loginLocator.forgotPasswordLink)
    * match text(loginLocator.backToLoginButton) == loginConstant.backToLogin
    * click(loginLocator.backToLoginButton)
    * match driver.url == 'https://zeus-test-r2.fnp.com/#/login'
    * match text(loginLocator.loginButton) == loginConstant.loginText
