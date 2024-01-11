Feature: Kitchen Get history list for all campaign scenarios with manager user role 

  Background: 
    Given url backOfficeAPIBaseUrl
    And header Accept = 'application/json'
    And path '/kitchen/v1/campaigns'
    * def loginResult = callonce read('classpath:com/fnp/api/utils/generate-token.feature') {userType:'kitchenManager'}
    * def authToken = loginResult.accessToken
    * def campaignId = 'U_04639'
    * def invalidcampaignId = 'aabc@!&'
    * def id = 'U_00446'
    * header Authorization = authToken
    
 
  #REV2-20379
  Scenario: GET - Verify manager user can change history for all campaign with valid values
  
    Given path '/history'
    And param page = 0
    And param size = 10
    And param sortparam = 'updatedAt:desc'
    When method get
    Then status 200
    And karate.log('Status : 200')
    And karate.log('Test Completed !')
    
 
  #REV2-20381
  Scenario: GET - Verify manager user can change history for all campaign with blank values
  
    Given path '/history'
    And param page = ' '
    And param size = ' '
    And param sortparam = ' '
    When method get
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message contains "invalid.value.forpage"
    And karate.log('Test Completed !')
    
  
  #REV2-20382
  Scenario: GET - Verify manager user can change history for all campaign with valid page value and other blank values
  
    Given path '/history'
    And param page = 0
    And param size = ' '
    And param sortparam = ' '
    When method get
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message contains "invalid.value.forsize"
    And karate.log('Test Completed !')
    
  
  #REV2-20383
  Scenario: GET - Verify manager user can change history for all campaign with valid page and size values and blank sortparam value
  
    Given path '/history'
    And param page = 0
    And param size = 10
    And param sortparam = ' '
    When method get
    Then status 200
    And karate.log('Status : 200')
    And karate.log('Test Completed !')
    
  
  #REV2-20384
  Scenario: GET - Verify manager user can change history for all campaign with valid sortparam value and other blank value
  
    Given path '/history'
    And param page = ' '
    And param size = ' '
    And param sortparam = 'updatedAt:desc'
    When method get
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message contains "invalid.value.forpage"
    And karate.log('Test Completed !')
    
  
 	#REV2-20385
  Scenario: GET - Verify manager user can change history for all campaign with updatedAt:asc value for sortparam 
  
    Given path '/history'
    And param page = 0
    And param size = 10
    And param sortparam = 'updatedAt:ASC'
    When method get
    Then status 200
    And karate.log('Status : 200')
    And karate.log('Test Completed !')
    
   
  #REV2-20386
  Scenario: GET - Verify manager user can change history for all campaign with updatedAt:desc value for sortparam 
  
    Given path '/history'
    And param page = 0
    And param size = 10
    And param sortparam = 'updatedAt:DESC'
    When method get
    Then status 200
    And karate.log('Status : 200')
    And karate.log('Test Completed !')
    
   
  #REV2-20389
  Scenario: GET - Verify manager user can change history for all campaign with size value as 00
  
    Given path '/history'
    And param page = 0
    And param size = 00
    And param sortparam = 'updatedAt:desc'
    When method get
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message contains "must be greater than or equal to 1"
    And karate.log('Test Completed !')
    
    
  #REV2-20390
  Scenario: GET - Verify manager user can change history for all campaign with size as -1
  
    Given path '/history'
    And param page = 0
    And param size = -1
    And param sortparam = 'updatedAt:desc'
    When method get
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message contains "must be greater than or equal to 1"
    And karate.log('Test Completed !')
    
  
  #REV2-20391
  Scenario: GET - Verify manager user can change history for campaign with size value  +1
  
    Given path '/history'
    And param page = 0
    And param size = +1
    And param sortparam = 'updatedAt:desc'
    When method get
    Then status 200
    And karate.log('Status : 200')
    And karate.log('Test Completed !')
    
  
  #REV2-20392
  Scenario: GET - Verify manager user can change history for campaign with valid campaignid
    
    Given path '/history/' + campaignId
    When method get
    Then status 200
    And karate.log('Status : 200')
    And karate.log('Test Completed !')
    
 
 	#REV2-20393/REV2-20395
  Scenario: GET - Verify manager user can change history for campaign with invalid campaignid
  
    Given path  '/history/' + invalidcampaignId
    When method get
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message contains "Campaign Id is not having proper format"
    And karate.log('Test Completed !')
    
  
  #REV2-20394
  Scenario: GET - Verify manager user can change history for campaign with blank campaignid
  	
  	Given param campaignId = ''
    And path '/history/' + campaignId 
    And param page = 0
    And param size = 10
    And param sortparam = 'updatedAt:desc'
    When method get
    Then status 200
    And karate.log('Status : 200')
    And karate.log('Test Completed !')
    