Feature: Manual alloc preference GET by quotas date ranges with super admin user role

  Background: 
    Given url backOfficeAPIBaseUrl
    And header Accept = 'application/json'
    And path '/hendrix/v1/manual-allocation-preferences'
    * def loginResult = callonce read('classpath:com/fnp/api/utils/generate-token.feature') {userType:'superAdminQA'}
    * def authToken = loginResult.accessToken
    * header Authorization = authToken
    
     #REV2-30778
  
  Scenario: GET - Verify super admin user can fetch records of manual allocation preference config get quotas-date-ranges api with valid values
  
   Given path '/quotas-date-ranges'
    And param baseGeoId = '411006'
    And param configName = 'party'
    And param fromDate = '10-11-2021'
    And param page = ''
    And param pgId = '1'
    And param size = ''
    And param thruDate = '11-11-2021'
    And param vendorType = 'CR'
    When method get
    Then status 200
    And karate.log('Status : 200')
    And karate.log('Test Completed !')
    
    #REV2-30793
  
  Scenario: GET - Verify  super admin user can fetch records of manual allocation preference config get quotas-date-ranges api with optional field values only
   
    Given path '/quotas-date-ranges'
    And param baseGeoId = ''
    And param configName = ''
    And param fromDate = ''
    And param page = '1'
    And param pgId = ''
    And param size = '10'
    And param thruDate = ''
    And param vendorType = ''
    When method get
    Then status 400
    And karate.log('Status : 400')
    And karate.log('Test Completed !')
    
     #REV2-30792
  
  Scenario: GET - Verify super admin user can fetch records of manual allocation preference config get quotas-date-ranges api with no data with created values
  
    Given path '/quotas-date-ranges'
    And param baseGeoId = '411007'
    And param configName = 'asdff'
    And param fromDate = '10-11-2021'
    And param page = ''
    And param pgId = '1'
    And param size = ''
    And param thruDate = '11-11-2021'
    And param vendorType = 'FC'
    When method get
    Then status 200
    And karate.log('Status : 200')
    And karate.log('Test Completed !')
    
    #REV2-30791
  
  Scenario: GET - Verify super admin user can fetch records of manual allocation preference config get quotas-date-ranges api with mandatory values
  
    Given path '/quotas-date-ranges'
    And param baseGeoId = '411006'
    And param configName = 'party'
    And param fromDate = '10-11-2021'
    And param page = ''
    And param pgId = '1'
    And param size = ''
    And param thruDate = '11-11-2021'
    And param vendorType = 'CR'
    When method get
    Then status 200
    And karate.log('Status : 200')
    And karate.log('Test Completed !')
    
     #REV2-30789
  
  Scenario: GET - Verify  super admin user can fetch records of manual allocation preference config get quotas-date-ranges api with missing value in optional field 
   
    Given path '/quotas-date-ranges'
    And param baseGeoId = '411006'
    And param configName = 'party'
    And param fromDate = '10-11-2021'
    And param page = ''
    And param pgId = '1'
    And param size = '10'
    And param thruDate = '11-11-2021'
    And param vendorType = 'CR'
    When method get
    Then status 200
    And karate.log('Status : 200')
    And karate.log('Test Completed !')
    
     #REV2-30787
  
  Scenario: GET - Verify  super admin user can fetch records of manual allocation preference config get quotas-date-ranges api with invalid URL 
   
    Given path '/quotas-date-rangesss'
    And param baseGeoId = '411006'
    And param configName = 'party'
    And param fromDate = '10-11-2021'
    And param page = ''
    And param pgId = '1'
    And param size = '10'
    And param thruDate = '11-11-2021'
    And param vendorType = 'CR'
    When method get
    Then status 404
    And karate.log('Status : 404')
    And match response.errors[0].message contains "http.request.not.found"
    And karate.log('Test Completed !')
    
     #REV2-30784
  
  Scenario: GET - Verify super admin user can fetch records of manual allocation pref config get-quotas-date-ranges api with invalid auth code
  
    * eval loginResult.accessToken = "UYGJEFGESJFHBDRHGVRDJ"
    * def saveToken = 'Bearer' + " " + loginResult.accessToken
    * header Authorization = saveToken
    Given path '/quotas-date-ranges'
    And param baseGeoId = '411006'
    And param configName = 'party'
    And param fromDate = '10-11-2021'
    And param page = ''
    And param pgId = '1'
    And param size = '10'
    And param thruDate = '11-11-2021'
    And param vendorType = 'CR'
    When method get
    Then status 401
    And karate.log('Response Errors are :', response.errors)
    And match response.errors[0].message == 'Token Invalid! Authentication Required'
    And karate.log('Status : 401')
    And karate.log('Test Completed !')
    
     #REV2-30783
  
  Scenario: GET - Verify super admin user cannot fetch records of manual alloc pref config get-quotas-date-ranges API with unsupported method
  
    Given request ''
    And param baseGeoId = '411006'
    And param configName = 'party'
    And param fromDate = '10-11-2021'
    And param page = ''
    And param pgId = '1'
    And param size = '10'
    And param thruDate = '11-11-2021'
    And param vendorType = 'CR'
    When method post
    Then status 405
    And karate.log('Status : 405')
    And match response.errors[0].message contains "METHOD_NOT_ALLOWED"
    And karate.log('Test Completed !')
    
    
    #REV2-30782
  
  Scenario: GET - Verify super admin user can fetch records of manual allocation preference config get quotas-date-ranges api with missing value in mandatory field 
   
    Given path '/quotas-date-ranges'
    And param baseGeoId = ''
    And param configName = 'party'
    And param fromDate = '10-11-2021'
    And param page = ''
    And param pgId = '1'
    And param size = '10'
    And param thruDate = ' '
    And param vendorType = ' '
    When method get
    Then status 400
    And karate.log('Status : 400')
    And karate.log('Test Completed !')
    
    #REV2-30781
  
  Scenario: GET - Verify  super admin user can fetch records of manual allocation preference config get quotas-date-ranges api with valid/invalid/blank values 
   
    Given path '/quotas-date-ranges'
    And param baseGeoId = 'ASw@@@'
    And param configName = ' '
    And param fromDate = '10-11-2021'
    And param page = ''
    And param pgId = '1'
    And param size = '10'
    And param thruDate = '11-11-2021'
    And param vendorType = ' '
    When method get
    Then status 400
    And karate.log('Status : 400')
    And karate.log('Test Completed !')
    
    #REV2-30780
  
  Scenario: GET - Verify  super admin user can fetch records of manual allocation preference config get quotas-date-ranges api with blank values
   
    Given path '/quotas-date-ranges'
    And param baseGeoId = ' '
    And param configName = ' '
    And param fromDate = ' '
    And param page = ''
    And param pgId = ' '
    And param size = ' '
    And param thruDate = ' '
    And param vendorType = ' '
    When method get
    Then status 400
    And karate.log('Status : 400')
    And karate.log('Test Completed !')
    
     #REV2-30779
  
  Scenario: GET - Verify  super admin user can fetch records of manual allocation preference config get quotas-date-ranges api with invalid values
   
    Given path '/quotas-date-ranges'
    And param baseGeoId = ' !@#'
    And param configName = 'as!## '
    And param fromDate = ' fghhds234567'
    And param page = '-122'
    And param pgId = ' dd'
    And param size = ' ss'
    And param thruDate = ' a1222'
    And param vendorType = ' ssd'
    When method get
    Then status 400
    And karate.log('Status : 400')
    And karate.log('Test Completed !')
    
    
   
    
