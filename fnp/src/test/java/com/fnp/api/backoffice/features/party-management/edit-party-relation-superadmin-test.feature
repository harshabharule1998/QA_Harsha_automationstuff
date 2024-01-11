Feature: Edit Party Relation Details API for super admin user

	Background: 
	
		Given url backOfficeAPIBaseUrl
    And header Accept = 'application/json'
    And path '/pawri/v1'
    * def loginResult = callonce read('classpath:com/fnp/api/utils/generate-token.feature') {userType:"partyAdmin"}
    * def authToken = loginResult.accessToken
    * header Authorization = authToken
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/party/edit-party-relation.json')
    * def partyRelationId = 'R_00664'
    * def invalidPartyRelationId = 'X_00664'

  	  
    #REV2-16447
    Scenario: PUT - Verify Edit Party Relation Details for valid values in partyRelationId & request body for super admin access.
    
    	Given path '/party-relations/' + partyRelationId
			And request requestPayload
			When method put
			Then status 201
			And karate.log('Status : 201')
			And match response.successCode == "party_relation.updated_successfully"
			And match response.message == "Relationship is updated"
			And karate.log('Test Completed !')
			
			
		#REV2-16450
    Scenario: PUT - Verify Edit Party Relation Details for invalid value in partyRelationId for super admin access.
    
    	Given path '/party-relations/' + invalidPartyRelationId
			And request requestPayload
			When method put
			Then status 404
			And karate.log('Status : 404')
			And match response.errors[*].errorCode contains "NOT_FOUND"
			And match response.errors[*].message contains "Party relation id not found"
			And karate.log('Test Completed !')
			
			
		#REV2-16451
    Scenario: PUT - Verify Edit Party Relation Details for blank value in partyRelationId for super admin access.
    
    	Given path '/party-relations/' + ''
			And request requestPayload
			When method put
			Then status 404
			And karate.log('Status : 404')
			And match response.errors[*].errorCode contains "NOT_FOUND"
			And match response.errors[*].message contains "http.request.not.found"
			And karate.log('Test Completed !')
			
		
		#REV2-16452
    Scenario: PUT - Verify Edit Party Relation Details for blank value with leading & trailing spaces in partyRelationId for super admin access.
    
    	Given path '/party-relations/' + '   '
			And request requestPayload
			When method put
			Then status 404
			And karate.log('Status : 404')
			And match response.errors[*].errorCode contains "NOT_FOUND"
			And match response.errors[*].message contains "Party relation id not found"
			And karate.log('Test Completed !')
			
		
		#REV2-16453
    Scenario: PUT - Verify Edit Party Relation Details for not allowed value in partyRelationId for super admin access.
    
    	Given path '/party-relations/' + '&@#$%'
			And request requestPayload
			When method put
			Then status 400
			And karate.log('Status : 400')
			And match response.errors[*].errorCode contains "BAD_REQUEST"
			And match response.errors[*].message contains "http.request.rejected"
			And karate.log('Test Completed !')
			
		
		#REV2-16840/REV2-16835
    Scenario: PUT - Verify Edit Party Relation Details for invalid inTheRoleOfPartyTo & isA in request body for super admin access.
    
    	* eval requestPayload.inTheRoleOfPartyTo = "X_00001"
    	* eval requestPayload.isA = "Z_00001"
    	
    	Given path '/party-relations/' + partyRelationId
			And request requestPayload
			When method put
			Then status 400
			And karate.log('Status : 400')
			And match response.errors[*].errorCode contains "BAD_REQUEST"
			And karate.log('Test Completed !')
			
		
		#REV2-16836/REV2-16837
    Scenario: PUT - Verify Edit Party Relation Details for invalid fromThePartyId & inTheRoleOfFromTheParty in request body for super admin access.
    
    	* eval requestPayload.fromThePartyId = "X_00001"
    	* eval requestPayload.inTheRoleOfFromTheParty = "Z_00001"
    	
    	Given path '/party-relations/' + partyRelationId
			And request requestPayload
			When method put
			Then status 404
			And karate.log('Status : 404')
			And match response.errors[*].errorCode contains "NOT_FOUND"
			And karate.log('Test Completed !')
			
		
		
		#REV2-16834/REV2-16841
    Scenario: PUT - Verify Edit Party Relation Details for invalid fromDate & toDate in request body for super admin access.
    
    	* eval requestPayload.fromDate = "202-03-30T20:06:25"
    	* eval requestPayload.toDate = "202-03-30T20:06:25"
    	
    	Given path '/party-relations/' + partyRelationId
			And request requestPayload
			When method put
			Then status 400
			And karate.log('Status : 400')
			And match response.errors[*].errorCode contains "unprocessable.input.data"
			And match response.errors[*].message contains "Invalid input data"
			And karate.log('Test Completed !')	
			
			
		#REV2-16473/REV2-16472
    Scenario: PUT - Verify Edit Party Relation Details for blank inTheRoleOfPartyTo & isA in request body for super admin access.
    
    	* eval requestPayload.inTheRoleOfPartyTo = ""
    	* eval requestPayload.isA = ""
    	
    	Given path '/party-relations/' + partyRelationId
			And request requestPayload
			When method put
			Then status 400
			And karate.log('Status : 400')
			And match response.errors[*].errorCode contains "INVALID_DATA"
			And karate.log('Test Completed !')	
			
		
		#REV2-16471/REV2-16470
    Scenario: PUT - Verify Edit Party Relation Details for blank fromThePartyId & inTheRoleOfFromTheParty in request body for super admin access.
    
    	* eval requestPayload.fromThePartyId = ""
    	* eval requestPayload.inTheRoleOfFromTheParty = ""
    	
    	Given path '/party-relations/' + partyRelationId
			And request requestPayload
			When method put
			Then status 400
			And karate.log('Status : 400')
			And match response.errors[*].errorCode contains "INVALID_DATA"
			And karate.log('Test Completed !')	
			
			
		#REV2-16469
    Scenario: PUT - Verify Edit Party Relation Details for blank fromDate in request body for super admin access.
    
    	* eval requestPayload.fromDate = ""
    	
    	Given path '/party-relations/' + partyRelationId
			And request requestPayload
			When method put
			Then status 400
			And karate.log('Status : 400')
			And match response.errors[*].errorCode contains "unprocessable.input.data"
			And karate.log('Test Completed !')
			
		
		#REV2-16456
    Scenario: PUT - Verify Edit Party Relation Details for blank toDate in request body for super admin access.
    
    	* eval requestPayload.toDate = null
    	
    	Given path '/party-relations/' + partyRelationId
			And request requestPayload
			When method put
			Then status 201
			And karate.log('Status : 201')
			And match response.successCode == "party_relation.updated_successfully"
			And match response.message == "Relationship is updated"
			And karate.log('Test Completed !')
			
			
		#REV2-16463
    Scenario: PUT - Verify Edit Party Relation Details with Invalid value in Endpoint (URL) for super admin access.
    	
    	Given path '/party-relat/' + partyRelationId
			And request requestPayload
			When method put
			Then status 404
			And karate.log('Status : 404')
			And match response.errors[*].errorCode contains "NOT_FOUND"
  		And match response.errors[*].message contains "http.request.not.found"
			And karate.log('Test Completed !')
			
			
		#REV2-16464
    Scenario: Verify Edit Party Relation Details for Unsupported Method for super admin access.
    	
    	Given path '/party-relations/' + partyRelationId
			And request requestPayload
			When method delete
			Then status 405
			And karate.log('Status : 405')
			And match response.errors[*].errorCode contains "unsupported.http.method"
			And match response.errors[*].message contains "Unsupported request Method. Contact the site administrator"
			And karate.log('Test Completed !')
			
			
		#REV2-16466
    Scenario: PUT - Verify Edit Party Relation Details for Invalid Authentication Token for super admin access.
    	
    	* def invalidAuthToken = "eyJraWQiOiJmbnAyIiwiYWxnIjoiUlMyNTYifQ"
    	* header Authorization = invalidAuthToken
    	
    	Given path '/party-relations/' + partyRelationId
			And request requestPayload
			When method put
			Then status 403
			And karate.log('Status : 403')
			And match response.errors[*].errorCode contains "access.denied"
			And match response.errors[*].message contains "Access Denied"
			And karate.log('Test Completed !')
			
		
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
		