Feature: Vendor allocation preferences date range test Api for allocation executive

  Background: 
    Given url backOfficeAPIBaseUrl
    And path '/hendrix/v1/new-vendor-allocation-preferences'
    * header Accept = 'application/json'
    
    * def loginResult = callonce read('classpath:com/fnp/api/utils/generate-token.feature') {userType:"allocExc"}
    * def token = loginResult.accessToken
    * header Authorization = token


  #REV2-20781
  Scenario: GET - Verify alloc executive fetch New-Vendor-Allocation-Preference Quota Configuration by Date-Range with valid value
  
    Given path '/vendor-allocation-by-date-range'
    And param deliveryMode = 'cr'
    And param fcId = 'FC_114'
		And param fromDate = '11-01-2022'
    And param geoGroupId = 'Kolkata'
    And param geoId = 'India'
    And param operator = 'EQUAL_TO'  
    And param page = 0
    And param size = 10
    And param thruDate = '14-11-2022'
    When method get
    Then status 200
    And karate.log('Status : 200')
    And karate.log('Response is:', response)
    And assert response.total >= 1
    And karate.log('Test Completed !')


  #Need to discuss with Hendrix team
  #REV2-20782
  Scenario: GET - Verify alloc exec can not fetch New-Vendor-Allocation-Preference Quota Configuration by Date-Range with
   All Invalid values

    Given path '/vendor-allocation-by-date-range'
    And param deliveryMode = 'test'
    And param fcId = 'abc'
    And param fieldName = 'baseGoId'
		And param fieldValues = 'pqr'
		And param fromDate = 'ab'
    And param geoGroupId = 'ab123'
    And param geoId = 'Test'
    And param page = 0
    And param size = 5
    And param operator = 'EQUAL_T' 
    And param thruDate = 'abc'
    When method get     
    Then status 400
    And karate.log('Status : 400')
    And karate.log('Response is:', response)
    And match response.errors[*].message contains 'Request Parameter Values are not as Expected fromDate'   
    And karate.log('Test Completed !')


  #REV2-20783
  Scenario: GET - Verify alloc exec cna not fetch New-Vendor-Allocation-Preference Quota Configuration by Date-Range with Combination of blank and Valid values (for mandatory fields)
 
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


  #REV2-20784
  Scenario: GET - Verify alloc exec fetch can not New-Vendor-Allocation-Preference Quota Configuration by Date-Range with blank values
 
    Given path '/vendor-allocation-by-date-range'
    And param deliveryMode = ' '
    And param fcId = ' '
     And param fieldName = ''
		And param fieldValues = ''
    And param fromDate = ' '
    And param geoGroupId = ' '
    And param geoId = ' '
    And param operator = ''
    And param thruDate = ' '    
    When method get   
    Then status 400
    And karate.log('Status : 400')
    And karate.log('Response is:', response)
    And assert response.errorCount >= 1
    And karate.log('Test Completed !')


  #REV2-20785
  Scenario: GET - Verify alloc exec can not fetch New-Vendor-Allocation-Preference Quota Configuration by Date-Range with Invalid URL
   
    Given path '/vendor-allocation-by-date-range/s'
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


  #REV2-20786
  Scenario: GET - Verify alloc exec can not fetch New-Vendor-Allocation-Preference Quota Configuration by Date-Range with Invalid authorization
   
    * def invalidAuthToken = "eyJraWQiOiJmbnAyIiwiYWxnIjoiUlMyNTYifQ"
    * header Authorization = invalidAuthToken
    
    Given path '/vendor-allocation-by-date-range'
    And param deliveryMode = 'hd'
    And param fieldName = 'baseGeoId'
		And param fieldValues = '411001'
    And param fcId = 'FC_114'
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
    And karate.log('Test Completed !')


  #REV2-24794
  Scenario: GET - Verify alloc exec fetch New-Vendor-Allocation-Preference Quota Configuration by Date-Range with FC Id
   
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
    Then status 200
    And karate.log('Status : 200')
    And karate.log('Response is:', response)
    And assert response.total >= 1
    And karate.log('Test Completed !')


  #REV2-17919
  Scenario: GET - Verify Allocation Executive user can fetch New Vendor Allocation Preference Quota Configuration by Vendor Id with valid values
  
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


  #REV2-17922
  Scenario: GET - Verify Allocation Executive user cannot fetch New Vendor Allocation Preference Quota Configuration by Vendor Id with blank values
  
    * def id = ''
    Given path '/date-ranges/vendor-id/' + id
    When method get
    Then status 404
    And karate.log('status : 404')
    And match response.errors[0].message == "http.request.not.found"
    And match response.errorCount == 1
    And karate.log('Test Completed !')


  #REV2-17925
  Scenario: GET - Verify 401 error for invalid authorization token for New Vendor Allocation Preference Quota Configuration by Vendor Id
  
    * def invalidAuthToken = "eyJraWQiOiJmbnAyiYWxnIjoiUlMyNTYifQAbcW"
    * header Authorization = invalidAuthToken
    * def id = 'FC_101'
    Given path '/date-ranges/vendor-id/' + id
    When method get
    Then status 401
    And karate.log('Status : 401')
    And match response.errors[0].message == "Token Invalid! Authentication Required"
    And match response.errorCount == 1
    And karate.log('Test Completed !')


  #REV2-17926
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

	
  #REV2-17928
  Scenario: GET - Verify Allocation Executive user can fetch New Vendor Allocation Preference Quota Configuration by Vendor Id even if missing any value in optional field
  
		* def id = 'FC_101'
    Given path '/date-ranges/vendor-id/' + id
    And param size = 2
    When method get
    Then status 200
    And karate.log('status : 200')
    And match each response.data[*].vendorId contains "FC_101"
    And match response.currentPage == 0
    And karate.log('Test Completed !')
    
    