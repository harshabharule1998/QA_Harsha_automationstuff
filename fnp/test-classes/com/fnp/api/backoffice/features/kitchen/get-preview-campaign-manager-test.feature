Feature: Kitchen Module Preview Campaign GET scenarios with Kitchen Manager

  Background: 
  
    Given url backOfficeAPIBaseUrl
    And header Accept = 'application/json'
    And path '/kitchen/v1/campaigns/preview'
    
    * def loginResult = callonce read('classpath:com/fnp/api/utils/generate-token.feature') {userType:'kitchenManager'}
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
    

  Scenario: GET - Verify Kitchen Manager to get preview campaign with valid data		
    
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


  Scenario: GET - Verify Kitchen Manager to get preview campaign with invalid data		
    
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
    
	
  Scenario: GET - Verify Kitchen Manager to get preview campaign with blank data		
    
    Given param page = " "
    And param size = " "
    And param filter = " "
    When method get
    Then status 400
    And karate.log('Response is : ', response)
    And karate.log('Status : 400')
    And karate.log('Test Completed !')
    
	
  Scenario: GET - Verify Kitchen Manager to get preview campaign with valid page param and valid filter	
    
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
    
	
  Scenario: GET - Verify Kitchen Manager to get preview campaign with invalid page param and valid filter	
    
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
    
	
  Scenario: GET - Verify Kitchen Manager to get preview campaign with blank page param and valid filter	
    
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
    

  Scenario: GET - Verify Kitchen Manager to get preview campaign with valid size param and valid filter	
    
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
    

  Scenario: GET - Verify Kitchen Manager to get preview campaign with invalid size param and valid filter	
    
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
    

  Scenario: GET - Verify Kitchen Manager to get preview campaign with blank size param and valid filter	
    
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
