Feature: List Roles of Party API Scenarios feature

	Background: 
    Given url backOfficeAPIBaseUrl
    And header Accept = 'application/json'
    And path '/simsim/v1/roles'
    * def loginResult = callonce read('classpath:com/fnp/api/utils/generate-token.feature') {userType:"superAdminQA"}
    * def authToken = loginResult.accessToken
    * header Authorization = authToken


 	#REV2-13573
 	Scenario: GET - Verify the API Response for get list of all roles of party
 	
    When method get
    Then status 200
    And karate.log('Status : 200')
    And karate.log('Test Completed !')
    
   
	#REV2-14318
	Scenario: GET - Verify the API Response for get list of roles of party - with Invalid value in Endpoint (URL)
	
	  Given path '/simsim/vv2/roles'
    When method get
    Then status 404
    And karate.log('Status : 404')
    And match response.errors[0].errorCode == "NOT_FOUND"
    And match response.errors[0].message contains "not.found"
    And karate.log('Test Completed !')
    
    
	#REV2-13578
	Scenario: PATCH - Unsupported Method to get the list of role of party for valid Endpoint URL
	
		* def requestPayload = {}
		
		Given request requestPayload
    When method patch
    Then status 405
    And karate.log('Status : 405')
    And match response.errors[*].message contains "Unsupported request Method. Contact the site administrator"
    And karate.log('Test Completed !')


	#REV2-13579
	Scenario: GET - Verify the API Response to get the list of roles of party using Invalid Authentication
	
		* def invalidAuthToken = "eyJraWQiOiJmbnAyIiwiYWxnIjoiUlMyNTYifQ"
		* header Authorization = invalidAuthToken
		
			When method get
	  	Then status 401
			And karate.log('Status : 401')
			And match response.errors[0].message == "Token Invalid! Authentication Required"
			And karate.log('Test Completed !')
	

 	