Feature: Tag Advance Search feature for Tag Manager

  Background: 
    Given url backOfficeAPIBaseUrl
    And header Accept = 'application/json'
    And path '/galleria/v1'
    
    * def loginResult = callonce read('classpath:com/fnp/api/utils/generate-token.feature') {userType:"tagManager"}
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
  #REV2-5791 
  Scenario: GET - Validate Tag Manager can perform advance search for Tag with EqualTo operator
   
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


  #REV2-5792 
  Scenario: GET - Validate Tag Manager can perform advance search for Tag with NotEqualTo operator
   
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
  #REV2-5793 
  Scenario: GET - Validate Tag Manager can perform advance search for Tag with Like operator
   
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


  #REV2-5794 
  Scenario: GET - Validate Tag Manager can perform advance search for Tag with NotLike operator
   
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
 

  #REV2-5795 
  Scenario: GET - Validate Tag Manager can perform advance search for Tag with In operator
   
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
    

  #REV2-5796 
  Scenario: GET - Validate Tag Manager can perform advance search for Tag with NotIn operator
   
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


	#REV2-5798 
  Scenario: GET - Validate Tag Manager cannot perform advance search for Tag with only optional parameters
   
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


	#REV2-5805
  Scenario: GET - Validate Tag Manager to perform advance search with invalid endpoint parameters
    
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/tag-search.json')
    * karate.log(requestPayload)
    
    # convert json to string
    * string searchRequestString = requestPayload
    * def encodedText = encode(searchRequestString)
    
    And karate.log('encodedText : ' + encodedText)
    
       
    Given path '/tags'
    And param filter1 = encodedText
    
    When method get
    Then status 200
    And karate.log('Status : 200')
    And karate.log('Test Completed !')
    
    
	#REV2-5806
  Scenario: GET - Validate Tag Manager to perform advance search with unsupported method
    
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/tag-search.json')
    * karate.log(requestPayload)
       
    Given path '/tags'
    And param pageNumber = 0
    And param pageSize = 10
    And param sortDirection = 'ASC'
    And param sortField = 'sequence'  
    #And param filter = encodedText
    
    And request requestPayload
    When method patch
    Then status 405
    And karate.log('Status : 405')
    And karate.log('Test Completed !')
    
	
	#REV2-5807
  Scenario: GET - Validate Tag Manager to perform advance search with invalid auth token
    
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/tag-search.json')
    * karate.log(requestPayload)
    
    # convert json to string
    * string searchRequestString = requestPayload
    * def encodedText = encode(searchRequestString)
    
    And karate.log('encodedText : ' + encodedText)
    
    * header Authorization = "eyJraWQiOiJmbnAyIiwiYWxnIjoiUlMyNTYifQ.eyJzdWIiOiIxMCIsImF1ZCI6Imh0dHBzOlwvXC93d3cuZm5wLmNvbSIsInVhbCI6IlNHX0VOVElUWV9BRE0iLCJuYmYiOjE2MTM3MjE3MzcsInVuYW1lIjoiZW50aXR5YWRtaW5AY3li"   
    Given path '/tags'
    And param pageNumber12 = 0
    And param pageSize1 = 10
    And param sortDirection1 = 'ASC'
    And param sortField22 = 'sequence'
    And param filter = encodedText
    
    When method get
    Then status 401
    And karate.log('Status : 401')
    And karate.log('Test Completed !')
    

	#REV2-5808 
  Scenario: GET - Validate sorting implemented for Tag Manager to perform advance search for Tag with Like operator
   	
   	* def ArrayList = Java.type('java.util.ArrayList')
		* def Collections = Java.type('java.util.Collections')
		
		* def sequenceList = new ArrayList()
		* def sequenceSortedList = new ArrayList()
		
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/tag-search.json')
    
    * eval requestPayload[0].fieldValue = "test"
    * eval requestPayload[0].operatorName = "Like"

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
    
    * def records = response.data
    
    * karate.repeat(records.length, function(i){ sequenceList.add(records[i].sequence) })
		* karate.log('sequenceList list : ', sequenceList)
		
		* karate.repeat(records.length, function(i){ sequenceSortedList.add(records[i].sequence) })
		* karate.log('sequenceSortedList before sort : ', sequenceSortedList)
		
		* Collections.sort(sequenceSortedList)
		* karate.log('sequenceSortedList after sort : ', sequenceSortedList)
		
		And match sequenceList == sequenceSortedList   
    And karate.log('Test Completed !')
    

	#REV2-5809 
  Scenario: GET - Validate pagination implemented for Tag Manager to perform advance search for Tag with Like operator
   
    * def requestPayload = 
    """
	    [
				{
			  	"fieldName": "tagId",
			    "fieldValue": "test",
			    "operatorName": "Like"
			  }
			]
		"""
		
		
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
    And assert response.currentPage == 0
    And assert response.totalPages >= 1
    And karate.log('Test Completed !')

