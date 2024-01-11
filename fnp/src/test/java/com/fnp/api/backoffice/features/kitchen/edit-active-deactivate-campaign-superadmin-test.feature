Feature: PATCH Method for activate and deactivate the campaign using Admin Role

  Background: 
    Given url backOfficeAPIBaseUrl
    And header Accept = 'application/json'
    And path '/kitchen/v1'
    * def loginResult = callonce read('classpath:com/fnp/api/utils/generate-token.feature') {userType:'kitchenAdmin'}
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/kitchen/activate-deactivate-campaign.json')
    * def authToken = loginResult.accessToken
    * def campaignId = 'U_04655'
    * def invalidcampaignId = 'aabc@!&'
    * def blankcampaignId = ' '
    * header Authorization = authToken


 	#REV2-17861
  Scenario: PATCH - Verify patch request for activate Campaign with valid campaign Id using Admin access
  
    Given path '/campaigns/statuses/' + campaignId
   	* eval requestPayload.campaign["status"] = "ACTIVE"
    And request requestPayload 
    When method patch
    Then status 202
    And karate.log('Status : 202')
    And match response.message == 'Campaign is activated'
    And karate.log('Test Completed !')
    

  #REV2-17862
  Scenario: PATCH - Verify patch request for activate Campaign with invalid campaign Id using Admin access
  
    Given path '/campaigns/statuses/' + invalidcampaignId
   	* eval requestPayload.campaign["status"] = "ACTIVE"
    And request requestPayload 
    When method patch
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message contains "Campaign Id is not having proper format"
    And karate.log('Test Completed !')
    
    
  #REV2-17863
  Scenario: PATCH - Verify patch request for activate Campaign with invalid campaign Id using Admin access
  
    Given path '/campaigns/statuses/' + blankcampaignId
   	* eval requestPayload.campaign["status"] = "ACTIVE"
    And request requestPayload 
    When method patch
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message contains "Campaign Id is not having proper format"
    And karate.log('Test Completed !')
    
  
  #REV2-17864
  Scenario: PATCH - Verify patch request for inactive Campaign with valid values using Admin access
  
    Given path '/campaigns/statuses/' + campaignId
   	* eval requestPayload.campaign["status"] = "INACTIVE"
    And request requestPayload 
    When method patch
    Then status 202
    And karate.log('Status : 202')
    And match response.message == 'Campaign is deactivated'
    And karate.log('Test Completed !')
    
   
  #REV2-17865
  Scenario: PATCH - Verify patch request for inactive Campaign with invalid campaign Id using Admin access
  
    Given path '/campaigns/statuses/' + invalidcampaignId
   	* eval requestPayload.campaign["status"] = "INACTIVE"
    And request requestPayload 
    When method patch
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message contains "Campaign Id is not having proper format"
    And karate.log('Test Completed !')
    
 
  #REV2-17866
  Scenario: PATCH - Verify patch request for inactive Campaign with blank campaign Id using Admin access
  
    Given path '/campaigns/statuses/' + blankcampaignId
   	* eval requestPayload.campaign["status"] = "ACTIVE"
    And request requestPayload 
    When method patch
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message contains "Campaign Id is not having proper format"
    And karate.log('Test Completed !')
    
    
    