Feature: Allocation Logic POST Carrier with Allocation Manager

  Background: 
    Given url backOfficeAPIBaseUrl
    And header Accept = 'application/json'
    And path '/hendrix/v1/pg-rating-configs'
    * configure readTimeout = 40000
    * def loginResult = callonce read('classpath:com/fnp/api/utils/generate-token.feature') {userType:'allocExc'}
    * def authToken = loginResult.accessToken
    * header Authorization = authToken
    
    * def supAdmloginResult = callonce read('classpath:com/fnp/api/utils/generate-token.feature') {userType:'superAdminQA'}
    * def authTokenSupAdm = supAdmloginResult.accessToken
    
    * def allocMgrloginResult = callonce read('classpath:com/fnp/api/utils/generate-token.feature') {userType:'allocMgr'}
    * def authTokenAllocMgr = allocMgrloginResult.accessToken
    
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/pg-rating-config.json')

	
  #REV2-11925 
  Scenario: GET - Verify Allocation Executive can fetch PG-Ratings configuration with valid data for vendorType FC
  
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

	 
	Scenario: GET - Verify Allocation Executive can fetch PG-Ratings configuration with valid data for vendorType CR

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
		
		
  #REV2-12082
  Scenario: PUT - Verify Allocation Executive cannot update PG-Rating Configuration with Blank PG-Rating
  
    * eval requestPayload[0].ratings[0].pgId = " "
    * eval requestPayload[0].ratings[0].value = " "
    And karate.log(requestPayload)
    And request requestPayload
    When method put
    
    Then status 400
    And karate.log('status : 400')
    And karate.log('Response is : ', response)
    And match response.errors[*].message contains 'Rating value should not be empty.'
    And karate.log('Test Completed !')


  #REV2-12081
  Scenario: PUT - Verify Allocation Executive can not update PG-Rating Configuration with Invalid PG-Rating
   
    * eval requestPayload[0].ratings[0].pgId = "7"
    * eval requestPayload[0].ratings[0].value = "6"
    And karate.log(requestPayload)
    And request requestPayload
    When method put
    
    Then status 400
    And karate.log('status : 400')
    And match response.errors[0].message == 'Rating value should be between 1 to 5.'
    And karate.log('Test Completed !')


  #REV2-12080
  Scenario: PUT - Verify Allocation Executive can not update PG-Rating Configuration with valid PG-Rating
   
    * eval requestPayload[0].ratings[0].pgId = "4"
    * eval requestPayload[0].ratings[0].value = "3"
    And karate.log(requestPayload)
    And request requestPayload
    When method put
    
    Then status 200
    And karate.log('status : 200')
    And match response.message == 'Record(s) Updated Successfully.'
    And karate.log('Test Completed !')
 
  
  #REV2-11927
  Scenario: GET- Verify Allocation Executive cannot fetch PG-Ratings configuration with Blank data
    
		And param X-domain = ""
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


	#REV2-11926
	Scenario: GET- Verify Allocation Executive cannot fetch PG-Ratings configuration with Invalid deliveryMode,geo,geoGroup and vendorType
	
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
    
    
    