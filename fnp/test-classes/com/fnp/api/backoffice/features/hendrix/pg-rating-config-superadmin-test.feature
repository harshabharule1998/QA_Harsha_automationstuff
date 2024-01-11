Feature: Get Filters PG-Rating Configurations scenarios for superadmin

	Background: 
  	Given url backOfficeAPIBaseUrl
    And header Accept = 'application/json'
    And path '/hendrix/v1/pg-rating-configs'
    * configure readTimeout = 40000
    * def loginResult = callonce read('classpath:com/fnp/api/utils/generate-token.feature') {userType:'superAdminQA'}
    * def authToken = loginResult.accessToken
    * header Authorization = authToken
  
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/pg-rating-config.json')

	 
	#REV2-11915 and REV2-11923
	Scenario: GET- Verify Super Admin user can fetch PG-Ratings configuration with valid data for vendorType FC
	  
		And param X-domain = "fnp.com"
    And param deliveryMode = "HD"
    And param fieldName = "vendorId"
    And param fieldValues = "FC_111" 
    And param geoGroupId = "Pune"
    And param geoId = "India"
    And param operator = "CONTAINS"
    And param page = 0
    And param size = 10
    And param vendorType = "FC"
		When method get
		Then status 200
		And karate.log('status : 200')
		And karate.log('Response is : ', response)
		And assert response.total >= 0
		And karate.log('Test Completed !')
		    
	
	Scenario: GET - Verify Super Admin user can fetch PG-Ratings configuration with valid data for vendorType CR

	 	Given param X-domain = "fnp.com"
    And param deliveryMode = "HD"
    And param fieldName = "vendorId"
    And param fieldValues = "Carrier_112" 
    And param geoGroupId = "Pune"
    And param geoId = "India"
    And param operator = "CONTAINS"
    And param page = 0
    And param size = 10
    And param vendorType = "CR"
    When method get
    Then status 200
		And karate.log('status : 200')
		And karate.log('Response is : ', response)
		And assert response.total >= 0
		And karate.log('Test Completed !')
    
    
	#REV2-11917
	Scenario: GET- Verify Super Admin cannot fetch PG-Ratings configuration with Blank data
	   
		Given param X-domain = ""
    And param deliveryMode = ""
    And param fieldName = ""
    And param fieldValues = "" 
    And param geoGroupId = ""
    And param geoId = ""
    And param operator = ""
    And param page = ""
    And param size = ""
    And param vendorType = ""
		When method get
		Then status 400
		And karate.log('status : 400')
		And match response.errors[*].message contains 'vendorType must not be blank.'
		And karate.log('Test Completed !')
	    
	  
	#REV2-11918   
	Scenario: GET-Verify super admin cannot fetch PG rating configuration with Invalid URL 
	    
		Given path '/hendrix/v1/pg-ratingconfigs'
		And param X-domain = "fnp.com"
    And param deliveryMode = "HD"
    And param fieldName = "vendorId"
    And param fieldValues = "Carrier_112" 
    And param geoGroupId = "Pune"
    And param geoId = "India"
    And param operator = "CONTAINS"
    And param page = 0
    And param size = 10
    And param vendorType = "CR"
		When method get
	  Then status 404
		And karate.log('status : 404')
		And match response.errors[0].message contains 'http.request.not.found'
		And karate.log('Test Completed !')
		    
		
	#REV2-11920
	Scenario: GET- Verify super admin cannot fetch PG rating configuration with Unsupported methods 
	   	   
		* def requestPayload = " "
	   	  
		Given param X-domain = "fnp.com"
    And param deliveryMode = "HD"
    And param fieldName = "vendorId"
    And param fieldValues = "FC_111" 
    And param geoGroupId = "Pune"
    And param geoId = "India"
    And param operator = "CONTAINS"
    And param page = 0
    And param size = 10
    And param vendorType = "FC"
		And request requestPayload
		When method post
		Then status 405
		And karate.log('status : 405')
		And match response.errors[0].message contains "METHOD_NOT_ALLOWED"
		And karate.log('Test Completed !')
		    
			        
	#REV2-11922
	Scenario: GET- Verify super admin cannot fetch PG rating configuration with Invalid authorization token
	
		* def invalidAuthToken = loginResult.accessToken + "aaaaasssssssssdddddd"
    * header Authorization = invalidAuthToken
    
		Given param X-domain = "fnp.com"
    And param deliveryMode = "HD"
    And param fieldName = "vendorId"
    And param fieldValues = "FC_111" 
    And param geoGroupId = "Pune"
    And param geoId = "India"
    And param operator = "CONTAINS"
    And param page = 0
    And param size = 10
    And param vendorType = "FC"
		When method get
		Then status 401
		And karate.log('status : 401')
		And match response.errors[0].message contains 'Token Invalid! Authentication Required'
		And karate.log('Test Completed !')
		    
	
	#REV2-11926
	Scenario: GET- Verify Super Admin cannot fetch PG-Ratings configuration with Invalid deliveryMode,geo,geoGroup and vendorType
	
		Given param X-domain = "fnp.com"
    And param deliveryMode = "HDF"
    And param fieldName = "vendorId"
    And param fieldValues = "Carrier_112" 
    And param geoGroupId = "PuneP"
    And param geoId = "IndiaIn"
    And param operator = "CONTAINS"
    And param page = 0
    And param size = 10
    And param vendorType = "FCR"
    When method get
    Then status 400
		And karate.log('status : 400')
		And match response.errors[*].message contains 'Vendor Type Has Unknown Value, Allowed Values -> FC, CR'
		And karate.log('Test Completed !')
    
   
	#REV2-12078
  Scenario: PUT - Verify Super Admin can not update PG-Rating Configuration with invalid Authorization
    
    * header Authorization = "eyJraWQiOiJmbnAyIiwiYWxnIjoiUlMyNTY"
    
    * eval requestPayload[0].deliveryMode = "CR"
    And karate.log(requestPayload)
    And request requestPayload
    When method put
    And request requestPayload
    Then status 401
    And karate.log('status : 401')
    And match response.errors[0].message == 'Token Invalid! Authentication Required'
    And karate.log('Test Completed !')

 
  #REV2-12077
  Scenario: PATCH - Verify any method with Unsupported methods for endpoints
       
    * eval requestPayload[0].deliveryMode = "CR"
    And karate.log(requestPayload)
    And request requestPayload
    When method patch
    
    Then status 405
    And karate.log('status : 405')
    And match response.errors[0].message == 'METHOD_NOT_ALLOWED'
    And karate.log('Test Completed !')
    
 
	 #Bug-REV2-14643
  #REV2-12076
  Scenario: PUT - Verify Super Admin can not update PG-Rating Configuration with blank data
    
    * eval requestPayload[0].ratings[0].pgId = " "
    * eval requestPayload[0].ratings[0].value = " "
    * eval requestPayload[0].deliveryMode = " "
    * eval requestPayload[0].vendorId = " "
    And karate.log(requestPayload)
    And request requestPayload
    When method put
    
    Then status 400
    And karate.log('status : 400')
    And match response.errors[*].message contains 'Rating value should not be empty.'
    And karate.log('Test Completed !')

 
  #REV2-12075
  Scenario: PUT - Verify Allocation Executive can not update PG-Rating Configuration with Invalid Endpoint URL
   
    Given path 't/'
    
    And karate.log(requestPayload)
    And request requestPayload
    When method put
   
    Then status 404
    And karate.log('status : 404')
    And match response.errors[*].message == ["http.request.not.found"]
    And karate.log('Test Completed !')

 
  #REV2-12072
  Scenario: PUT - Verify SuperAdmin can not update PG-Rating Configuration with Blank PG-Rating
    
    * eval requestPayload[0].ratings[0].pgId = ""
    * eval requestPayload[0].ratings[0].value = ""
    And karate.log(requestPayload)
    And request requestPayload
    When method put
    
    Then status 400
    And karate.log('status : 400')
    And match response.errors[*].message contains 'Rating value should not be empty.'
    And karate.log('Test Completed !')

 
  #REV2-12071
  Scenario: PUT - Verify Super Admin can not update PG-Rating Configuration with Invalid PG-Rating
      
    * eval requestPayload[0].ratings[0].pgId = "7"
    * eval requestPayload[0].ratings[0].value = "6"
    And karate.log(requestPayload)
    And request requestPayload
    When method put
    
    Then status 400
    And karate.log('status : 400')
    And match response.errors[0].message == 'Rating value should be between 1 to 5.'
    And karate.log('Test Completed !')


  #REV2-12070
  Scenario: PUT - Verify Super Admin can not update PG-Rating Configuration with valid PG-Rating
    
    * eval requestPayload[0].ratings[0].pgId = "3"
    * eval requestPayload[0].ratings[0].value = "1"
    And karate.log(requestPayload)
    
    Given request requestPayload
    When method put
    Then status 200
    And karate.log('status : 200')
    And match response.message == 'Record(s) Updated Successfully.'
    And karate.log('Test Completed !')	
    
     