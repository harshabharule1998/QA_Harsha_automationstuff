Feature: Kitchen Module Refresh Campaign API scenarios with Super Admin Access

  Background: 
  
    Given url backOfficeAPIBaseUrl
    And header Accept = 'application/json'
    And path '/kitchen/v1/campaigns'
    
    * def loginResult = callonce read('classpath:com/fnp/api/utils/generate-token.feature') {userType:'kitchenAdmin'}
    * def authToken = loginResult.accessToken
    * header Authorization = authToken

    * def validCampaignId = "U_04657"
    
    
	#REV2-25590
  Scenario: GET - Verify Super admin can Refresh Campaign with valid campaignId
  
  	Given path '/refresher/' + validCampaignId
  	And param format = 'CSV'
  	When method get
  	Then status 200
  	And karate.log('Response is : ', response)
    And karate.log('Status : 200')
    And match response.message == 'Campaign is refreshed'
    And karate.log('Test Completed !')
    
  
	#REV2-25591
	Scenario: GET - Verify Super admin cannot Refresh Campaign with invalid campaignId
	
		* def invalidCampaignId = "gfhfhfh"
		
		Given path '/refresher/' + invalidCampaignId
  	And param format = 'CSV'
  	When method get
  	Then status 400
  	And karate.log('Response is : ', response)
    And karate.log('Status : 400')
    And match response.errors[0].message == 'Campaign Id is not having proper format'
    And karate.log('Test Completed !')
    
    
	#REV2-25592
	Scenario: GET - Verify Super admin cannot Refresh Campaign with blank campaignId
	
		* def blankCampaignId = ""
		
		Given path '/refresher/' + blankCampaignId
  	And param format = 'CSV'
  	When method get
  	Then status 400
  	And karate.log('Response is : ', response)
    And karate.log('Status : 400')
    And match response.errors[0].message == 'Campaign Id is not having proper format'
    And karate.log('Test Completed !')
    
    
	#REV2-25593
	Scenario: GET - Verify Super admin cannot Refresh Campaign with campaignId as special characters
	
		* def invalidCampaignId = "%40%40%23%24%25%25"
		
		Given path '/refresher/' + invalidCampaignId
  	And param format = 'CSV'
  	When method get
  	Then status 400
  	And karate.log('Response is : ', response)
    And karate.log('Status : 400')
    And match response.errors[0].message == 'http.request.rejected'
    And match response.errors[0].errorCode == 'BAD_REQUEST'
    And karate.log('Test Completed !')
    
	 
	#REV2-25594
	Scenario: GET - Verify Super admin cannot Refresh Campaign with campaignId as zero 
	
		* def campaignId = "0"
		
		Given path '/refresher/' + campaignId
  	And param format = 'CSV'
  	When method get
  	Then status 400
  	And karate.log('Response is : ', response)
    And karate.log('Status : 400')
    And match response.errors[0].message == 'Campaign Id is not having proper format'
    And karate.log('Test Completed !')
    
	
	#REV2-25595
	Scenario: GET - Verify Super admin cannot Refresh Campaign with campaignId as combination of alphanumeric and special characters
	
		* def campaignId = "abc123@#$$"
		
		Given path '/refresher/' + campaignId
  	And param format = 'CSV'
  	When method get
  	Then status 400
  	And karate.log('Response is : ', response)
    And karate.log('Status : 400')
    And match response.errors[0].message == 'Campaign Id is not having proper format'
    And karate.log('Test Completed !')
    
    
	#REV2-25596
	Scenario: GET - Verify Super admin cannot Refresh Campaign with minus icon in campaignId

		* def campaignId = "-1111"
		
		Given path '/refresher/' + campaignId
  	And param format = 'CSV'
  	When method get
  	Then status 400
  	And karate.log('Response is : ', response)
    And karate.log('Status : 400')
    And match response.errors[0].message == 'Campaign Id is not having proper format'
    And karate.log('Test Completed !')
    
  
	#REV2-25597
	Scenario: GET - Verify Super admin cannot Refresh Campaign with plus icon in campaignId
	
		* def campaignId = "+1111"
		
		Given path '/refresher/' + campaignId
  	And param format = 'CSV'
  	When method get
  	Then status 400
  	And karate.log('Response is : ', response)
    And karate.log('Status : 400')
    And match response.errors[0].message == 'Campaign Id is not having proper format'
    And karate.log('Test Completed !')
    
 
 