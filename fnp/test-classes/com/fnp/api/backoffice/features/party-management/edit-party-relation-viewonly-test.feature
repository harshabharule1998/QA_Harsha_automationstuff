Feature: Edit Party Relation Details API for view only user

	Background: 
	
		Given url backOfficeAPIBaseUrl
    And header Accept = 'application/json'
    And path '/pawri/v1'
    * def loginResultPartyView = callonce read('classpath:com/fnp/api/utils/generate-token.feature') {userType:"partyViewOnly"}
  	* def authTokenPartyView = loginResultPartyView.accessToken
  	* header Authorization = authTokenPartyView
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/party/edit-party-relation.json')
    * def partyRelationId = 'R_00664'    
    
    
		#REV2-16467
    Scenario: PUT - Verify Edit Party Relation Details for view only permission access.
    	
    	Given path '/party-relations/' + partyRelationId
			And request requestPayload
			When method put
			Then status 403
			And karate.log('Status : 403')
			And match response.errors[*].errorCode contains "access.denied"
			And match response.errors[*].message contains "Access Denied"
			And karate.log('Test Completed !')