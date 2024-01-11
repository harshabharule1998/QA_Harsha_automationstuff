Feature: Tag Advance Search feature for Tag Agent with Edit and View permission

  Background: 
    Given url backOfficeAPIBaseUrl
    And header Accept = 'application/json'
    And path '/galleria/v1'
    
    * def loginResult = callonce read('classpath:com/fnp/api/utils/generate-token.feature') {userType:"tagAgent"}
    * def authToken = loginResult.accessToken
		
		* header Authorization = authToken
		
		* def encode =
 		"""
 			function(jsonRequest) {
   			var encodedText = encodeURIComponent(jsonRequest).replace(/'/g,"%27").replace(/"/g,"%22");   		
   			return encodedText;
   		}
 		"""
 		
@Regression
  #REV2-5780 
  Scenario: GET - Validate Tag Agent with Edit and View permission can perform advance search for Tag with EqualTo operator
   
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/tag-search.json')
    * karate.log(requestPayload)
    
    # convert json to string
    * string searchRequestString = requestPayload
    * def encodedText = encode(searchRequestString)
    
    And karate.log('encodedText : ' + encodedText)
    
    Given path '/tags'
    And param pageNumber = 0
    And param pageSize = 10
    And param sortDirection = 'ASC'
    And param sortField = 'sequence'
    And param filter = encodedText
    
    When method get
    Then status 200
    And karate.log('Status : 200')
    And match response.data[0].tagId == requestPayload[0].fieldValue
    And match response.data[0].tagName == requestPayload[1].fieldValue
    And karate.log('Test Completed !')


  #REV2-5781 
  Scenario: GET - Validate Tag Agent with Edit and View permission can perform advance search for Tag with NotEqualTo operator
   
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/tag-search.json')
    
    * eval requestPayload[0].operatorName = "NotEqualTo"
    * eval requestPayload[1].operatorName = "NotEqualTo"
    * eval requestPayload[2].operatorName = "NotEqualTo"
    * karate.log(requestPayload)
    
    # convert json to string
    * string searchRequestString = requestPayload
    * def encodedText = encode(searchRequestString)
    
    And karate.log('encodedText : ' + encodedText)
    
    Given path '/tags'
    And param pageNumber = 0
    And param pageSize = 10
    And param sortDirection = 'ASC'
    And param sortField = 'sequence'
    And param filter = encodedText
    
    When method get
    Then status 200
    And karate.log('Status : 200')
    And match each response.data[*].tagId != requestPayload[0].fieldValue
    And match each response.data[*].tagName != requestPayload[1].fieldValue
    And karate.log('Test Completed !')

  @Regression
  #REV2-5782 
  Scenario: GET - Validate Tag Agent with Edit and View permission can perform advance search for Tag with Like operator
   
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/tag-search.json')
    
    * eval requestPayload[0].fieldValue = "test"
    * eval requestPayload[0].operatorName = "Like"
    
    * eval requestPayload[1].fieldValue = "test"
    * eval requestPayload[1].operatorName = "Like"
    
    * eval requestPayload[2].operatorName = "Like"
    
    * karate.log(requestPayload)
    
    # convert json to string
    * string searchRequestString = requestPayload
    * def encodedText = encode(searchRequestString)
    
    And karate.log('encodedText : ' + encodedText)
    
    Given path '/tags'
    And param pageNumber = 0
    And param pageSize = 10
    And param sortDirection = 'ASC'
    And param sortField = 'sequence'  
    And param filter = encodedText
    
    When method get
    Then status 200
    And karate.log('Status : 200')
    And match each response.data[*].tagId == "#regex (?i).*" + requestPayload[0].fieldValue + ".*"
    And match each response.data[*].tagName == "#regex (?i).*" + requestPayload[1].fieldValue + ".*"
    And karate.log('Test Completed !')


  #REV2-5783 
  Scenario: GET - Validate Tag Agent with Edit and View permission can perform advance search for Tag with NotLike operator
   
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/tag-search.json')
    
    * eval requestPayload[0].fieldValue = "test"
    * eval requestPayload[0].operatorName = "NotLike"
    
    * eval requestPayload[1].fieldValue = "test"
    * eval requestPayload[1].operatorName = "NotLike"
    
    * eval requestPayload[2].operatorName = "NotLike"
    
    * karate.log(requestPayload)
       
    # convert json to string
    * string searchRequestString = requestPayload
    * def encodedText = encode(searchRequestString)
    
    And karate.log('encodedText : ' + encodedText)
    
    Given path '/tags'
    And param pageNumber = 0
    And param pageSize = 10
    And param sortDirection = 'ASC'
    And param sortField = 'sequence'   
    And param filter = encodedText
    
    When method get
    Then status 200
    And karate.log('Status : 200')
    And match each response.data[*].tagId !contains requestPayload[0].fieldValue
    And match each response.data[*].tagName !contains requestPayload[1].fieldValue
    And karate.log('Test Completed !')
 

  #REV2-5784 
  Scenario: GET - Validate Tag Agent with Edit and View permission can perform advance search for Tag with In operator
   
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/tag-search.json')
    
    * eval requestPayload[0].fieldValue = ["colombia"]
    * eval requestPayload[0].operatorName = "In"
    
    * eval requestPayload[1].fieldValue = ["colombia"]
    * eval requestPayload[1].operatorName = "In"
    
    * eval requestPayload[2].fieldValue = ["G"]
    * eval requestPayload[2].operatorName = "In"
    
    * karate.log(requestPayload)
    
    # convert json to string
    * string searchRequestString = requestPayload
    * def encodedText = encode(searchRequestString)
    
    And karate.log('encodedText : ' + encodedText)
       
    
    Given path '/tags'
    And param pageNumber = 0
    And param pageSize = 10
    And param sortDirection = 'ASC'
    And param sortField = 'sequence'  
    And param filter = encodedText
    
    When method get
    Then status 200
    And karate.log('Status : 200')
    And match each response.data[*].tagId == "colombia"
    And match each response.data[*].tagName == "colombia"
    And karate.log('Test Completed !')
    

  #REV2-5785 
  Scenario: GET - Validate Tag Agent with Edit and View permission can perform advance search for Tag with NotIn operator
   
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/tag-search.json')
    
    * eval requestPayload[0].fieldValue = ["colombia"]
    * eval requestPayload[0].operatorName = "NotIn"
    
    * eval requestPayload[1].fieldValue = ["colombia"]
    * eval requestPayload[1].operatorName = "NotIn"
    
    * eval requestPayload[2].fieldValue = ["G"]
    * eval requestPayload[2].operatorName = "NotIn"
    
    * karate.log(requestPayload)
       
    # convert json to string
    * string searchRequestString = requestPayload
    * def encodedText = encode(searchRequestString)
    
    And karate.log('encodedText : ' + encodedText)
       
    
    Given path '/tags'
    And param pageNumber = 0
    And param pageSize = 10
    And param sortDirection = 'ASC'
    And param sortField = 'sequence'
    And param filter = encodedText
    
    When method get
    Then status 200
    And karate.log('Status : 200')
    And match each response.data[*].tagId != "colombia"
    And match each response.data[*].tagName != "colombia"
    And karate.log('Test Completed !')


	#REV2-5787 
  Scenario: GET - Validate Tag Agent with Edit and View permission cannot perform advance search for Tag with only optional parameters
   
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/tag-search.json')
    
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
    
    Given path '/tags'
    And param pageNumber = 0
    And param pageSize = 10
    And param sortDirection = 'ASC'
    And param sortField = 'sequence'    
    And param filter = encodedText
    
    When method get
    Then status 400
    And karate.log('Status : 400')
    And assert response.errors[0].message == "Enter valid search operator for tagId"
    And karate.log('Test Completed !')


	#REV2-5788 
  Scenario: GET - Validate Tag Agent with Edit and View permission cannot perform advance search for Tag with all blank parameters
   
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/tag-search.json')
    
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
    
    Given path '/tags'
    And param pageNumber = 0
    And param pageSize = 10
    And param sortDirection = 'ASC'
    And param sortField = 'sequence'  
    And param filter = encodedText
    
    When method get
    Then status 400
    And karate.log('Status : 400')
    And assert response.errors[0].message == "Enter unique search field names"
    And karate.log('Test Completed !')    
    
 
	#REV2-5789 
  Scenario: GET - Validate Tag Agent with Edit and View permission cannot perform advance search for Tag with all invalid values in parameters
   
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/tag-search.json')
    
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
    
    Given path '/tags'
    And param pageNumber = 0
    And param pageSize = 10
    And param sortDirection = 'ASC'
    And param sortField = 'sequence'    
    And param filter = encodedText
    
    When method get
    Then status 400
    And karate.log('Status : 400')
    And assert response.errors[0].message == "Enter valid search operator for tagId"
    And karate.log('Test Completed !')
    

	#REV2-5790
	Scenario: GET - Validate Tag Agent with Edit and View permission can perform advance search for Tag having spacing in parameter values
   
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/tag-search.json')
    
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
    
    Given path '/tags'
    And param pageNumber = 0
    And param pageSize = 10
    And param sortDirection = 'ASC'
    And param sortField = 'sequence'   
    And param filter = encodedText
    
    When method get
    Then status 200
    And karate.log('Status : 200')
    And match response.data == []
    And karate.log('Test Completed !')
   
