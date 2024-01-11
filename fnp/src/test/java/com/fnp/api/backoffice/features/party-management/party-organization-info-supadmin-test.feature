Feature: Party Organization Information scenarios

  Background: 
    Given url backOfficeAPIBaseUrl
    And header Accept = 'application/json'
    And path '/pawri/v1/party-organizations'
    * def loginResult = callonce read('classpath:com/fnp/api/utils/generate-token.feature') {userType:"superAdminQA"}
    * def authToken = loginResult.accessToken
    * header Authorization = authToken
    
    
  #REV2-15365
	Scenario: GET - Verify Super admin can fetch Party Organization Info with valid value in partyId
    
		* def partyId = 'C_00001'
    
		Given path '/' + partyId
    When method get
    Then status 200
    And karate.log('Status : 200')
    And karate.log(' Records found : ', response)
    And karate.log('Test Completed !')
    
    
  #REV2-15366
	Scenario: GET - Verify user cannot fetch Party Organization Info with invalid value in partyId
	
		* def partyId = 'ABC001'
		
		Given path '/' + partyId
		When method get
		Then status 404
		And karate.log('Status : 404')
		And match response.errors[0].message contains "party.id.not_found.party.organizationABC001"
		And karate.log('Test Completed !')
	
	
	#REV2-15367
	Scenario: GET - Verify user cannot fetch Party Organization Info with blank value in partyId
	
		* def partyId = '   '
		
		Given path '/' + partyId
		When method get
	  Then status 404
		And karate.log('Status : 404')
		And match response.errors[0].message contains "party.id.not_found.party.organization"
		And karate.log('Test Completed !')
		
	
	#REV2-15368
	Scenario: GET - Verify user cannot fetch Party Organization Info with multiple spaces in partyId
	
		* def partyId = ' C_000 01 ' 
		
		Given path '/' + partyId
		When method get
	  Then status 404
		And karate.log('Status : 404')
		And match response.errors[0].message contains "party.id.not_found.party.organization"
		And karate.log('Test Completed !')
		
		
	#REV2-15369
	Scenario: GET - Verify Super Admin cannot access Party Organization Info with Invalid Endpoint URL
	
		* def partyId = 'C_00001'
	
		Given path '/test/' + partyId
		When method get
	  Then status 404
		And karate.log('Status : 404')
		And match response.errors[0].message == "http.request.not.found"
		And karate.log('Test Completed !')
		
	
	#REV2-15370
	Scenario: GET - Verify Super Admin cannot access Party Organization Info with Unsupported Method
	
		* def partyId = 'C_00001'
		* def requestPayload = {}
    
    Given path '/' + partyId
    When request requestPayload
    And method post
    Then status 405
    And karate.log('Status : 405')
    And match response.errors[0].message contains "Unsupported request Method"
    And karate.log('Test Completed !')
    
  
  #REV2-15371
	Scenario: GET - Verify Super Admin cannot access Party Organization Info with Invalid authorization token
    
		* def invalidAuthToken = loginResult.accessToken + "eyJraWQiOiJmbnAyIiwiYWxnIjoiUlMyNTYifQ"
		* header Authorization = invalidAuthToken
		* def partyId = 'C_00001'
			
		Given path '/' + partyId
		When method get
	  Then status 401
		And karate.log('Status : 401')
		And karate.log('Test Completed !')
    
    