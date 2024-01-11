Feature: New Vendor Allocation Preference by Calendar view test Api for super admin

  Background: 
    Given url backOfficeAPIBaseUrl
    And path '/hendrix/v1/new-vendor-allocation-preferences'
    * header Accept = 'application/json'
    * def loginResult = callonce read('classpath:com/fnp/api/utils/generate-token.feature') {userType:"superAdminQA"}
    * def token = loginResult.accessToken
    * header Authorization = token


  #REV2-20207/REV2-31415/REV2-31402
  Scenario: GET - Verify super admin can fetch New Vendor Allocation Preference by Calendar View with valid ids

    Given path '/calendar-view'  
    And param baseGeoId = '411001'
    And param deliveryMode = 'hd'
    And param fieldName = 'vendorId'
    And param fieldValues = 'FC_101'
    And param fromDate = '20-09-2021'
    And param geoGroupId = 'pune'
    And param geoId = 'india'
    And param operator = 'NOT_EQUAL_TO'
    And param page = 0
    And param size = 10
    And param pgId = '5'
    And param thruDate = '22-11-2021'
    
    When method get
    Then status 200
    And karate.log('Status : 200')
    And karate.log('Response is:', response)
    And assert response.total >= 1
    And karate.log('Test Completed !')

 
  #REV2-20208
  Scenario: GET - Verify super admin can not fetch New Vendor Allocation Preference by Calendar View with Invalid ids	

    Given path '/calendar-view'  
   	And param baseGeoId = '411001'
    And param deliveryMode = 'hd'
    And param fieldName = 'vendorId'
    And param fieldValues = 'FC_111'
    And param fieldValues = 'FC_103'
    And param fromDate = '20-09-2021'
    And param geoGroupId = 'pune'
    And param geoId = 'india'
    And param operator = 'EQUAL_TO'
    And param page = 0
    And param size = 10
    And param pgId = '7'
    And param thruDate = '22-11-2021'

    When method get
    Then status 400
    And karate.log('Status : 400')
    And karate.log('Response is:', response)
    And match response.errors[*].message contains "Requested pgId doesn't exist -> 7"
    And karate.log('Test Completed !')
    
    
  #REV2-20209
  Scenario: GET - Verify super admin can not fetch New Vendor Allocation Preference by Calendar View with space in the parameters	
 
		Given path '/calendar-view' 
    And param baseGeoId = ' 411001 '
    And param deliveryMode = ' hd  '
    And param fieldName = 'vendorId '
    And param fieldValues = ' FC_111 '
    And param fieldValues = ' FC_103 '
    And param fromDate = ' 20-09-2021 '
    And param geoGroupId = ' pune '
    And param geoId = ' india '
    And param operator = ' EQUAL_TO '
    And param page = 0
    And param size = 10
    And param pgId = ' 5 '
    And param thruDate = ' 22-11-2021 '

    When method get
    Then status 400
    And karate.log('Status : 400')
    And karate.log('Response is:', response)
    And match response.errors[*].message contains "Request Parameter Values are not as Expected fromDate"
    And karate.log('Test Completed !')

   
  #REV2-20210/REV2-31406
  Scenario: GET - Verify super admin can not fetch New Vendor Allocation Preference by Calendar View with blank Ids

    Given path '/calendar-view'  
    And param baseGeoId = ''
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
    And param pgId = ''
    And param thruDate = '22-12-2021'

    When method get
    Then status 400
    And karate.log('Status : 400')
    And karate.log('Response is:', response)
    And match response.errors[*].message contains "The Product Group field is mandatory."
    And match response.errors[*].message contains "baseGeoId must not be blank"
    And karate.log('Test Completed !')
    
     
  #REV2-20213/REV2-31407
  Scenario: GET - Verify super admin can not fetch New Vendor Allocation Preference by Calendar View with missing any mandatory fields

    Given path '/calendar-view'  
    And param baseGeoId = '411001'
    And param fieldName = 'vendorId'
    And param fieldValues = 'FC_111'
    And param fieldValues = 'FC_103'
    And param fromDate = '20-12-2021'
    And param geoGroupId = 'pune'
    And param geoId = 'india'
    And param operator = 'DOES_NOT_CONTAIN'
    And param page = '0'
    And param size = '10'
    And param pgId = '5'
    And param thruDate = '22-12-2021'

    When method get
    Then status 400
    And karate.log('Status : 400')
    And karate.log('Response is:', response)
    And match response.errors[*].message contains "The Delivery mode field is mandatory."
    And match response.errors[*].errorCode contains "BAD_REQUEST"
    And match response.errors[*].field contains "getCalendarView.deliveryMode"
    And karate.log('Test Completed !')
    

  #REV2-20214/REV2-31408
  Scenario: DELETE - Verify super admin can not fetch New Vendor Allocation Preference by Calendar View with Unsupported methods

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
    
    When method delete
    Then status 405
    And karate.log('Status : 405')
    And karate.log('Response is:', response)
    And match response.errors[*].message contains "METHOD_NOT_ALLOWED"
    And karate.log('Test Completed !')
    
  
  #REV2-20215/REV2-31409
  Scenario: GET - Verify super admin can not fetch New Vendor Allocation Preference by Calendar View with Invalid authorization
  
    * def invalidAuthToken = "eyJraWQiOiJmbnAyIiwiYWxnIjoiUlMyNTYifQ"
    * header Authorization = invalidAuthToken

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
    Then status 401
    And karate.log('Status : 401')
    And karate.log('Response is:', response)
    And match response.errors[*].message contains "Token Invalid! Authentication Required"
    And karate.log('Test Completed !')
    
    
  #REV2-20216/REV2-31410
  Scenario: GET - Verify super admin can not fetch New Vendor Allocation Preference by Calendar View with blank authorization
  
    * def invalidAuthToken = " "
    * header Authorization = invalidAuthToken
 
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
    Then status 401
    And karate.log('Status : 401')
    And karate.log('Response is:', response)
    And match response.errors[*].message contains "Token Invalid! Authentication Required"
    And karate.log('Test Completed !')
    
   	
  #REV2-20218/REV2-31412
  Scenario: GET - Verify super admin can not fetch New Vendor Allocation Preference by Calendar View with Invalid URL

    Given path '/alendar'    
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
    Then status 404
    And karate.log('Status : 404')
    And karate.log('Response is:', response)
    And match response.errors[*].message contains "http.request.not.found"
    And karate.log('Test Completed !')  
    

  #REV2-20223/REV2-31413/REV2-31403
  Scenario: GET - Verify super admin can not fetch New Vendor Allocation Preference by Calendar View with invalid dates

    Given path '/calendar-view'    
   	And param baseGeoId = '411001'
    And param deliveryMode = 'hd'
    And param fieldName = 'vendorId'
    And param fieldValues = 'FC_111'
    And param fieldValues = 'FC_103'
    And param fromDate = '20-12-2026'
    And param geoGroupId = 'pune'
    And param geoId = 'india'
    And param operator = 'EQUAL_TO'
    And param page = '0'
    And param size = '10'
    And param pgId = '5'
    And param thruDate = '22-13-9021'

    When method get
    Then status 400
    And karate.log('Status : 400')
    And karate.log('Response is:', response)
    And match response.errors[*].message contains "Request Parameter Values are not as Expected thruDate"
    
    #Verifying if fromDate is greater than thruDate
    
    * header Authorization = token
    Given path '/hendrix/v1/new-vendor-allocation-preferences/calendar-view'
  	And param baseGeoId = '411001'
    And param deliveryMode = 'hd'
    And param fieldName = 'vendorId'
    And param fieldValues = 'FC_111'
    And param fieldValues = 'FC_103'
    And param fromDate = '20-12-2026'
    And param geoGroupId = 'pune'
    And param geoId = 'india'
    And param operator = 'EQUAL_TO'
    And param page = '0'
    And param size = '10'
    And param pgId = '5'
    And param thruDate = '22-12-2021'

    When method get
    Then status 400
    And karate.log('Status : 400')
    And karate.log('Response is:', response)
    And match response.errors[*].errorCode contains "Invalid request parameter(s)."
    And match response.errors[*].message contains "2021-12-23 < 2026-12-20"
    And karate.log('Test Completed !')
    
	
	#REV2-31418
	Scenario: GET - Verify super admin can Search New Vendor Allocation Preference by Calendar View with invalid values for fieldName/values
  
		Given path '/calendar-view'  
   	And param baseGeoId = '411001'
    And param deliveryMode = 'hd'
    And param fieldName = 'vendorABCId'
    And param fieldValues = 'FC_AB111'
    And param fromDate = '20-09-2021'
    And param geoGroupId = 'pune'
    And param geoId = 'india'
    And param operator = 'EQUAL_TO'
    And param page = 0
    And param size = 2
    And param pgId = '5'
    And param thruDate = '22-11-2021'

    When method get
    Then status 200
    And karate.log('Status : 200')
    And karate.log('Response is:', response)
    And assert response.total == 0
    And karate.log('Test Completed !')
    
   	
	#REV2-31417
	Scenario: GET - Verify super admin can Search New Vendor Allocation Preference by Calendar View with all valid values and operator is DOES_NOT_CONTAIN
	
		Given path '/calendar-view'  
   	And param baseGeoId = '411001'
    And param deliveryMode = 'hd'
    And param fieldName = 'vendorId'
    And param fieldValues = 'FC_111'
    And param fieldValues = 'FC_103'
    And param fromDate = '20-09-2021'
    And param geoGroupId = 'pune'
    And param geoId = 'india'
    And param operator = 'DOES_NOT_CONTAIN'
    And param page = 0
    And param size = 2
    And param pgId = '5'
    And param thruDate = '22-11-2021'

    When method get
    Then status 200
    And karate.log('Status : 200')
    And karate.log('Response is:', response)
    And assert response.total >= 1
    And karate.log('Test Completed !')
    
    
	#REV2-31416
	Scenario: GET - Verify super admin can Search New Vendor Allocation Preference by Calendar View with all valid values and operator is CONTAINS
    
		Given path '/calendar-view'  
   	And param baseGeoId = '411001'
    And param deliveryMode = 'hd'
    And param fieldName = 'vendorName'
    And param fieldValues = 'FC_Name103'
    And param fromDate = '20-09-2021'
    And param geoGroupId = 'pune'
    And param geoId = 'india'
    And param operator = 'CONTAINS'
    And param page = 0
    And param size = 10
    And param pgId = '5'
    And param thruDate = '22-11-2021'

    When method get
    Then status 200
    And karate.log('Status : 200')
    And karate.log('Response is:', response)
    And assert response.total >= 1
    And karate.log('Test Completed !')
	
		
	#REV2-31414
	Scenario: GET - Verify super admin can Search New Vendor Allocation Preference by Calendar View with all valid values and operator is EQUAL_TO
	
		Given path '/calendar-view'  
   	And param baseGeoId = '411001'
    And param deliveryMode = 'hd'
    And param fieldName = 'vendorName'
    And param fieldValues = 'FC_Name103'
    And param fromDate = '20-09-2021'
    And param geoGroupId = 'pune'
    And param geoId = 'india'
    And param operator = 'EQUAL_TO'
    And param page = 0
    And param size = 10
    And param pgId = '5'
    And param thruDate = '22-11-2021'

    When method get
    Then status 200
    And karate.log('Status : 200')
    And karate.log('Response is:', response)
    And assert response.total >= 1
    And karate.log('Test Completed !')
	
	