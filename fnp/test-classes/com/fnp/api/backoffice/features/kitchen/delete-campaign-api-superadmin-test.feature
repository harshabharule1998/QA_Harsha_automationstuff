Feature: Kitchen module delete api scenarios with super admin user role 

  Background: 
    Given url backOfficeAPIBaseUrl
    And header Accept = 'application/json'
    And path '/kitchen/v1'
    * def loginResult = callonce read('classpath:com/fnp/api/utils/generate-token.feature') {userType:'kitchenAdmin'}
    * def authToken = loginResult.accessToken
    * def campaignId = 'U_04655'
    * def invalidcampaignId = 'aabc@!&'
    * def blankcampaignId = ' '
    * header Authorization = authToken
    
    
  #REV2-17816
  Scenario: DELETE - Verify delete request for Campaign with valid campaign Id using Admin access
  	
  	Given path '/campaigns/' + campaignId
  	When method delete
		Then status 200
		And karate.log('Status : 200')
		And match response.message contains "Campaign successfully deleted"
		And karate.log('Test Completed !')
		

	#REV2-17817/REV2-17818
  Scenario: DELETE - Verify delete request for Campaign with invalid campaign Id using Admin access
    
   	Given path '/campaigns/' + invalidcampaignId
    When method delete
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message contains "Campaign Id is not having proper format"
    And karate.log('Test Completed !')
    
	
	#REV2-17819
  Scenario: DELETE - Verify delete request for Campaign with blank campaign Id using Admin access
    
   	Given path '/campaigns/' + blankcampaignId
    When method delete
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message contains "Campaign Id is not having proper format"
    And karate.log('Test Completed !')
    