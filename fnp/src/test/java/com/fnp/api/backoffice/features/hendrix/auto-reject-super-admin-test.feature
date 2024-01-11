Feature: Auto Reject Duration Policy Configuration scenarios for Super Admin role


  Background: 
    Given url backOfficeAPIBaseUrl
    And header Accept = "application/json"
    And path '/hendrix/v1/auto-rejection-policies'
    * def loginResult = callonce read('classpath:com/fnp/api/utils/generate-token.feature') {userType:"superAdminQA"}
    * def authToken = loginResult.accessToken
    * header Authorization = authToken


  #REV2-12883
  Scenario: GET - Verify Super admin user can fetch Auto Reject Duration Policy Configuration for valid input
    Given param geoId = 'India'
    When method get
    Then status 200
    And karate.log('status : 200')
    And match response.geoId contains 'India'
    And karate.log('Test Completed !')


  #REV2-12884
  Scenario: GET - Verify Super admin user cannot fetch Auto Reject Duration Policy Configuration for invalid input
    Given param geoId = 'abc@123.'
    When method get
    Then status 400
    And karate.log('status : 400')
    And match response.errors[0].message == "Invalid characters found."
    And match response.errorCount == 1
    And karate.log('Test Completed !')


  #REV2-12885
  Scenario: GET - Verify Super admin user cannot fetch Auto Reject Duration Policy Configuration for blank input
    Given param geoId = ""
    When method get
    Then status 400
    And karate.log('status : 400')
    And match response.errors[0].message == "The Geography field is mandatory."
    And match response.errorCount == 1
    And karate.log('Test Completed !')


  #REV2-12886
  Scenario: GET - Verify Super admin get 404 error for Auto Reject Duration Policy Configuration invalid endpoint URL
    Given path '/hendrix/v1/rejection-policies'
    Given param geoId = 'India'
    When method get
    Then status 404
    And karate.log('status : 404')
    And match response.errors[0].message == "http.request.not.found"
    And match response.errorCount == 1
    And karate.log('Test Completed !')


  #REV2-12861
  Scenario: PUT - Verify Super admin can update Auto Reject Duration Policy Configuration with valid values
    
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/hendrix/auto-reject-policy.json') 
    * eval requestPayload.distanceFromBaseGeoId = 23
    * eval requestPayload.futureDuration = 64
    * eval requestPayload.geoId = "India"
    
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
    And match response.geoId == "India"
    And match response.futureDuration == 64
    And karate.log('Test Completed !')


  #REV2-12862
  Scenario: PUT - Verify Super admin can update Auto Reject Duration Policy Configuration with only mandatory fields
    
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

    * def authToken = loginResult.accessToken
    * header Authorization = authToken
    Given path '/hendrix/v1/auto-rejection-policies'
    And param geoId = 'India'
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
    And karate.log('Test Completed !')


  #REV2-12863
  Scenario: PUT - Verify Super admin cannot update Auto Reject Duration Policy Configuration with blank fields
  
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/hendrix/auto-reject-policy.json') 
    * eval requestPayload.distanceFromBaseGeoId = ' '
    * eval requestPayload.fromTime == " "  
    * eval requestPayload.futureDuration = ' '
    * eval requestPayload.geoId = " "
    * eval requestPayload.nextDayDuration = ' '
    * eval requestPayload.sameDayDuration = ' '
    * eval requestPayload.exceptionalFcs = [" "," "]
    * eval requestPayload.thruTime = " "
    * eval requestPayload.columnOption = " "
    
    * karate.log(requestPayload)
    When request requestPayload
    And method put
    Then status 400
    
    And match response.errors[*].message contains "The Future field is mandatory."
    And match response.errors[*].message contains "Invalid 'thruTime'! Valid format is 'HH:MM'."
    And match response.errors[*].message contains "Blank 'columnOption'! Possible values are either 'VENDOR_ID' or 'VENDOR_NAME'."
    And match response.errors[*].message contains "Invalid characters found in geoId."
    And match response.errors[*].message contains "The Same-Day field is mandatory."
    And match response.errors[*].message contains "The Distance field is mandatory."
    And match response.errors[*].message contains "The Geography field is mandatory."
    And match response.errors[*].message contains "The Next Day field is mandatory."  
    
    And match response.errorCount == 8
    And karate.log('Status : 400')

    * def authToken = loginResult.accessToken
    * header Authorization = authToken
    Given path '/hendrix/v1/auto-rejection-policies'
    And param geoId = 'India'
    When method get
    Then status 200
    And karate.log('Test Completed !')


  #REV2-12867
  Scenario: PUT - Verify Super admin cannot update Auto Reject Duration Policy Configuration with invalid sameDayDuration
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/hendrix/auto-reject-policy.json') 
    * eval requestPayload.distanceFromBaseGeoId = 1
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
    And match response.errors[0].message == "Invalid_Input_Data"  
    Then response.status == "sameDayDuration value should be between 0 to 12."  
    And match response.errorCount == 1
    And karate.log('Test Completed !')


  #REV2-12868
  Scenario: PUT - Verify Super admin cannot update Auto Reject Duration Policy Configuration with invalid nextDayDuration
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/hendrix/auto-reject-policy.json') 
    * eval requestPayload.distanceFromBaseGeoId = 1
    * eval requestPayload.geoId = "India"
    * eval requestPayload.futureDuration = 2
    * eval requestPayload.nextDayDuration = 25
    * eval requestPayload.sameDayDuration = 4
    * eval requestPayload.vendorIds = ["FC_101","FC_102"]
    * karate.log(requestPayload)
    When request requestPayload
    And method put
    Then status 400
    And karate.log('Status : 400')
    Then response.status == "nextDayDuration value should be between 0 to 24."    
    And match response.errorCount == 1
    And karate.log('Test Completed !')


  #REV2-12869
  Scenario: PUT - Verify Super admin cannot update Auto Reject Duration Policy Configuration with invalid futureDuration
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/hendrix/auto-reject-policy.json') 
    * eval requestPayload.distanceFromBaseGeoId = 1
    * eval requestPayload.geoId = "India"
    * eval requestPayload.futureDuration = 0
    * eval requestPayload.nextDayDuration = 3
    * eval requestPayload.sameDayDuration = 4
    * eval requestPayload.vendorIds = ["FC_101","FC_102"]
    * karate.log(requestPayload)
    When request requestPayload
    And method put
    Then status 400
    And karate.log('Status : 400')
    Then response.status ==  "futureDuration value should be above 0."
    And match response.errorCount == 1
    And karate.log('Test Completed !')

    