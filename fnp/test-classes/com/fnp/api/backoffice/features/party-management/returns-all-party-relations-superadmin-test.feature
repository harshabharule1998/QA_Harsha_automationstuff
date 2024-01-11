Feature: Returns all relations for party API

  Background: 
    Given url backOfficeAPIBaseUrl
    And header Accept = 'application/json'
    And path '/pawri/v1'
    * def loginResult = callonce read('classpath:com/fnp/api/utils/generate-token.feature') {userType:"partyAdmin"}
    * def authToken = loginResult.accessToken
    * header Authorization = authToken
    
    
  	#REV2-16241
  	Scenario: GET - Verify Returns all relations for party with valid partyId for super admin access.
  		
  		Given path '/parties/relations' 
  		And param page = 0
  		And param partyId = 'P_00170'
  		And param size = 10
  		And param sortParam = 'id:asc'
  		
  		When method get
			Then status 200
			And karate.log('Status : 200')
			And match response[*].id == '#notnull'
			And karate.log(' Records found : ', response)
    	And karate.log('Test Completed !')
    	
    
  	#REV2-16242
  	Scenario: GET - Verify Returns all relations for party with invalid partyId for super admin access.
	
			Given path '/parties/relations' 
			And param page = 0
  		And param partyId = 'X_00170'
  		And param size = 10
  		And param sortParam = 'id:asc'
  		
  		When method get
			Then status 404
			And karate.log('Status : 404')
			And match response.errors[*].errorCode contains "NOT_FOUND"
  		And match response.errors[*].message contains "party.id.not_found"
    	And karate.log('Test Completed !')
    	
    
    #REV2-16243
  	Scenario: GET - Verify Returns all relations for party with blank partyId for super admin access.
  
  		Given path '/parties/relations' 
  		And param page = 0
  		And param partyId = ''
  		And param size = 10
  		And param sortParam = 'id:asc'
  		
  		When method get
			Then status 404
			And karate.log('Status : 404')
			And match response.errors[*].errorCode contains "NOT_FOUND"
  		And match response.errors[*].message contains "party.id.not_found"
    	And karate.log('Test Completed !')	
    	
    
  	#REV2-16244
  	Scenario: GET - Verify Returns all relations for party with leading and trailing spaces in partyId for super admin access.
  		
  		Given path '/parties/relations' 
  		And param page = 0
  		And param partyId = '  P_00170  '
  		And param size = 10
  		And param sortParam = 'id:asc'
  		
  		When method get
			Then status 404
			And karate.log('Status : 404')
			And match response.errors[*].errorCode contains "NOT_FOUND"
  		And match response.errors[*].message contains "party.id.not_found"
    	And karate.log('Test Completed !')	
    	
    
  	#REV2-16245
  	Scenario: GET - Verify Returns all relations for party with not allowed values in partyId for super admin access.
  
  		Given path '/parties/relations' 
  		And param page = 0
  		And param partyId = '&%$#@'
  		And param size = 10
  		And param sortParam = 'id:asc'
  		
  		When method get
			Then status 404
			And karate.log('Status : 404')
			And match response.errors[*].errorCode contains "NOT_FOUND"
  		And match response.errors[*].message contains "party.id.not_found"
    	And karate.log('Test Completed !')
    	
  	
  	#REV2-16246
  	Scenario: GET - Verify Returns all relations for party with multiple values in partyId for super admin access.
  		
  		Given path '/parties/relations' 
  		And param page = 0
  		And param partyId = ["P_00170", "P_00172"]
  		And param size = 10
  		And param sortParam = 'id:asc'
  		
  		When method get
			Then status 404
			And karate.log('Status : 404')
			And match response.errors[*].errorCode contains "NOT_FOUND"
  		And match response.errors[*].message contains "party.id.not_found"
    	And karate.log('Test Completed !')
    	
    	
    #REV2-16247
  	Scenario: GET - Verify Returns all relations for party with invalid value in Size for super admin access.
  		
  		Given path '/parties/relations' 
  		And param page = 0
  		And param partyId = 'P_00170'
  		And param size = 'ab'
  		And param sortParam = 'id:asc'
  		
  		When method get
			Then status 400
			And karate.log('Status : 400')
			And match response.errors[*].errorCode contains "400"
  		And match response.errors[*].message contains "invalid.value.forsize"
    	And karate.log('Test Completed !')	
    	
    
  	#REV2-16248
  	Scenario: GET - Verify Returns all relations for party with invalid value in Page for super admin access.
  		
  		Given path '/parties/relations' 
  		And param page = 'ab'
  		And param partyId = 'P_00170'
  		And param size = 10
  		And param sortParam = 'id:asc'
  		
  		When method get
			Then status 400
			And karate.log('Status : 400')
			And match response.errors[*].errorCode contains "400"
  		And match response.errors[*].message contains "invalid.value.forpage"
    	And karate.log('Test Completed !')	
    	
    
  	#REV2-16249
  	Scenario: GET - Verify Returns all relations for party with invalid value in sortParam for super admin access.
  		
  		Given path '/parties/relations' 
  		And param page = 0
  		And param partyId = 'P_00170'
  		And param size = 10
  		And param sortParam = 'ab:asc'
  		
  		When method get
			Then status 400
			And karate.log('Status : 400')
			And match response.errors[*].errorCode contains "invalid.data.url.param"
  		And match response.errors[*].message contains "Invalid data url param "
    	And karate.log('Test Completed !')	
    	
   	
  	#REV2-16252
  	Scenario: GET - Verify Returns all relations for party with Invalid authorization token for super admin access.
  
  		* def invalidAuthToken = "eyJraWQiOiJmbnAyIiwiYWxnIjoiUlMyNTYifQ"
    	* header Authorization = invalidAuthToken
  		
  		Given path '/parties/relations'
  		And param page = 0
  		And param partyId = 'P_00170'
  		And param size = 10
  		And param sortParam = 'id:asc' 
  		
  		When method get
			Then status 403
			And karate.log('Status : 403')
			And match response.errors[*].errorCode contains "access.denied"
			And match response.errors[*].message contains "Access Denied"
    	And karate.log('Test Completed !')
    	
    
  	#REV2-16253
  	Scenario: GET - Verify Returns all relations for party with Invalid Endpoint URL for super admin access.
  		
  		Given path '/part/relat' 
  		And param page = 0
  		And param partyId = 'P_00170'
  		And param size = 10
  		And param sortParam = 'id:asc'
  		
  		When method get
			Then status 404
			And karate.log('Status : 404')
			And match response.errors[*].errorCode contains "NOT_FOUND"
  		And match response.errors[*].message contains "http.request.not.found"
    	And karate.log('Test Completed !')
    	
    
  	#REV2-16254
  	Scenario: Verify Returns all relations for party with Unsupported Method for super admin access.
  		
  		Given path '/parties/relations' 
  		And param page = 0
  		And param partyId = 'P_00170'
  		And param size = 10
  		And param sortParam = 'id:asc'
  		
  		When method delete
			Then status 405
			And karate.log('Status : 405')
			And match response.errors[*].errorCode contains "unsupported.http.method"
			And match response.errors[*].message contains "Unsupported request Method. Contact the site administrator"
    	And karate.log('Test Completed !')
    	
    	