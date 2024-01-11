Feature: GET New Vendor Allocation Preference Quota Configuration scenarios for Add Rule page with Allocation Manager Role


  Background: 
    Given url backOfficeAPIBaseUrl
    And path '/hendrix/v1/new-vendor-allocation-preferences'
    * header Accept = 'application/json'
    * def loginResult = callonce read('classpath:com/fnp/api/utils/generate-token.feature') {userType:"allocMgr"}
    * def token = loginResult.accessToken
    * header Authorization = token


  #REV2-17547
  Scenario: GET - Verify 403 error for invalid user role (Allocation Manager) for New Vendor Allocation Preference Quota Configuration for Add Rule page
    Given path '/configs'
    And param deliveryMode = 'Courier'
    And param fcId = 'FC_101'
    And param geoId = '1'
    And param geoGroupId = '2'
    And param fieldName = 'baseGeoId'
    And param fieldValues = '411'
    And param operator = 'CONTAINS'
    And param page = 0
    And param size = 10
    When method get
    Then status 403
    And karate.log('Status : 403')
    And karate.log('Response is:', response)
    And match response.errors[0].message == "Access_Denied"
    And match response.errorCount == 1
    And karate.log('Test Completed !')

    