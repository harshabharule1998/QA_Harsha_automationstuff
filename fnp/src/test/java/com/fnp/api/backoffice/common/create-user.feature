Feature: Reusable function to create new user
	
	Background:
	
		* url 'https://api-test-r2.fnp.com'
	 	* header Accept = 'application/json'
	 	* def today = new java.util.Date().time
	 	* def num = today + ""
	 	* def num = num.substring(3)
	 	* def firstName = "Automation" + num
	 	* def lastName = "User" + num
	 	* def email = "automation" + num + "@fnp.com"
	 	* def phoneNumber = num
	 	* def password = "Auto1234$"
	 	
	 	* def user =
      """
      {
		    "firstName": "#(firstName)",
		    "lastName": "#(lastName)",
		    "confirmPassword": "#(password)",
		    "password": "#(password)",
		    "email": "#(email)",
		    "phonenumber": "#(phoneNumber)",
		    "domainName": "fnp"
			}
      """
      
		Given path '/iam/v1/users'
		* karate.log('USER : ', user)
		
	
	@ignore
	Scenario: create new user
		And request user
		When method post
		Then status 200
		And karate.log('Status : 200')
		And match response contains { token: '#notnull' }
		And karate.log('User created successfully')
