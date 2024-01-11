Feature: Tag Advance Search feature for Tag Agent with only View permission

  Background: 
    Given url backOfficeAPIBaseUrl
    And header Accept = 'application/json'
    And path '/galleria/v1'
    
    * def loginResult = callonce read('classpath:com/fnp/api/utils/generate-token.feature') {userType:"tagAgentView"}
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
  #REV2-5799 
  Scenario: GET - Validate Tag Agent with only View permission can perform advance search for Tag with EqualTo operator
   
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

