Feature: Deactivate Party Relation by partyRelationId API

  Background: 
    Given url backOfficeAPIBaseUrl
    And header Accept = 'application/json'
    And path '/pawri/v1'
    * def loginResult = callonce read('classpath:com/fnp/api/utils/generate-token.feature') {userType:"partyAdmin"}
    * def authToken = loginResult.accessToken
    * header Authorization = authToken
    * def partyRelationId = 'R_00660'
    * def invalidPartyRelationId = 'R_00XX7'
    
    
    #REV2-16365
  	Scenario: PATCH - Verify Deactivate Party Relation by partyRelationId with valid partyRelationId for super admin access.
  
  		Given path '/party-relations/' + partyRelationId
  		And request ''
  		When method patch
			Then status 200
			And karate.log('Status : 200')
			And match response.successCode == "party.party_relation_deactivated"
			And match response.message == "Relationship is deleted"
    	And karate.log('Test Completed !')
    	
    	
  	#REV2-16366
  	Scenario: PATCH - Verify Deactivate Party Relation by partyRelationId with invalid partyRelationId for super admin access.
  
  		Given path '/party-relations/' + invalidPartyRelationId
  		And request ''
  		When method patch
			Then status 404
			And karate.log('Status : 404')
			And match response.errors[*].errorCode contains "NOT_FOUND"
  		And match response.errors[*].message contains "Party relation id not found"
    	And karate.log('Test Completed !')
    	
    
  	#REV2-16367
  	Scenario: PATCH - Verify Deactivate Party Relation by partyRelationId with blank partyRelationId for super admin access.
  
  		Given path '/party-relations/' + ""
  		And request ''
  		When method patch
			Then status 404
			And karate.log('Status : 404')
			And match response.errors[*].errorCode contains "NOT_FOUND"
  		And match response.errors[*].message contains "http.request.not.found"
    	And karate.log('Test Completed !')
    	
    
  	#REV2-16368
  	Scenario: PATCH - Verify Deactivate Party Relation by partyRelationId for valid value with leading & trailing spaces in partyRelationId for super admin access.
  
  		Given path '/party-relations/' + " R_00660 "
  		And request ''
  		When method patch
			Then status 404
			And karate.log('Status : 404')
			And match response.errors[*].errorCode contains "NOT_FOUND"
  		And match response.errors[*].message contains "Party relation id not found"
    	And karate.log('Test Completed !')
    	
    
  	#REV2-16369
  	Scenario: PATCH - Verify Deactivate Party Relation by partyRelationId for not allowed values in partyRelationId for super admin access.
  
  		Given path '/party-relations/' + "$#@%&"
  		And request ''
  		When method patch
			Then status 400
			And karate.log('Status : 400')
			And match response.errors[*].errorCode contains "BAD_REQUEST"
    	And karate.log('Test Completed !')
    	
    
  	#REV2-16370
  	Scenario: PATCH - Verify Deactivate Party Relation by partyRelationId for valid multiple values in partyRelationId for super admin access.
  	
  		* def partyRelationId = "R_00660, R_00664"
  		
  		Given path '/party-relations/' + partyRelationId
  		And request ''
  		When method patch
			Then status 404
			And karate.log('Status : 404')
			And match response.errors[*].errorCode contains "NOT_FOUND"
  		And match response.errors[*].message contains "Party relation id not found"
    	And karate.log('Test Completed !')
    	
   	
  	#REV2-16372
  	Scenario: PATCH - Verify Deactivate Party Relation by partyRelationId for Invalid Authentication Token for super admin access.
    	
    	* def invalidAuthToken = "eyJraWQiOiJmbnAyIiwiYWxnIjoiUlMyNTYifQ"
    	* header Authorization = invalidAuthToken
    	
    	Given path '/party-relations/' + "R_00660"
  		And request ''
  		When method patch
			Then status 403
			And karate.log('Status : 403')
			And match response.errors[*].errorCode contains "access.denied"
  		And match response.errors[*].message contains "Access Denied"
    	And karate.log('Test Completed !')
    	
    	
  	#REV2-16373
  	Scenario: PATCH - Verify Deactivate Party Relation by partyRelationId with Invalid value in Endpoint (URL) for super admin access.
    	
    	Given path '/party-relat/' + "R_00660"
  		And request ''
  		When method patch
			Then status 404
			And karate.log('Status : 404')
			And match response.errors[*].errorCode contains "NOT_FOUND"
  		And match response.errors[*].message contains "http.request.not.found"
    	And karate.log('Test Completed !')
    	
    
  	#REV2-16374
  	Scenario: Verify Deactivate Party Relation by partyRelationId for Unsupported Method for super admin access.
    	
    	Given path '/party-relations/' + "R_00660"
  		And request ''
  		When method post
			Then status 405
			And karate.log('Status : 405')
			And match response.errors[*].errorCode contains "unsupported.http.method"
  		And match response.errors[*].message contains "Unsupported request Method. Contact the site administrator"
    	And karate.log('Test Completed !')
    	
    	
    	
    	
    	
    	
    	
    	
    	
    	
    	
    	
    	
    	
    	
    	
    	
    	
    	
    	
    	
    	