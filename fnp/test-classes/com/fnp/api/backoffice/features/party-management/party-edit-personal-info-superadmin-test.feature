Feature: Edit Party Individual Personal Information scenarios for super admin role

	Background: 
       
		Given url backOfficeAPIBaseUrl
    And header Accept = 'application/json'
    And path '/pawri/v1'
    * def loginResult = callonce read('classpath:com/fnp/api/utils/generate-token.feature') {userType:"partyAdmin"}
    * def authToken = loginResult.accessToken
    * header Authorization = authToken
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/party/edit-personal-info.json')
    
    	 
	#REV2-15425
	Scenario: PUT - Verify super admin cannot edit Party Individual Personal Information with Invalid Authentication Token
		
		* def partyId = 'P_00170'
		* eval requestPayload.name = "sophia"
    * eval requestPayload.dateOfAnniversary = "2008-05-11T14:13:57.68"
    * eval requestPayload.dateOfBirth = "1994-06-15T12:22:13.23"
    * eval requestPayload.gender = "female"
    * def invalidAuthToken = loginResult.accessToken + "eyJraWQiOiJmbnAyIiwiYWxnIjoiUlMyNTYifQ"
    * header Authorization = invalidAuthToken
    
    Given path '/party-individuals/' + partyId
   	And request requestPayload
   	When method put
   	Then status 401
		And karate.log('Status : 401')
		And karate.log('Test Completed !')
		
		
	#REV2-15424
	Scenario: PUT - Verify super admin cannot edit Party Individual Personal Information for Unsupported Method 
		
		* def partyId = 'P_00170'
		* eval requestPayload.name = "sophia"
    * eval requestPayload.dateOfAnniversary = "2008-05-11T14:13:57.68"
    * eval requestPayload.dateOfBirth = "1994-06-15T12:22:13.23"
    * eval requestPayload.gender = "female"
		
		Given path '/party-individuals/' + partyId
   	And request requestPayload
   	When method post
   	Then status 405
		And karate.log('Status : 405')
		And match response.errors[0].errorCode contains "unsupported.http.method"
		And match response.errors[0].message contains "Unsupported request Method. Contact the site administrator"
		And karate.log('Test Completed !')
		
		
	#REV2-15423
	Scenario: PUT - Verify super admin cannot edit Party Individual Personal Information with Invalid value in Endpoint URL
	
		* def partyId = 'P_00170'
		* eval requestPayload.name = "sophia"
    * eval requestPayload.dateOfAnniversary = "2008-05-11T14:13:57.68"
    * eval requestPayload.dateOfBirth = "1994-06-15T12:22:13.23"
    * eval requestPayload.gender = "female"
		
		Given path '/party-individuals/' + '/abc/' + partyId
   	And request requestPayload
   	When method put
   	Then status 404
		And karate.log('Status : 404')
		And match response.errors[0].errorCode contains "NOT_FOUND"
		And match response.errors[0].message contains "http.request.not.found"
		And karate.log('Test Completed !')
		

	#REV2-15422
	Scenario: PUT - Verify super admin cannot edit Party Individual Personal Information with Invalid Date of Anniversary
	
		* def partyId = 'P_00170'
		* eval requestPayload.name = "sophia"
    * eval requestPayload.dateOfAnniversary = "8%21F%23%24"
    * eval requestPayload.dateOfBirth = "1994-06-15T12:22:13.23"
    * eval requestPayload.gender = "female"
		
		Given path '/party-individuals/' + partyId
   	And request requestPayload
   	When method put
   	Then status 400
   	And karate.log(requestPayload)
		And karate.log('Status : 400')
		And match response.errors[0].errorCode contains "unprocessable.input.data"
		And match response.errors[0].message contains "Invalid input data"
		And karate.log('Test Completed !')
		

	#REV2-15421
	Scenario: PUT - Verify super admin cannot edit Party Individual Personal Information with Invalid Date of Birth
		
		* def partyId = 'P_00170'
		* eval requestPayload.name = "sophia"
    * eval requestPayload.dateOfAnniversary = "2008-05-11T14:13:57.68"
    * eval requestPayload.dateOfBirth = "8%21F%AAA%%tt23%24"
    * eval requestPayload.gender = "female"
    
    Given path '/party-individuals/' + partyId
   	And request requestPayload
   	When method put
   	Then status 400
   	And karate.log(requestPayload)
		And karate.log('Status : 400')
		And match response.errors[0].errorCode contains "unprocessable.input.data"
		And match response.errors[0].message contains "Invalid input data"
		And karate.log('Test Completed !')
		
		
	#REV2-15420
	Scenario: PUT - Verify super admin cannot edit Party Individual Personal Information for invalid gender
	
		* def partyId = 'P_00170'
		* eval requestPayload.name = "sophia"
    * eval requestPayload.dateOfAnniversary = "2008-05-11T14:13:57.68"
    * eval requestPayload.dateOfBirth = "1994-06-15T12:22:13.23"
    * eval requestPayload.gender = "12%21%40%23"
    
    Given path '/party-individuals/' + partyId
   	And request requestPayload
   	When method put
   	Then status 400
   	And karate.log(requestPayload)
		And karate.log('Status : 400')
		And match response.errors[0].errorCode contains "INVALID_DATA"
		And match response.errors[0].message contains "Please provide valid input for gender"
		And match response.errors[0].field contains "gender"
		And karate.log('Test Completed !')
		
		
	#REV2-15419
	Scenario: PUT - Verify super admin cannot edit Party Individual Personal Information for invalid name
	
		* def partyId = 'P_00170'
		* eval requestPayload.name = "12%21%40%2"
    * eval requestPayload.dateOfAnniversary = "2008-05-11T14:13:57.68"
    * eval requestPayload.dateOfBirth = "1994-06-15T12:22:13.23"
    * eval requestPayload.gender = "female"
    
    Given path '/party-individuals/' + partyId
   	And request requestPayload
   	When method put
   	Then status 400
   	And karate.log(requestPayload)
		And karate.log('Status : 400')
		And match response.errors[0].errorCode contains "INVALID_DATA"
		And match response.errors[0].message contains "The name allow only Characters value"
		And match response.errors[0].field contains "name"
		And karate.log('Test Completed !')
		
			
	#REV2-15418
	Scenario: PUT - Verify super admin cannot edit Party Individual Personal Information with invalid partyId
	
		* def partyId = '675%25AGB'
		* eval requestPayload.name = "sophia"
    * eval requestPayload.dateOfAnniversary = "2008-05-11T14:13:57.68"
    * eval requestPayload.dateOfBirth = "1994-06-15T12:22:13.23"
    * eval requestPayload.gender = "female"
    
    Given path '/party-individuals/' + partyId
   	And request requestPayload
   	When method put
   	Then status 400
   	And karate.log(requestPayload)
		And karate.log('Status : 400')
		And match response.errors[0].errorCode contains "BAD_REQUEST"
		And match response.errors[0].message contains "http.request.rejected"
		And karate.log('Test Completed !')
		
		
	#REV2-15417
	Scenario: PUT - Verify super admin cannot edit Party Individual Personal Information with try inserting with leading and trailing spaces in request body
	
		* def partyId = 'P_00170'
		* eval requestPayload.name = "  sophia  "
    * eval requestPayload.dateOfAnniversary = "  2008-05-11T14:13:57.68  "
    * eval requestPayload.dateOfBirth = "  1994-06-15T12:22:13.23  "
    * eval requestPayload.gender = "  female  "
	
		Given path '/party-individuals/' + partyId
   	And request requestPayload
   	When method put
   	Then status 400
   	And karate.log(requestPayload)
		And karate.log('Status : 400')
		And match response.errors[0].errorCode contains "unprocessable.input.data"
		And match response.errors[0].message contains "Invalid input data"
		And karate.log('Test Completed !')
		
		
	#REV2-15416
	Scenario: PUT - Verify super admin cannot edit Party Individual Personal Information with leading and trailing spaces in partyId
	
		* def partyId = '  P_00170  '
		* eval requestPayload.name = "sophia"
    * eval requestPayload.dateOfAnniversary = "2008-05-11T14:13:57.68"
    * eval requestPayload.dateOfBirth = "1994-06-15T12:22:13.23"
    * eval requestPayload.gender = "female"
	
		Given path '/party-individuals/' + partyId
   	And request requestPayload
   	When method put
   	Then status 404
		And karate.log('Status : 404')
		And match response.errors[0].errorCode contains "NOT_FOUND"
		And match response.errors[0].message contains "party.id.not_found_in_party_individual"
		And match response.errors[0].field contains "partyId"
		And karate.log('Test Completed !')
		

	#REV2-15414
	Scenario: PUT - Verify super admin cannot edit Party Individual Personal Information with Blank values in Request Body
	
		* def partyId = 'P_00170'
		* eval requestPayload.name = " "
    * eval requestPayload.dateOfAnniversary = " "
    * eval requestPayload.dateOfBirth = " "
    * eval requestPayload.gender = " "
	
		Given path '/party-individuals/' + partyId
   	And request requestPayload
   	When method put
   	Then status 400
		And karate.log('Status : 400')
		And match response.errors[0].errorCode contains "unprocessable.input.data"
		And match response.errors[0].message contains "Invalid input data"
		And karate.log('Test Completed !')
		
		
	#REV2-15413
	Scenario: PUT - Verify super admin cannot edit Party Individual Personal Information with with Blank values in partyId
	
		* def partyId = ' '
		* eval requestPayload.name = "emy"
    * eval requestPayload.dateOfAnniversary = "2008-05-11T14:13:57.68"
    * eval requestPayload.dateOfBirth = "1994-06-15T12:22:13.23"
    * eval requestPayload.gender = "female"
	
		Given path '/party-individuals/' + partyId
   	And request requestPayload
   	When method put
   	Then status 404
		And karate.log('Status : 404')
		And match response.errors[0].errorCode contains "NOT_FOUND"
		And match response.errors[0].message contains "party.id.not_found_in_party_individual"
		And match response.errors[0].field contains "partyId"
		And karate.log('Test Completed !')
		
	
	#REV2-15412
	Scenario: PUT - Verify super admin can edit Party Individual Personal Information with all valid values in Request Body and partyId
     
    * def partyId = 'P_00170'
    * eval requestPayload.name = "sophia"
    * eval requestPayload.dateOfAnniversary = "2008-05-11T14:13:57.68"
    * eval requestPayload.dateOfBirth = "1994-06-15T12:22:13.23"
    * eval requestPayload.gender = "female"
    
   	Given path '/party-individuals/' + partyId
   	And request requestPayload
   	When method put
   	Then status 200
   	And karate.log(requestPayload)
		And karate.log('Status : 200')
		And karate.log('Test Completed !')
		
		