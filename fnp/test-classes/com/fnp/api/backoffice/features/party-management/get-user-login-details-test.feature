Feature: Party  get user login details scenarios

  Background: 
    Given url backOfficeAPIBaseUrl
    And header Accept = 'application/json'
    And path '/simsim/v1'
    * def loginResult = callonce read('classpath:com/fnp/api/utils/generate-token.feature') {userType:"partyAdmin"}
    * def authToken = loginResult.accessToken
    * header Authorization = authToken
   
       
  #REV2-15482   
	Scenario: GET - Verify User Login Details with Super Admin access with valid value in loginId.
	
  		* def loginId = 'U_01006'
  		
  		Given path '/logins/' + loginId 
  		When method get
			Then status 200
			And karate.log('Status : 200')
    	And karate.log('Test Completed !')
    	
     
  #REV2-15483  
	Scenario: GET - Verify User Login Details with Super Admin access with invalid value in loginId.
	
  		* def loginId = 'abcd'
  		
  		Given path '/logins/' + loginId 
  		When method get
			Then status 404
			And karate.log('Status : 404')
    	And karate.log('Test Completed !')
    
  
	#REV2-15484   
	Scenario: GET - Verify User Login Details with Super Admin access with blank value in loginId.
	
  		* def loginId = ' '
  		
  		Given path '/logins/' + loginId 
  		When method get
			Then status 404
			And karate.log('Status : 404')
    	And karate.log('Test Completed !')
    
    
	#REV2-15485 
	Scenario: GET - Verify User Login Details with Super Admin access with blank value for leading & trailing spaces in loginId.
	
  		* def loginId = " " + 'U_01006' + " "
  		
  		Given path '/logins/' + loginId 
  		When method get
			Then status 404
			And karate.log('Status : 404')
    	And karate.log('Test Completed !')
        
     
	#REV2-15486
	Scenario: GET - Verify User Login Details with Super Admin access with not allowed value in loginId.
	
  		* def loginId = '@*$%'
  		
  		Given path '/logins/' + loginId 
  		When method get
			Then status 400
			And karate.log('Status : 400')
    	And karate.log('Test Completed !')
          
        
  #REV2-15487  
	Scenario: GET - Verify User Login Details with Super Admin access with invalid endpoint URL
	
  		* def loginId = 'U_01006'
  		
  		Given path '/login/' + loginId 
  		When method get
			Then status 404
			And karate.log('Status : 404')
    	And karate.log('Test Completed !')
    	
    	
  #REV2-15488 
	Scenario: GET - Verify Unsupported Method User Login Details with Super Admin access with Valid value in Endpoint URL.
			
			* def requestPayload = {}
		  * def loginId = 'U_01006'
  	
  		Given path '/logins/' + loginId 
  	  When request requestPayload
			And method post
			Then status 405
			And karate.log('Status : 405')
			And match response.errors[0].message contains "Unsupported request Method. Contact the site administrator"
    	And karate.log('Test Completed !')
    	
   	 
  #REV2-15489 
	Scenario: GET - Verify User Login Details with Super Admin access with invalid authorization token
	
			* def invalidAuthToken = loginResult.accessToken + "kjdhddsudnbcnnnchdchy"
    	* header Authorization = invalidAuthToken
    	
  		* def loginId = 'U_01006'
  		
  		Given path '/logins/' + loginId 
  		When method get
			Then status 401
			And karate.log('Status : 401')
			And match response.errors[0].message contains "Token Invalid! Authentication Required"
    	And karate.log('Test Completed !')
    	