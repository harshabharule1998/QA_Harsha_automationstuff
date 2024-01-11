Feature: Kitchen Get history list ncampaign scenarios with super admin user role 

  Background: 
    Given url backOfficeAPIBaseUrl
    And header Accept = 'application/json'
    And path '/kitchen/v1/campaigns'
    * def loginResult = callonce read('classpath:com/fnp/api/utils/generate-token.feature') {userType:'kitchenAdmin'}
    * def authToken = loginResult.accessToken
    * header Authorization = authToken
    
  
  #REV2-20363
  Scenario: GET - Verify super admin user can change history for all campaign with valid values
  
    Given path '/history'
    And param page = 0
    And param size = 10
    And param sortparam = 'updatedAt:desc'
    When method get
    Then status 200
    And karate.log('Status : 200')
    And karate.log('Test Completed !')
  
  
  #REV2-20366
  Scenario: GET - Verify super admin user can change history for all campaign with valid page value and other blank values
  
    Given path '/history'
    And param page = 0
    And param size = ' '
    And param sortparam = ' '
    When method get
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message contains "invalid.value.forsize"
    And karate.log('Test Completed !')
    
  
  #REV2-20367
  Scenario: GET - Verify super admin user can change history for all campaign with valid page and size values and blank sortparam value
  
    Given path '/history'
    And param page = 0
    And param size = 10
    And param sortparam = ' '
    When method get
    Then status 200
    And karate.log('Status : 200')
    And karate.log('Test Completed !')
    
 
  #REV2-20368
  Scenario: GET - Verify super admin user can change history for all campaign with valid sortparam value and other blank value
  
    Given path '/history'
    And param page = ' '
    And param size = ' '
    And param sortparam = 'updatedAt:desc'
    When method get
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message contains "invalid.value.forpage"
    And karate.log('Test Completed !')
    
  
  #REV2-20369
  Scenario: GET - Verify super admin user can change history for all campaign with updatedAt:asc value for sortparam 
  
    Given path '/history'
    And param page = 0
    And param size = 10
    And param sortparam = 'updatedAt:ASC'
    When method get
    Then status 200
    And karate.log('Status : 200')
    And karate.log('Test Completed !')
    

  #REV2-20370
  Scenario: GET - Verify super admin user can change history for all campaign with updatedAt:desc value for sortparam 
  
    Given path '/history'
    And param page = 0
    And param size = 10
    And param sortparam = 'updatedAt:DESC'
    When method get
    Then status 200
    And karate.log('Status : 200')
    And karate.log('Test Completed !')
    
 
  #REV2-20371
  Scenario: GET - Verify super admin user can change history for all campaign with page value as +1 
  
    Given path '/history'
    And param page = +1
    And param size = 10
    And param sortparam = 'updatedAt:desc'
    When method get
    Then status 200
    And karate.log('Status : 200')
    And karate.log('Test Completed !')
    
  
  #REV2-20373
  Scenario: GET - Verify super admin user can change history for all campaign with size value as 00
  
    Given path '/history'
    And param page = 0
    And param size = 00
    And param sortparam = 'updatedAt:desc'
    When method get
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message contains "must be greater than or equal to 1"
    And karate.log('Test Completed !')
    
   
  #REV2-20374
  Scenario: GET - Verify super admin user can change history for all campaign with size as -1
  
    Given path '/history'
    And param page = 0
    And param size = -1
    And param sortparam = 'updatedAt:desc'
    When method get
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message contains "must be greater than or equal to 1"
    And karate.log('Test Completed !')
    
   
  #REV2-20375
  Scenario: GET - Verify super admin user can change history for all campaign with size as +1
  
    Given path '/history'
    And param page = 0
    And param size = +1
    And param sortparam = 'updatedAt:desc'
    When method get
    Then status 200
    And karate.log('Status : 200')
    And karate.log('Test Completed !')
    
 
  #REV2-20376
  Scenario: GET - Verify super admin user can change history for all campaign with campaignid 1
  
    Given path '/history' 
    And param campaignId = 1
    And param page = 0
    And param size = 10
    And param sortparam = 'updatedAt:desc'
    When method get
    Then status 200
    And karate.log('Status : 200')
    And karate.log('Test Completed !')
    
    
  #REV2-20377
  Scenario: GET - Verify super admin user can change history for all campaign with campaignid blank
  
    Given path '/history/campaignId' 
    And param campaignId = ' '
    And param page = 0
    And param size = 10
    And param sortparam = 'updatedAt:desc'
    When method get
    Then status 400
    And match response.errors[0].message contains "Campaign Id is not having proper format"
    And karate.log('Status : 400')
    And karate.log('Test Completed !')
    
    