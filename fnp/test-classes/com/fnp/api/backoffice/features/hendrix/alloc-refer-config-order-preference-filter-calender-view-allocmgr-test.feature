Feature: New Vendor Allocation Preference by Calendar view test Api for allocation manager

  Background: 
    Given url backOfficeAPIBaseUrl
    And path '/hendrix/v1/new-vendor-allocation-preferences'
    * header Accept = 'application/json'
    * def loginResult = callonce read('classpath:com/fnp/api/utils/generate-token.feature') {userType:"allocMgr"}
    * def token = loginResult.accessToken
    * header Authorization = token


  #REV2-20220/REV2-31424
  Scenario: GET - Verify allocation manager can fetch New Vendor Allocation Preference by Calendar View with valid ids	

    Given path '/calendar-view'  
    And param baseGeoId = '411001'
    And param deliveryMode = 'hd'
    And param fieldName = 'vendorId'
    And param fieldValues = 'FC_111'
    And param fieldValues = 'FC_103'
    And param fromDate = '20-12-2021'
    And param geoGroupId = 'pune'
    And param geoId = 'india'
    And param operator = 'EQUAL_TO'
    And param page = '0'
    And param size = '10'
    And param pgId = '5'
    And param thruDate = '22-12-2021'

    When method get
    Then status 200
    And karate.log('Status : 200')
    And assert response.total >= 1
    And karate.log('Response is:', response)
    And karate.log('Test Completed !')
