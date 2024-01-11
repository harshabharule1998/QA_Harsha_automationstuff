Feature: Get Weightage for New Order Prference Vendor allocation by pg scenarios for allocation executive

  Background: 
    Given url backOfficeAPIBaseUrl
    And path '/hendrix/v1/new-vendor-allocation-preferences'
    * header Accept = 'application/json'
    * def loginResult = callonce read('classpath:com/fnp/api/utils/generate-token.feature') {userType:"allocExc"}
    * def token = loginResult.accessToken
    * header Authorization = token

   
	#REV2-20516/REV2-29472/REV2-29474
	Scenario: GET - Verify allocation executive can fetch New Vendor Allocation Preference Quota Configuration by pg with all Valid values 
	
    Given path '/vendor-allocation-by-pg'
    And param baseGeoId = '411007'
    And param deliveryMode = 'hd'
    And param fieldName = 'vendorName'
    And param fieldValues = ['FC_Name101','FC_Name102']  
    And param geoGroupId = 'mumbai'
    And param geoId = 'India'
    And param operator = 'EQUAL_TO'
    And param page = '0' 
    And param pgId = '2'
    And param size = '10'    
    When method get
    Then status 200
    And karate.log('Status : 200')
    And karate.log('Response is:', response)
    And karate.log('Test Completed !')
    
  
	#REV2-20517
  Scenario: GET - Verify allocation executive can not fetch New Vendor Allocation Preference Quota Configuration by pg with all Invalid values 
  	 
  	Given path '/vendor-allocation-by-pg'
    And param baseGeoId = '411019'
    And param deliveryMode = 'ab'
    And param fieldName = 'FC_10'
    And param fieldValues = 'FC_Name10' 
    And param geoGroupId = 'delhi'
    And param geoId = 'japan'
    And param operator = 'EQUAL_TO'
    And param page = '00'
    And param pgId = '17'
    And param size = '30'    
    When method get
    Then status 400
    And karate.log('Status : 400')
    And karate.log('Response is:', response)
    And match response.errors[*].message contains "Requested pgId doesn't exist -> 17" 
    And karate.log('Test Completed !')
     
    
  #REV2-20518
  Scenario: GET - Verify allocation executive can not fetch New Vendor Allocation Preference Quota Configuration by pg with combination of Invalid and valid values.
    
		Given path '/vendor-allocation-by-pg'
    And param baseGeoId = '411006'
    And param deliveryMode = 'pq '
    And param fieldName = 'FC_10'
    And param fieldValues = 'FC_Name10' 
    And param geoGroupId = 'mumbai'
    And param geoId = 'abcd' 
    And param operator = 'EQUAL_TO'
    And param page = '00'
    And param pgId = '17'
    And param size = '30'    
    When method get
    Then status 400
    And karate.log('Status : 400')
    And karate.log('Response is:', response)
    And match response.errors[*].message contains "Requested pgId doesn't exist -> 17"  
    And karate.log('Test Completed !')
    
 
	#REV2-20519/REV2-29471
	Scenario: GET - Verify allocation executive can not fetch New Vendor Allocation Preference Quota Configuration by pg with blank values 
    
		Given path '/vendor-allocation-by-pg'
    And param baseGeoId = ' '
    And param deliveryMode = ' '
    And param fieldName = ' '
    And param fieldValues = ' '
    And param geoGroupId = ' '
    And param geoId = ' '
    And param operator = 'EQUAL_TO'
    And param page = '00'
    And param pgId = ' '
    And param size = '30'    
    When method get
    Then status 400
    And karate.log('Status : 400')
    And karate.log('Response is:', response)
    And match response.errors[*].message contains "The Delivery mode field is mandatory."  
    And match response.errors[*].message contains "Invalid characters found in pgId."
    And match response.errors[*].message contains "Invalid characters found in baseGeoId."
    And match response.errors[*].message contains "The Geo group field is mandatory."
    And match response.errors[*].message contains "Invalid characters found in geoId."
    And karate.log('Test Completed !')  	
   
         
  #REV2-20520
  Scenario: GET - Verify allocation executive can not fetch New Vendor Allocation Preference Quota Configuration by pg with combination of blank and Invalid values for mandatory fields.
        
		Given path '/vendor-allocation-by-pg'
    And param baseGeoId = '41100'
    And param deliveryMode = ' '
    And param fieldName = 'vendorName'
    And param fieldValues = 'FC_Name101'
    And param geoGroupId = 'mumba'
    And param geoId = ' '
    And param operator = 'EQUAL_TO'
    And param page = '0'  
    And param pgId = '11'
    And param size = '10'
    When method get
    Then status 400
    And karate.log('Status : 400')
    And karate.log('Response is:', response)
    And match response.errors[*].message contains "The Delivery mode field is mandatory."
    And match response.errors[*].message contains "Invalid characters found in geoId."
    And karate.log('Test Completed !')
    

  #REV2-20521/REV2-29392
	Scenario: GET - Verify allocation executive can not fetch New Vendor Allocation Preference Quota Configuration by pg with invalid URL
    
    Given path '/vendor-allocation-by-pgs'
    And param baseGeoId = 411007
    And param deliveryMode = 'hd'
    And param fieldName = 'vendorName'
    And param fieldValues = 'FC_Name101'  
    And param geoGroupId = 'mumbai'
    And param geoId = 'India'
    And param operator = 'EQUAL_TO'
    And param page = '0'  
    And param pgId = '10'
    And param size = '10'  
    When method get
    Then status 404
    And karate.log('Status : 404')
    And karate.log('Response is:', response)
    And match response.errors[0].message == "http.request.not.found"
    And karate.log('Test Completed !')
  
  
  #REV2-20522
	Scenario: GET - Verify allocation executive cannot fetch New Vendor Allocation Preference Quota Configuration by pg with Invalid authorization
    
    * def invalidAuthToken = "eyJraWQiOiJmbnAyIiwiYWxnIjoiUlMyNTYifQ"
    * header Authorization = invalidAuthToken
    
    Given path '/vendor-allocation-by-pg'
    And param baseGeoId = 411007
    And param deliveryMode = 'hd'
    And param fieldName = 'vendorName'
    And param fieldValues = 'FC_Name101'  
    And param geoGroupId = 'mumbai'
    And param geoId = 'India'
    And param operator = 'EQUAL_TO'
    And param page = '0'  
    And param pgId = '1'
    And param size = '10'   
    When method get
  	Then status 401
    And karate.log('Status : 401')
    And karate.log('Response is:', response)
    And match response.errors[0].message == 'Token Invalid! Authentication Required'
    And karate.log('Test Completed !')    
     
     
    #### New Vendor Allocation Preference Quota Configuration Search functionality by pg ###### 

	#REV2-29477
	Scenario:  Verify Method : GET request to verify search by field to be performed by does not Contains operator
	 with Allocation Executive access
   
    Given path '/vendor-allocation-by-pg'
    And param baseGeoId = '411007'
    And param deliveryMode = 'hd'
    And param fieldName = 'vendorName'
    And param fieldValues = 'FC_Name101' 
    And param geoGroupId = 'mumbai'
    And param geoId = 'India'
    And param operator = 'DOES_NOT_CONTAIN'
    And param page = '0' 
    And param pgId = '2'
    And param size = '10'    
    When method get
    Then status 200
    And karate.log('Status : 200')
    And karate.log('Response is:', response)
    And karate.log('Test Completed !')
    
 
  #REV2-29469
  Scenario: Verify Method : GET request to verify list should be filtered based on the search by field value with
   Allocation Executive access - All valid values for fields
   
    Given path '/vendor-allocation-by-pg'
    And param baseGeoId = '411007'
    And param deliveryMode = 'hd'
    And param fieldName = 'vendorId'
    And param fieldValues = ['FC_101','FC_102']
    And param geoGroupId = 'mumbai'
    And param geoId = 'India'
    And param operator = 'EQUAL_TO'
    And param page = '0' 
    And param pgId = '2'
    And param size = '10'    
    When method get
    Then status 200
    And karate.log('Status : 200')
    And karate.log('Response is:', response)
    And karate.log('Test Completed !')
   
  
	#REV2-29470
  Scenario: Verify Method : GET request to verify list should be filtered based on the search by field value with Allocation 
   Executive access - All invalid values for fields
   
    Given path '/vendor-allocation-by-pg'
    And param baseGeoId = '41100'
    And param deliveryMode = 'hd'
    And param fieldName = 'vendorId'
    And param fieldValues = ['abc','ab']
    And param geoGroupId = 'mumbai'
    And param geoId = 'India'
    And param operator = 'EQUAL_TO'
    And param page = '0' 
    And param pgId = '2'
    And param size = '10'    
    When method get
    Then status 200
    And karate.log('Status : 200')
    And karate.log('Response is:', response)
    And karate.log('Test Completed !')
   
  
	#REV2-29473
  Scenario:  Verify Method : GET request to verify field should accept comma separated value with Allocation Executive
   access - one invalid values for fields
   
    Given path '/vendor-allocation-by-pg'
    And param baseGeoId = '41100'
    And param deliveryMode = 'hd'
    And param fieldName = 'vendorId'
    And param fieldValues = ['FC_101','ab']
    And param geoGroupId = 'mumbai'
    And param geoId = 'India'
    And param operator = 'EQUAL_TO'
    And param page = '0' 
    And param pgId = '2'
    And param size = '10'    
    When method get
    Then status 200
    And karate.log('Status : 200')
    And karate.log('Response is:', response)
    And karate.log('Test Completed !')
   
  
  #REV2-29475
  Scenario: Verify Method : GET request to verify search by field to be performed by Not Equal to
   operator with Allocation Executive access 
   
    Given path '/vendor-allocation-by-pg'
    And param baseGeoId = '41100'
    And param deliveryMode = 'hd'
    And param fieldName = 'vendorId'
    And param fieldValues = ['FC_101','FC_102']
    And param geoGroupId = 'mumbai'
    And param geoId = 'India'
    And param operator = 'NOT_EQUAL_TO'
    And param page = '0' 
    And param pgId = '2'
    And param size = '10'    
    When method get
    Then status 200
    And karate.log('Status : 200')
    And karate.log('Response is:', response)
    And karate.log('Test Completed !')
    
 
  #REV2-29476
  Scenario: Verify Method : GET request to verify search by field to be performed by Contains operator with Allocation 
  Executive access
  
  	Given path '/vendor-allocation-by-pg'
    And param baseGeoId = '41100'
    And param deliveryMode = 'hd'
    And param fieldName = 'vendorId'
    And param fieldValues = ['FC_101','FC_102']
    And param geoGroupId = 'mumbai'
    And param geoId = 'India'
    And param operator = 'CONTAINS'
    And param page = '0' 
    And param pgId = '2'
    And param size = '10'    
    When method get
    Then status 200
    And karate.log('Status : 200')
    And karate.log('Response is:', response)
    And karate.log('Test Completed !')
    
 
  #REV2-29479
  Scenario: Verify Method: GET request with Allocation Executive access - Missing any value in optional 
  fields
  
    Given path '/vendor-allocation-by-pg'
    And param baseGeoId = '411007'
    And param deliveryMode = 'hd'
    And param fieldName = 'vendorId'
    And param fieldValues = ['FC_101','FC_102']
    And param geoGroupId = 'mumbai'
    And param geoId = 'India'
    And param operator = 'EQUAL_TO'
    And param page = '' 
    And param pgId = '2'
    And param size = ''    
    When method get
    Then status 200
    And karate.log('Status : 200')
    And karate.log('Response is:', response)
    And karate.log('Test Completed !') 
   
  
  #REV2-29478
  Scenario: Verify Method: GET request  with Allocation Executive access - with editing the search values
  
  	Given path '/vendor-allocation-by-pg'
    And param baseGeoId = '41100'
    And param deliveryMode = 'hd'
    And param fieldName = 'vendorId'
    And param fieldValues = 'FC_151'
    And param geoGroupId = 'mumbai'
    And param geoId = 'India'
    And param operator = 'CONTAINS'
    And param page = '0' 
    And param pgId = '2'
    And param size = '10'    
    When method get
    Then status 200
    And karate.log('Status : 200')
    And karate.log('Response is:', response)
    And karate.log('Test Completed !')
  
  
  