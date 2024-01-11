Feature: Site Config Url Redirect Advance Search Super Admin feature

  Background: 
    Given url backOfficeAPIBaseUrl
    And header Accept = 'application/json'
    And path '/beautyplus/v1/sites'
    * def loginResult = callonce read('classpath:com/fnp/api/utils/generate-token.feature') {userType:"superAdminQA"}
    * def authToken = loginResult.accessToken
    
    * def tagAgentLoginResult = call read('classpath:com/fnp/api/utils/generate-token.feature') {userType:"tagAgentView"}
    * def tagAgentAuthToken = tagAgentLoginResult.accessToken
    
    * def encode =
 		"""
 			function(jsonRequest) {
   			var Base64 = Java.type('java.util.Base64');
  			var encodedText = Base64.getEncoder().encodeToString(jsonRequest.getBytes());		
   			return encodedText;
   		}
 		"""
   
  @Regression
	#REV2-7172 
  Scenario: GET - Validate Super Admin can perform advance search with EqualTo operator
   
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/url-redirect-search.json')
    * karate.log(requestPayload)
    
    # convert json to string
    * string searchRequestString = requestPayload
    * def encodedText = encode(searchRequestString)
    
    And karate.log('encodedText : ' + encodedText)
    
    * header Authorization = authToken
    Given path '/urlRedirect'
    And param page = 0
    And param size = 10
    And param sortParam = 'sourceUrl:asc'
    And param filter = encodedText
    
    When method get
    Then status 200
    And karate.log('Status : 200')
    And match each response.data[*].sourceUrl contains requestPayload[0].fieldValue
    And match each response.data[*].targetUrl contains requestPayload[3].fieldValue
    And match each response.data[*].redirectType contains requestPayload[2].fieldValue
    And karate.log('Test Completed !')
	  
	 
	#REV2-7173
  Scenario: GET - Validate Super Admin can perform advance search with NotEqualTo operator
   
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/url-redirect-search.json')
    
    
    * eval requestPayload[0].operatorName = "NotEqualTo"
    * eval requestPayload[1].operatorName = "NotEqualTo"
    * eval requestPayload[2].operatorName = "NotEqualTo"
    * eval requestPayload[3].operatorName = "NotEqualTo"
    * eval requestPayload[4].operatorName = "NotEqualTo"
    
    * karate.log(requestPayload)
    
    # convert json to string
    * string searchRequestString = requestPayload
    * def encodedText = encode(searchRequestString)
    
    And karate.log('encodedText : ' + encodedText)
    
    * header Authorization = authToken
    Given path '/urlRedirect'
    And param page = 0
    And param size = 10
    And param sortParam = 'sourceUrl:asc'
    And param filter = encodedText
    
    When method get
    Then status 200
    And karate.log('Status : 200')
    And match each response.data[*].sourceUrl != requestPayload[0].fieldValue
    And match each response.data[*].targetUrl != requestPayload[3].fieldValue
    And match each response.data[*].redirectType != requestPayload[2].fieldValue
		And karate.log('Test Completed !')
    
  @Regression  
	#REV2-7174
  Scenario: GET - Validate Super Admin can perform advance search with Like operator
   
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/url-redirect-search.json')
    
    
    * eval requestPayload[0].operatorName = "Like"
    * eval requestPayload[1].operatorName = "Like"
    * eval requestPayload[2].operatorName = "Like"
    * eval requestPayload[3].operatorName = "Like"
    * eval requestPayload[4].operatorName = "Like"
    
    * karate.log(requestPayload)
    
    # convert json to string
    * string searchRequestString = requestPayload
    * def encodedText = encode(searchRequestString)
    
    And karate.log('encodedText : ' + encodedText)
    
    * header Authorization = authToken
    Given path '/urlRedirect'
    And param page = 0
    And param size = 10
    And param sortParam = 'sourceUrl:asc' 
    And param filter = encodedText
    
    When method get
    Then status 200
    And karate.log('Status : 200')
    And match each response.data[*].sourceUrl contains requestPayload[0].fieldValue
    And match each response.data[*].targetUrl contains requestPayload[3].fieldValue
    And match each response.data[*].redirectType contains requestPayload[2].fieldValue
		And karate.log('Test Completed !')
    
    
	#REV2-7175
  Scenario: GET - Validate Super Admin can perform advance search with NotLike operator
   
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/url-redirect-search.json')
    
    * eval requestPayload[0].operatorName = "NotLike"
    * eval requestPayload[1].operatorName = "NotLike"
    * eval requestPayload[2].operatorName = "NotLike"
    * eval requestPayload[3].operatorName = "NotLike"
    * eval requestPayload[4].operatorName = "NotLike"
    
    
    * karate.log(requestPayload)
    
    # convert json to string
    * string searchRequestString = requestPayload
    * def encodedText = encode(searchRequestString)
    
    And karate.log('encodedText : ' + encodedText)
    
    * header Authorization = authToken
    Given path '/urlRedirect'
    And param page = 0
    And param size = 10
    And param sortParam = 'sourceUrl:asc'
    And param filter = encodedText
    
    When method get
    Then status 200
    And karate.log('Status : 200')
    And match each response.data[*].sourceUrl !contains requestPayload[0].fieldValue
    And match each response.data[*].targetUrl !contains requestPayload[3].fieldValue
    And match each response.data[*].redirectType !contains requestPayload[2].fieldValue
    And karate.log('Test Completed !')
    
  @Regression
	#REV2-7176
  Scenario: GET - Validate Super Admin can perform advance search with In operator
   
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/url-redirect-search.json')
    
    * eval requestPayload[0].fieldValue = ["fnp.com"]
    * eval requestPayload[1].fieldValue = ["Product"]
    * eval requestPayload[2].fieldValue = ["302"]
    * eval requestPayload[3].fieldValue = ["fnp.com/gifts"]
    
    * eval requestPayload[0].operatorName = "In"
    * eval requestPayload[1].operatorName = "In"
    * eval requestPayload[2].operatorName = "In"
    * eval requestPayload[3].operatorName = "In"
    
    * karate.log(requestPayload)
    
    # convert json to string
    * string searchRequestString = requestPayload
    * def encodedText = encode(searchRequestString)
    
    And karate.log('encodedText : ' + encodedText)
    
    * header Authorization = authToken
    Given path '/urlRedirect'
    And param page = 0
    And param size = 10
    And param sortParam = 'sourceUrl:asc'
    And param filter = encodedText
    
    When method get
    Then status 200
    And karate.log('Status : 200')
    And match each response.data[*].sourceUrl == "fnp.com"
    And match each response.data[*].targetUrl == "fnp.com/gifts"
    And match each response.data[*].redirectType == "302"
		And karate.log('Test Completed !')
		
		
	#REV2-7177
  Scenario: GET - Validate Super Admin can perform advance search with NotIn operator
   
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/url-redirect-search.json')
    
    * eval requestPayload[0].fieldValue = ["fnp.com"]
    * eval requestPayload[1].fieldValue = ["Product"]
    * eval requestPayload[2].fieldValue = ["302"]
    * eval requestPayload[3].fieldValue = ["fnp.com/gifts"]
    
    * eval requestPayload[0].operatorName = "NotIn"
    * eval requestPayload[1].operatorName = "NotIn"
    * eval requestPayload[2].operatorName = "NotIn"
    * eval requestPayload[3].operatorName = "NotIn"
    
    * karate.log(requestPayload)
    
    # convert json to string
    * string searchRequestString = requestPayload
    * def encodedText = encode(searchRequestString)
    
    And karate.log('encodedText : ' + encodedText)
    
    * header Authorization = authToken
    Given path '/urlRedirect'
    And param page = 0
    And param size = 10
    And param sortParam = 'sourceUrl:asc'  
    And param filter = encodedText
    
    When method get
    Then status 200
    And karate.log('Status : 200')
    And match each response.data[*].sourceUrl != "fnp.com"
    And match each response.data[*].targetUrl != "fnp.com/gifts"
    And match each response.data[*].redirectType != "302"
    And karate.log('Test Completed !')
    
  @Regression
	#REV2-7178
  Scenario: GET - Validate Super Admin can perform advance search with blank values in all parameters
   
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/url-redirect-search.json')
    
    * eval requestPayload[0].fieldName = ""
    * eval requestPayload[1].fieldName = ""
    * eval requestPayload[2].fieldName = ""
    * eval requestPayload[3].fieldName = ""
    * eval requestPayload[4].fieldName = ""
    
    * eval requestPayload[0].fieldValue = ""
    * eval requestPayload[1].fieldValue = ""
    * eval requestPayload[2].fieldValue = ""
    * eval requestPayload[3].fieldValue = ""
    * eval requestPayload[4].fieldValue = ""
    
    * eval requestPayload[0].operatorName = ""
    * eval requestPayload[1].operatorName = ""
    * eval requestPayload[2].operatorName = ""
    * eval requestPayload[3].operatorName = ""
    * eval requestPayload[4].operatorName = ""
    
    * karate.log(requestPayload)
    
    # convert json to string
    * string searchRequestString = requestPayload
    * def encodedText = encode(searchRequestString)
    
    And karate.log('encodedText : ' + encodedText)
    
    * header Authorization = authToken
    Given path '/urlRedirect'
    And param page = 0
    And param size = 10
    And param sortParam = 'sourceUrl:asc'   
    And param filter = encodedText
    
    When method get
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message contains "Enter unique search field names"
    And karate.log('Test Completed !')
    
    
	#REV2-7179
  Scenario: GET - Validate Super Admin can perform advance search with invalid values in all parameters
   
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/url-redirect-search.json')
    
    * eval requestPayload[0].fieldValue = "123"
    * eval requestPayload[1].fieldValue = "123"
    * eval requestPayload[2].fieldValue = "123"
    * eval requestPayload[3].fieldValue = "123"
    * eval requestPayload[4].fieldValue = "123"
    
    * karate.log(requestPayload)
    
    # convert json to string
    * string searchRequestString = requestPayload
    * def encodedText = encode(searchRequestString)
    
    And karate.log('encodedText : ' + encodedText)
    
    * header Authorization = authToken
    Given path '/urlRedirect'
    And param page = 0
    And param size = 10
    And param sortParam = 'sourceUrl:asc'
    And param filter = encodedText
    
    When method get
    Then status 200
    And karate.log('Status : 200')
    And assert response.data.length == 0
    And karate.log('Test Completed !')


	#REV2-7180
  Scenario: GET - Validate Super Admin can perform advance search with values having spaces for some parameters
   
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/url-redirect-search.json')
    
    * eval requestPayload[0].fieldValue = " " + requestPayload[0].fieldValue + " "
    * eval requestPayload[1].fieldValue = " " + requestPayload[1].fieldValue + " "
    * eval requestPayload[2].fieldValue = " " + requestPayload[2].fieldValue + " "
    * eval requestPayload[3].fieldValue = " " + requestPayload[3].fieldValue + " "
    
    * karate.log(requestPayload)
    
    # convert json to string
    * string searchRequestString = requestPayload
    * def encodedText = encode(searchRequestString)
    
    And karate.log('encodedText : ' + encodedText)
    
    * header Authorization = authToken
    Given path '/urlRedirect'
    And param page = 0
    And param size = 10
    And param sortParam = 'sourceUrl:asc'
    And param filter = encodedText
    
    When method get
    Then status 200
    And karate.log('Status : 200')
    And assert response.data.length > 0
    And karate.log('Test Completed !')
    
	@Regression
	#REV2-7181
  Scenario: GET - Validate Tag Agent with only view permission cannot perform advance search with EqualTo operator
   
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/url-redirect-search.json')
    * karate.log(requestPayload)
    
    # convert json to string
    * string searchRequestString = requestPayload
    * def encodedText = encode(searchRequestString)
    
    And karate.log('encodedText : ' + encodedText)
    
    * header Authorization = tagAgentAuthToken
    Given path '/urlRedirect'
    And param page = 0
    And param size = 10
    And param sortParam = 'sourceUrl:asc'
    And param filter = encodedText
    
    When method get
    Then status 403
    And karate.log('Status : 403')
		And karate.log('Test Completed !')
		
	
	#REV2-7182
  Scenario: GET - Validate error code for Super Admin to perform advance search with invalid endpoint
   
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/url-redirect-search.json')
    * karate.log(requestPayload)
    
    # convert json to string
    * string searchRequestString = requestPayload
    * def encodedText = encode(searchRequestString)
    
    And karate.log('encodedText : ' + encodedText)
    
    * header Authorization = authToken
    Given path '/urlRedirect2/advance-search1'
    And param page = 0
    And param size = 10
    And param sortParam = 'sourceUrl:asc'
    And param filter = encodedText
    
    When method get
    Then status 404
    And karate.log('Status : 404')   
		And karate.log('Test Completed !')
		

	#REV2-7183
  Scenario: PATCH - Validate error code for Super Admin to perform advance search with unsupported method
   
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/url-redirect-search.json')
    * karate.log(requestPayload)
    
    # convert json to string
    * string searchRequestString = requestPayload
    * def encodedText = encode(searchRequestString)
    
    And karate.log('encodedText : ' + encodedText)
    
    * header Authorization = authToken
    Given path '/urlRedirect'
    And param page = 0
    And param size = 10
    And param sortParam = 'sourceUrl:asc'  
    And param filter = encodedText
    
    And request requestPayload
    When method patch
    Then status 405
    And karate.log('Status : 405')
 		And karate.log('Test Completed !')
 		

	#REV2-7184
  Scenario: GET - Validate error code to perform advance search with invalid auth token
   
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/url-redirect-search.json')
    * karate.log(requestPayload)
    
    # convert json to string
    * string searchRequestString = requestPayload
    * def encodedText = encode(searchRequestString)
    
    And karate.log('encodedText : ' + encodedText)
    
    * header Authorization = "eyJraWQiOiJmbnAyIiwiYWxnIjoiUlMyNTYifQ"
    Given path '/urlRedirect'
    And param page = 0
    And param size = 10
    And param sortParam = 'sourceUrl:asc' 
    And param filter = encodedText
    
    When method get
    Then status 401
    And karate.log('Status : 401')   
		And karate.log('Test Completed !')
