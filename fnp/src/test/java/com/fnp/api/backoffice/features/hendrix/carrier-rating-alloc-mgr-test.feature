Feature: Carrier rating scenarios for Allocation Manager role


  Background: 
    Given url backOfficeAPIBaseUrl
    And header Accept = "application/json"
    And path '/hendrix/v1/carrier-ratings'
    * def loginResult = callonce read('classpath:com/fnp/api/utils/generate-token.feature') {userType:"allocMgr"}
    * def authToken = loginResult.accessToken
    * header Authorization = authToken


  #REV2-17547
  Scenario: GET -Verify Method: GET request for Carrier Rating Configuration with Allocation Manager role access

    Given param deliveryMode = "hd"
    And param fieldName = "vendorId"
    And param fieldValues = "Carrier_101"
    And param fieldValues = "Carrier_115"
    And param operator = "EQUAL_TO"
    And param page = 0
    And param size = 10
  
    When method get
    Then status 200
    And karate.log('Status : 200')
    And karate.log('Test Completed !')


  #REV2-14610
  Scenario: POST - Verify 403 error for invalid user role (Allocation Manager)
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/carrier-rating.json')
    * eval requestPayload.deliveryMode = "Courier"
    * eval requestPayload.rating = 4
    * eval requestPayload.vendorId = "Carrier_110"
    * karate.log(requestPayload)
    When request requestPayload
    And method post
    Then status 403
    And karate.log('Status : 403')
    And match response.errors[0].message == "Access_Denied"
    And match response.errorCount == 1
    And karate.log('Test Completed !')


  #REV2-17488
  Scenario: PUT - Verify 403 error for invalid user role (Allocation Manager)
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/carrier-rating-put.json')
    * eval requestPayload[0].deliveryMode = "Courier"
    * eval requestPayload[0].rating = 2
    * eval requestPayload[0].vendorId = "Carrier_112"
    * karate.log(requestPayload)
    When request requestPayload
    And method put
    Then status 403
    And karate.log('Status : 403')
    And match response.errors[0].message == "Access_Denied"
    And match response.errorCount == 1
    And karate.log('Test Completed !')

    