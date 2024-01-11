Feature: Party Edit Profile API Scenarios feature

	Background: 
    Given url backOfficeAPIBaseUrl
    And header Accept = 'application/json'
    And path '/simsim/v1/logins'
    * def loginResult = callonce read('classpath:com/fnp/api/utils/generate-token.feature') {userType:"partyAdmin"}
    * def authToken = loginResult.accessToken
    * header Authorization = authToken
    * def loginId = 'U_01208'
    * def invalidLoginId = 'U_01208x0c07'
    
   	* def requestPayload = 
   	"""
   		{
			    "disabledDate": "2022-08-12T05:05:17",
			    "status": true
			}
   	"""


  #REV2-11977
  Scenario: PUT - Validate Party Admin can edit profile for valid loginId and request body
    	
  	And path '/' + loginId	
		And request requestPayload
		When method put
		Then status 202
		And karate.log('Status : 202')
		And match response.successCode == "party.username_updated"
		And match response.message contains "updated"
		And karate.log('Test Completed !')
		

  #REV2-11978
  Scenario: PUT - Validate Party Admin cannot edit profile for invalid loginId and valid request body
    	
  	And path '/' + invalidLoginId	
		And request requestPayload
		When method put
		Then status 404
		And karate.log('Status : 404')
		And match response.errors[0].message contains "Party Id not found"
		And karate.log('Test Completed !')
			
			
	#REV2-11979
  Scenario: PUT - Validate Party Admin cannot edit profile for valid loginId and invalid request body
    
    * eval requestPayload.disabledDate = "12345"
    * eval requestPayload.status = "123"
    	
  	And path '/' + loginId	
		And request requestPayload
		When method put
		Then status 400
		And karate.log('Status : 400')
		And match response.errors[0].message contains "Invalid input data"
		And karate.log('Test Completed !')
		

	#REV2-11980
  Scenario: PUT - Validate Party Admin cannot edit profile for duplicate data
    
  	And path '/' + loginId	
		And request requestPayload
		When method put
		Then status 202
		And karate.log('Status : 202')
		And match response.successCode == "party.username_updated"
		And match response.message contains "updated"
		And karate.log('Test Completed !')
		
		
	#REV2-11981
  Scenario: PUT - Validate Party Admin cannot edit profile for duplicate data with leading and trailing spaces
    
    * eval requestPayload.disabledDate = " " + requestPayload.disabledDate + " "
    * eval requestPayload.status = " " + requestPayload.status + " "
    
  	And path '/' + loginId	
		And request requestPayload
		When method put
		Then status 400
		And karate.log('Status : 400')
		And match response.errors[0].message contains "Invalid input data"
		And karate.log('Test Completed !')
		

	#REV2-11982
  Scenario: PUT - Validate Party Admin cannot edit profile for valid loginId and invalid disabledDate
    
    * eval requestPayload.disabledDate = "12345"
    	
  	And path '/' + loginId	
		And request requestPayload
		When method put
		Then status 400
		And karate.log('Status : 400')
		And match response.errors[0].message contains "Invalid input data"
		And karate.log('Test Completed !')
		

	#REV2-11983
  Scenario: PUT - Validate Party Admin cannot edit profile for valid loginId and invalid status
    
    * eval requestPayload.status = "123"
    	
  	And path '/' + loginId	
		And request requestPayload
		When method put
		Then status 400
		And karate.log('Status : 400')
		And match response.errors[0].message contains "Invalid input data"
		And karate.log('Test Completed !')
		
	
	#REV2-11984
  Scenario: PUT - Validate Party Admin cannot edit profile for blank loginId and valid request body
    
    * def blankLoginId = ""
    	
  	And path '/' + blankLoginId	
		And request requestPayload
		When method put
		Then status 405
		And karate.log('Status : 405')
		And match response.errors[0].message contains "Unsupported request Method"
		And karate.log('Test Completed !')
		
	
	#REV2-11985
  Scenario: PUT - Validate Party Admin cannot edit profile for valid loginId and blank request body
    
    * eval requestPayload.disabledDate = ""
    * eval requestPayload.status = ""
    	
  	And path '/' + loginId	
		And request requestPayload
		When method put
		Then status 400
		And karate.log('Status : 400')
		And match response.errors[0].message contains "Invalid input data"
		And karate.log('Test Completed !')
		
	
	#REV2-11986
  Scenario: PUT - Validate Party Admin cannot edit profile with leading and trailing spaces in request body
    
    * eval requestPayload.disabledDate = " " + requestPayload.disabledDate + " "
    * eval requestPayload.status = " " + requestPayload.status + " "
    
  	And path '/' + loginId	
		And request requestPayload
		When method put
		Then status 400
		And karate.log('Status : 400')
		And match response.errors[0].message contains "Invalid input data"
		And karate.log('Test Completed !')
		
		
	#REV2-11987
  Scenario: PUT - Validate Party Admin get error for edit profile invalid endpoint url
    	
  	And path '/' + loginId	+ '/123'
		And request requestPayload
		When method put
		Then status 404
		And karate.log('Status : 404')
		And karate.log('Test Completed !')
		

	#REV2-11988
  Scenario: PUT - Validate Party Admin get error for edit profile unsupported request method
    	
  	And path '/' + loginId
		And request requestPayload
		When method post
		Then status 405
		And karate.log('Status : 405')
		And match response.errors[0].message contains "Unsupported request Method"
		And karate.log('Test Completed !')
	