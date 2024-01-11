Feature: Oauth2 workflow
	
	Background:
	
		* url backOfficeAPIBaseUrl
	 	* header Accept = 'application/json'
	 	
	 	Given path '/oauth/token'
	 	And form field grant_type = 'password'
	
	Scenario: Generate token 
	
		* def data = read('classpath:com/fnp/api/backoffice/data/users.json')
		
		* def userType = __arg.userType
		* karate.log("User Type : ", userType)
		* def user = data.users[userType]
				
		* def userName = user.email
		* def password = user.password
		
		And form field username = userName
		And form field password = password
		When method post
		* status 200
		* def accessToken = 'Bearer '+ response.token
		Then print accessToken