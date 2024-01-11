Feature: Tag Simple Search feature for Super Admin

  Background: 
    Given url backOfficeAPIBaseUrl
    And header Accept = 'application/json'
    And path '/galleria/v1'
    
    * def loginResult = callonce read('classpath:com/fnp/api/utils/generate-token.feature') {userType:"superAdminQA"}
    * def authToken = loginResult.accessToken
		* header Authorization = authToken

	#REV2-4632 
  Scenario: GET - Validate Super Admin can perform simple search with invalid endpoint parameters
          
    Given path '/tags'
    And param pageNumber12 = 0
    And param pageSize1 = 10
    And param simpleSearchValue1 = 'abcc'
    And param sortDirection1 = 'ASC'
    And param sortField22 = 'sequence'
    
    When method get
    Then status 200
    And karate.log('Status : 200')
    And karate.log('Test Completed !')
    
	
	#REV2-4633 
  Scenario: PATCH - Validate error message for Super Admin to perform simple search with unsupported method
    
    * def requestPayload = {}
  
    Given path '/tags'
    And param pageNumber = 0
    And param pageSize = 10
    And param simpleSearchValue = 'abcc'
    And param sortDirection = 'ASC'
    And param sortField = 'sequence'
    
    And request requestPayload
    
    When method patch
    Then status 405
    And karate.log('Status : 405')
    And match response.errors[0].message contains "Unsupported request Method"
    And karate.log('Test Completed !')


	#REV2-4634 
  Scenario: GET - Validate error message to perform simple search with invalid auth token
      
    * header Authorization = "eyJraWQiOiJmbnAyIiwiYWxnIjoiUlMyNTYifQ.eyJzdWIiOiIxMCIsImF1ZCI6Imh0dHBzOlwvXC93d3cuZm5wLmNvbSIsInVhbCI6IlNHX0VOVElUWV9BRE0iLCJuYmYiOjE2MTM3MjE3MzcsInVuYW1lIjoiZW50aXR5YWRtaW5AY3li" 
    Given path '/tags'
    And param pageNumber = 0
    And param pageSize = 10
    And param simpleSearchValue = 'abcc'
    And param sortDirection = 'ASC'
    And param sortField = 'sequence'
     
    When method get
    Then status 401
    And karate.log('Status : 401')
    And karate.log('Test Completed !')
    

	#REV2-4636 
  Scenario: GET - Validate pagination implemented for Super Admin to perform simple search
      
    Given path '/tags'
    And param pageNumber = 0
    And param pageSize = 10
    And param simpleSearchValue = 'tag'
    And param sortDirection = 'ASC'
    And param sortField = 'sequence'
    
    When method get
    Then status 200
    And karate.log('Status : 200')
    And assert response.currentPage == 0
    And assert response.totalPages > 1
    And karate.log('Test Completed !')
 
 
	#REV2-4638 
  Scenario: GET - Validate Super Admin can perform simple search with valid tagId
      
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
    

	#REV2-4639 
  Scenario: GET - Validate Super Admin can perform simple search with valid tagName
     
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

  
 	#REV2-4640 
  Scenario: GET - Validate Super Admin can perform simple search with invalid tagId
       
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
    

	#REV2-4641 
  Scenario: GET - Validate Super Admin can perform simple search with invalid tagName
       
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
    

	#REV2-4642 
  Scenario: GET - Validate Super Admin can perform simple search with blank tagId
       
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
    

	#REV2-4643 
  Scenario: GET - Validate Super Admin can perform simple search with leading and trailing spaces for tagName
    
    * header Authorization = authToken   
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
