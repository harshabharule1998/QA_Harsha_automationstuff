Feature: Party Suggestion API

  Background: 
    Given url backOfficeAPIBaseUrl
    And header Accept = 'application/json'
    And path '/pawri/v1'
    * def loginResult = callonce read('classpath:com/fnp/api/utils/generate-token.feature') {userType:"partyAdmin"}
    * def authToken = loginResult.accessToken
    * header Authorization = authToken
    
    
   	#REV2-32964
  	Scenario: GET - Verify Party Suggestion with valid simpleSearchValue for super admin access.
  		
  		Given path '/parties/suggestion' 
  		And param page = 0
  		And param partyType = 'Individual'
  		And param simpleSearchValue = 'satyam'
  		And param size = 10
  		And param sortParam = 'name:asc'
  		And param status = 'true'
  		
  		When method get
			Then status 200
			And karate.log('Status : 200')
			And match response[*].id == '#notnull'
    	And karate.log('Test Completed !')
    	
    
    #REV2-32965
  	Scenario: GET - Verify Party Suggestion with not matching value in simpleSearchValue for super admin access.
  		
  		Given path '/parties/suggestion' 
  		And param page = 0
  		And param partyType = 'Individual'
  		And param simpleSearchValue = 'oiu'
  		And param size = 10
  		And param sortParam = 'name:asc'
  		And param status = 'true'
  		
  		When method get
			Then status 200
			And karate.log('Status : 200')
			And match response.data == []
    	And karate.log('Test Completed !')
    
    
    #REV2-32966
    Scenario: GET - Verify Party Suggestion with Invalid authorization token for super admin access.
  		
  		* def invalidAuthToken = "eyJraWQiOiJmbnAyIiwiYWxnIjoiUlMyNTYifQ"
    	* header Authorization = invalidAuthToken
    	
  		Given path '/parties/suggestion' 
  		And param page = 0
  		And param partyType = 'Individual'
  		And param simpleSearchValue = 'satyam'
  		And param size = 10
  		And param sortParam = 'name:asc'
  		And param status = 'true'
  		
  		When method get
			Then status 403
			And karate.log('Status : 403')
			And match response.errors[*].errorCode contains "access.denied"
			And match response.errors[*].message contains "Access Denied"
    	And karate.log('Test Completed !')	
    	
    
    #REV2-32967
  	Scenario: GET - Verify Party Suggestion with Invalid Endpoint URL for super admin access.
  		
  		Given path '/part/suggest' 
  		And param page = 0
  		And param partyType = 'Individual'
  		And param simpleSearchValue = 'satyam'
  		And param size = 10
  		And param sortParam = 'name:asc'
  		And param status = 'true'
  		
  		When method get
			Then status 404
			And karate.log('Status : 404')
			And match response.errors[*].errorCode contains "NOT_FOUND"
			And match response.errors[*].message contains "http.request.not.found"
    	And karate.log('Test Completed !')
    	
    
    #REV2-32968
  	Scenario: Verify Party Suggestion with Unsupported Method for super admin access.
  		
  		Given path '/parties/suggestion' 
  		And param page = 0
  		And param partyType = 'Individual'
  		And param simpleSearchValue = 'satyam'
  		And param size = 10
  		And param sortParam = 'name:asc'
  		And param status = 'true'
  		
  		When method delete
			Then status 405
			And karate.log('Status : 405')
			And match response.errors[*].errorCode contains "unsupported.http.method"
			And match response.errors[*].message contains "Unsupported request Method. Contact the site administrator"
    	And karate.log('Test Completed !')
    