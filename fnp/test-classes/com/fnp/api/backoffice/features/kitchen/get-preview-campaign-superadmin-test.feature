Feature: Kitchen Module Preview Campaign GET scenarios with Super Admin

  Background: 
  
    Given url backOfficeAPIBaseUrl
    And header Accept = 'application/json'
    And path '/kitchen/v1/campaigns/preview'
    
    * def loginResult = callonce read('classpath:com/fnp/api/utils/generate-token.feature') {userType:'kitchenAdmin'}
    * def authToken = loginResult.accessToken
    * header Authorization = authToken
    
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/kitchen/preview-campaign.json')
    
    * def encode =
 		"""
 			function(jsonRequest) {
   			var encodedText = encodeURIComponent(jsonRequest).replace(/'/g,"%27").replace(/"/g,"%22");   		
   			return encodedText;
   		}
 		"""
    

  #REV2-43440
  Scenario: GET - Verify Super admin to get preview campaign with valid data		
    
   	# convert json to string
    * string filterRequestString = requestPayload
    * def encodedFilter = encode(filterRequestString)
    
    * karate.log('encodedFilter : ' + encodedFilter)
    
    * karate.log(requestPayload)
    
    Given param page = 0
    And param size = 10
    And param filter = encodedFilter
    When method get
    Then status 200
    And karate.log('Response is : ', response)
    And karate.log('Status : 200')
    And match response.currentPage == 0
    And match response.data[*].city == "#notnull"
    And karate.log('Test Completed !')


  #REV2-43441
  Scenario: GET - Verify Super admin to get preview campaign with invalid data		
    
   	# convert json to string
    * string filterRequestString = requestPayload
    * def encodedFilter = encode(filterRequestString)
    
    * karate.log('encodedFilter : ' + encodedFilter)
    
    * karate.log(requestPayload)
    
    Given param page = "abc"
    And param size = "xyz"
    And param filter = encodedFilter + "123"
    When method get
    Then status 400
    And karate.log('Response is : ', response)
    And karate.log('Status : 400')
    And karate.log('Test Completed !')
    
	
  #REV2-43442
  Scenario: GET - Verify Super admin to get preview campaign with blank data		
    
    Given param page = " "
    And param size = " "
    And param filter = " "
    When method get
    Then status 400
    And karate.log('Response is : ', response)
    And karate.log('Status : 400')
    And karate.log('Test Completed !')
    
	
  #REV2-43443
  Scenario: GET - Verify Super admin to get preview campaign with valid page param and valid filter	
    
    # convert json to string
    * string filterRequestString = requestPayload
    * def encodedFilter = encode(filterRequestString)
    
    * karate.log('encodedFilter : ' + encodedFilter)
    
    * karate.log(requestPayload)
    
    Given param page = 0
    And param size = 10
    And param filter = encodedFilter
    When method get
    Then status 200
    And karate.log('Response is : ', response)
    And karate.log('Status : 200')
    And karate.log('Test Completed !')
    
	
  #REV2-43444
  Scenario: GET - Verify Super admin to get preview campaign with invalid page param and valid filter	
    
    # convert json to string
    * string filterRequestString = requestPayload
    * def encodedFilter = encode(filterRequestString)
    
    * karate.log('encodedFilter : ' + encodedFilter)
    
    * karate.log(requestPayload)
    
    Given param page = "abc"
    And param size = 10
    And param filter = encodedFilter
    When method get
    Then status 400
    And karate.log('Response is : ', response)
    And karate.log('Status : 400')
    And match response.errors[0].message == "invalid.value.forpage"
    And karate.log('Test Completed !')
    
	
  #REV2-43445
  Scenario: GET - Verify Super admin to get preview campaign with blank page param and valid filter	
    
    # convert json to string
    * string filterRequestString = requestPayload
    * def encodedFilter = encode(filterRequestString)
    
    * karate.log('encodedFilter : ' + encodedFilter)
    
    * karate.log(requestPayload)
    
    Given param page = ""
    And param size = 10
    And param filter = encodedFilter
    When method get
    Then status 200
    And karate.log('Response is : ', response)
    And karate.log('Status : 200')
    And karate.log('Test Completed !')
    
	
	#REV2-43446
  Scenario: GET - Verify Super admin to get preview campaign with valid size param and valid filter	
    
    # convert json to string
    * string filterRequestString = requestPayload
    * def encodedFilter = encode(filterRequestString)
    
    * karate.log('encodedFilter : ' + encodedFilter)
    
    * karate.log(requestPayload)
    
    Given param page = 1
    And param size = 10
    And param filter = encodedFilter
    When method get
    Then status 200
    And karate.log('Response is : ', response)
    And karate.log('Status : 200')
    And karate.log('Test Completed !')
    
	
	#REV2-43447
  Scenario: GET - Verify Super admin to get preview campaign with invalid size param and valid filter	
    
    # convert json to string
    * string filterRequestString = requestPayload
    * def encodedFilter = encode(filterRequestString)
    
    * karate.log('encodedFilter : ' + encodedFilter)
    
    * karate.log(requestPayload)
    
    Given param page = 1
    And param size = "abc"
    And param filter = encodedFilter
    When method get
    Then status 400
    And karate.log('Response is : ', response)
    And karate.log('Status : 400')
    And match response.errors[0].message == "invalid.value.forsize"
    And karate.log('Test Completed !')
    
	
	#REV2-43448
  Scenario: GET - Verify Super admin to get preview campaign with blank size param and valid filter	
    
    # convert json to string
    * string filterRequestString = requestPayload
    * def encodedFilter = encode(filterRequestString)
    
    * karate.log('encodedFilter : ' + encodedFilter)
    
    * karate.log(requestPayload)
    
    Given param page = 1
    And param size = ""
    And param filter = encodedFilter
    When method get
    Then status 200
    And karate.log('Response is : ', response)
    And karate.log('Status : 200')
    And karate.log('Test Completed !')
