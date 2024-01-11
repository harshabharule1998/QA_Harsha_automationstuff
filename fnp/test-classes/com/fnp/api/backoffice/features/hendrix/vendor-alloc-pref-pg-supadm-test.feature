Feature: Get Weightage for New Order Prference Vendor allocation by pg scenarios for super admin

  Background: 
    Given url backOfficeAPIBaseUrl
    And path '/hendrix/v1/new-vendor-allocation-preferences'
    * header Accept = 'application/json'
    * def loginResult = callonce read('classpath:com/fnp/api/utils/generate-token.feature') {userType:"superAdminQA"}
    * def token = loginResult.accessToken
    * header Authorization = token
    
   
  #REV2-20499/REV2-29480/	REV2-29485
	Scenario: GET - Verify super admin can fetch New Vendor Allocation Preference Quota Configuration by pg 
	with all Valid values 
    
	 	Given path '/vendor-allocation-by-pg'
    And param baseGeoId = '411007'
    And param deliveryMode = 'hd'
    And param fieldName = 'vendorName'
    And param fieldValues = 'FC_Name101'
    And param geoGroupId = 'mumbai'
    And param geoId = 'India'
    And param page = '0'
    And param pgId = '2'
    And param size = '10'
    And param operator = 'EQUAL_TO'
    When method get
    Then status 200
    And karate.log('Status : 200')
    And karate.log('Response is:', response)
    And karate.log('Test Completed !')
    
 
	#REV2-20503
  Scenario: GET - Verify super admin can not fetch New Vendor Allocation Preference Quota Configuration
   by pg with combination of blank and Valid values 
    
		Given path '/vendor-allocation-by-pg'
    And param baseGeoId = '411006'
    And param deliveryMode = ' '
    And param fieldName = 'vendorName'
    And param fieldValues = 'FC_Name101'
    And param geoGroupId = 'mumbai'
    And param geoId = ' '
    And param operator = 'EQUAL_TO'
    And param page = '0'
    And param pgId = '1'
    And param size = '10'  
    When method get
    Then status 400
    And karate.log('Status : 400')
    And karate.log('Response is:', response)
    And match response.errors[*].message contains "The Geography field is mandatory."  
    And match response.errors[*].message contains "The Delivery mode field is mandatory."
    And match response.errors[*].message contains "Invalid characters found in geoId."
    And karate.log('Test Completed !')
    
   
	#REV2-20500/REV2-29481 
	Scenario: GET - Verify super admin can not fetch New Vendor Allocation Preference Quota Configuration 
	by pg with all Invalid values 
    
		Given path '/vendor-allocation-by-pg'
    And param baseGeoId = '41100'
    And param deliveryMode = 'h'
    And param fieldName = 'vendorName'
    And param fieldValues = 'abc'
    And param geoGroupId = 'mumba'
    And param geoId = 'Indi'
    And param operator = 'EQUAL_TO'
    And param page = '0'
    And param pgId = '30'
    And param size = '10' 
    When method get
    Then status 400
    And karate.log('Status : 400')
    And karate.log('Response is:', response)
    And match response.errors[0].message contains "Requested pgId doesn't exist -> 30"
    And karate.log('Test Completed !')
 	
  
 	#REV2-20501
	Scenario: GET - Verify super admin can not fetch New Vendor Allocation Preference Quota Configuration
	 by pg with Combination of invalid and valid values
    
		Given path '/vendor-allocation-by-pg'
    And param baseGeoId = 411007
    And param deliveryMode = 'hd'
    And param fieldName = 'vendorName'
    And param fieldValues = 'FC_Name101' 
    And param geoGroupId = 'mumba'
    And param geoId = 'India'
    And param operator = 'EQUAL_TO'
    And param page = '0'
    And param pgId = '30'
    And param size = '10'    
    When method get
    Then status 400
    And karate.log('Status : 400')
    And karate.log('Response is:', response)
    And match response.errors[0].message contains "Requested pgId doesn't exist -> 30"
    And karate.log('Test Completed !')
 
  
 	#REV2-20502/REV2-29482
 	Scenario: GET - Verify super admin can not fetch New Vendor Allocation Preference Quota Configuration
 	 by pg with blank values 
    
		Given path '/vendor-allocation-by-pg'
    And param baseGeoId = ' '
    And param deliveryMode = ' '
    And param fieldName = ' '
    And param fieldValues = ' '  
    And param geoGroupId = ' '
    And param geoId = ' '
    And param operator = ' '
    And param page = ' '
    And param pgId = ' '
    And param size = ' '    
    When method get
    Then status 400
    And karate.log('Status : 400')
    And karate.log('Response is:', response)
    And match response.errors[*].message contains "Invalid characters found in pgId."
    And match response.errors[*].message contains "The Product Group field is mandatory."    
    And match response.errors[*].message contains "The Geography field is mandatory."  
    And match response.errors[*].message contains "The Delivery mode field is mandatory."
    And match response.errors[*].message contains "Invalid characters found in geoId."
    And match response.errors[*].message contains "The Geo group field is mandatory."
    And match response.errors[*].message contains "Invalid characters found in geoGroupId."      
    And karate.log('Test Completed !')  	
    
     
  #REV2-20507/REV2-29392/REV2-29397
	Scenario: GET - Verify super admin can not fetch New Vendor Allocation Preference Quota Configuration 
	by pg with invalid URL
    
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
    
  
  #REV2-20504/REV2-29390/REV2-29395
	Scenario: GET - Verify super admin can not fetch New Vendor Allocation Preference Quota Configuration 
	by pg with Invalid authorization
    
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
 
  
	#REV2-20509
	Scenario: GET - Verify super admin can not fetch New Vendor Allocation Preference Quota Configuration
	 by pg with Unsupported methods 
     
    * def requestPayload = " "
     
		Given path '/vendor-allocation-by-pg'
    And param baseGeoId = 411006
    And param deliveryMode = 'hd'
    And param fieldName = 'vendorName'
    And param fieldValues = 'FC_Name101'
    And param geoGroupId = 'mumbai'
    And param geoId = 'India'
    And param operator = 'EQUAL_TO'
    And param page = '0'    
    And param pgId = '10'
    And param size = '10'        
    And request requestPayload
    When method post
    Then status 405
    And karate.log('Status : 405')
    And karate.log('Response is:', response)
    And match response.errors[0].message == "METHOD_NOT_ALLOWED"
    And karate.log('Test Completed !')
    
    
	#REV2-20510/REV2-29489    
  Scenario: GET - Verify super admin can not fetch New Vendor Allocation Preference Quota Configuration by 
  pg with Missing any value in Mandatory fields
   
		Given path '/vendor-allocation-by-pg'
    And param baseGeoId = '411006'
    And param deliveryMode = 'hd'
    And param fieldName = 'vendorName'
    And param fieldValues = ['FC_Name101','FC_Name102'] 
    And param geoGroupId = 'mumbai'
    And param geoId = ''
    And param operator = 'EQUAL_TO'
    And param page = '0'      
    And param pgId = '1'
    And param size = '10'          
    When method get
    Then status 400
    And karate.log('Status : 400')
    And karate.log('Response is:', response)
    And match response.errors[0].message == "The Geography field is mandatory."
    And karate.log('Test Completed !')
    
  	
	#REV2-20511/REV2-29490    		
  Scenario: GET - Verify super admin can fetch New Vendor Allocation Preference Quota Configuration by pg 
  with Missing any value in Optional fields
		
		Given path '/vendor-allocation-by-pg'
    And param baseGeoId = '411007'
    And param deliveryMode = 'hd'
    And param fieldName = ''
    And param fieldValues = 'FC_Name101'   
    And param geoGroupId = 'mumbai'
    And param geoId = 'India'
    And param operator = 'EQUAL_TO'
    And param page = ''        
    And param pgId = '10'
    And param size = ''  
    When method get
    Then status 200
    And karate.log('Status : 200')
    And karate.log('Response is:', response)
    And assert response.total >= 1
    And karate.log('Test Completed !')	
    
  
	#REV2-20512    		
  Scenario: GET - Verify super admin can fetch New Vendor Allocation Preference Quota Configuration by pg
   with Missing Optional parameters
  
		Given path '/vendor-allocation-by-pg'
    And param baseGeoId = '411007'
    And param deliveryMode = 'hd'
    And param fieldName = 'vendorName'
    And param fieldValues = 'FC_Name101'
    And param geoGroupId = 'mumbai'
    And param geoId = 'India'
    And param operator = 'EQUAL_TO'
    And param page = ''   
    And param pgId = '10'
    And param size = ''  
    When method get
    Then status 200
    And karate.log('Status : 200')
    And karate.log('Response is:', response)
    And assert response.total >= 1
    And karate.log('Test Completed !')	
    
   
	#REV2-20513  
	Scenario: GET - Verify super admin can not fetch New Vendor Allocation Preference Quota Configuration by
	 pg with Missing mendatory parameters
	  	
		Given path '/vendor-allocation-by-pg'
    And param baseGeoId = '411006'
    And param deliveryMode = 'hd'
    And param fieldName = 'vendorName'
    And param fieldValues = 'FC_Name101' 
    And param geoGroupId = 'mumbai'
    And param operator = 'EQUAL_TO'
    And param page = '2'   
    And param pgId = '1'
    And param size = '10'    
    When method get
    Then status 400
    And karate.log('Status : 400')
    And karate.log('Response is:', response)
    And match response.errors[0].message == "The Geography field is mandatory."
    And karate.log('Test Completed !')
    
     
	#REV2-20514
	Scenario: GET - Verify super admin can not fetch New Vendor Allocation Preference Quota Configuration by 
	pg with only spaces in the parameter
	  	
		Given path '/vendor-allocation-by-pg'
    And param baseGeoId = '411007'
    And param deliveryMode = 'hd'
    And param fieldName = 'vendorName'
    And param fieldValues = 'FC_Name101'  
    And param geoGroupId = 'mumbai'
    And param geoId = 'India'
    And param operator = 'EQUAL_TO'
    And param page = '2'   
    And param pgId = '   2'
    And param size = '10'    
    When method get
    Then status 400
    And karate.log('Status : 400')
    And karate.log('Response is:', response)
    And match response.errors[0].message == "Invalid characters found in pgId."
    And karate.log('Test Completed !')
    
