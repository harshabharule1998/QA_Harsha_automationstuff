Feature: Kitchen Get feed configuration API scenarios with Super Admin Access

  Background: 
  
    Given url backOfficeAPIBaseUrl
    And header Accept = 'application/json'
    And path '/kitchen/v1/'
    
    * def loginResult = callonce read('classpath:com/fnp/api/utils/generate-token.feature') {userType:'kitchenAdmin'}
    * def authToken = loginResult.accessToken
    * header Authorization = authToken
   
    
	#REV2-21762
	Scenario: GET - Verify Super admin can fetch Feed Configuration with valid campaignId
	
		* def campaignId = 'U_04665'
  	
		Given path 'feedconfiguration/' + campaignId
  	When method get
  	Then status 200
  	And karate.log('Response is : ', response)
    And karate.log('Status : 200')
    And karate.log('Test Completed !')
   
   
	#REV2-21763
	Scenario: GET - Verify Super admin cannot fetch Feed Configuration with invalid campaignId
	
		* def invalidcampaignId = 'abc233'
  	
		Given path 'feedconfiguration/' + invalidcampaignId
  	When method get
  	Then status 400
  	And karate.log('Response is : ', response)
    And karate.log('Status : 400')
    And match response.errors[0].message contains "Campaign Id is not having proper format"
    And karate.log('Test Completed !')
   
    
	#REV2-21764
	Scenario: GET - Verify Super admin cannot fetch Feed Configuration with blank campaignId
	
		* def campaignId = ''
  	
		Given path 'feedconfiguration/' + campaignId
  	When method get
  	Then status 404
  	And karate.log('Response is : ', response)
    And karate.log('Status : 404')
    And match response.errors[0].message contains "http.request.not.found"
    And karate.log('Test Completed !')
    
	
	#REV2-21765
	Scenario: GET - Verify Super admin cannot fetch Feed Configuration with valid publisherID in place of CampaignId
	
		* def campaignId = 'PUB_0002'
  	
		Given path 'feedconfiguration/' + campaignId
  	When method get
  	Then status 400
  	And karate.log('Response is : ', response)
    And karate.log('Status : 400')
    And match response.errors[0].message contains "Campaign Id is not having proper format"
    And karate.log('Test Completed !')
    
   
	#REV2-21766
  Scenario: GET - Verify Super admin cannot fetch Feed Configuration with invalid endpoint url
  	
  	* def campaignId = 'U_04665'
  	
		Given path 'feedconfiguration/test/' + campaignId
  	When method get
  	Then status 404
  	And karate.log('Response is : ', response)
    And karate.log('Status : 404')
    And match response.errors[0].message contains "http.request.not.found"
    And karate.log('Test Completed !')
 
    