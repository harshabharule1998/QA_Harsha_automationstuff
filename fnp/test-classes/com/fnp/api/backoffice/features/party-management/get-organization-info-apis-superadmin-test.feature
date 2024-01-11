Feature: Party get organization info apis scenarios for super admin

  Background: 
    Given url backOfficeAPIBaseUrl
    And header Accept = 'application/json'
    And path '/pawri/v1'
    * def loginResult = callonce read('classpath:com/fnp/api/utils/generate-token.feature') {userType:"partyAdmin"}
    * def authToken = loginResult.accessToken
    * header Authorization = authToken
    
	
	#REV2-15365
	Scenario: GET - Verify superadmin Party Organization By PartyId with Valid partyId
	
		* def partyId = 'C_01160'
    Given path '/party-organizations/' + partyId
    When method get
		Then status 200
		And karate.log('Status : 200')
		And karate.log('Test Completed !')
		
	
	#REV2-15366
	Scenario: GET - Verify superadmin Party Organization By PartyId with invalid partyId
	
		* def partyId = '@!&^*%'
    Given path '/party-organizations/' + partyId
    When method get
		Then status 400
		And karate.log('Status : 400')
		And match response.errors[0].message contains "http.request.rejected"
		And karate.log('Test Completed !')	
		
	
	#REV2-15367
	Scenario: GET - Verify superadmin Party Organization By PartyId with  Blank  partyId
	
		* def partyId = ' '
    Given path '/party-organizations/' + partyId
    When method get
		Then status 404
		And karate.log('Status : 404')
		And match response.errors[0].message contains "party.id.not_found.party.organization"
		And karate.log('Test Completed !')	
		
			
	#REV2-15368
	Scenario: GET - Verify superadmin Party Organization By PartyId  try inserting with leading and trailing spaces in partyId.
		
		* def partyId = 'C_01160'
    Given path '/party-organizations/' + " " + partyId + " "
    When method get
		Then status 404
		And karate.log('Status : 404')
		And match response.errors[0].message contains "party.id.not_found.party.organization"
		And karate.log('Test Completed !')	
		
		
	#REV2-15369	
	Scenario: GET - Verify superadmin Party Organization By PartyId with invalid value in endpoint URL
	
	  * def partyId = 'C_01160'
    Given path '/party-organization/' +  partyId 
    When method get
		Then status 404
		And karate.log('Status : 404')
		And match response.errors[0].message contains "http.request.not.found"
		And karate.log('Test Completed !')	
		
	
	#REV2-15370	
	Scenario: GET - Verify superadmin Party Organization By PartyId with Unsupported Method
	  
	  * def requestPayload = {}
	  * def partyId = 'C_01160'
    Given path '/party-organizations/' +  partyId 
    When request requestPayload
    When method patch
		Then status 405
		And karate.log('Status : 405')
		And match response.errors[0].message contains "Unsupported request Method. Contact the site administrator"
		And karate.log('Test Completed !')		
			
					
	#REV2-15371		
	Scenario: GET - Verify superadmin Party Organization By PartyId with Invalid Authentication
	   
	  * def invalidAuthToken = loginResult.accessToken
    * header Authorization = invalidAuthToken + "kdhdbjidh"
	 
	  * def partyId = 'C_01160'
    Given path '/party-organizations/' +  partyId 
    When method get
		Then status 401
		And karate.log('Status : 401')
		And karate.log('Test Completed !')		
	