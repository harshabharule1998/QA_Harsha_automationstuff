Feature: Tag Simple Search feature for Tag Manager

  Background: 
    Given url backOfficeAPIBaseUrl
    And header Accept = 'application/json'
    And path '/galleria/v1'
    
    * def loginResult = callonce read('classpath:com/fnp/api/utils/generate-token.feature') {userType:"tagManager"}
    * def authToken = loginResult.accessToken
		* header Authorization = authToken


	#REV2-4656 
  Scenario: GET - Validate Tag Manager can perform simple search with valid tagId
      
    Given path '/tags'
    And param pageNumber = 0
    And param pageSize = 10
    And param simpleSearchValue = 'tag-auto-30747'
    And param sortDirection = 'ASC'
    And param sortField = 'sequence'
    
    When method get
    Then status 200
    And karate.log('Status : 200')
    And match response.data[0].tagId == "tag-auto-3074749"
    And karate.log('Test Completed !')
    

	#REV2-4657 
  Scenario: GET - Validate Tag Manager can perform simple search with valid tagName
      
    Given path '/tags'
    And param pageNumber = 0
    And param pageSize = 10
    And param simpleSearchValue = 'tag-auto-30747'
    And param sortDirection = 'ASC'
    And param sortField = 'sequence'
    
    When method get
    Then status 200
    And karate.log('Status : 200')
    And match response.data[0].tagName == "tag-auto-3074749"
    And karate.log('Test Completed !')   

  
 	#REV2-4658 
  Scenario: GET - Validate Tag Manager can perform simple search with invalid tagId
       
    Given path '/tags'
    And param pageNumber = 0
    And param pageSize = 10
    And param simpleSearchValue = 'tag-auto-5043-inv'
    And param sortDirection = 'ASC'
    And param sortField = 'sequence'
    
    When method get
    Then status 200
    And karate.log('Status : 200')
    And match response.data == []
    And karate.log('Test Completed !')
    
	
	#REV2-4659 
  Scenario: GET - Validate Tag Manager can perform simple search with invalid tagName
       
    Given path '/tags'
    And param pageNumber = 0
    And param pageSize = 10
    And param simpleSearchValue = 'testDemo10.sg-inv'
    And param sortDirection = 'ASC'
    And param sortField = 'sequence'
    
    When method get
    Then status 200
    And karate.log('Status : 200')
    And match response.data == []
    And karate.log('Test Completed !')
    

	#REV2-4660 
  Scenario: GET - Validate Tag Manager can perform simple search with blank tagId
       
    Given path '/tags'
    And param pageNumber = 0
    And param pageSize = 10
    And param simpleSearchValue = ' '
    And param sortDirection = 'ASC'
    And param sortField = 'sequence'
    
    When method get
    Then status 200
    And karate.log('Status : 200')
    And assert response.data.length > 1
    And karate.log('Test Completed !')
    

	#REV2-4661 
  Scenario: GET - Validate Tag Manager can perform simple search with leading and trailing spaces for tagName
       
    Given path '/tags'
    And param pageNumber = 0
    And param pageSize = 10
    And param simpleSearchValue = ' tag-auto-30747 ' 
    And param sortDirection = 'ASC'
    And param sortField = 'sequence'
    
    When method get
    Then status 200
    And karate.log('Status : 200')
    And match response.data[0].tagName == "tag-auto-3074749"
    And karate.log('Test Completed !')
