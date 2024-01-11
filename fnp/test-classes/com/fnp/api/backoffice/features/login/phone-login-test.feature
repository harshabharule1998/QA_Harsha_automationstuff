Feature: validate login by mobile and password

  Background: 
    * url 'https://api-test-r2.fnp.com/oauth/token'
    * form field grant_type = 'password'
  
  #REV2-4760
  Scenario: POST - Login by mobile and password
    * form field username = '9169696787'
    * form field password = 'Auto1234$'
    * method post
    * status 200
    And karate.log('Status : 200')
    And karate.log('Response is:', response)
    And karate.log('User Login is successful by using phone and password')
    And karate.log('Test Completed !')
  
  #REV2-4762
  Scenario: POST - Login by invalid mobile and password
    * form field username = '1234567898967'
    * form field password = 'Welcome01$'
    * method post
    * status 401
    And karate.log('Status : 401')
    And karate.log('Error code :', response.errors[0].errorCode)
    And match response.errors[0].message == "Incorrect Email Address or Password"
    And karate.log('Error message :', response.errors[0].message)
    And karate.log('Test Completed !')
 
  #REV2-4761
  Scenario: POST - Login by mobile and invalid password
    * form field username = '8999377300'
    * form field password = 'Welcome01$456757'
    * method post
    * status 401
    And karate.log('Status : 401')
    And karate.log('Error code :', response.errors[0].errorCode)
    And match response.errors[0].message == "Incorrect Email Address or Password"
    And karate.log('Error message :', response.errors[0].message)
    And karate.log('Test Completed !')
  
  Scenario: POST - Login by Invalid mobile and invalid password
    * form field username = '8999300'
    * form field password = 'Welcome01$456757'
    * method post
    * status 401
    And karate.log('Status : 401')
    And karate.log('Error code :', response.errors[0].errorCode)
    And match response.errors[0].message == "Incorrect Email Address or Password"
    And karate.log('Error message :', response.errors[0].message)
    And karate.log('Test Completed !')
  
  Scenario: POST - Login by empty mobile and empty password
    * form field username = ''
    * form field password = ''
    * method post
    * status 400
    And karate.log('Status : 400')
    And karate.log('Error code :', response.errors[0].errorCode)
    And match response.errors[0].message == "Password is empty"
    And karate.log('Error message :', response.errors[0].message)
    And karate.log('Test Completed !')
  
  Scenario: POST - Login by prefix empty mobile and prefix empty password
    * form field username = ' 8999377300'
    * form field password = ' Welcome01$'
    * method post
    * status 401
    And karate.log('Status : 401')
    And karate.log('Error code :', response.errors[0].errorCode)
    And match response.errors[0].message == "Incorrect Email Address or Password"
    And karate.log('Error message :', response.errors[0].message)
    And karate.log('Test Completed !')
  
  Scenario: POST - Login by suffix empty mobile and suffix empty password
    * form field username = '8999377300  '
    * form field password = 'Welcome01$  '
    * method post
    * status 401
    And karate.log('Status : 401')
    And karate.log('Error code :', response.errors[0].errorCode)
    And match response.errors[0].message == "Incorrect Email Address or Password"
    And karate.log('Error message :', response.errors[0].message)
    And karate.log('Test Completed !')
  
  Scenario: POST - Login by mobile and without password
    * form field username = '8999377300'
    * method post
    * status 400
    And karate.log('Status : 400')
    And karate.log('Error code :', response.errors[0].errorCode)
    And match response.errors[0].message == "Password is empty"
    And karate.log('Error message :', response.errors[0].message)
    And karate.log('Test Completed !')
  
  Scenario: POST - Login by without mobile and password
    * form field password = 'Welcome01$'
    * method post
    * status 401
    And karate.log('Status : 401')
    And karate.log('Error code :', response.errors[0].errorCode)
    And match response.errors[0].message == "Incorrect Email Address or Password"
    And karate.log('Error message :', response.errors[0].message)
    And karate.log('Test Completed !')
