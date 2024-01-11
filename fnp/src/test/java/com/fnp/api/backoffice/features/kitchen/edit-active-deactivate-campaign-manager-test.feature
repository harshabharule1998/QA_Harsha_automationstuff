Feature: PATCH Method for activate and deactivate the campaign using Manager Role

  Background: 
    Given url backOfficeAPIBaseUrl
    And header Accept = 'application/json'
    And path '/kitchen/v1'
    * def loginResult = callonce read('classpath:com/fnp/api/utils/generate-token.feature') {userType:'kitchenManager'}
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/kitchen/activate-deactivate-campaign.json')
    * def authToken = loginResult.accessToken
    * def campaignId = 'U_04655'
    * def invalidcampaignId = 'aabc@!&'
    * def blankcampaignId = ' '
    * header Authorization = authToken
    
 
  #REV2-17867
  Scenario: PATCH - Verify patch request for inactive Campaign with valid campaign Id using Manager access
  
    Given path '/campaigns/statuses/' + campaignId
   	* eval requestPayload.campaign["status"] = "INACTIVE"
    And request requestPayload 
    When method patch
    Then status 403
    And karate.log('Status : 403')
    And match response.errors[0].message contains "Token Missing! Authentication Required"
    And karate.log('Test Completed !')
    
  
  #REV2-17868
  Scenario: PATCH - Verify patch request for active Campaign with valid campaign Id using Manager access
  
    Given path '/campaigns/statuses/' + campaignId
   	* eval requestPayload.campaign["status"] = "ACTIVE"
    And request requestPayload 
    When method patch
    Then status 403
    And karate.log('Status : 403')
    And match response.errors[0].message contains "Token Missing! Authentication Required"
    And karate.log('Test Completed !')