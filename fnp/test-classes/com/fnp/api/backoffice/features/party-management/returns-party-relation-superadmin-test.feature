Feature: Returns party relation by party API

  Background: 
    Given url backOfficeAPIBaseUrl
    And header Accept = 'application/json'
    And path '/pawri/v1'
    * def loginResult = callonce read('classpath:com/fnp/api/utils/generate-token.feature') {userType:"partyAdmin"}
    * def authToken = loginResult.accessToken
    * header Authorization = authToken
    * def partyRelationId = 'R_00664'
    * def invalidPartyRelationId = 'R_00XX7'
    
    
  	#REV2-16259
  	Scenario: GET - Verify Returns party relation by party with valid partyRelationId for super admin access.
  
  		Given path '/party-relations/' + partyRelationId
  		When method get
			Then status 200
			And karate.log('Status : 200')
			And match response[*].id == '#notnull'
    	And karate.log('Test Completed !')
    	
    	
  	#REV2-16260
  	Scenario: GET - Verify Returns party relation by party with invalid partyRelationId for super admin access.
  
  		Given path '/party-relations/' + invalidPartyRelationId
  		When method get
			Then status 404
			And karate.log('Status : 404')
			And match response.errors[*].errorCode contains "NOT_FOUND"
  		And match response.errors[*].message contains "Party relation id not found"
    	And karate.log('Test Completed !')
    	
    
    #REV2-16261
  	Scenario: GET - Verify Returns party relation by party with blank partyRelationId for super admin access.
  
  		Given path '/party-relations/' + ""
  		When method get
			Then status 404
			And karate.log('Status : 404')
			And match response.errors[*].errorCode contains "NOT_FOUND"
  		And match response.errors[*].message contains "http.request.not.found"
    	And karate.log('Test Completed !')	
    	
    
  	#REV2-16262
  	Scenario: GET - Verify Returns party relation by party with leading & trailing spaces in partyRelationId for super admin access.
  
  		Given path '/party-relations/' + "  R_00664  "
  		When method get
			Then status 404
			And karate.log('Status : 404')
			And match response.errors[*].errorCode contains "NOT_FOUND"
  		And match response.errors[*].message contains "Party relation id not found"
    	And karate.log('Test Completed !')	
    	
    
  	#REV2-16263
  	Scenario: GET - Verify Returns party relation by party with not Allowed values in partyRelationId for super admin access.
  
  		Given path '/party-relations/' + "$#@%&"
  		When method get
			Then status 400
			And karate.log('Status : 400')
			And match response.errors[*].errorCode contains "BAD_REQUEST"
  		And match response.errors[*].message contains "http.request.rejected"
    	And karate.log('Test Completed !')
    	
    
  	#REV2-16264
  	Scenario: GET - Verify Returns party relation by party with multiple values in partyRelationId for super admin access.
  
  		* def partyRelationId = "R_00664, R_00667"
  		Given path '/party-relations/' + partyRelationId
  		When method get
			Then status 404
			And karate.log('Status : 404')
			And match response.errors[*].errorCode contains "NOT_FOUND"
  		And match response.errors[*].message contains "Party relation id not found"
    	And karate.log('Test Completed !')
    	
    
  	#REV2-16265
  	Scenario: Verify Returns party relation by party for Unsupported Method for super admin access.
  
  		Given path '/party-relations/' + partyRelationId
  		When method delete
			Then status 405
			And karate.log('Status : 405')
			And match response.errors[*].errorCode contains "unsupported.http.method"
  		And match response.errors[*].message contains "Unsupported request Method. Contact the site administrator"
    	And karate.log('Test Completed !')
    
    	
    #REV2-16266
  	Scenario: GET - Verify Returns party relation by party for Invalid Authentication Token for super admin access.
  		
  		* def invalidAuthToken = "eyJraWQiOiJmbnAyIiwiYWxnIjoiUlMyNTYifQ"
    	* header Authorization = invalidAuthToken
    	
  		Given path '/party-relations/' + partyRelationId
  		When method get
			Then status 403
			And karate.log('Status : 403')
			And match response.errors[*].errorCode contains "access.denied"
  		And match response.errors[*].message contains "Access Denied"
    	And karate.log('Test Completed !')
    	
    	
  	#REV2-16267
  	Scenario: GET - Verify Returns party relation by party with Invalid value in Endpoint (URL) for super admin access.
  
  		Given path '/party-relat/' + partyRelationId
  		When method get
			Then status 404
			And karate.log('Status : 404')
			And match response.errors[*].errorCode contains "NOT_FOUND"
  		And match response.errors[*].message contains "http.request.not.found"
    	And karate.log('Test Completed !')
    	
    
  	
    	
    	
    	
    	
    	
    	
    	
    	
    	
    	
    	
    	
    	
    	
    	
    	
    	
    	