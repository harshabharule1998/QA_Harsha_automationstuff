Feature: Create multiple new users
	
	Background:
	
		* url backOfficeAPIBaseUrl
	 	* header Accept = 'application/json'
	
	@performanceData
	Scenario Outline: given id, validate email from same feature file
	  * def userEmail = '<email>'
	  * karate.log('Email : ', userEmail)
	  * def result = call read('./create-multiple-users.feature@createUser') {email: "#(userEmail)"}

  Examples:
   | read('classpath:com/fnp/api/backoffice/data/emails.csv')|
   
 
 	@createUser
	Scenario: create new user and assign security group
	
		* def today = new java.util.Date().time
	 	* def num = today + ""
	 	* def num = num.substring(3)
	 	* def firstName = "Performance" + num
	 	* def lastName = "User" + num
	 	* def email = __arg.email
	 	* def phoneNumber = num
	 	* def password = "Password@123"
	 	
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
      
    * def securityGroup = 
    	"""
    	[
			  "SUP_ADMIN"
			]
    	"""
      
		Given path '/iam/v1/users'
		* karate.log('USER : ', user)
		And request user
		When method post
		Then status 200
		And karate.log('Status : 200')
		And match response contains { token: '#notnull' }
		And karate.log('User created successfully')
		
		Given path '/iam/v1/parties/' + user.email + '/securitygroups'
		* karate.log('securityGroup : ', securityGroup)
		And request securityGroup
		When method put
		Then status 200
		And karate.log('Status : 200')
		And karate.log('User securityGroup updated successfully')
