Feature: Return roles by partyId API

  Background: 
    Given url backOfficeAPIBaseUrl
    And header Accept = 'application/json'
    And path '/simsim/v1'
    * def loginResult = callonce read('classpath:com/fnp/api/utils/generate-token.feature') {userType:"partyAdmin"}
    * def authToken = loginResult.accessToken
    * header Authorization = authToken
    * def partyId = 'P_00170'
    * def invalidPartyId = 'P_00XX7'
    
    
  	#REV2-14207
  	Scenario: GET - Verify Return roles by partyId with valid partyId for super admin access.
  
  		Given path '/party-roles/' + partyId
  		When method get
			Then status 200
			And karate.log('Status : 200')
			And match response[*].roleId == '#notnull'
    	And karate.log('Test Completed !')
    
    
  	#REV2-14208
  	Scenario: GET - Verify Return roles by partyId with invalid partyId for super admin access.
  
  		Given path '/party-roles/' + invalidPartyId
  	 	When method get
			Then status 400
			And karate.log('Status : 400')
			And match response.errors[*].errorCode contains "BAD_REQUEST"
  		And match response.errors[*].message contains "Party Id not found"
    	And karate.log('Test Completed !')
    	
    	
  	#REV2-14209
  	Scenario: GET - Verify Return roles by partyId with blank partyId for super admin access.
  
  		Given path '/party-roles/' + ''
  	 	When method get
			Then status 404
			And karate.log('Status : 404')
			And match response.errors[*].errorCode contains "NOT_FOUND"
  		And match response.errors[*].message contains "http.request.not.found"
    	And karate.log('Test Completed !')
  	
    
  	#REV2-14210
  	Scenario: GET - Verify Return roles by partyId with Invalid value in Endpoint (URL) for super admin access.
  	
  		Given path '/part/' + partyId
  	 	When method get
			Then status 404
			And karate.log('Status : 404')
			And match response.errors[*].errorCode contains "NOT_FOUND"
  		And match response.errors[*].message contains "http.request.not.found"
    	And karate.log('Test Completed !')
    	
    
  	#REV2-14211
  	Scenario: PUT - Verify Return roles by partyId for Unsupported Method for super admin access.
    
    	Given path '/party-roles/' + partyId
  		And request ''
  		When method put
			Then status 405
			And karate.log('Status : 405')
			And match response.errors[*].message contains "Unsupported request Method. Contact the site administrator"
			And karate.log('Test Completed !')
    
    
    #REV2-14212
  	Scenario: GET - Verify Return roles by partyId for Invalid Authentication Token for super admin access.
    
    	* def invalidAuthToken = "eyJraWQiOiJmbnAyIiwiYWxnIjoiUlMyNTYifQ"
    	* header Authorization = invalidAuthToken
  	
  		Given path '/party-roles/' + partyId
  		When method get
			Then status 401
			And karate.log('Status : 401')
  		And match response.errors[*].errorCode contains "UNAUTHORIZED"
  		And match response.errors[*].message contains "Token Invalid! Authentication Required"
  		And karate.log('Test Completed !')
    
    
    	
    	
    	