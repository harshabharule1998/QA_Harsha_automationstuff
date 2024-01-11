Feature: Party - GET party types and party classifications API's scenarios for super admin

  Background: 
    Given url backOfficeAPIBaseUrl
    And header Accept = 'application/json'
    And path '/pawri/v1'
    * def loginResult = callonce read('classpath:com/fnp/api/utils/generate-token.feature') {userType:"partyAdmin"}
    * def authToken = loginResult.accessToken
    * header Authorization = authToken
	  
  
  #REV2-11341
  Scenario: GET - Verify get partytype API for super admin access  with valid URL .
	
		Given path '/partytypes/'
		When method get
		Then status 200
		And karate.log('Status : 200')
		And karate.log(' Records found : ', response)
    And karate.log('Test Completed !')
	
  
	#REV2-11342 
  Scenario: GET - Verify get partytype API for superadmin access with Invalid value in Endpoint (URL).
		
		Given path '/partytype'
		When method get
		Then status 404
		And karate.log('Status : 404')
		And karate.log(' Records found : ', response)
		And match response.errors[0].message == "http.request.not.found"
    And karate.log('Test Completed !')
  
 
  #REV2-11343
  Scenario:  Verify get partytype API with Unsupported Method for super admin access with Valid value in Endpoint (URL).
    
    * def requestPayload = {}
     
    Given path '/partytypes'
    When request requestPayload
    And method patch
    Then status 405
    And karate.log('Status : 405')
    And karate.log('Response is:', response)
    And match response.errors[0].message == "Unsupported request Method. Contact the site administrator"
    And karate.log('Test Completed !')
      
     
  #REV2-11345
  Scenario: GET - Verify get classifications API for super admin access  with valid URL 
		Given path '/classifications/'
		When method get
		Then status 200
		And karate.log('Status : 200')
		And karate.log(' Records found : ', response)
    And karate.log('Test Completed !')
    
   
  #REV2-11346
		Scenario: GET - Verify get classifications API for super admin access with Invalid value in Endpoint (URL)
		
		Given path '/classification'
		When method get
		Then status 404
		And karate.log('Status : 404')
		And karate.log(' Records found : ', response)
		And match response.errors[0].message == "http.request.not.found"
    And karate.log('Test Completed !')
  
  
	#REV2-11347 
	Scenario: GET - Verify get classifications API with Unsupported Method for super admin access with Valid value in Endpoint (URL) 
 
   * def requestPayload = {}
     
    Given path '/classifications'
    When request requestPayload
    And method patch
    Then status 405
    And karate.log('Status : 405')
    And karate.log('Response is:', response)
    And match response.errors[0].message == "Unsupported request Method. Contact the site administrator"
    And karate.log('Test Completed !')
  
  
  #REV2-11349
  Scenario: GET - Verify get classifications API for super admin access with valid Party ID.
 			 
 		* def partyTypeId = "S_70002"
 		
 		Given path '/classifications/' + partyTypeId
	  When method get
		Then status 200
		And karate.log('Status : 200')
		And karate.log(' Records found : ', response)
    And karate.log('Test Completed !')
  
   
  #REV2-11350 
  Scenario: GET - Verify get classifications API for super admin access with Invalid Party ID.
  
    * def partyTypeId = 'S_70005'
  	
 		Given path '/classifications/' + partyTypeId
	  When method get
		Then status 400
		And karate.log('Status : 400')
		And karate.log(' Records found : ', response)
		And match response.errors[0].message == "partytype.not_found"
    And karate.log('Test Completed !')
    

	#REV2-11351 
  Scenario: GET -Verify get classifications API Unsupported Method for super admin access with Valid value in Endpoint (URL)
  
    * def requestPayload = {}
     
    Given path '/classifications'
    When request requestPayload
    And method patch
    Then status 405
    And karate.log('Status : 405')
    And karate.log('Response is:', response)
    And match response.errors[0].message == "Unsupported request Method. Contact the site administrator"
    And karate.log('Test Completed !')
    
 
  Scenario: GET - Verify get classification API for super admin access with Empty Party ID.
  
    * def partyTypeId = ' '
  	
 		Given path '/classifications/' + partyTypeId
	  When method get
		Then status 400
		And karate.log('Status : 400')
		And karate.log(' Records found : ', response)
		 And match response.errors[0].message == "partytype.not_found"
    And karate.log('Test Completed !')
        
  
	Scenario: GET - Verify get classification API for super admin access with special characters in Party ID.
  
    * def partyTypeId = '@$%^&*(!'
  	
 		Given path '/classifications/' + partyTypeId
	  When method get
		Then status 400
		And karate.log('Status : 400')
		And karate.log(' Records found : ', response)
		And match response.errors[0].message == "http.request.rejected"
    And karate.log('Test Completed !')
        
    
    
  