Feature: Vendor allocation preferences date range test Api for super admin

  Background: 
    Given url backOfficeAPIBaseUrl
    And path '/hendrix/v1/new-vendor-allocation-preferences'
    * header Accept = 'application/json'
    * def loginResult = callonce read('classpath:com/fnp/api/utils/generate-token.feature') {userType:"superAdminQA"}
    * def token = loginResult.accessToken
    * header Authorization = token


  #REV2-24793
  Scenario: GET - Verify super admin fetch New-Vendor-Allocation-Preference Quota Configuration by Date-Range with FC Id
    
    Given path '/vendor-allocation-by-date-range'
    And param deliveryMode = 'hd'
    And param fcId = 'FC_101'
    And param fieldName = 'baseGeoId'
		And param fieldValues = '411001'
    And param fromDate = '11-01-2022'
    And param geoGroupId = 'Kolkata'
    And param operator = 'EQUAL_TO'
    And param geoId = 'India'
    And param page = 0
    And param size = 10
    And param thruDate = '14-11-2022'
    When method get
    Then status 200
    And karate.log('Status : 200')
    And karate.log('Response is:', response)
    And assert response.total >= 1
    And karate.log('Test Completed !')


  #REV2-20764
  Scenario: GET - Verify super admin fetch New-Vendor-Allocation-Preference Quota Configuration by Date-Range with All valid values
    
    Given path '/vendor-allocation-by-date-range'
    And param deliveryMode = 'cr'
    And param fcId = 'FC_102'
    And param fieldName = 'baseGeoId'
		And param fieldValues = '411001'
    And param fromDate = '11-01-2022'
    And param geoGroupId = 'Delhi'
    And param operator = 'EQUAL_TO'
    And param geoId = 'India'
    And param page = 0
    And param size = 5
    And param thruDate = '14-11-2022'
    When method get
    Then status 200
    And karate.log('Status : 200')
    And karate.log('Response is:', response)
    And assert response.total >= 1
    And karate.log('Test Completed !')

 
  #REV2-20765
  Scenario: GET - Verify super admin fetch New-Vendor-Allocation-Preference Quota Configuration by Date-Range with All Invalid values
    
    Given path '/vendor-allocation-by-date-range'
    And param deliveryMode = 'test'
    And param fcId = 'FC_101'
    And param fieldName = 'baseGeoId'
		And param fieldValues = '411001'
    And param fromDate = '11-01-2022'
    And param geoGroupId = 'patna'
    And param operator = 'EQUAL_TO'
    And param geoId = 'Test'
    And param page = 0
    And param size = 5
    And param thruDate = '14-11-2022'
    When method get
    Then status 200
    And karate.log('Status : 200')
    And karate.log('Response is:', response)
    And assert response.total >= 1
    And karate.log('Test Completed !')
    
    
  #REV2-20766
  Scenario: Verify Method: GET request for New-Vendor-Allocation-Preference Quota Configuration by Date-Range 
  with Super Admin access - Combination of invalid and valid values  
    Given path '/vendor-allocation-by-date-range'
    And param deliveryMode = 'test'
    And param fcId = 'abc'
    And param fieldName = 'baseGeoId'
		And param fieldValues = '411001'
    And param fromDate = '11-01-2022'
    And param geoGroupId = '123'
    And param operator = 'EQUAL_TO'
    And param geoId = 'pqr'
    And param page = 0
    And param size = 5
    And param thruDate = '14-11-202'
    When method get
    Then status 400
    And karate.log('Status : 400')
    And karate.log('Response is:', response)
    And karate.log('Test Completed !')

 
  #REV2-20767
  Scenario: GET - Verify super admin fetch can not New-Vendor-Allocation-Preference Quota Configuration by Date-Range with blank values
    
    Given path '/vendor-allocation-by-date-range'
    And param deliveryMode = ' '
    And param fcId = ' '
    And param fieldName = ' '
		And param fieldValues = ' '
    And param fromDate = ' '
    And param geoGroupId = ' '
    And param operator = ' '
    And param geoId = ' '
    And param thruDate = ' '
    When method get
    Then status 400
    And karate.log('Status : 400')
    And karate.log('Response is:', response)
    And assert response.errorCount >= 1
    And karate.log('Test Completed !')


  #REV2-20768
  Scenario: GET - Verify super admin cna not fetch New-Vendor-Allocation-Preference Quota Configuration by Date-Range with Combination of blank and Valid values (for mandatory fields)
    
    Given path '/vendor-allocation-by-date-range'
    And param deliveryMode = ' '
    And param fcId = ' '
    And param fieldName = 'baseGeoId'
		And param fieldValues = '411001'
    And param fromDate = ' '
    And param geoGroupId = 'patna'
    And param geoId = 'India'
    And param operator = 'EQUAL_TO'
    And param page = 0
    And param size = 5
    And param thruDate = ' '
    When method get
    Then status 400
    And karate.log('Status : 400')
    And karate.log('Response is:', response)
    And assert response.errorCount >= 1
    And karate.log('Test Completed !')


  #REV2-20769
  Scenario: GET - Verify super admin can not fetch New-Vendor-Allocation-Preference Quota Configuration by Date-Range with Invalid authorization
    
    * def invalidAuthToken = "eyJraWQiOiJmbnAyIiwiYWxnIjoiUlMyNTYifQ"
    * header Authorization = invalidAuthToken
    
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
    Then status 401
    And karate.log('Status : 401')
    And karate.log('Response is:', response)
    And match response.errors[0].message == 'Token Invalid! Authentication Required'
    And karate.log('Test Completed !')


  #REV2-20770
  Scenario: GET - Verify 404 error for New-Vendor-Allocation-Preference Quota Configuration by Date-Range
    
    Given path '/vendor-allocation-by-date-ranges'
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
    Then status 404
    And karate.log('Status : 404')
    And karate.log('Response is:', response)
    And match response.errors[0].message == 'http.request.not.found'
    And karate.log('Test Completed !')


  #REV2-20772
  Scenario: GET - Verify super admin can not fetch New-Vendor-Allocation-Preference Quota Configuration by Date-Range with Invalid URL
    
    Given path '/vendor-allocation-by-date-ranges'
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
    Then status 404
    And karate.log('Status : 404')
    And karate.log('Response is:', response)
    And match response.errors[0].message == 'http.request.not.found'
    And karate.log('Test Completed !')


  #REV2-20774
  Scenario: HEAD - Verify Unsupported Methods for endpoints.
    
    Given path '/vendor-allocation-by-date-ranges'
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
    When method HEAD
    Then status 404
    And karate.log('Status : 404')
    And karate.log('Test Completed !')


  #REV2-20775
  Scenario: GET - Verify super admin can not fetch New-Vendor-Allocation-Preference Quota Configuration by Date-Range with Missing any value in Mandatory fields
    
    Given path '/vendor-allocation-by-date-range'
    And param deliveryMode = ''
    And param fcId = 'FC_114'
    And param fieldName = 'baseGeoId'
		And param fieldValues = '411001'
    And param fromDate = ' '
    And param geoGroupId = 'Kolkata'
    And param geoId = 'India'
    And param operator = 'EQUAL_TO'
    And param page = 0
    And param size = 10
    And param thruDate = '14-11-2022'
    When method get
    Then status 400
    And karate.log('Status : 400')
    And karate.log('Response is:', response)
    And match response.errors[*].message contains 'The Delivery mode field is mandatory.'
    And match response.errors[*].message contains 'The From Date field is mandatory.'
    And karate.log('Test Completed !')


  #REV2-20776
  Scenario: GET - Verify super admin fetch New-Vendor-Allocation-Preference Quota Configuration by Date-Range for Missing any value in Optional fields
    
     Given path '/vendor-allocation-by-date-range'
    And param deliveryMode = 'hd'
    And param fcId = 'FC_114'
    And param fieldName = 'baseGeoId'
		And param fieldValues = ''
    And param fromDate = '11-01-2022'
    And param geoGroupId = 'Kolkata'
    And param operator = 'EQUAL_TO'
    And param geoId = 'India'
    And param page = ''
    And param size = ''
    And param thruDate = '14-11-2022'
    When method get
    Then status 200
    And karate.log('Status : 200')
    And karate.log('Response is:', response)
    And assert response.total >= 1
    And karate.log('Test Completed !')


  #REV2-20777
  Scenario: GET - Verify super admin can not fetch New-Vendor-Allocation-Preference Quota Configuration by Date-Range for Missing Optional Parameters
    
    Given path '/vendor-allocation-by-date-range'
    And param deliveryMode = 'hd'
    And param fcId = 'FC_114'
    And param fromDate = '11-01-2022'
    And param geoGroupId = 'Kolkata'
    And param geoId = 'India'
    And param thruDate = '14-11-2022'
    When method get
    Then status 200
    And karate.log('Status : 200')
    And karate.log('Response is:', response)
    And assert response.total >= 1
    And karate.log('Test Completed !')


  #REV2-20778
  Scenario: GET - Verify super admin can not fetch New-Vendor-Allocation-Preference Quota Configuration by Date-Range with Missing Mandatory Parameters
    
    Given path '/vendor-allocation-by-date-range'
    And param deliveryMode = ''
    And param fcId = 'FC_114'
    And param fieldName = 'baseGeoId'
		And param fieldValues = '411001'
    And param fromDate = ' '
    And param geoGroupId = 'Kolkata'
    And param geoId = 'India'
    And param operator = 'EQUAL_TO'
    And param page = 0
    And param size = 10
    And param thruDate = '14-11-2022'
    When method get
    Then status 400
    And karate.log('Status : 400')
    And karate.log('Response is:', response)
    And match response.errors[*].message contains 'The Delivery mode field is mandatory.'
    And match response.errors[*].message contains 'The From Date field is mandatory.'
    And assert response.errorCount >= 1
    And karate.log('Test Completed !')


  #REV2-20779
  Scenario: GET - Verify super admin can not fetch New-Vendor-Allocation-Preference Quota Configuration by Date-Range with only spaces in the parameter
    
    Given path '/vendor-allocation-by-date-range'
    And param deliveryMode = ' hd '
    And param fcId = ' FC_114 '
    And param fieldName = ' baseGeoId'
		And param fieldValues = ' 411001'
    And param geoGroupId = ' Kolkata '
    And param geoId = ' India '
    And param operator = 'EQUAL_TO'
    And param fromDate = ' 11-01-2022'
    And param page = 0
    And param size = 10
    And param thruDate = ' 14-11-2022'
    When method get
    Then status 400
    And karate.log('Status : 400')
    And karate.log('Response is:', response)
    And assert response.errorCount >= 1
    And karate.log('Test Completed !')


  #REV2-17901
  Scenario: GET - Verify Super admin user can fetch New Vendor Allocation Preference Quota Configuration by Vendor Id with valid values
  
    * def id = 'FC_101'
    Given path '/date-ranges/vendor-id/' + id
    And param page = 0
    And param size = 10
    When method get
    Then status 200
    And karate.log('status : 200')
    And match each response.data[*].vendorId contains "FC_101"
    And match response.currentPage == 0
    And karate.log('Test Completed !')


  #REV2-17905
  Scenario: GET - Verify Super admin user cannot fetch New Vendor Allocation Preference Quota Configuration by Vendor Id with blank values
  
		* def id = ''
    Given path '/date-ranges/vendor-id/' + id
    When method get
    Then status 404
    And karate.log('status : 404')
    And match response.errors[0].message == "http.request.not.found"
    And match response.errorCount == 1
    And karate.log('Test Completed !')


  #REV2-17908
  Scenario: GET - Verify Super admin user cannot fetch New Vendor Allocation Preference Quota Configuration by Vendor Id if missing mandatory fields
  
    Given path '/date-ranges/vendor-id/'
    When method get
    Then status 404
    And karate.log('status : 404')
    And match response.errors[0].message == "http.request.not.found"
    And match response.errorCount == 1
    And karate.log('Test Completed !')


  #REV2-17909
  Scenario: GET - Verify 405 error for unsupported method for New Vendor Allocation Preference Quota Configuration by Vendor Id
  
		* def requestPayload = read('classpath:com/fnp/api/backoffice/data/new-vendor-alloc-preference.json')
    * eval requestPayload.vendorId = "FC_102"
    * karate.log(requestPayload)
    Given path '/date-ranges/vendor-id/:id'
    When request requestPayload
    And method patch
    Then status 405
    And karate.log('status : 405')
    And match response.errors[0].message == "METHOD_NOT_ALLOWED"
    And match response.errorCount == 1
    And karate.log('Test Completed !')


  #REV2-17910
  Scenario: GET - Verify 401 error for invalid authorization token for New Vendor Allocation Preference Quota Configuration by Vendor Id
  
    * def invalidAuthToken = "eyJraWQiOiJmbnAyIiwiYWxnIjoiUlMyNTYifQ"
    * header Authorization = invalidAuthToken
    * def id = 'FC_101'
    Given path '/date-ranges/vendor-id/' + id
    When method get
    Then status 401
    And karate.log('Status : 401')
    And match response.errors[0].message == "Token Invalid! Authentication Required"
    And match response.errorCount == 1
    And karate.log('Test Completed !')


  #REV2-17911
  Scenario: GET - Verify 401 error for missing authorization token for New Vendor Allocation Preference Quota Configuration by Vendor Id
  
    * def invalidAuthToken = ""
    * header Authorization = invalidAuthToken
    * def id = 'FC_101'
    Given path '/date-ranges/vendor-id/' + id
    When method get
    Then status 401
    And karate.log('Status : 401')
    And match response.errors[0].message contains "Authentication Required"
    And match response.errorCount == 1
    And karate.log('Test Completed !')

	
  #REV2-17913
  Scenario: GET - Verify 404 error for New Vendor Allocation Preference Quota Configuration by Vendor Id invalid endpoint URL
  
    * def id = 'FC_101'
    Given path '/date-ranges/endor-id/' + id
    When method get
    Then status 404
    And karate.log('status : 404')
    And match response.errors[0].message == "http.request.not.found"
    And match response.errorCount == 1
    And karate.log('Test Completed !')

	
  #REV2-17918
  Scenario: GET - Verify Super admin user can fetch New Vendor Allocation Preference Quota Configuration by Vendor Id even if missing any value in optional field
  
    * def id = 'FC_101'
    Given path '/date-ranges/vendor-id/' + id
    Given param size = 2
    When method get
    Then status 200
    And karate.log('status : 200')
    And match each response.data[*].vendorId contains "FC_101"
    And match response.currentPage == 0
    And karate.log('Test Completed !')
    
    