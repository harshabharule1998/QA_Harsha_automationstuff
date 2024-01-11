Feature: Manual alloc preference GET by date ranges with Allocation manager user role

  Background: 
    Given url backOfficeAPIBaseUrl
    And header Accept = 'application/json'
    And path '/hendrix/v1/manual-allocation-preferences'
    * def loginResult = callonce read('classpath:com/fnp/api/utils/generate-token.feature') {userType:'allocMgr'}
    * def authToken = loginResult.accessToken
    * header Authorization = authToken
    
  #REV2-30669
  Scenario: GET - Verify  allocation manager user can fetch records of manual allocation preference config GET-date-ranges api with valid values
    Given path '/date-ranges'
    And param baseGeoId = '411006'
    And param page = '0'
    And param pgId = '1'
    And param size = 10
    And param vendorType = 'FC'
    When method get
    Then status 403
    And karate.log('Status : 403')
    And match response.errors[0].message == "Access_Denied"
    
    And karate.log('Test Completed !')