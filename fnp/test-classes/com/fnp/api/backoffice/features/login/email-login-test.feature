Feature: To check if user is able/unable to login with/without valid email/password
	
	Background:
		
		* url 'https://api-test-r2.fnp.com'
		# url to me moved to karate config later
	 	* header Accept = 'application/json'
	 	* def result = call read('classpath:com/fnp/api/backoffice/common/create-user.feature')
	 		
	 	Given path '/oauth/token'
	 	And form field grant_type = 'password'
		
	 	
	#REV2-4757		
	Scenario: POST - Validate user is able to login with valid email and password
		
		* def userName = result.email
		* def password = result.password
		
		And form field username = userName
		And form field password = password
		When method post
		Then status 200
		And karate.log('Status : 200')
		And match response.tokenType == "Bearer"
		And karate.log('Token Type :', response.tokenType)
		And match response contains { token: '#notnull' }
		And karate.log('Token returned successfully')
		And karate.log('Test Completed !')
 
  #REV2-4758
	Scenario: POST - Validate user is getting appropriate message and response code for valid username and invalid password	
		
		* def userName = "automatio11nte@fnp.com"
		* def password = "Auto123456$"
		
		And form field username = userName
		And form field password = password
		
		When method post
		Then status 401
		And karate.log('Status : 401')
		And karate.log('Error code :', response.errors[0].errorCode)
		And match response.errors[0].message == "Incorrect Email Address or Password"
		And karate.log('Error message :', response.errors[0].message)
		And karate.log('Test Completed !')
   
   #REV2-4759
   Scenario Outline: POST - Validate user is getting appropriate message and response code for invalid email/password
		
		And form field username = '<email>'
		And form field password = '<password>'
		When method post
		Then status 401
		And karate.log('Status : 401')
		And karate.log('Error code :', response.errors[0].errorCode)
		And match response.errors[0].message == "Incorrect Email Address or Password"
		And karate.log('Error message :', response.errors[0].message)
		And karate.log('Test Completed !')

	# 1. Invalid username and valid password
	# 2. Invalid username and invalid password		
	Examples:
		| email                | password    |
		| dummyemail12@fnp.com | Auto1234$   | 
		| dummyemail13@fnp.com | Auto123455$ |

  
	Scenario: POST - Validate user is getting appropriate message and response code for password containing space as suffix	
		
		* def userName = "automatio11nte@fnp.com"
		* def password = "Auto1234$" + " "
		
		And form field username = userName
		And form field password = password
		
		When method post
		Then status 401
		And karate.log('Status : 401')
		And karate.log('Error code :', response.errors[0].errorCode)
		And match response.errors[0].message == "Incorrect Email Address or Password"
		And karate.log('Error message :', response.errors[0].message)
		And karate.log('Test Completed !')

  
	Scenario: POST - Validate user is getting appropriate message and response code for password containing space as prefix
		
		* def userName = result.email
		* def password = " " + result.password
		
		And form field username = userName
		And form field password = password
		
		When method post
		Then status 401
		And karate.log('Status : 401')
		And karate.log('Error code :', response.errors[0].errorCode)
		And match response.errors[0].message == "Incorrect Email Address or Password"
		And karate.log('Error message :', response.errors[0].message)
		And karate.log('Test Completed !')

  
	Scenario: POST - Validate user is getting appropriate message and response code for password containing space as in-between
		
		* def userName = result.email
		* def password = 'Auto 1234$'
		
		And form field username = userName
		And form field password = password
		
		When method post
		Then status 401
		And karate.log('Status : 401')
		And karate.log('Error code :', response.errors[0].errorCode)
		And match response.errors[0].message == "Incorrect Email Address or Password"
		And karate.log('Error message :', response.errors[0].message)
		And karate.log('Test Completed !')

  
	Scenario: POST - Validate user is getting appropriate message and response code for email containing space as suffix	
		
		* def userName = result.email + " "
		* def password = result.password
		
		And form field username = userName
		And form field password = password
		
		When method post
		Then status 401
		And karate.log('Status : 401')
    And karate.log('Error code :', response.errors[0].errorCode)
		And match response.errors[0].message == "Incorrect Email Address or Password"
		And karate.log('Error message :', response.errors[0].message)
		And karate.log('Test Completed !')

 
	Scenario: POST - Validate user is getting appropriate message and response code for email containing space as prefix
		
		* def userName = " " + result.email
		* def password = result.password
		
		And form field username = userName
		And form field password = password
		
		When method post
		Then status 401
		And karate.log('Status : 401')
		And karate.log('Error code :', response.errors[0].errorCode)
		And match response.errors[0].message == "Incorrect Email Address or Password"
		And karate.log('Error message :', response.errors[0].message)
		And karate.log('Test Completed !')

  
	Scenario: POST - Validate user is getting appropriate message and response code for email containing space as in-between
		
		* def userName = "automation 44@fnp.com"
		* def password = result.password
		
		And form field username = userName
		And form field password = password
		
		When method post
		Then status 401
		And karate.log('Status : 401')
		And karate.log('Error code :', response.errors[0].errorCode)
		And match response.errors[0].message == "Incorrect Email Address or Password"
		And karate.log('Error message :', response.errors[0].message)
		And karate.log('Test Completed !')

		
	Scenario: POST - Validate user is getting appropriate message and response code for blank email/password
		
		And form field username = ''
		And form field password = ''
		When method post
		Then status 400
		And karate.log('Status : 400')
		And karate.log('Error code :', response.errors[0].errorCode)
		And match response.errors[0].message == "Password is empty"
		And karate.log('Error message :', response.errors[0].message)
		And karate.log('Test Completed !')