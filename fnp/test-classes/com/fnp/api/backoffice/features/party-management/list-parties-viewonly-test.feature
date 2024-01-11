Feature: Party - GET parties APIs scenarios for view only permission user.

  Background: 
  
    Given url backOfficeAPIBaseUrl
    And header Accept = 'application/json'
    And path '/pawri/v1'
    
    * def partyViewOnlyLoginResult = callonce read('classpath:com/fnp/api/utils/generate-token.feature') {userType:"partyViewOnly"}
    * def partyViewOnlyauthToken = partyViewOnlyLoginResult.accessToken
    * header PartyViewOnlyAuthorization = partyViewOnlyauthToken

   
	#REV2-13229 and REV2-13242
	Scenario: GET - Verify list of parties with View permission access for all valid fields
	
    * header PartyViewOnlyAuthorization = partyViewOnlyauthToken
    
    Given path '/parties'
 		And param page = 0
    And param size = 10
    And param sortParam = "firstName:asc"
		When method get
		Then status 200
		And karate.log('Status : 200')
		And karate.log(' Records found : ', response)
    And karate.log('Test Completed !')
   
  
	#REV2-13230
	Scenario: GET - Verify list of parties with View permission access for all invalid fields

    Given path '/parties'
    And param page = 'ab'
    And param size = 'xz'
    And param sortParam = 'ab:asc'
		When method get
		Then status 400
		And karate.log('Status : 400')
		And karate.log(' Records found : ', response)
    And karate.log('Test Completed !')
    
  	
	#REV2-13231
	Scenario: GET - Verify  list of parties with View permission access for all balnk fields

    Given path '/parties'
    And param page = ' '
    And param size =  ' '
    And param sortParam = " "
		When method get
		Then status 400
		And karate.log('Status : 400')
		And karate.log(' Records found : ', response)
    And karate.log('Test Completed !')
    
	  
	#REV2-13238
	Scenario: GET - Verify 404 Error for GET request for Listing party with view permission access
	
    Given path '/partie'
    And param page = 0
    And param size =  10
    And param sortParam = "firstName:asc"
		When method get
		Then status 404
		And karate.log('Status : 404')
		And karate.log(' Records found : ', response)
    And karate.log('Test Completed !')
	

	#REV2-13240
	Scenario: GET - Verify any method with Unsupported methods for endpoints
	
	
	  * def requestPayload = {}
	  
    Given path '/parties'
    And param page = 0
    And param size = 10
    And param sortParam = "firstName:asc"
		When request requestPayload
    And method patch
    Then status 405
    And karate.log('Status : 405')
		And karate.log(' Records found : ', response)
    And karate.log('Test Completed !')
	
	
	#REV2-13241
	Scenario: GET - Verify GET method with Invalid authorization token	
	
	 	* def partyViewOnlyInvalidAuthToken =  partyViewOnlyLoginResult.accessToken + "eyJraWQiOiJmbnAyIiwiYWxnIjoiUlMyNTYifQ"
		* header PartyViewOnlyAuthorization = partyViewOnlyInvalidAuthToken
	
    Given path '/parties'
    And param page = 0
    And param size = 10
    And param sortParam = 'firstName:asc'
    
		When method get
		Then status 403
		And karate.log('Status : 403')
		And karate.log(' Records found : ', response)
    And karate.log('Test Completed !')
	 
	 

	
	
	