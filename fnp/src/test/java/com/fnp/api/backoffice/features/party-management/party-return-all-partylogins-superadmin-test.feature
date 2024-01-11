Feature: Party POST Return All PartyLogins Scenarios for Super Admin Role

	Background: 
	
		Given url backOfficeAPIBaseUrl
    And header Accept = 'application/json'
    And path '/simsim/v1/party-logins-info'
    * def loginResult = callonce read('classpath:com/fnp/api/utils/generate-token.feature') {userType:"partyAdmin"}
    * def authToken = loginResult.accessToken
    * header Authorization = authToken
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/party/return-all-partylogin.json')
 
 
 	#REV2-18181
	Scenario: POST - Verify Super Admin cannot fetch All Party Logins with Unsupported Method and valid value in Endpoint URL
		
		Given request requestPayload
		When method PUT
		Then status 405
		And karate.log('Status : 405')
		And match response.errors[0].message contains "Unsupported request Method. Contact the site administrator"
		And karate.log('Test Completed !')
		
		 
	#REV2-18180
	Scenario: POST - Verify Super Admin cannot fetch All Party Logins with Invalid Endpoint URL
		
		Given path '/abc'
		And request requestPayload
		When method post
		Then status 404
		And karate.log('Status : 404')
		And match response.errors[0].errorCode contains "NOT_FOUND"
		And karate.log('Test Completed !')
		
		
	#REV2-18179
	Scenario: POST - Verify Super Admin cannot fetch All Party Logins with Invalid authorization token
		
		* def invalidAuthToken = "eyJraWQiOiJmbnAyIiwiYWxnIjoiUlMyNTYifQ"
    * header Authorization = invalidAuthToken
    
		Given request requestPayload
		When method post
		Then status 401
		And karate.log('Status : 401')
		And match response.errors[0].message contains "Token Invalid! Authentication Required"
		And match response.errors[0].errorCode contains "UNAUTHORIZED"
		And karate.log('Test Completed !')
			
	
	#Defect : REV2-31148
	#REV2-18177
	Scenario: POST - Verify Super Admin cannot fetch All Party Logins with multiple values in loginName
		
		* eval requestPayload.loginName = "091919892098920, Satyam@fnp.com"
		* eval requestPayload.partyIds[0] = 'P_00870'
  	
		Given request requestPayload
		When method post
		Then status 200
		And karate.log('Status : 200')
		And match response == []
		And karate.log('Test Completed !')
		
		
	#REV2-18176
	Scenario:  POST - Verify Super Admin cannot fetch All Party Logins with values not allowed in loginName
		
		* eval requestPayload.loginName = "%40%23%26%255E%25"
		* eval requestPayload.partyIds[0] = 'P_00870'
		
		Given request requestPayload
		When method post
		Then status 200
		And karate.log('Request Body : '+ requestPayload)
		And karate.log('Status : 200')
		And match response == []
		And karate.log('Test Completed !')
			
			
	#REV2-18175
	Scenario: POST - Verify Super Admin cannot fetch All Party Logins for blank value with leading & trailing spaces in loginName
			
		* eval requestPayload.loginName = "   Satyam@fnp.com  "
		* eval requestPayload.partyIds[0] = 'P_00870'
			
		Given request requestPayload
		When method post
		Then status 200
		And karate.log('Request Body : '+ requestPayload)
		And karate.log('Status : 200')
		And match response == []
		And karate.log('Test Completed !')
			
		
	#REV2-18174
	Scenario: POST - Verify Super Admin cannot fetch All Party Logins with blank value in loginName
			
		* eval requestPayload.loginName = ""
		* eval requestPayload.partyIds[0] = 'P_00870'
			
		Given request requestPayload
		When method post
		Then status 200
		And karate.log('Request Body : '+ requestPayload)
		And karate.log('Status : 200')
		And match response == []
		And karate.log('Test Completed !')
			
	 	
	#REV2-18173
	Scenario: POST - Verify Super Admin cannot fetch All Party Logins with invalid value in loginName
			
		* eval requestPayload.loginName = "ABCXYZ"
		* eval requestPayload.partyIds[0] = 'P_00870'
			
		Given request requestPayload
		When method post
		Then status 200
		And karate.log('Request Body : '+ requestPayload)
		And karate.log('Status : 200')
		And match response == []
		And karate.log('Test Completed !')
			
						
	#REV2-18172
	Scenario: POST - Verify Super Admin can fetch All Party Logins with valid value in loginName
			
		* eval requestPayload.loginName = "Satyam@fnp.com"
    * eval requestPayload.partyIds[0] = "P_00870"
    	
    Given request requestPayload
		When method post
		Then status 200
		And karate.log('Status : 200')
		And karate.log('Test Completed !')
			
		
	#REV2-18171
	Scenario: POST - Verify Super Admin can fetch All Party Logins with multiple values in partyId
			
		* eval requestPayload.loginName = "Satyam@fnp.com"	
    * eval requestPayload.partyIds = ["P_00870", "P_00007"]
    	
    Given request requestPayload
		When method post
		Then status 200
		And karate.log('Request Body : '+ requestPayload)
		And karate.log('Status : 200')
		And karate.log('Test Completed !')
			
	
	#REV2-18170
	Scenario: POST - Verify Super Admin cannot fetch All Party Logins with not allowed value in partyId
			
		* eval requestPayload.loginName = "Satyam@fnp.com"
    * eval requestPayload.partyIds[0] = "%40%23%24%25%40"
    	
    Given request requestPayload
		When method post
		Then status 200
		And karate.log('Request Body : '+ requestPayload)
		And karate.log('Status : 200')
		And match response == []
		And karate.log('Test Completed !')
			
		
	#REV2-18169
	Scenario: POST - Verify Super Admin cannot fetch All Party Logins for blank value with leading & trailing spaces in partyId
			
		* eval requestPayload.loginName = "Satyam@fnp.com"
    * eval requestPayload.partyIds[0] = "   P_00870   "
    	
    Given request requestPayload
		When method post
		Then status 200
		And karate.log('Request Body : '+ requestPayload)
		And karate.log('Status : 200')
		And match response == []
		And karate.log('Test Completed !')
			
						
	#REV2-18168
	Scenario: POST - Verify Super Admin cannot fetch All Party Logins with blank value in partyId
			
		* eval requestPayload.loginName = "Satyam@fnp.com"
    * eval requestPayload.partyIds[0] = ""
    	
    Given request requestPayload
		When method post
		Then status 200
		And karate.log('Status : 200')
		And karate.log('Request Body : '+ requestPayload)
		And match response == []
		And karate.log('Test Completed !')
			
				
	#REV2-18167
	Scenario: POST - Verify Super Admin cannot fetch All Party Logins with invalid value in partyId
			
		* eval requestPayload.loginName = "Satyam@fnp.com"
    * eval requestPayload.partyIds[0] = "ABC001"
    	
    Given request requestPayload
		When method post
		Then status 200
		And karate.log('Status : 200')
		And karate.log('Request Body : '+ requestPayload)
		And match response == []
		And karate.log('Test Completed !')
			

	#REV2-18166
  Scenario: POST - Verify Super Admin can fetch All Party Logins with valid value in partyId
  	
		* eval requestPayload.loginName = "Satyam@fnp.com"
    * eval requestPayload.partyIds[0] = "P_00870"
  	
		Given request requestPayload
		When method post
		Then status 200
		And karate.log('Status : 200')
		And karate.log('Test Completed !')
			
			