Feature: Category Simple Search feature for Category Agent with only View permission

  Background: 
    Given url 'https://api-test-r2.fnp.com'
    And header Accept = 'application/json'
    And path '/categoryservice/v1'
    
    * def loginResult = callonce read('classpath:com/fnp/api/utils/generate-token.feature') {userType:"categoryAgentViewQA"}
    * def authToken = loginResult.accessToken
    
    * def validCategoryId = "1218133"
    * def invalidCategoryId = "1218133zzz"
    
    * def validContentId = "226599"
    * def invalidContentId = "226599zzz"
    
    * def validContentName = "IMAGE_URL"
    * def invalidContentName = "IMAGE_URL1"
    
    * def validAttributeName = "HoHO"
    * def invalidAttributeName = "HoHO-1233"
    
    * def validAttributeValue = "Santa"
    * def invalidAttributeValue = "Santa-123"
    
    * def validAssociationId = "1885049"
    * def invalidAssociationId = "1885049zzz"
    
    * def validCategoryName = "testCategory12319"
    * def invalidCategoryName = "testCategory12319-125"
    
  # defectId : https://revvit2fnp.atlassian.net/browse/REV2-9226  
	#REV2-8049 
  Scenario: GET - Validate Category Agent with only View permission to perform simple search with valid categoryId and valid contentId
    
    * header Authorization = authToken   
    Given path 'categories/' + validCategoryId + '/contents'
    And param pageNumber = 0
    And param pageSize = 10
    And param simpleSearchValue = validContentId
    And param sortDirection = 'ASC'
    And param sortField = 'contentDetails'
    
    When method get
    Then status 200
    And karate.log('Status : 200')
    And match each response.data[*].id == validContentId
    And karate.log('Test Completed !')
    
  # defectId : https://revvit2fnp.atlassian.net/browse/REV2-9226
	#REV2-8050 
  Scenario: GET - Validate Category Agent with only View permission to perform simple search with invalid categoryId and invalid contentId
    
    * header Authorization = authToken   
    Given path 'categories/' + invalidCategoryId + '/contents'
    And param pageNumber = 0
    And param pageSize = 10
    And param simpleSearchValue = invalidContentId
    And param sortDirection = 'ASC'
    And param sortField = 'contentDetails'
    
    When method get
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message == "Invalid category id"
    And karate.log('Test Completed !')

	# defectId : https://revvit2fnp.atlassian.net/browse/REV2-9226
	#REV2-8051 
  Scenario: GET - Validate Category Agent with only View permission to perform simple search with valid categoryId and valid contentName
    
    * header Authorization = authToken   
    Given path 'categories/' + validCategoryId + '/contents'
    And param pageNumber = 0
    And param pageSize = 10
    And param simpleSearchValue = validContentName
    And param sortDirection = 'ASC'
    And param sortField = 'contentDetails'
    
    When method get
    Then status 200
    And karate.log('Status : 200')
    And match each response.data[*].contentName contains validContentName
    And karate.log('Test Completed !')
    
  # defectId : https://revvit2fnp.atlassian.net/browse/REV2-9226  
	#REV2-8052 
  Scenario: GET - Validate Category Agent with only View permission to perform simple search with invalid categoryId and invalid contentName
    
    * header Authorization = authToken   
    Given path 'categories/' + invalidCategoryId + '/contents'
    And param pageNumber = 0
    And param pageSize = 10
    And param simpleSearchValue = invalidContentName
    And param sortDirection = 'ASC'
    And param sortField = 'contentDetails'
    
    When method get
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message == "Invalid category id"
    And karate.log('Test Completed !')

	
	#REV2-8067 
  Scenario: GET - Validate Category Agent with only View permission to perform simple search with valid categoryId and valid attributeName
    
    * header Authorization = authToken   
    Given path 'categories/' + validCategoryId + '/attributes'
    And param pageNumber = 0
    And param pageSize = 10
    And param simpleSearchValue = validAttributeName
    And param sortDirection = 'ASC'
    And param sortField = 'attributeName'
    
    When method get
    Then status 200
    And karate.log('Status : 200')
    And match each response.data[*].attributeName contains validAttributeName
    And karate.log('Test Completed !')
    
  
	#REV2-8068 
  Scenario: GET - Validate Category Agent with only View permission to perform simple search with invalid categoryId and invalid attributeName
    
    * header Authorization = authToken   
    Given path 'categories/' + invalidCategoryId + '/attributes'
    And param pageNumber = 0
    And param pageSize = 10
    And param simpleSearchValue = invalidAttributeName
    And param sortDirection = 'ASC'
    And param sortField = 'attributeName'
    
    When method get
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message == "Invalid category id"
    And karate.log('Test Completed !')


	#REV2-8069 
  Scenario: GET - Validate Category Agent with only View permission to perform simple search with valid categoryId and valid attributeValue
    
    * header Authorization = authToken   
    Given path 'categories/' + validCategoryId + '/attributes'
    And param pageNumber = 0
    And param pageSize = 10
    And param simpleSearchValue = validAttributeValue
    And param sortDirection = 'ASC'
    And param sortField = 'attributeValue'
    
    When method get
    Then status 200
    And karate.log('Status : 200')
    And match each response.data[*].attributeValue contains validAttributeValue
    And karate.log('Test Completed !')
    
   
	#REV2-8070 
  Scenario: GET - Validate Category Agent with only View permission to perform simple search with invalid categoryId and invalid attributeValue
    
    * header Authorization = authToken   
    Given path 'categories/' + invalidCategoryId + '/attributes'
    And param pageNumber = 0
    And param pageSize = 10
    And param simpleSearchValue = invalidAttributeValue
    And param sortDirection = 'ASC'
    And param sortField = 'attributeValue'
    
    When method get
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message == "Invalid category id"
    And karate.log('Test Completed !')	
    
	# defectId : https://revvit2fnp.atlassian.net/browse/REV2-9438
	#REV2-8085 
  Scenario: GET - Validate Category Agent with only View permission to perform simple search with valid categoryId and valid categoryName
    
    * header Authorization = authToken   
    Given path 'categories/' + validCategoryId + '/associations'
    And param pageNumber = 0
    And param pageSize = 10
    And param simpleSearchValue = validCategoryName
    And param sortDirection = 'ASC'
    And param sortField = 'targetCategoryId'
    
    When method get
    Then status 200
    And karate.log('Status : 200')
    And match each response.data[*].categoryName contains validCategoryName
    And karate.log('Test Completed !')
    
  # defectId : https://revvit2fnp.atlassian.net/browse/REV2-9438
	#REV2-8086 
  Scenario: GET - Validate Category Agent with only View permission to perform simple search with invalid categoryId and invalid categoryName
    
    * header Authorization = authToken   
    Given path 'categories/' + invalidCategoryId + '/associations'
    And param pageNumber = 0
    And param pageSize = 10
    And param simpleSearchValue = invalidCategoryName
    And param sortDirection = 'ASC'
    And param sortField = 'targetCategoryId'
    
    When method get
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message == "Invalid category id"
    And karate.log('Test Completed !')

	# defectId : https://revvit2fnp.atlassian.net/browse/REV2-9438
	#REV2-8087 
  Scenario: GET - Validate Category Agent with only View permission to perform simple search with valid categoryId and valid associationId
    
    * header Authorization = authToken   
    Given path 'categories/' + validCategoryId + '/associations'
    And param pageNumber = 0
    And param pageSize = 10
    And param simpleSearchValue = validAssociationId
    And param sortDirection = 'ASC'
    And param sortField = 'targetCategoryId'
    
    When method get
    Then status 200
    And karate.log('Status : 200')
    And match each response.data[*].id == validAssociationId
    And karate.log('Test Completed !')
    
	# defectId : https://revvit2fnp.atlassian.net/browse/REV2-9438  
	#REV2-8088 
  Scenario: GET - Validate Category Agent with only View permission to perform simple search with invalid categoryId and invalid associationId
    
    * header Authorization = authToken   
    Given path 'categories/' + invalidCategoryId + '/associations'
    And param pageNumber = 0
    And param pageSize = 10
    And param simpleSearchValue = invalidAssociationId
    And param sortDirection = 'ASC'
    And param sortField = 'targetCategoryId'
    
    When method get
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message == "Invalid category id"
    And karate.log('Test Completed !')
	