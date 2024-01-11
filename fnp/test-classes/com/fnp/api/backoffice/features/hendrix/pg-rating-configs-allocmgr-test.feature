Feature: Allocation Logic POST Carrier with Allocation Manager

  Background: 
    Given url backOfficeAPIBaseUrl
    And header Accept = 'application/json'
    And path '/hendrix/v1/pg-rating-configs'
    * def loginResult = callonce read('classpath:com/fnp/api/utils/generate-token.feature') {userType:'allocMgr'}
    * def authToken = loginResult.accessToken
    * header Authorization = authToken
    
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/pg-rating-config.json')

  
  #REV2-19474
  Scenario: GET - Verify Allocation Manager can fetch PG-Ratings configuration with valid data for vendorType FC
  
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
    Then status 200
		And karate.log('status : 200')
		And karate.log('Response is : ', response)
		And assert response.total >= 0
		And karate.log('Test Completed !')


	Scenario: GET - Verify Allocation Manager can fetch PG-Ratings configuration with valid data for vendorType CR

	 	Given param X-domain = "fnp.com"
    And param deliveryMode = "HD"
    And param fieldName = "vendorId"
    And param fieldValues = "Carrier_111" 
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
		

	#REV2-11930
  Scenario: GET - Verify Allocation Manager cannot fetch PG-Ratings configuration for Blank deliveryMode,geo,geoGroup and vendorType
		
		Given param X-domain = "fnp.com"
    And param deliveryMode = ""
    And param fieldName = "vendorId"
    And param fieldValues = "Carrier_111" 
    And param geoGroupId = ""
    And param geoId = ""
    And param operator = "CONTAINS"
    And param page = 0
    And param size = 10
    And param vendorType = ""
		When method get
		Then status 400
		And karate.log('status : 400')
		And match response.errors[*].message contains 'vendorType must not be blank.'
		And match response.errors[*].message contains 'The Geography field is mandatory.'
		And match response.errors[*].message contains 'The Delivery mode field is mandatory.'
		And match response.errors[*].message contains 'The Geo group field is mandatory.'
		And karate.log('Test Completed !')
		
	
  #REV2-19473
  Scenario: PUT - Verify Allocation Manager can update PG-Rating Configuration
    
    * eval requestPayload[0].deliveryMode = "CR"
    And karate.log(requestPayload)
    And request requestPayload
    When method put
    Then status 200
    And karate.log('status : 200')
    And match response.message == 'Record(s) Updated Successfully.'
    And karate.log('Test Completed !')

	
  #REV2-12078
  Scenario: PUT - Verify Allocation Mananger can not update PG-Rating Configuration with invalid Authorization
  
    * header Authorization = "eyJraWQiOiJmbnAyIiwiYWxnIjoiUlMyNTY"
    
    * eval requestPayload[0].deliveryMode = "CR"
    And request requestPayload
    And karate.log(requestPayload)
    When method put
    Then status 401
    And karate.log('status : 401')
    And match response.errors[0].message == 'Token Invalid! Authentication Required'
    And karate.log('Test Completed !')


  #REV2-12077
  Scenario: PATCH - Verify any method with Unsupported methods for endpoints
   
    * eval requestPayload[0].deliveryMode = "CR"
    And request requestPayload
    And karate.log(requestPayload)
    When method patch
    Then status 405
    And karate.log('status : 405')
    And match response.errors[0].message == 'METHOD_NOT_ALLOWED'
    And karate.log('Test Completed !')
    
    
 