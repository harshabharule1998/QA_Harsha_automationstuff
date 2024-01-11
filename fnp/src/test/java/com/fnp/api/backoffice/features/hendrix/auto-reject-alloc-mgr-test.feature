Feature: Auto Reject Duration Policy Configuration scenarios for Allocation Manager role


  Background: 
    Given url backOfficeAPIBaseUrl
    And header Accept = "application/json"
    And path '/hendrix/v1/auto-rejection-policies'
    * def loginResult = callonce read('classpath:com/fnp/api/utils/generate-token.feature') {userType:"allocMgr"}
    * def authToken = loginResult.accessToken
    * header Authorization = authToken


  #REV2-12873
  Scenario: GET - Verify Allocation Manager user can fetch Auto Reject Duration Policy Configuration for valid input
    Given param geoId = 'India'
    When method get
    Then status 200
    And karate.log('status : 200')
    And match response.geoId contains 'India'
    And karate.log('Test Completed !')


  #REV2-12874
  Scenario: GET - Verify Allocation Manager user cannot fetch Auto Reject Duration Policy Configuration for invalid input
    Given param geoId = 'abcd@123'
    When method get
    Then status 400
    And karate.log('status : 400')
    And match response.errors[0].message == "Invalid characters found."
    And match response.errorCount == 1
    And karate.log('Test Completed !')


  #REV2-12875
  Scenario: GET - Verify Allocation Manager user cannot fetch Auto Reject Duration Policy Configuration for blank input
    Given param geoId = ''
    When method get
    Then status 400
    And karate.log('status : 400')
    And match response.errors[0].message == "The Geography field is mandatory."
    And match response.errorCount == 1
    And karate.log('Test Completed !')


  #REV2-12876
  Scenario: GET - Verify error for invalid authorization token
    * def invalidAuthToken = "eyJraWQiOiJmbnAyIiwiYWxnIjoiUlMyNTYifQ"
    * header Authorization = invalidAuthToken
    Given param geoId = 'India'
    When method get
    Then status 401
    And karate.log('Status : 401')
    And match response.errors[0].message == "Token Invalid! Authentication Required"
    And match response.errorCount == 1
    And karate.log('Test Completed !')


  #REV2-12879
  Scenario: GET -  Verify Allocation Manager get 404 error for Auto Reject Duration Policy Configuration invalid endpoint URL
    Given path '/hendrix/v1/uto-rejection-policies'
    And param domainId = "fnp.com"
    When method get
    Then status 404
    And karate.log('status : 404')
    And match response.errors[0].message == "http.request.not.found"
    And match response.errorCount == 1
    And karate.log('Test Completed !')


  #REV2-12845
  Scenario: PUT - Verify Allocation Manager can update Auto Reject Duration Policy Configuration with valid values
    
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/hendrix/auto-reject-policy.json') 
    * eval requestPayload.distanceFromBaseGeoId = 21
    * eval requestPayload.futureDuration = 64
    * eval requestPayload.geoId = "India"
    * eval requestPayload.nextDayDuration = 15
    * eval requestPayload.sameDayDuration = 12
    * eval requestPayload.exceptionalFcs = ["FC_111","FC_141"]
    * eval requestPayload.thruTime = "20:08"
    * eval requestPayload.columnOption = "vendor_Id"
    
    * karate.log(requestPayload)
    When request requestPayload
    And method put
    Then status 200
    And karate.log('Status : 200')

    * def authToken = loginResult.accessToken
    * header Authorization = authToken
    Given path '/hendrix/v1/auto-rejection-policies'
    And param geoId = 'India'
    When method get
    Then status 200
    And karate.log('status : 200')
    And karate.log('Test Completed !')


  #REV2-12846
  Scenario: PUT - Verify Allocation Manager can update Auto Reject Duration Policy Configuration with only mandatory fields
   
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/hendrix/auto-reject-policy.json') 
    * eval requestPayload.distanceFromBaseGeoId = 23
    * eval requestPayload.futureDuration = 64
    * eval requestPayload.geoId = "India"
    * eval requestPayload.nextDayDuration = 15
    * eval requestPayload.sameDayDuration = 12
    * eval requestPayload.exceptionalFcs = ["FC_111","FC_141"]
    * eval requestPayload.thruTime = "20:08"
    * eval requestPayload.columnOption = "vendor_Id"
    
    * karate.log(requestPayload)
    When request requestPayload
    And method put
    Then status 200
    And karate.log('Status : 200')
   # Verify updated changes on GET method
    * def authToken = loginResult.accessToken
    * header Authorization = authToken
    Given path '/hendrix/v1/auto-rejection-policies'
    And param geoId = "India"
    
    When method get
    Then status 200
    And karate.log('status : 200')
    
    And match response.distanceFromBaseGeoId == 23  
    And match response.geoId == "India"
    And match response.thruTime == "20:08"
    And match response.exceptionalFcs == [{"FC_111":"FC_Name111"},{"FC_141":"FC_Name141"}]
    And match response.futureDuration == 64
    And match response.nextDayDuration == 15
    And match response.sameDayDuration == 12
    #And match response.columnOption == "vendor_Id"
    And karate.log('Test Completed !')


  #REV2-12847
  Scenario: PUT - Verify Allocation Manager cannot update Auto Reject Duration Policy Configuration with blank fields
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/hendrix/auto-reject-policy.json') 
    * eval requestPayload.distanceFromBaseGeoId = ' '
    * eval requestPayload.fromTime == " "
    * eval requestPayload.geoId = " "
    * eval requestPayload.futureDuration = ' '
    * eval requestPayload.nextDayDuration = ' '
    * eval requestPayload.sameDayDuration = ' '
    * eval requestPayload.thruTime == " "
    * eval requestPayload.exceptionalFcs = [ ]
    * eval requestPayload.columnOption = " "
    
    * karate.log(requestPayload)
    When request requestPayload
    And method put
    Then status 400
    And karate.log('Status : 400')
   
    And match response.errors[*].message contains "The Future field is mandatory."
    And match response.errors[*].message contains "Invalid characters found in geoId."
    And match response.errors[*].message contains "The Same-Day field is mandatory."
    And match response.errors[*].message contains "The Distance field is mandatory."
    And match response.errors[*].message contains "The Geography field is mandatory."
    And match response.errors[*].message contains "The Next Day field is mandatory."  
    
    * def authToken = loginResult.accessToken
    * header Authorization = authToken
    Given path '/hendrix/v1/auto-rejection-policies'
    And param geoId = 'India'
    When method get
    Then status 200
    And karate.log('Test Completed !')


  #REV2-12848
  Scenario: PUT - Verify Allocation Manager cannot update Auto Reject Duration Policy Configuration if there are spaces in fields
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/hendrix/auto-reject-policy.json') 
    * eval requestPayload.distanceFromBaseGeoId = 1
    * eval requestPayload.geoId = " India"
    * eval requestPayload.futureDuration = 2
    * eval requestPayload.nextDayDuration = 3
    * eval requestPayload.sameDayDuration = 4
    * eval requestPayload.exceptionalFcs = ["FC_111","FC_141"]
    * karate.log(requestPayload)
    When request requestPayload
    And method put
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message == "Invalid characters found in geoId."
    And match response.errorCount == 1
    And karate.log('Test Completed !')


  #REV2-12852
  Scenario: PUT - Verify Allocation Manager cannot update Auto Reject Duration Policy Configuration with invalid nextDayDuration
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/hendrix/auto-reject-policy.json') 
   
    * eval requestPayload.distanceFromBaseGeoId = 23
    * eval requestPayload.futureDuration = 64
    * eval requestPayload.geoId = "India"
    * eval requestPayload.sameDayDuration = 12
    * eval requestPayload.exceptionalFcs = ["FC_111","FC_141"]
    * eval requestPayload.thruTime = "20:08"
    * eval requestPayload.columnOption = "vendor_Id"
    * eval requestPayload.nextDayDuration = 25
  
    * karate.log(requestPayload)
    When request requestPayload
    And method put
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message == "nextDayDuration value should be between 0 to 24."
    And match response.errorCount == 1
    And karate.log('Test Completed !')


  #REV2-25817
  Scenario: PUT - Verify Allocation Manager cannot update Auto Reject Duration Policy Configuration with invalid sameDayDuration
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/hendrix/auto-reject-policy.json') 
    * eval requestPayload.distanceFromBaseGeoId = 23
    * eval requestPayload.geoId = "India"
    * eval requestPayload.futureDuration = 2
    * eval requestPayload.nextDayDuration = 3
    * eval requestPayload.sameDayDuration = 13
    * eval requestPayload.vendorIds = ["FC_101","FC_102"]
    * karate.log(requestPayload)
    When request requestPayload
    And method put
    Then status 400
    And karate.log('Status : 400')
    Then response.status == "sameDayDuration value should be between 0 to 12."
    And match response.errorCount == 1
    And karate.log('Test Completed !')


  #REV2-25818
  Scenario: PUT - Verify Allocation Manager cannot update Auto Reject Duration Policy Configuration with invalid futureDuration
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/hendrix/auto-reject-policy.json') 
    * eval requestPayload.distanceFromBaseGeoId =23
    * eval requestPayload.geoId = "India"
    * eval requestPayload.futureDuration = 0
    When request requestPayload
    And method put
    Then status 400
    And karate.log('Status : 400')
    Then response.status == "futureDuration value should be above 0."
    And match response.errorCount == 1
    And karate.log('Test Completed !')


  #REV2-12854
  Scenario: PUT : Verify 401 error for invalid authorization token
    * def invalidAuthToken = "eyJraWQiOiJmbnAyIiwiYWxnIjoiUlMyNTYifQ"
    * header Authorization = invalidAuthToken
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/hendrix/auto-reject-policy.json') 
    * eval requestPayload.distanceFromBaseGeoId = 1
    * eval requestPayload.geoId = "India"
    * eval requestPayload.futureDuration = 2
    * eval requestPayload.nextDayDuration = 3
    * eval requestPayload.sameDayDuration = 4
    * eval requestPayload.vendorIds = ["FC_101","FC_102"]
    When request requestPayload
    And method put
    Then status 401
    And karate.log('Status : 401')
    Then response.status == "Token Invalid! Authentication Required"
    And match response.errorCount == 1
    And karate.log('Test Completed !')


  #REV2-12857
  Scenario: PUT - Verify Allocation Manager get 404 error for Auto Reject Duration Policy Configuration with invalid endpoint
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/hendrix/auto-reject-policy.json') 
    * eval requestPayload.distanceFromBaseGeoId = 1
    * eval requestPayload.geoId = "India"
    * eval requestPayload.futureDuration = 2
    * eval requestPayload.nextDayDuration = 3
    * eval requestPayload.sameDayDuration = 4
    * eval requestPayload.vendorIds = ["FC_101","FC_102"]
    * karate.log(requestPayload)
    Given path '/hendrix/v1/uto-rejection-policies'
    When request requestPayload
    And method put
    Then status 404
    And karate.log('status : 404')
    And match response.errors[0].message == "http.request.not.found"
    And match response.errorCount == 1
    And karate.log('Test Completed !')


  #REV2-12860
  Scenario: PUT - Verify error for Auto Reject Duration Policy Configuration if there are invalid data in request body
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/hendrix/auto-reject-policy.json') 
    * eval requestPayload.distanceFromBaseGeoId = 1
    * eval requestPayload.geoId = "India"
    * eval requestPayload.futureDuration = 2
    * eval requestPayload.nextDayDuration = 3
    * eval requestPayload.sameDayDuration = 4
    * eval requestPayload.vendorIds = ["FC_101","FC_102"]
    * eval requestPayload.test = "test"
    When request requestPayload
    And method put
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message == "Invalid_Input_Data"
    And match response.errorCount == 1
    And karate.log('Test Completed !')

    