Feature:  PUT Deactivate partyLogin permission scenarios for super admin

  Background: 
    Given url backOfficeAPIBaseUrl
    And header Accept = 'application/json'for 
    And path '/simsim/v1'
    * def loginResult = callonce read('classpath:com/fnp/api/utils/generate-token.feature') {userType:"partyAdmin"}
    * def authToken = loginResult.accessToken
    * header Authorization = authToken
   

	#REV2-18301
	Scenario: PUT - Verify super admin to Deactivate partyLogin permission For Valid permissionId & partyLoginId

	    * def requestPayload = {}
  		* def id = 'U_02905'
  		* def permissionId = 'S_20228'
  		Given path '/logins/' + id + '/permissions/' + permissionId
  		When request requestPayload
  		And method put
			Then status 200
			And karate.log('Status : 200')
    	And karate.log('Test Completed !')
    	
    
	#REV2-18302
	Scenario: PUT - Verify super admin to Deactivate partyLogin permission with Invalid value in Endpoint (URL).

	    * def requestPayload = {}
  		* def id = 'U_02905'
  		* def permissionId = 'S_20201'
  		Given path '/login/' + id + '/permission/' + permissionId
  		When request requestPayload
  		And method put
			Then status 404
			And karate.log('Status : 404')
			And match response.errors[0].message contains "http.request.not.found"
    	And karate.log('Test Completed !')
    	
   		
	#REV2-18303
  Scenario: PUT - Verify super admin to Deactivate partyLogin permission with Unsupported method For Valid partyLoginId & permissionId
    	
    	* def requestPayload = {}
  		* def id = 'U_02905'
  		* def permissionId = 'S_20201'
  		Given path '/logins/' + id + '/permissions/' + permissionId
  		When request requestPayload
  		And method get
			Then status 405
			And karate.log('Status : 405')
			And match response.errors[0].message contains "Unsupported request Method. Contact the site administrator"
    	And karate.log('Test Completed !')
    	
    
	#REV2-18304	
  Scenario: PUT - Verify super admin to Deactivate partyLogin permission with Token Invalid Authentication Required  For Valid partyLoginId 
			
			* def invalidAuthToken = loginResult.accessToken + "kjbdhxbjcjch"
      * header Authorization = invalidAuthToken
   
	    * def requestPayload = {}
	    
  		* def id = 'U_02905'
  		* def permissionId = 'S_20201'
  		
  		Given path '/logins/' + id + '/permissions/' + permissionId
  		When request requestPayload
  		And method put
			Then status 401
			And karate.log('Status : 401')
			And match response.errors[0].message contains "Token Invalid! Authentication Required"
    	And karate.log('Test Completed !')  	
    	
 
	#REV2-18305
	Scenario: PUT - Verify super admin to Deactivate partyLogin permission For Invalid partyLoginId

	    * def requestPayload = {}
  		* def id = 'U^02905'
  		* def permissionId = 'S_20201'
  		Given path '/logins/' + id + '/permissions/' + permissionId
  		When request requestPayload
  		And method put
			Then status 404
			And karate.log('Status : 404')
    	And karate.log('Test Completed !')
	
	
	#REV2-18306 
	Scenario: PUT - Verify super admin to Deactivate partyLogin permission For Invalid permissionId
	
			* def requestPayload = {}
			
  		* def id = 'U_02905'
  		* def permissionId = 'abcd'
  		
  		Given path '/logins/' + id + '/permissions/' + permissionId
  		When request requestPayload
  		And method put
			Then status 400
			And karate.log('Status : 400')
    	And karate.log('Test Completed !')
	
	  
	#REV2-18307 
	Scenario: PUT - Verify super admin to Deactivate partyLogin permission For Multiple permissionId with valid partyLoginId
    	
    	* def requestPayload = {}
    	
			* def id = "U_02905"
			* def permissionId = ["S_20228", "S_20201","S_22007"]
			
  		Given path '/logins/' + id + '/permissions/' + permissionId
			And request requestPayload
			When method put
			Then status 400
			And karate.log('Status : 400')
			And karate.log('Test Completed !')
			
 
	#REV2-18308
	Scenario: PUT - Verify super admin to Deactivate partyLogin permission For Multiple partyLoginId (comma separated) with valid permissionId
    	
    	* def requestPayload = {}
    	
			* def id = ["U_01821","U_02905"]
			* def permissionId = "S_20201"
			
  		Given path '/logins/' + id + '/permissions/' + permissionId
			And request requestPayload
			When method put
			Then status 404
			And karate.log('Status : 404')
			And karate.log('Test Completed !')
	
	
	#REV2-18309 
	Scenario: PUT - Verify super admin to Deactivate partyLogin permission with Bad Request For Blank permissionId

	    * def requestPayload = {}
  		* def id = 'U_02905'
  		* def permissionId = ' '
  		Given path '/logins/' + id + '/permissions/' + permissionId
  		When request requestPayload
  		And method put
			Then status 400
			And karate.log('Status : 400')
    	And karate.log('Test Completed !')
    	
 
	#REV2-18310 
	Scenario: PUT - Verify super admin to Deactivate partyLogin permission with Bad Request For Blank partyLoginId
	
			* def requestPayload = {}
			
  		* def id = ' '
  		* def permissionId = 'S_20201'
  		
  		Given path '/logins/' + id + '/permissions/' + permissionId
  		When request requestPayload
  		And method put
			Then status 404
			And karate.log('Status : 404')
    	And karate.log('Test Completed !')	
    	
   	
	#REV2-18312
	Scenario: PUT - Verify super admin to Deactivate partyLogin permission with Bad Request For not allowed values in permissionId
	
			* def requestPayload = {}
			
  		* def id = 'U_02905'
  		* def permissionId = '%^&*'
  		
  		Given path '/logins/' + id + '/permissions/' + permissionId
  		When request requestPayload
  		And method put
			Then status 400
			And karate.log('Status : 400')
    	And karate.log('Test Completed !')	
    
   
  #REV2-18313	
  Scenario: PUT - Verify super admin to Deactivate partyLogin permission with Bad Request For not allowed values in partyLoginId
			
			* def requestPayload = {}
			
  		* def id = '^%$(*'
  		* def permissionId = 'S_20201'
  		
  		Given path '/logins/' + id + '/permissions/' + permissionId
  		When request requestPayload
  		And method put
			Then status 400
			And karate.log('Status : 400')
    	And karate.log('Test Completed !')	  	