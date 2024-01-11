Feature: Create relationship for party API for view only user

	Background: 
	
		Given url backOfficeAPIBaseUrl
    And header Accept = 'application/json'
    And path '/pawri/v1'
    * def loginResult = callonce read('classpath:com/fnp/api/utils/generate-token.feature') {userType:"partyViewOnly"}
    * def authToken = loginResult.accessToken
    * header Authorization = authToken
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/party/create-party-relationship.json')
    * def partyId = 'P_01157'
    
    
    #REV2-16301
    Scenario: POST - Verify Create relationship for party for valid values in partyId & request body for view only user.
    	
    	* eval requestPayload.isA = "U_00406"
    	
    	Given path '/parties/relations/' + partyId
			And request requestPayload
			When method post
			Then status 403
			And karate.log('Status : 403')
			And match response.errors[*].errorCode contains "access.denied"
			And match response.errors[*].message contains "Access Denied"
			And karate.log('Test Completed !')