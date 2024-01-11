Feature: New Vendor Allocation Preference Quota Configuration Scenarios for Allocation Manager role

  Background: 
    Given url backOfficeAPIBaseUrl
    And path '/hendrix/v1/new-vendor-allocation-preferences'
    * header Accept = 'application/json'
    
    * def loginResult = callonce read('classpath:com/fnp/api/utils/generate-token.feature') {userType:"allocMgr"}
    * def token = loginResult.accessToken
    * header Authorization = token


  #REV2-20780
  Scenario: GET - Verify alloc manager can not fetch New-Vendor-Allocation-Preference Quota Configuration by Date-Range

		Given path '/vendor-allocation-by-date-range'
    And param deliveryMode = 'hd'
    And param fcId = 'FC_114'
    And param fieldName = 'baseGeoId'
		And param fieldValues = '411001'
    And param fromDate = '11-01-2022'
    And param geoGroupId = 'Kolkata'
    And param geoId = 'India'
    And param operator = 'EQUAL_TO'
    And param page = 0
    And param size = 10
    And param thruDate = '14-11-2022'
    When method get
    Then status 403
    And karate.log('Status : 403')
    And karate.log('Response is:', response)
    And match response.errors[*].message contains 'Access_Denied'
    And assert response.errorCount >= 1
    And karate.log('Test Completed !')
    
 
  #REV2-17915
  Scenario: GET - Verify alloc manager can fetch New Vendor Allocation Preference Quota Configuration by Vendor Id
 
    * def id = 'FC_101'
    Given path '/date-ranges/vendor-id/' + id
    And param page = 0
    And param size = 10
    When method get
    Then status 200
    And karate.log('Status : 200')
  	And match each response.data[*].vendorId contains "FC_101"
		And karate.log('Test Completed !')

		