#### New Vendor Allocation Preference Quota Configuration Search functionality by pg ###### 

	#REV2-29484
	Scenario:  Verify Method : GET request to verify field should accept comma separated value with Super
	 Admin access
	 - one invalid values for fields
	
		Given path '/vendor-allocation-by-pg'
    And param baseGeoId = '411007'
    And param deliveryMode = 'hd'
    And param fieldName = 'vendorName'
    And param fieldValues = ['FC_Name101','abc']
    And param geoGroupId = 'mumbai'
    And param geoId = 'India'
    And param page = '0'
    And param pgId = '2'
    And param size = '10'
    And param operator = 'EQUAL_TO'
    When method get
    Then status 200
    And karate.log('Status : 200')
    And karate.log('Response is:', response)
    And karate.log('Test Completed !')


	#REV2-29486
	Scenario: Verify Method : GET request to verify search by field to be performed by Not Equal to operator
	 with Super Admin access

		Given path '/vendor-allocation-by-pg'
    And param baseGeoId = '411007'
    And param deliveryMode = 'hd'
    And param fieldName = 'vendorName'
    And param fieldValues = ['FC_Name101','FC_Name102']
    And param geoGroupId = 'mumbai'
    And param geoId = 'India'
    And param page = '0'
    And param pgId = '2'
    And param size = '10'
    And param operator = 'NOT_EQUAL_TO'
    When method get
    Then status 200
    And karate.log('Status : 200')
    And karate.log('Response is:', response)
    And karate.log('Test Completed !')


	#REV2-29487
	Scenario: Verify Method : GET request to verify search by field to be performed by Contains operator with 
	Super Admin access
		
		Given path '/vendor-allocation-by-pg'
    And param baseGeoId = '411007'
    And param deliveryMode = 'hd'
    And param fieldName = 'vendorName'
    And param fieldValues = ['FC_Name101','FC_Name102']
    And param geoGroupId = 'mumbai'
    And param geoId = 'India'
    And param page = '0'
    And param pgId = '2'
    And param size = '10'
    And param operator = 'CONTAINS'
    When method get
    Then status 200
    And karate.log('Status : 200')
    And karate.log('Response is:', response)
    And karate.log('Test Completed !')
  
	
	#REV2-29488
	Scenario: Verify Method : GET request to verify search by field to be performed by does not Contains 
	operator with Super Admin access
	
		Given path '/vendor-allocation-by-pg'
    And param baseGeoId = '411007'
    And param deliveryMode = 'hd'
    And param fieldName = 'vendorName'
    And param fieldValues = ['FC_Name101','FC_Name102']
    And param geoGroupId = 'mumbai'
    And param geoId = 'India'
    And param page = '0'
    And param pgId = '2'
    And param size = '10'
    And param operator = 'DOES_NOT_CONTAIN'
    When method get
    Then status 200
    And karate.log('Status : 200')
    And karate.log('Response is:', response)
    And karate.log('Test Completed !')
    
  
