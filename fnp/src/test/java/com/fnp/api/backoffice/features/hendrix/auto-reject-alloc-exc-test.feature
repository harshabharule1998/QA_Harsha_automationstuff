Feature: Auto Reject Duration Policy Configuration scenarios for Allocation Executive role


  Background: 
    Given url backOfficeAPIBaseUrl
    And header Accept = "application/json"
    And path '/hendrix/v1/auto-rejection-policies'
    * def loginResult = callonce read('classpath:com/fnp/api/utils/generate-token.feature') {userType:"allocExc"}
    * def authToken = loginResult.accessToken
    * header Authorization = authToken


  #REV2-12881
  Scenario: GET - Verify 403 error for invalid user role (Allocation executive)
    Given param geoId = 'India'
    When method get
    Then status 200
    And karate.log('Status : 200')
    And karate.log('Test Completed !')


  #REV2-12859
  Scenario: PUT - Verify 403 error for invalid user role (Allocation executive)
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/hendrix/auto-reject-policy.json') 
    * eval requestPayload.distanceFromBaseGeoId = 23
    * eval requestPayload.geoId = "India"
    * eval requestPayload.futureDuration = 2
    * eval requestPayload.nextDayDuration = 3
    * eval requestPayload.sameDayDuration = 4
    * eval requestPayload.vendorIds = ["FC_101","FC_102"]
    When request requestPayload
    And method put
    Then status 400
    And karate.log('Status : 403')
    Then response.status == "Access_Denied"
    And match response.errorCount == 1
    And karate.log('Test Completed !')

    