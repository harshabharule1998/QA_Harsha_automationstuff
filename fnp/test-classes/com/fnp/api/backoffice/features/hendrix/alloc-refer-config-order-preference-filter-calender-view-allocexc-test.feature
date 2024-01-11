Feature: New Vendor Allocation Preference by Calendar view test Api for allocation executive

  Background: 
    Given url backOfficeAPIBaseUrl
    And path '/hendrix/v1/new-vendor-allocation-preferences'
    * header Accept = 'application/json'
    * def loginResult = callonce read('classpath:com/fnp/api/utils/generate-token.feature') {userType:"allocExc"}
    * def token = loginResult.accessToken
    * header Authorization = token


	#REV2-20224/REV2-31419
  Scenario: GET - Verify allocation executive can fetch New Vendor Allocation Preference by Calendar View with valid ids	

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
    And param pgId = '5'
    And param thruDate = '22-11-2021'

    When method get
    Then status 200
    And karate.log('Status : 200')
    And karate.log('Response is:', response)
    And assert response.total >= 1
    And karate.log('Test Completed !')

  
	#REV2-20225/REV2-31423
  Scenario: GET - Verify allocation executive can not fetch New Vendor Allocation Preference by Calendar View with Invalid ids	

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
    
       
  #REV2-20800/REV2-20801
  Scenario: GET - Verify allocation executive can not fetch New Vendor Allocation Preference by Calendar View with space in the parameters	

    Given path '/calendar-view'  
    And param baseGeoId = '411001'
    And param deliveryMode = ' hd  '
    And param fieldName = 'vendorId '
    And param fieldValues = ' FC_111 '
    And param fieldValues = 'FC_103'
    And param fromDate = ' 20-09-2021 '
    And param geoGroupId = 'pune'
    And param geoId = 'india'
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

      
  #REV2-20226/REV2-31423
  Scenario: GET - Verify allocation executive can not fetch New Vendor Allocation Preference by Calendar View with blank Ids

    Given path '/calendar-view'  
   	And param baseGeoId = ''
    And param deliveryMode = 'hd'
    And param fieldName = 'vendorId'
    And param fieldValues = 'FC_111'
    And param fieldValues = 'FC_103'
    And param fromDate = '20-09-2021'
    And param geoGroupId = 'pune'
    And param geoId = ''
    And param operator = 'EQUAL_TO'
    And param page = 0
    And param size = 10
    And param pgId = ''
    And param thruDate = '22-11-2021'

    When method get
    Then status 400
    And karate.log('Status : 400')
    And karate.log('Response is:', response)
    And match response.errors[*].message contains "The Product Group field is mandatory."
    And match response.errors[*].message contains "baseGeoId must not be blank"
    And match response.errors[*].message contains "The Geography field is mandatory."
    And karate.log('Test Completed !')
    
       
  #REV2-20228
  Scenario: GET - Verify allocation executive can not fetch New Vendor Allocation Preference by Calendar View with missing any mandatory fields

    Given path '/calendar-view'  
    And param baseGeoId = ''
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
    And param pgId = '5'
    And param thruDate = '22-11-2021'

    When method get
    Then status 400
    And karate.log('Status : 400')
    And karate.log('Response is:', response)
    And match response.errors[*].message contains "baseGeoId must not be blank"
    And karate.log('Test Completed !')
    
  
  Scenario: DELETE - Verify allocation executive can not fetch New Vendor Allocation Preference by Calendar View with Unsupported methods

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

    When method delete
    Then status 405
    And karate.log('Status : 405')
    And karate.log('Response is:', response)
    And match response.errors[*].message contains "METHOD_NOT_ALLOWED"
    And karate.log('Test Completed !')
    
    
  #REV2-20229
  Scenario: GET - Verify allocation executive can not fetch New Vendor Allocation Preference by Calendar View with Invalid authorization
  
    * def invalidAuthToken = "eyJraWQiOiJmbnAyIiwiYWxnIjoiUlMyNTYifQ"
    * header Authorization = invalidAuthToken
 
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
    And param pgId = '5'
    And param thruDate = '22-11-2021'

    When method get
    Then status 401
    And karate.log('Status : 401')
    And karate.log('Response is:', response)
    And match response.errors[*].message contains "Token Invalid! Authentication Required"
    And karate.log('Test Completed !')
    
    
  #REV2-20230
  Scenario: GET - Verify allocation executive can not fetch New Vendor Allocation Preference by Calendar View with blank authorization
  
    * def invalidAuthToken = " "
    * header Authorization = invalidAuthToken

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
    And param pgId = '5'
    And param thruDate = '22-11-2021'

    When method get
    Then status 401
    And karate.log('Status : 401')
    And karate.log('Response is:', response)
    And match response.errors[*].message contains "Token Invalid! Authentication Required"
    And karate.log('Test Completed !')    
  

  Scenario: GET - Verify allocation executive can not fetch New Vendor Allocation Preference by Calendar View with Invalid URL

		Given path '/calendar'    
		And param baseGeoId = '411001'
    And param deliveryMode = 'hd'
    And param fieldName = 'vendorId'
    And param fieldValues = 'FC_111'
    And param fieldValues = 'FC_103'
    And param fromDate = '20-12-2021'
    And param geoGroupId = 'pune'
    And param geoId = 'india'
    And param operator = 'EQUAL_TO'
    And param page = 0
    And param size = 10
    And param pgId = '5'
    And param thruDate = '22-12-2021'

    When method get
    Then status 404
    And karate.log('Status : 404')
    And karate.log('Response is:', response)
    And match response.errors[*].message contains "http.request.not.found"
    And karate.log('Test Completed !')  
   
   
	#REV2-20232
 	Scenario: GET - Verify allocation executive can not fetch New Vendor Allocation Preference by Calendar View with invalid dates
 
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
    And param thruDate = '22-13-9021'

    When method get
    Then status 400
    And karate.log('Status : 400')
    And karate.log('Response is:', response)
    And match response.errors[*].message contains "Request Parameter Values are not as Expected thruDate"
    And karate.log('Test Completed !')
    
    
	#REV2-31422
	Scenario: GET - Verify allocation executive can Search New Vendor Allocation Preference by Calendar View with valid values & operator is DOES_NOT_CONTAIN
  
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
    And param size = 10
    And param pgId = '5'
    And param thruDate = '22-11-2021'

    When method get
    Then status 200
    And karate.log('Status : 200')
    And karate.log('Response is:', response)
    And assert response.total >= 1
    And karate.log('Test Completed !')
    
   
	#REV2-31421
	Scenario: GET - Verify allocation executive can Search New Vendor Allocation Preference by Calendar View with valid values & operator is CONTAINS
	
		Given path '/calendar-view'  
   	And param baseGeoId = '411001'
    And param deliveryMode = 'hd'
    And param fieldName = 'vendorId'
    And param fieldValues = 'FC_111'
    And param fieldValues = 'FC_103'
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
    
     
	#REV2-31420
	Scenario:  GET - Verify allocation executive can Search New Vendor Allocation Preference by Calendar View with valid values & operator is NOT_EQUAL_TO
	
		Given path '/calendar-view'  
   	And param baseGeoId = '411001'
    And param deliveryMode = 'hd'
    And param fieldName = 'vendorId'
    And param fieldValues = 'FC_111'
    And param fieldValues = 'FC_103'
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
    
    