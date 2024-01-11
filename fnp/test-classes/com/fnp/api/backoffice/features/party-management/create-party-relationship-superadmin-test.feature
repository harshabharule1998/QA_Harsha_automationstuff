Feature: Create relationship for party API for super admin

	Background: 
	
		Given url backOfficeAPIBaseUrl
    And header Accept = 'application/json'
    And path '/pawri/v1'
    * def loginResult = callonce read('classpath:com/fnp/api/utils/generate-token.feature') {userType:"partyAdmin"}
    * def authToken = loginResult.accessToken
    * header Authorization = authToken
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/party/create-party-relationship.json')
    * def partyId = 'P_01157'
    * def invalidPartyId = 'X_01157'
    
    
    #REV2-16276
    Scenario: POST - Verify Create relationship for party for valid values in partyId & request body for super admin access.
    	
    	* eval requestPayload.isA = "U_00402"
    	
    	Given path '/parties/relations/' + partyId
			And request requestPayload
			When method post
			Then status 201
			And karate.log('Status : 201')
			And match response.successCode == "party.new_party_relation_created"
			And match response.message == "New relationship created"
			And karate.log('Test Completed !')
			
		
		#REV2-16277
    Scenario: POST - Verify Create relationship for party for only required parameters in request body for super admin access.
    
    	* eval requestPayload.isA = "U_00302"
    	* eval requestPayload.toDate = null
    	
    	Given path '/parties/relations/' + partyId
			And request requestPayload
			When method post
			Then status 201
			And karate.log('Status : 201')
			And match response.successCode == "party.new_party_relation_created"
			And match response.message == "New relationship created"
			And karate.log('Test Completed !')
			
		
		#REV2-16278
    Scenario: POST - Verify Create relationship for party for only optional parameters in request body for super admin access.
    
    	* eval requestPayload.inTheRoleOfPartyTo = null
    	* eval requestPayload.isA = null
    	* eval requestPayload.fromThePartyId = null
    	* eval requestPayload.inTheRoleOfFromTheParty = null
    	* eval requestPayload.fromDate = null
    	
    	Given path '/parties/relations/' + partyId
			And request requestPayload
			When method post
			Then status 400
			And karate.log('Status : 400')
			And karate.log('Test Completed !')
			
		
		#REV2-16279
    Scenario: POST - Verify Create relationship for party for invalid partyId for super admin access.
    
    	* eval requestPayload.isA = "U_00103"
    	
    	Given path '/parties/relations/' + invalidPartyId
			And request requestPayload
			When method post
			Then status 404
			And karate.log('Status : 404')
			And match response.errors[*].errorCode contains "party.not_found"
  		And match response.errors[*].message contains "Party not found"
			And karate.log('Test Completed !')
			
		
		#REV2-16280
    Scenario: POST - Verify Create relationship for party for blank partyId for super admin access.
    
    	* eval requestPayload.isA = "U_00103"
    	
    	Given path '/parties/relations/' + ' '
			And request requestPayload
			When method post
			Then status 404
			And karate.log('Status : 404')
			And match response.errors[*].errorCode contains "party.not_found"
  		And match response.errors[*].message contains "Party not found"
			And karate.log('Test Completed !')
			
		
		#REV2-16281
    Scenario: POST - Verify Create relationship for party for leading & trailing spaces in partyId for super admin access.
    
    	* eval requestPayload.isA = "U_00103"
    	
    	Given path '/parties/relations/' + ' P_01157 '
			And request requestPayload
			When method post
			Then status 404
			And karate.log('Status : 404')
			And match response.errors[*].errorCode contains "party.not_found"
  		And match response.errors[*].message contains "Party not found"
			And karate.log('Test Completed !')	
			
		
		#REV2-16282
    Scenario: POST - Verify Create relationship for party for not allowed values in partyId for super admin access.
    
    	* eval requestPayload.isA = "U_00103"
    	
    	Given path '/parties/relations/' + '@#$%&'
			And request requestPayload
			When method post
			Then status 400
			And karate.log('Status : 400')
			And match response.errors[*].errorCode contains "BAD_REQUEST"
  		And match response.errors[*].message contains "http.request.rejected"
			And karate.log('Test Completed !')	
			
		
		#REV2-16283
    Scenario: POST - Verify Create relationship for party for multiple valid values in partyId for super admin access.
    
    	* eval requestPayload.isA = "U_00103"
    	* def multiplePartyId = ["P_00170", "P_00172"]
    	
    	Given path '/parties/relations/' + multiplePartyId
			And request requestPayload
			When method post
			Then status 404
			And karate.log('Status : 404')
			And match response.errors[*].errorCode contains "party.not_found"
  		And match response.errors[*].message contains "Party not found"
			And karate.log('Test Completed !')	
			
		
		#REV2-16284
    Scenario: POST - Verify Create relationship for party for duplicate values in partyId & request body for super admin access.
    	
    	* eval requestPayload.isA = "U_00103"
    	
    	Given path '/parties/relations/' + partyId
			And request requestPayload
			When method post
			Then status 400
			And karate.log('Status : 400')
			And match response.errors[*].errorCode contains "party.relation_already_created"
			And karate.log('Test Completed !')
			
			
		#REV2-16287/REV2-16286
    Scenario: POST - Verify Create relationship for party for invalid values in inTheRoleOfPartyTo & isA in request body for super admin access.
    	
    	* eval requestPayload.inTheRoleOfPartyTo = "X_00103"
    	* eval requestPayload.isA = "Y_00103"
    	
    	Given path '/parties/relations/' + partyId
			And request requestPayload
			When method post
			Then status 400
			And karate.log('Status : 400')
			And match response.errors[*].errorCode contains "BAD_REQUEST"
			And karate.log('Test Completed !')
			
			
		#REV2-16288/REV2-16289
    Scenario: POST - Verify Create relationship for party for invalid values in fromThePartyId & inTheRoleOfFromTheParty in request body for super admin access.
    	
    	* eval requestPayload.fromThePartyId = "X_00103"
    	* eval requestPayload.inTheRoleOfFromTheParty = "Y_00103"
    	
    	Given path '/parties/relations/' + partyId
			And request requestPayload
			When method post
			Then status 404
			And karate.log('Status : 404')
			And match response.errors[*].errorCode contains "NOT_FOUND"
			And karate.log('Test Completed !')
			
			
		#REV2-16285/REV2-16292
    Scenario: POST - Verify Create relationship for party for invalid values in fromDate & toDate in request body for super admin access.
    	
    	* eval requestPayload.fromDate = "20-10-01T00:11:57"
    	* eval requestPayload.toDate = "20-03-30T20:06:25"
    	
    	Given path '/parties/relations/' + partyId
			And request requestPayload
			When method post
			Then status 400
			And karate.log('Status : 400')
			And match response.errors[*].errorCode contains "unprocessable.input.data"
			And match response.errors[*].message contains "Invalid input data"
			And karate.log('Test Completed !')
			
			
		#REV2-16295
    Scenario: POST - Verify Create relationship for party for blank value in inTheRoleOfPartyTo in request body for super admin access.
    	
    	* eval requestPayload.inTheRoleOfPartyTo = ""
    	* eval requestPayload.isA = "U_00103"
    	
    	Given path '/parties/relations/' + partyId
			And request requestPayload
			When method post
			Then status 400
			And karate.log('Status : 400')
			And match response.errors[*].errorCode contains "INVALID_DATA"
			And match response.errors[*].message contains "InTheRoleOfPartyTo must not be blank"
			And karate.log('Test Completed !')
		
		
		#REV2-16294
    Scenario: POST - Verify Create relationship for party for blank value in isA in request body for super admin access.
    	
    	* eval requestPayload.isA = ""
    	
    	Given path '/parties/relations/' + partyId
			And request requestPayload
			When method post
			Then status 400
			And karate.log('Status : 400')
			And match response.errors[*].errorCode contains "BAD_REQUEST"
			And match response.errors[*].message contains "Relation type not found"
			And karate.log('Test Completed !')
		
		
		#REV2-16296
    Scenario: POST - Verify Create relationship for party for blank value in fromThePartyId in request body for super admin access.
    	
    	* eval requestPayload.isA = "U_00103"
    	* eval requestPayload.fromThePartyId = ""
    	
    	Given path '/parties/relations/' + partyId
			And request requestPayload
			When method post
			Then status 400
			And karate.log('Status : 400')
			And match response.errors[*].errorCode contains "INVALID_DATA"
			And match response.errors[*].message contains "FromThePartyId must not be blank"
			And karate.log('Test Completed !')
		
		
		#REV2-16297
    Scenario: POST - Verify Create relationship for party for blank value in inTheRoleOfFromTheParty in request body for super admin access.
    	
    	* eval requestPayload.isA = "U_00103"
    	* eval requestPayload.inTheRoleOfFromTheParty = ""
    	
    	Given path '/parties/relations/' + partyId
			And request requestPayload
			When method post
			Then status 400
			And karate.log('Status : 400')
			And match response.errors[*].errorCode contains "INVALID_DATA"
			And match response.errors[*].message contains "InTheRoleOfFromTheParty name must not be blank"
			And karate.log('Test Completed !')
		
		
		#REV2-16293
    Scenario: POST - Verify Create relationship for party for blank value in fromDate in request body for super admin access.
    	
    	* eval requestPayload.isA = "U_00103"
    	* eval requestPayload.fromDate = ""
    	
    	Given path '/parties/relations/' + partyId
			And request requestPayload
			When method post
			Then status 400
			And karate.log('Status : 400')
			And match response.errors[*].errorCode contains "unprocessable.input.data"
			And match response.errors[*].message contains "Invalid input data"
			And karate.log('Test Completed !')
		
		
		#REV2-16300
    Scenario: POST - Verify Create relationship for party for Invalid Authentication Token for super admin access.
    	
    	* def invalidAuthToken = "eyJraWQiOiJmbnAyIiwiYWxnIjoiUlMyNTYifQ"
    	* header Authorization = invalidAuthToken
    	* eval requestPayload.isA = "U_00103"
    	
    	Given path '/parties/relations/' + partyId
			And request requestPayload
			When method post
			Then status 403
			And karate.log('Status : 403')
			And match response.errors[*].errorCode contains "access.denied"
			And match response.errors[*].message contains "Access Denied"
			And karate.log('Test Completed !')
		
		
		#REV2-16302
    Scenario: POST - Verify Create relationship for party with Invalid value in Endpoint (URL) for super admin access.
    	
    	* eval requestPayload.isA = "U_00103"
    	
    	Given path '/part/relat/' + partyId
			And request requestPayload
			When method post
			Then status 404
			And karate.log('Status : 404')
			And match response.errors[*].errorCode contains "NOT_FOUND"
  		And match response.errors[*].message contains "http.request.not.found"
			And karate.log('Test Completed !')
		
		
		#REV2-16303
    Scenario: POST - Verify Create relationship for party for Unsupported Method for super admin access.
    	
    	* eval requestPayload.isA = "U_00103"
    	
    	Given path '/parties/relations/' + partyId
			And request requestPayload
			When method delete
			Then status 405
			And karate.log('Status : 405')
			And match response.errors[*].errorCode contains "unsupported.http.method"
			And match response.errors[*].message contains "Unsupported request Method. Contact the site administrator"
			And karate.log('Test Completed !')
		
		
		
		
		
			
			
			