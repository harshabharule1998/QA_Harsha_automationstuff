Feature: Category Advance Search feature for Category Manager

  Background: 
    Given url backOfficeAPIBaseUrl
    And header Accept = 'application/json'
    And path '/galleria/v1'
    
    * def loginResult = callonce read('classpath:com/fnp/api/utils/generate-token.feature') {userType:"categoryManagerQA"}
    * def authToken = loginResult.accessToken
    * configure readTimeout = 50000
    * header Authorization = authToken
    
    * def encode =
 		"""
 			function(jsonRequest) {
   			var encodedText = encodeURIComponent(jsonRequest).replace(/'/g,"%27").replace(/"/g,"%22");   		
   			return encodedText;
   		}
 		"""

 	@Regression
  Scenario: GET - Validate Category Manager can perform advance search for Category with EqualTo operator
   	
   	* def requestPayload = read('classpath:com/fnp/api/backoffice/data/category-search.json')
    * karate.log(requestPayload)
    
    # convert json to string
    * string searchRequestString = requestPayload
    * def encodedText = encode(searchRequestString)
    
    And karate.log('encodedText : ' + encodedText)
      
    Given path '/categories'
    And param page = 0
    And param size = 10
    And param sortParam = 'categoryName:asc'
    And param filter = encodedText
    
    When method get
    Then status 200
    And karate.log('Status : 200')
    And match response.data[0].categoryName == requestPayload[0].fieldValue
    And match response.data[0].categoryType == requestPayload[1].fieldValue
    And match response.data[0].categoryUrl == requestPayload[2].fieldValue
    And karate.log('Test Completed !')

 	@Regression
  Scenario: GET - Validate Category Manager can perform advance search for Category with NotEqualTo operator
   
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/category-search.json')
    
    * eval requestPayload[0].operatorName = "NotEqualTo"
    * eval requestPayload[1].operatorName = "NotEqualTo"
    * eval requestPayload[2].operatorName = "NotEqualTo"
    
    * karate.log(requestPayload)
    
    # convert json to string
    * string searchRequestString = requestPayload
    * def encodedText = encode(searchRequestString)
    
    And karate.log('encodedText : ' + encodedText)
      
    Given path '/categories'
    And param page = 0
    And param size = 10
    And param sortParam = 'categoryName:asc'
    And param filter = encodedText
    
    When method get
    Then status 200
    And karate.log('Status : 200')
    
    And match each response.data[*].categoryName != requestPayload[0].fieldValue
    And match each response.data[*].categoryType != requestPayload[1].fieldValue
    And match each response.data[*].categoryUrl != requestPayload[2].fieldValue
    And karate.log('Test Completed !')

 	@Regression
  Scenario: GET - Validate Category Manager can perform advance search for Category with Like operator
   
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/category-search.json')
    
    * eval requestPayload[0].fieldValue = "Cake"
    * eval requestPayload[0].operatorName = "Like"
    
    * eval requestPayload[1].fieldValue = "MIXMATCH_CATEGORY"
    * eval requestPayload[1].operatorName = "Like"
    
    * eval requestPayload[2].fieldValue = "gift"
    * eval requestPayload[2].operatorName = "Like"
    

    * karate.log(requestPayload)
    
    # convert json to string
    * string searchRequestString = requestPayload
    * def encodedText = encode(searchRequestString)
    
    And karate.log('encodedText : ' + encodedText)
      
    Given path '/categories'
    And param page = 0
    And param size = 10
    And param sortParam = 'categoryName:asc'
    And param filter = encodedText
    
    When method get
    Then status 200
    And karate.log('Status : 200')
    And match each response.data[*].categoryName == "#regex (?i).*" + requestPayload[0].fieldValue + ".*"
    And match each response.data[*].categoryType contains requestPayload[1].fieldValue
    And match each response.data[*].categoryUrl contains requestPayload[2].fieldValue
    And karate.log('Test Completed !')

 	@Regression
  Scenario: GET - Validate Category Manager can perform advance search for Category with NotLike operator
   
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/category-search.json')
    
    * eval requestPayload[0].fieldValue = "Cake"
    * eval requestPayload[0].operatorName = "NotLike"
    
    * eval requestPayload[1].fieldValue = "MIXMATCH_CATEGORY"
    * eval requestPayload[1].operatorName = "NotLike"
    
    * eval requestPayload[2].fieldValue = "gift"
    * eval requestPayload[2].operatorName = "NotLike"
    
    * karate.log(requestPayload)
       
    # convert json to string
    * string searchRequestString = requestPayload
    * def encodedText = encode(searchRequestString)
    
    And karate.log('encodedText : ' + encodedText)
      
    Given path '/categories'
    And param page = 0
    And param size = 10
    And param sortParam = 'categoryName:asc'
    And param filter = encodedText
    
    When method get
    Then status 200
    And karate.log('Status : 200')
    And match each response.data[*].categoryName !contains requestPayload[0].fieldValue
    And match each response.data[*].categoryType !contains requestPayload[1].fieldValue
    And match each response.data[*].categoryUrl !contains requestPayload[2].fieldValue
    And karate.log('Test Completed !')
 
  @Regression
  Scenario: GET - Validate Category Manager can perform advance search for Category with In operator
   
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/category-search.json')
    
    * eval requestPayload[0].fieldValue = ["Send Christmas Gifts to Malaysia"]
    * eval requestPayload[0].operatorName = "In"
    
    * eval requestPayload[1].fieldValue = ["MIXMATCH_CATEGORY"]
    * eval requestPayload[1].operatorName = "In"
    
    * eval requestPayload[2].fieldValue = ["fnp.com/malaysia/gifts/christmas"]
    * eval requestPayload[2].operatorName = "In"
    
    * karate.log(requestPayload)
       
		# convert json to string
    * string searchRequestString = requestPayload
    * def encodedText = encode(searchRequestString)
    
    And karate.log('encodedText : ' + encodedText)
      
    Given path '/categories'
    And param page = 0
    And param size = 10
    And param sortParam = 'categoryName:asc'    
    And param filter = encodedText
    
    When method get
    Then status 200
    And karate.log('Status : 200')
    And match each response.data[*].categoryName == requestPayload[0].fieldValue[0]
    And match each response.data[*].categoryType == requestPayload[1].fieldValue[0]
    And match each response.data[*].categoryUrl == requestPayload[2].fieldValue[0]
    And karate.log('Test Completed !')
    
 	@Regression
  Scenario: GET - Validate Category Manager can perform advance search for Category with NotIn operator
   
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/category-search.json')
    
    * eval requestPayload[0].fieldValue = ["Cake"]
    * eval requestPayload[0].operatorName = "NotIn"
    
    * eval requestPayload[1].fieldValue = ["MIXMATCH_CATEGORY"]
    * eval requestPayload[1].operatorName = "NotIn"
    
    * eval requestPayload[2].fieldValue = ["gift"]
    * eval requestPayload[2].operatorName = "NotIn"
    
    * karate.log(requestPayload)
      
    # convert json to string
    * string searchRequestString = requestPayload
    * def encodedText = encode(searchRequestString)
    
    And karate.log('encodedText : ' + encodedText)
      
    Given path '/categories'
    And param page = 0
    And param size = 10
    And param sortParam = 'categoryName:asc'
    And param filter = encodedText
    
    When method get
    Then status 200
    And karate.log('Status : 200')
    And match each response.data[*].categoryName != requestPayload[0].fieldValue[0]
    And match each response.data[*].categoryType != requestPayload[1].fieldValue[0]
    And match each response.data[*].categoryUrl != requestPayload[2].fieldValue[0]
    And karate.log('Test Completed !')

 	
  Scenario: GET - Validate Category Manager cannot perform advance search for Category with only optional parameters
   
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/category-search.json')
    
    * eval requestPayload[0].fieldValue = ""
    * eval requestPayload[0].operatorName = ""
    
    * eval requestPayload[1].fieldValue = ""
    * eval requestPayload[1].operatorName = ""
    
    * eval requestPayload[2].fieldValue = ""
    * eval requestPayload[2].operatorName = ""
    
    * karate.log(requestPayload)
       
    # convert json to string
    * string searchRequestString = requestPayload
    * def encodedText = encode(searchRequestString)
    
    And karate.log('encodedText : ' + encodedText)
      
    Given path '/categories'
    And param page = 0
    And param size = 10
    And param sortParam = 'categoryName:asc'
    And param filter = encodedText
    
    When method get
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message contains "Enter valid search operator for categoryName"
    And karate.log('Test Completed !')

 
  Scenario: GET - Validate Category Manager cannot perform advance search for Category with all blank parameters
   
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/category-search.json')
    
    * eval requestPayload[0].fieldName = ""
    * eval requestPayload[0].fieldValue = ""
    * eval requestPayload[0].operatorName = ""
    
    * eval requestPayload[1].fieldName = ""
    * eval requestPayload[1].fieldValue = ""
    * eval requestPayload[1].operatorName = ""
    
    * eval requestPayload[2].fieldName = ""
    * eval requestPayload[2].fieldValue = ""
    * eval requestPayload[2].operatorName = ""
    * karate.log(requestPayload)
       
    # convert json to string
    * string searchRequestString = requestPayload
    * def encodedText = encode(searchRequestString)
    
    And karate.log('encodedText : ' + encodedText)
      
    Given path '/categories'
    And param page = 0
    And param size = 10
    And param sortParam = 'categoryName:asc'
    And param filter = encodedText
    
    When method get
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message contains "Enter unique search field names"
    And karate.log('Test Completed !')    
    
 
  Scenario: GET - Validate Category Manager cannot perform advance search for Category with all invalid values in parameters
   
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/category-search.json')
    
    * eval requestPayload[0].fieldValue = "$@!*(#"
    * eval requestPayload[0].operatorName = "12345"
    
    * eval requestPayload[1].fieldValue = "$@!*(#"
    * eval requestPayload[1].operatorName = "12345"
    
    * eval requestPayload[2].fieldValue = "$@!*(#"
    * eval requestPayload[2].operatorName = "12345"
    
    * karate.log(requestPayload)
       
    # convert json to string
    * string searchRequestString = requestPayload
    * def encodedText = encode(searchRequestString)
    
    And karate.log('encodedText : ' + encodedText)
      
    Given path '/categories'
    And param page = 0
    And param size = 10
    And param sortParam = 'categoryName:asc'
    And param filter = encodedText
    
    When method get
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message contains "Enter valid search operator for categoryName"
    And karate.log('Test Completed !')
    

	Scenario: GET - Validate Category Manager can perform advance search for Category having spacing in parameter values
   
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/category-search.json')
    
    * eval fieldValue = requestPayload[0].fieldValue
    * eval requestPayload[0].fieldValue = " " + fieldValue + " "
    
    * eval fieldValue = requestPayload[1].fieldValue
    * eval requestPayload[1].fieldValue = " " + fieldValue + " "
    
    * eval fieldValue = requestPayload[2].fieldValue
    * eval requestPayload[2].fieldValue = " " + fieldValue + " "
    
    * karate.log(requestPayload)
    
    # convert json to string
    * string searchRequestString = requestPayload
    * def encodedText = encode(searchRequestString)
    
    And karate.log('encodedText : ' + encodedText)
      
    Given path '/categories'
    And param page = 0
    And param size = 10
    And param sortParam = 'categoryName:asc'
    And param filter = encodedText
    
    When method get
    Then status 200
    And karate.log('Status : 200')
    And match response.data == []
    And karate.log('Test Completed !')   

  
	Scenario: GET - Validate Category Manager can perform advance search for Category with EqualTo and NotEqualTo operators
   
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/category-search.json')
    
    * eval requestPayload[0].fieldValue = "Send Christmas Gifts to Malaysia"
    * eval requestPayload[0].operatorName = "EqualTo"
    
    * eval requestPayload[1].fieldValue = "Promotional"
    * eval requestPayload[1].operatorName = "NotEqualTo"
    
    * karate.log(requestPayload)
       
    # convert json to string
    * string searchRequestString = requestPayload
    * def encodedText = encode(searchRequestString)
    
    And karate.log('encodedText : ' + encodedText)
      
    Given path '/categories'
    And param page = 0
    And param size = 10
    And param sortParam = 'categoryName:asc'
    And param filter = encodedText
    
    When method get
    Then status 200
    And karate.log('Status : 200')
    And match each response.data[*].categoryName == requestPayload[0].fieldValue
    And match each response.data[*].categoryType != requestPayload[1].fieldValue
    And karate.log('Test Completed !')
    
    
	   
	Scenario: GET - Validate Category Manager can perform advance search for Category with EqualTo and Like operators
   
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/category-search.json')
    
    * eval requestPayload[0].fieldValue = "Send Christmas Gifts to Malaysia"
    * eval requestPayload[0].operatorName = "EqualTo"
    
    * eval requestPayload[1].fieldValue = "MIXMATCH_CATEGORY"
    * eval requestPayload[1].operatorName = "Like"
    
    * karate.log(requestPayload)
       
    # convert json to string
    * string searchRequestString = requestPayload
    * def encodedText = encode(searchRequestString)
    
    And karate.log('encodedText : ' + encodedText)
      
    Given path '/categories'
    And param page = 0
    And param size = 10
    And param sortParam = 'categoryName:asc'
    And param filter = encodedText
    
    When method get
    Then status 200
    And karate.log('Status : 200')
    And match each response.data[*].categoryName == requestPayload[0].fieldValue
    And match each response.data[*].categoryType contains requestPayload[1].fieldValue
    And karate.log('Test Completed !')
      
	Scenario: GET - Validate Category Manager can perform advance search for Category with EqualTo and NotLike operators
   
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/category-search.json')
    
    * eval requestPayload[0].fieldValue = "Send Christmas Gifts to Malaysia"
    * eval requestPayload[0].operatorName = "EqualTo"
    
    * eval requestPayload[1].fieldValue = "Promotional"
    * eval requestPayload[1].operatorName = "NotLike"
    
    * karate.log(requestPayload)
       
    # convert json to string
    * string searchRequestString = requestPayload
    * def encodedText = encode(searchRequestString)
    
    And karate.log('encodedText : ' + encodedText)
      
    Given path '/categories'
    And param page = 0
    And param size = 10
    And param sortParam = 'categoryName:asc'
    And param filter = encodedText
    
    When method get
    Then status 200
    And karate.log('Status : 200')
    And match each response.data[*].categoryName == requestPayload[0].fieldValue
    And match each response.data[*].categoryType !contains requestPayload[1].fieldValue
    And karate.log('Test Completed !')
    

	Scenario: GET - Validate Category Manager can perform advance search for Category with EqualTo and In operators
   
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/category-search.json')
    
    * eval requestPayload[0].fieldValue = "Send Christmas Gifts to Malaysia"
    * eval requestPayload[0].operatorName = "EqualTo"
    
    * eval requestPayload[1].fieldValue = ["MIXMATCH_CATEGORY"]
    * eval requestPayload[1].operatorName = "In"
    
    * karate.log(requestPayload)
       
    # convert json to string
    * string searchRequestString = requestPayload
    * def encodedText = encode(searchRequestString)
    
    And karate.log('encodedText : ' + encodedText)
      
    Given path '/categories'
    And param page = 0
    And param size = 10
    And param sortParam = 'categoryName:asc'
    And param filter = encodedText
    
    When method get
    Then status 200
    And karate.log('Status : 200')
    And match each response.data[*].categoryName == requestPayload[0].fieldValue
    And match each response.data[*].categoryType == requestPayload[1].fieldValue[0]
    And karate.log('Test Completed !')
       
       
	Scenario: GET - Validate Category Manager can perform advance search for Category with EqualTo and NotIn operators
   
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/category-search.json')
    
    * eval requestPayload[0].fieldValue = "Send Christmas Gifts to Malaysia"
    * eval requestPayload[0].operatorName = "EqualTo"
    
    * eval requestPayload[1].fieldValue = ["Promotional"]
    * eval requestPayload[1].operatorName = "NotIn"
    
    * karate.log(requestPayload)
       
    # convert json to string
    * string searchRequestString = requestPayload
    * def encodedText = encode(searchRequestString)
    
    And karate.log('encodedText : ' + encodedText)
      
    Given path '/categories'
    And param page = 0
    And param size = 10
    And param sortParam = 'categoryName:asc'
    And param filter = encodedText
    
    When method get
    Then status 200
    And karate.log('Status : 200')
    And match each response.data[*].categoryName == requestPayload[0].fieldValue
    And match each response.data[*].categoryType != requestPayload[1].fieldValue[0]
    And karate.log('Test Completed !')
    
   
	Scenario: GET - Validate Category Manager can perform advance search for Category with Like and NotLike operators
   
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/category-search.json')
    
    * eval requestPayload[0].fieldValue = "Christmas"
    * eval requestPayload[0].operatorName = "Like"
    
    * eval requestPayload[1].fieldValue = "Promotional"
    * eval requestPayload[1].operatorName = "NotLike"
    
    * karate.log(requestPayload)
       
    # convert json to string
    * string searchRequestString = requestPayload
    * def encodedText = encode(searchRequestString)
    
    And karate.log('encodedText : ' + encodedText)
      
    Given path '/categories'
    And param page = 0
    And param size = 10
    And param sortParam = 'categoryName:asc'
    And param filter = encodedText
    
    When method get
    Then status 200
    And karate.log('Status : 200')
    And match each response.data[*].categoryName == "#regex (?i).*" + requestPayload[0].fieldValue + ".*"
    And match each response.data[*].categoryType !contains requestPayload[1].fieldValue
    And karate.log('Test Completed !')
    
       
	Scenario: GET - Validate Category Manager can perform advance search for Category with Like and EqualTo operators
   
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/category-search.json')
    
    * eval requestPayload[0].fieldValue = "Christmas"
    * eval requestPayload[0].operatorName = "Like"
    
    * eval requestPayload[1].fieldValue = "MIXMATCH_CATEGORY"
    * eval requestPayload[1].operatorName = "EqualTo"
    
    * karate.log(requestPayload)
       
    # convert json to string
    * string searchRequestString = requestPayload
    * def encodedText = encode(searchRequestString)
    
    And karate.log('encodedText : ' + encodedText)
      
    Given path '/categories'
    And param page = 0
    And param size = 10
    And param sortParam = 'categoryName:asc'
    And param filter = encodedText
    
    When method get
    Then status 200
    And karate.log('Status : 200')
    And match each response.data[*].categoryName contains requestPayload[0].fieldValue
    And match each response.data[*].categoryType == requestPayload[1].fieldValue
    And karate.log('Test Completed !')
  
      
	Scenario: GET - Validate Category Manager can perform advance search for Category with Like and NotEqualTo operators
   
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/category-search.json')
    
    * eval requestPayload[0].fieldValue = "Christmas"
    * eval requestPayload[0].operatorName = "Like"
    
    * eval requestPayload[1].fieldValue = "Promotional"
    * eval requestPayload[1].operatorName = "NotEqualTo"
    
    * karate.log(requestPayload)
       
    # convert json to string
    * string searchRequestString = requestPayload
    * def encodedText = encode(searchRequestString)
    
    And karate.log('encodedText : ' + encodedText)
      
    Given path '/categories'
    And param page = 0
    And param size = 10
    And param sortParam = 'categoryName:asc'
    And param filter = encodedText
    
    When method get
    Then status 200
    And karate.log('Status : 200')
    And match each response.data[*].categoryName contains requestPayload[0].fieldValue
    And match each response.data[*].categoryType != requestPayload[1].fieldValue
    And karate.log('Test Completed !')
    

	Scenario: GET - Validate Category Manager can perform advance search for Category with Like and In operators
   
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/category-search.json')
    
    * eval requestPayload[0].fieldValue = "Christmas"
    * eval requestPayload[0].operatorName = "Like"
    
    * eval requestPayload[1].fieldValue = ["MIXMATCH_CATEGORY"]
    * eval requestPayload[1].operatorName = "In"
    
    * karate.log(requestPayload)
       
    # convert json to string
    * string searchRequestString = requestPayload
    * def encodedText = encode(searchRequestString)
    
    And karate.log('encodedText : ' + encodedText)
      
    Given path '/categories'
    And param page = 0
    And param size = 10
    And param sortParam = 'categoryName:asc'
    And param filter = encodedText
    
    When method get
    Then status 200
    And karate.log('Status : 200')
    And match each response.data[*].categoryName contains requestPayload[0].fieldValue
    And match each response.data[*].categoryType == requestPayload[1].fieldValue[0]
    And karate.log('Test Completed !')
       
       
	Scenario: GET - Validate Category Manager can perform advance search for Category with Like and NotIn operators
   
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/category-search.json')
    
    * eval requestPayload[0].fieldValue = "Christmas"
    * eval requestPayload[0].operatorName = "Like"
    
    * eval requestPayload[1].fieldValue = ["Promotional"]
    * eval requestPayload[1].operatorName = "NotIn"
    
    * karate.log(requestPayload)
       
    # convert json to string
    * string searchRequestString = requestPayload
    * def encodedText = encode(searchRequestString)
    
    And karate.log('encodedText : ' + encodedText)
      
    Given path '/categories'
    And param page = 0
    And param size = 10
    And param sortParam = 'categoryName:asc'
    And param filter = encodedText
    
    When method get
    Then status 200
    And karate.log('Status : 200')
    And match each response.data[*].categoryName contains requestPayload[0].fieldValue
    And match each response.data[*].categoryType != requestPayload[1].fieldValue[0]
    And karate.log('Test Completed !')
    
    
	Scenario: GET - Validate Category Manager can perform advance search for Category with In and NotIn operators
   
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/category-search.json')
    
    * eval requestPayload[0].fieldValue = ["Send Christmas Gifts to Malaysia"]
    * eval requestPayload[0].operatorName = "In"
    
    * eval requestPayload[1].fieldValue = ["Promotional"]
    * eval requestPayload[1].operatorName = "NotIn"
    
    * karate.log(requestPayload)
       
    # convert json to string
    * string searchRequestString = requestPayload
    * def encodedText = encode(searchRequestString)
    
    And karate.log('encodedText : ' + encodedText)
      
    Given path '/categories'
    And param page = 0
    And param size = 10
    And param sortParam = 'categoryName:asc'
    And param filter = encodedText
    
    When method get
    Then status 200
    And karate.log('Status : 200')
    And match each response.data[*].categoryName == requestPayload[0].fieldValue[0]
    And match each response.data[*].categoryType != requestPayload[1].fieldValue[0]
    And karate.log('Test Completed !')
    
       
	Scenario: GET - Validate Category Manager can perform advance search for Category with In and EqualTo operators
   
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/category-search.json')
    
    * eval requestPayload[0].fieldValue = ["Send Christmas Gifts to Malaysia"]
    * eval requestPayload[0].operatorName = "In"
    
    * eval requestPayload[1].fieldValue = "MIXMATCH_CATEGORY"
    * eval requestPayload[1].operatorName = "EqualTo"
    
    * karate.log(requestPayload)
       
    # convert json to string
    * string searchRequestString = requestPayload
    * def encodedText = encode(searchRequestString)
    
    And karate.log('encodedText : ' + encodedText)
      
    Given path '/categories'
    And param page = 0
    And param size = 10
    And param sortParam = 'categoryName:asc'
    And param filter = encodedText
    
    When method get
    Then status 200
    And karate.log('Status : 200')
    And match each response.data[*].categoryName == requestPayload[0].fieldValue[0]
    And match each response.data[*].categoryType == requestPayload[1].fieldValue
    And karate.log('Test Completed !')
  
      
	Scenario: GET - Validate Category Manager can perform advance search for Category with In and NotEqualTo operators
   
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/category-search.json')
    
    * eval requestPayload[0].fieldValue = ["Send Christmas Gifts to Malaysia"]
    * eval requestPayload[0].operatorName = "In"
    
    * eval requestPayload[1].fieldValue = "Promotional"
    * eval requestPayload[1].operatorName = "NotEqualTo"
    
    * karate.log(requestPayload)
       
    # convert json to string
    * string searchRequestString = requestPayload
    * def encodedText = encode(searchRequestString)
    
    And karate.log('encodedText : ' + encodedText)
      
    Given path '/categories'
    And param page = 0
    And param size = 10
    And param sortParam = 'categoryName:asc'
    And param filter = encodedText
    
    When method get
    Then status 200
    And karate.log('Status : 200')
    And match each response.data[*].categoryName == requestPayload[0].fieldValue[0]
    And match each response.data[*].categoryType != requestPayload[1].fieldValue
    And karate.log('Test Completed !')
    

	Scenario: GET - Validate Category Manager can perform advance search for Category with In and Like operators
   
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/category-search.json')
    
    * eval requestPayload[0].fieldValue = ["Send Christmas Gifts to Malaysia"]
    * eval requestPayload[0].operatorName = "In"
    
    * eval requestPayload[1].fieldValue = "MIXMATCH_CATEGORY"
    * eval requestPayload[1].operatorName = "Like"
    
    * karate.log(requestPayload)
       
    # convert json to string
    * string searchRequestString = requestPayload
    * def encodedText = encode(searchRequestString)
    
    And karate.log('encodedText : ' + encodedText)
      
    Given path '/categories'
    And param page = 0
    And param size = 10
    And param sortParam = 'categoryName:asc'
    And param filter = encodedText
    
    When method get
    Then status 200
    And karate.log('Status : 200')
    And match each response.data[*].categoryName == requestPayload[0].fieldValue[0]
    And match each response.data[*].categoryType contains requestPayload[1].fieldValue
    And karate.log('Test Completed !')
       
       
	Scenario: GET - Validate Category Manager can perform advance search for Category with In and NotLike operators
   
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/category-search.json')
    
    * eval requestPayload[0].fieldValue = ["Send Christmas Gifts to Malaysia"]
    * eval requestPayload[0].operatorName = "In"
    
    * eval requestPayload[1].fieldValue = "Promotional"
    * eval requestPayload[1].operatorName = "NotLike"
    
    * karate.log(requestPayload)
       
    # convert json to string
    * string searchRequestString = requestPayload
    * def encodedText = encode(searchRequestString)
    
    And karate.log('encodedText : ' + encodedText)
      
    Given path '/categories'
    And param page = 0
    And param size = 10
    And param sortParam = 'categoryName:asc'
    And param filter = encodedText
    
    When method get
    Then status 200
    And karate.log('Status : 200')
    And match each response.data[*].categoryName == requestPayload[0].fieldValue[0]
    And match each response.data[*].categoryType !contains requestPayload[1].fieldValue
    And karate.log('Test Completed !')
    
  
	Scenario: GET - Validate Category Manager can perform advance search for Category with NotEqualTo and EqualTo operators
   
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/category-search.json')
    
    * eval requestPayload[0].fieldValue = "Base18"
    * eval requestPayload[0].operatorName = "NotEqualTo"
    
    * eval requestPayload[1].fieldValue = "MIXMATCH_CATEGORY"
    * eval requestPayload[1].operatorName = "EqualTo"
    
    * karate.log(requestPayload)
       
    # convert json to string
    * string searchRequestString = requestPayload
    * def encodedText = encode(searchRequestString)
    
    And karate.log('encodedText : ' + encodedText)
      
    Given path '/categories'
    And param page = 0
    And param size = 10
    And param sortParam = 'categoryName:asc'
    And param filter = encodedText
    
    When method get
    Then status 200
    And karate.log('Status : 200')
    And match each response.data[*].categoryName != requestPayload[0].fieldValue
    And match each response.data[*].categoryType == requestPayload[1].fieldValue
    And karate.log('Test Completed !')

    
	Scenario: GET - Validate Category Manager can perform advance search for Category with NotEqualTo and Like operators
   
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/category-search.json')
    
    * eval requestPayload[0].fieldValue = "Base18"
    * eval requestPayload[0].operatorName = "NotEqualTo"
    
    * eval requestPayload[1].fieldValue = "MIXMATCH_CATEGORY"
    * eval requestPayload[1].operatorName = "Like"
    
    * karate.log(requestPayload)
       
    # convert json to string
    * string searchRequestString = requestPayload
    * def encodedText = encode(searchRequestString)
    
    And karate.log('encodedText : ' + encodedText)
      
    Given path '/categories'
    And param page = 0
    And param size = 10
    And param sortParam = 'categoryName:asc'
    And param filter = encodedText
    
    When method get
    Then status 200
    And karate.log('Status : 200')
    And match each response.data[*].categoryName != requestPayload[0].fieldValue
    And match each response.data[*].categoryType contains requestPayload[1].fieldValue
    And karate.log('Test Completed !')
    
      
	Scenario: GET - Validate Category Manager can perform advance search for Category with NotEqualTo and NotLike operators
   
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/category-search.json')
    
    * eval requestPayload[0].fieldValue = "Base18"
    * eval requestPayload[0].operatorName = "NotEqualTo"
    
    * eval requestPayload[1].fieldValue = "Promotional"
    * eval requestPayload[1].operatorName = "NotLike"
    
    * karate.log(requestPayload)
       
    # convert json to string
    * string searchRequestString = requestPayload
    * def encodedText = encode(searchRequestString)
    
    And karate.log('encodedText : ' + encodedText)
      
    Given path '/categories'
    And param page = 0
    And param size = 10
    And param sortParam = 'categoryName:asc'
    And param filter = encodedText
    
    When method get
    Then status 200
    And karate.log('Status : 200')
    And match each response.data[*].categoryName != requestPayload[0].fieldValue
    And match each response.data[*].categoryType !contains requestPayload[1].fieldValue
    And karate.log('Test Completed !')
    

	Scenario: GET - Validate Category Manager can perform advance search for Category with NotEqualTo and In operators
   
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/category-search.json')
    
    * eval requestPayload[0].fieldValue = "Base18"
    * eval requestPayload[0].operatorName = "NotEqualTo"
    
    * eval requestPayload[1].fieldValue = ["MIXMATCH_CATEGORY"]
    * eval requestPayload[1].operatorName = "In"
    
    * karate.log(requestPayload)
       
    # convert json to string
    * string searchRequestString = requestPayload
    * def encodedText = encode(searchRequestString)
    
    And karate.log('encodedText : ' + encodedText)
      
    Given path '/categories'
    And param page = 0
    And param size = 10
    And param sortParam = 'categoryName:asc'
    And param filter = encodedText
    
    When method get
    Then status 200
    And karate.log('Status : 200')
    And match each response.data[*].categoryName != requestPayload[0].fieldValue
    And match each response.data[*].categoryType == requestPayload[1].fieldValue[0]
    And karate.log('Test Completed !')
    
  
	Scenario: GET - Validate Category Manager can perform advance search for Category with NotEqualTo and NotIn operators
   
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/category-search.json')
    
    * eval requestPayload[0].fieldValue = "Base18"
    * eval requestPayload[0].operatorName = "NotEqualTo"
    
    * eval requestPayload[1].fieldValue = ["Promotional"]
    * eval requestPayload[1].operatorName = "NotIn"
    
    * karate.log(requestPayload)
       
    # convert json to string
    * string searchRequestString = requestPayload
    * def encodedText = encode(searchRequestString)
    
    And karate.log('encodedText : ' + encodedText)
      
    Given path '/categories'
    And param page = 0
    And param size = 10
    And param sortParam = 'categoryName:asc'
    And param filter = encodedText
    
    When method get
    Then status 200
    And karate.log('Status : 200')
    And match each response.data[*].categoryName != requestPayload[0].fieldValue
    And match each response.data[*].categoryType != requestPayload[1].fieldValue[0]
    And karate.log('Test Completed !')
    
    
	Scenario: GET - Validate Category Manager can perform advance search for Category with NotLike and Like operators
   
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/category-search.json')
    
    * eval requestPayload[0].fieldValue = "Base"
    * eval requestPayload[0].operatorName = "NotLike"
    
    * eval requestPayload[1].fieldValue = "MIXMATCH_CATEGORY"
    * eval requestPayload[1].operatorName = "Like"
    
    * karate.log(requestPayload)
       
    # convert json to string
    * string searchRequestString = requestPayload
    * def encodedText = encode(searchRequestString)
    
    And karate.log('encodedText : ' + encodedText)
      
    Given path '/categories'
    And param page = 0
    And param size = 10
    And param sortParam = 'categoryName:asc'
    And param filter = encodedText
    
    When method get
    Then status 200
    And karate.log('Status : 200')
    And match each response.data[*].categoryName !contains requestPayload[0].fieldValue
    And match each response.data[*].categoryType contains requestPayload[1].fieldValue
    And karate.log('Test Completed !')

    
	Scenario: GET - Validate Category Manager can perform advance search for Category with NotLike and EqualTo operators
   
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/category-search.json')
    
    * eval requestPayload[0].fieldValue = "Base"
    * eval requestPayload[0].operatorName = "NotLike"
    
    * eval requestPayload[1].fieldValue = "MIXMATCH_CATEGORY"
    * eval requestPayload[1].operatorName = "EqualTo"
    
    * karate.log(requestPayload)
       
    # convert json to string
    * string searchRequestString = requestPayload
    * def encodedText = encode(searchRequestString)
    
    And karate.log('encodedText : ' + encodedText)
      
    Given path '/categories'
    And param page = 0
    And param size = 10
    And param sortParam = 'categoryName:asc'
    And param filter = encodedText
    
    When method get
    Then status 200
    And karate.log('Status : 200')
    And match each response.data[*].categoryName !contains requestPayload[0].fieldValue
    And match each response.data[*].categoryType == requestPayload[1].fieldValue
    And karate.log('Test Completed !')
    
      
	Scenario: GET - Validate Category Manager can perform advance search for Category with NotLike and NotEqualTo operators
   
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/category-search.json')
    
    * eval requestPayload[0].fieldValue = "Base"
    * eval requestPayload[0].operatorName = "NotLike"
    
    * eval requestPayload[1].fieldValue = "Promotional"
    * eval requestPayload[1].operatorName = "NotEqualTo"
    
    * karate.log(requestPayload)
       
    # convert json to string
    * string searchRequestString = requestPayload
    * def encodedText = encode(searchRequestString)
    
    And karate.log('encodedText : ' + encodedText)
      
    Given path '/categories'
    And param page = 0
    And param size = 10
    And param sortParam = 'categoryName:asc'
    And param filter = encodedText
    
    When method get
    Then status 200
    And karate.log('Status : 200')
    And match each response.data[*].categoryName !contains requestPayload[0].fieldValue
    And match each response.data[*].categoryType != requestPayload[1].fieldValue
    And karate.log('Test Completed !')
    
	    
	Scenario: GET - Validate Category Manager can perform advance search for Category with NotLike and In operators
   
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/category-search.json')
    
    * eval requestPayload[0].fieldValue = "Base"
    * eval requestPayload[0].operatorName = "NotLike"
    
    * eval requestPayload[1].fieldValue = ["MIXMATCH_CATEGORY"]
    * eval requestPayload[1].operatorName = "In"
    
    * karate.log(requestPayload)
       
    # convert json to string
    * string searchRequestString = requestPayload
    * def encodedText = encode(searchRequestString)
    
    And karate.log('encodedText : ' + encodedText)
      
    Given path '/categories'
    And param page = 0
    And param size = 10
    And param sortParam = 'categoryName:asc'
    And param filter = encodedText
    
    When method get
    Then status 200
    And karate.log('Status : 200')
    And match each response.data[*].categoryName !contains requestPayload[0].fieldValue
    And match each response.data[*].categoryType == requestPayload[1].fieldValue[0]
    And karate.log('Test Completed !')
    
      
	Scenario: GET - Validate Category Manager can perform advance search for Category with NotLike and NotIn operators
   
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/category-search.json')
    
    * eval requestPayload[0].fieldValue = "Base"
    * eval requestPayload[0].operatorName = "NotLike"
    
    * eval requestPayload[1].fieldValue = ["Promotional"]
    * eval requestPayload[1].operatorName = "NotIn"
    
    * karate.log(requestPayload)
       
    # convert json to string
    * string searchRequestString = requestPayload
    * def encodedText = encode(searchRequestString)
    
    And karate.log('encodedText : ' + encodedText)
      
    Given path '/categories'
    And param page = 0
    And param size = 10
    And param sortParam = 'categoryName:asc'
    And param filter = encodedText
    
    When method get
    Then status 200
    And karate.log('Status : 200')
    And match each response.data[*].categoryName !contains requestPayload[0].fieldValue
    And match each response.data[*].categoryType != requestPayload[1].fieldValue[0]
    And karate.log('Test Completed !')
    
    
	Scenario: GET - Validate Category Manager can perform advance search for Category with NotIn and In operators
   
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/category-search.json')
    
    * eval requestPayload[0].fieldValue = ["Base18"]
    * eval requestPayload[0].operatorName = "NotIn"
    
    * eval requestPayload[1].fieldValue = ["MIXMATCH_CATEGORY"]
    * eval requestPayload[1].operatorName = "In"
    
    * karate.log(requestPayload)
       
    # convert json to string
    * string searchRequestString = requestPayload
    * def encodedText = encode(searchRequestString)
    
    And karate.log('encodedText : ' + encodedText)
      
    Given path '/categories'
    And param page = 0
    And param size = 10
    And param sortParam = 'categoryName:asc'
    And param filter = encodedText
    
    When method get
    Then status 200
    And karate.log('Status : 200')
    And match each response.data[*].categoryName != requestPayload[0].fieldValue[0]
    And match each response.data[*].categoryType == requestPayload[1].fieldValue[0]
    And karate.log('Test Completed !')
    
    
	
	Scenario: GET - Validate Category Manager can perform advance search for Category with NotIn and EqualTo operators
   
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/category-search.json')
    
    * eval requestPayload[0].fieldValue = ["Base18"]
    * eval requestPayload[0].operatorName = "NotIn"
    
    * eval requestPayload[1].fieldValue = "MIXMATCH_CATEGORY"
    * eval requestPayload[1].operatorName = "EqualTo"
    
    * karate.log(requestPayload)
       
    # convert json to string
    * string searchRequestString = requestPayload
    * def encodedText = encode(searchRequestString)
    
    And karate.log('encodedText : ' + encodedText)
      
    Given path '/categories'
    And param page = 0
    And param size = 10
    And param sortParam = 'categoryName:asc'
    And param filter = encodedText
    
    When method get
    Then status 200
    And karate.log('Status : 200')
    And match each response.data[*].categoryName != requestPayload[0].fieldValue[0]
    And match each response.data[*].categoryType == requestPayload[1].fieldValue
    And karate.log('Test Completed !')
    
        
	Scenario: GET - Validate Category Manager can perform advance search for Category with NotIn and NotEqualTo operators
   
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/category-search.json')
    
    * eval requestPayload[0].fieldValue = ["Base18"]
    * eval requestPayload[0].operatorName = "NotIn"
    
    * eval requestPayload[1].fieldValue = "Promotional"
    * eval requestPayload[1].operatorName = "NotEqualTo"
    
    * karate.log(requestPayload)
       
    # convert json to string
    * string searchRequestString = requestPayload
    * def encodedText = encode(searchRequestString)
    
    And karate.log('encodedText : ' + encodedText)
      
    Given path '/categories'
    And param page = 0
    And param size = 10
    And param sortParam = 'categoryName:asc'
    And param filter = encodedText
    
    When method get
    Then status 200
    And karate.log('Status : 200')
    And match each response.data[*].categoryName != requestPayload[0].fieldValue[0]
    And match each response.data[*].categoryType != requestPayload[1].fieldValue
    And karate.log('Test Completed !')
    
   
	Scenario: GET - Validate Category Manager can perform advance search for Category with NotIn and Like operators
   
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/category-search.json')
    
    * eval requestPayload[0].fieldValue = ["Base18"]
    * eval requestPayload[0].operatorName = "NotIn"
    
    * eval requestPayload[1].fieldValue = "MIXMATCH_CATEGORY"
    * eval requestPayload[1].operatorName = "Like"
    
    * karate.log(requestPayload)
       
    # convert json to string
    * string searchRequestString = requestPayload
    * def encodedText = encode(searchRequestString)
    
    And karate.log('encodedText : ' + encodedText)
      
    Given path '/categories'
    And param page = 0
    And param size = 10
    And param sortParam = 'categoryName:asc'
    And param filter = encodedText
    
    When method get
    Then status 200
    And karate.log('Status : 200')
    And match each response.data[*].categoryName != requestPayload[0].fieldValue[0]
    And match each response.data[*].categoryType contains requestPayload[1].fieldValue
    And karate.log('Test Completed !')
    
    
	Scenario: GET - Validate Category Manager can perform advance search for Category with NotIn and NotLike operators
   
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/category-search.json')
    
    * eval requestPayload[0].fieldValue = ["Base18"]
    * eval requestPayload[0].operatorName = "NotIn"
    
    * eval requestPayload[1].fieldValue = "Promotional"
    * eval requestPayload[1].operatorName = "NotLike"
    
    * karate.log(requestPayload)
       
    # convert json to string
    * string searchRequestString = requestPayload
    * def encodedText = encode(searchRequestString)
    
    And karate.log('encodedText : ' + encodedText)
      
    Given path '/categories'
    And param page = 0
    And param size = 10
    And param sortParam = 'categoryName:asc'
    And param filter = encodedText
    
    When method get
    Then status 200
    And karate.log('Status : 200')
    And match each response.data[*].categoryName != requestPayload[0].fieldValue[0]
    And match each response.data[*].categoryType !contains requestPayload[1].fieldValue
    And karate.log('Test Completed !')
    