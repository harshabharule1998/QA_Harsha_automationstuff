Feature: Kitchen Get feed configuration API scenarios with Super Admin Access

  Background: 
  
    Given url backOfficeAPIBaseUrl
    And header Accept = 'application/json'
    And path '/kitchen/v1/'
    
    * def loginResult = callonce read('classpath:com/fnp/api/utils/generate-token.feature') {userType:'kitchenAdmin'}
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/kitchen/activate-deactivate-campaign.json')
    * def authToken = loginResult.accessToken
    * header Authorization = authToken
    
  
	#REV2-25340
 	Scenario: DELETE - Verify super admin to check cron expression for QARTZ_CRON_TRIGGER table in database when campaign is deleted
  	
		* def campaignId = 'U_04698'
  	
  	Given path '/campaigns/' + campaignId
  	When method delete
		Then status 200
		And karate.log('Status : 200')
		And match response.message contains "Campaign successfully deleted"
		And karate.log('Test Completed !')	
	
		
	#REV2-25339
	Scenario: PATCH - Verify super admin to check TRIGGER_STATE for QARTZ_TRIGGER table in database when campaign is deactivated
	
		* def campaignId = 'U_04665'
		* eval requestPayload.campaign["status"] = "INACTIVE"
		
	 	Given path '/campaigns/statuses/' + campaignId
    And request requestPayload 
    When method patch
    Then status 202
    And karate.log('Status : 202')
    And match response.message == 'Campaign is deactivated'
    And karate.log('Test Completed !')
	

	#REV2-25338
	Scenario: PATCH - Verify super admin to check cron expression for QARTZ_CRON_TRIGGER table in database when campaign is deactivated
		
		* def campaignId = 'U_04665'
		* eval requestPayload.campaign["status"] = "INACTIVE"
		
	 	Given path '/campaigns/statuses/' + campaignId
    And request requestPayload 
    When method patch
    Then status 202
    And karate.log('Status : 202')
    And match response.message == 'Campaign is deactivated'
    And karate.log('Test Completed !')
    
    
	#REV2-25337
	Scenario: PATCH - Verify super admin to check TRIGGER_STATE for QARTZ_TRIGGER table in database when campaign is activated
	
		* def campaignId = 'U_04665'
		* eval requestPayload.campaign["status"] = "ACTIVE"
		
		Given path '/campaigns/statuses/' + campaignId
    And request requestPayload 
    When method patch
    Then status 202
    And karate.log('Status : 202')
    And match response.message == 'Campaign is activated'
    And karate.log('Test Completed !')
    
   
	#REV2-25336
	Scenario: PATCH - Verify super admin to check cron expression for QARTZ_CRON_TRIGGER table in database when campaign is activated
		
		* def campaignId = 'U_04665'
		* eval requestPayload.campaign["status"] = "ACTIVE"
		
		Given path '/campaigns/statuses/' + campaignId
    And request requestPayload 
    When method patch
    Then status 202
    And karate.log('Status : 202')
    And match response.message == 'Campaign is activated'
    And karate.log('Test Completed !')
	
	