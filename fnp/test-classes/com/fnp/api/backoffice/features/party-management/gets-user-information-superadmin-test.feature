Feature: Gets user information API

  Background: 
    Given url backOfficeAPIBaseUrl
    And header Accept = 'application/json'
    And path '/simsim/v1'
    * def loginResult = callonce read('classpath:com/fnp/api/utils/generate-token.feature') {userType:"partyAdmin"}
    * def authToken = loginResult.accessToken
    * header Authorization = authToken
    * def loginName = 'test343@cybage.com'
    * def invalidLoginName = 'xyz'
    
    
    #REV2-32976
  	Scenario: GET - Verify Gets user information with valid loginName for super admin access.
  		
  		Given path '/party/' + loginName
  		When method get
			Then status 200
			And karate.log('Status : 200')
			And karate.log(' Records found : ', response)
    	And karate.log('Test Completed !')
    	
    
    #REV2-32977
  	Scenario: GET - Verify Gets user information with invalid loginName for super admin access.
  		
  		Given path '/party/' + invalidLoginName
  		When method get
			Then status 400
			And karate.log('Status : 400')
			And match response.errors[*].errorCode contains "partylogin.party_id_not_found"
  		And match response.errors[*].message contains "Party Id not found"
    	And karate.log('Test Completed !')
    	
    
    #REV2-32978
  	Scenario: GET - Verify Gets user information with blank loginName for super admin access.
  		
  		Given path '/party/' + ''
  		When method get
			Then status 404
			And karate.log('Status : 404')
			And match response.errors[*].errorCode contains "NOT_FOUND"
  		And match response.errors[*].message contains "http.request.not.found"
    	And karate.log('Test Completed !')
    	
    
    #REV2-32979	
  	Scenario: GET - Verify Gets user information with leading & trailing spaces in valid loginName for super admin access.
  		
  		Given path '/party/' + '  test343@cybage.com  '
  		When method get
			Then status 400
			And karate.log('Status : 400')
			And match response.errors[*].errorCode contains "partylogin.party_id_not_found"
  		And match response.errors[*].message contains "Party Id not found"
    	And karate.log('Test Completed !')
  	
  	
  	#REV2-32980
  	Scenario: GET - Verify Gets user information with not allowed values in loginName for super admin access.
  		
  		Given path '/party/' + '#$%&'
  		When method get
			Then status 400
			And karate.log('Status : 400')
			And match response.errors[*].errorCode contains "BAD_REQUEST"
  		And match response.errors[*].message contains "http.request.rejected"
    	And karate.log('Test Completed !')
    	
    
   	#REV2-32981 
  	Scenario: GET - Verify Gets user information with Invalid authorization token for super admin access.
  		
  		* def invalidAuthToken = "eyJraWQiOiJmbnAyIiwiYWxnIjoiUlMyNTYifQ"
    	* header Authorization = invalidAuthToken
    	
  		Given path '/party/' + loginName
  		When method get
			Then status 401
			And karate.log('Status : 401')
			And match response.errors[*].errorCode contains "UNAUTHORIZED"
			And match response.errors[*].message contains "Token Invalid! Authentication Required"
    	And karate.log('Test Completed !')
    	
    #REV2-32982
  	Scenario: GET - Verify Gets user information with Invalid Endpoint URL for super admin access.
  		
  		Given path '/par/' + loginName
  		When method get
			Then status 404
			And karate.log('Status : 404')
			And match response.errors[*].errorCode contains "NOT_FOUND"
  		And match response.errors[*].message contains "http.request.not.found"
    	And karate.log('Test Completed !')
    	
   	#REV2-32983
  	Scenario: Verify Gets user information with Unsupported Method for super admin access.
  		
  		Given path '/party/' + loginName
  		When method delete
			Then status 405
			And karate.log('Status : 405')
			And match response.errors[*].errorCode contains "unsupported.http.method"
			And match response.errors[*].message contains "Unsupported request Method. Contact the site administrator"
    	And karate.log('Test Completed !')
    	
    	