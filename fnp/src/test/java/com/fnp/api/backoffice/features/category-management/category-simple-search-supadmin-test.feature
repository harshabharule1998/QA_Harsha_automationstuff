Feature: Category Simple Search feature for Super Admin

  Background: 
    Given url 'https://api-test-r2.fnp.com'
    And header Accept = 'application/json'
    And path '/categoryservice/v1'
    
    * def loginResult = callonce read('classpath:com/fnp/api/utils/generate-token.feature') {userType:"superAdminQA"}
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
	#REV2-8037 
  Scenario: GET - Validate Super Admin to perform simple search with valid categoryId and valid contentId
    
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
	#REV2-8038 
  Scenario: GET - Validate Super Admin to perform simple search with invalid categoryId and invalid contentId
    
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
	#REV2-8039 
  Scenario: GET - Validate Super Admin to perform simple search with valid categoryId and valid contentName
    
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
	#REV2-8040 
  Scenario: GET - Validate Super Admin to perform simple search with invalid categoryId and invalid contentName
    
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

	
	#REV2-8055 
  Scenario: GET - Validate Super Admin to perform simple search with valid categoryId and valid attributeName
    
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
    
  
	#REV2-8056 
  Scenario: GET - Validate Super Admin to perform simple search with invalid categoryId and invalid attributeName
    
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


	#REV2-8057 
  Scenario: GET - Validate Super Admin to perform simple search with valid categoryId and valid attributeValue
    
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
    
   
	#REV2-8058 
  Scenario: GET - Validate Super Admin to perform simple search with invalid categoryId and invalid attributeValue
    
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
	#REV2-8073 
  Scenario: GET - Validate Super Admin to perform simple search with valid categoryId and valid categoryName
    
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
	#REV2-8074 
  Scenario: GET - Validate Super Admin to perform simple search with invalid categoryId and invalid categoryName
    
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
	#REV2-8075 
  Scenario: GET - Validate Super Admin to perform simple search with valid categoryId and valid associationId
    
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
	#REV2-8076 
  Scenario: GET - Validate Super Admin to perform simple search with invalid categoryId and invalid associationId
    
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

  
	#REV2-8053 
  Scenario: GET - Validate Super Admin to perform simple search with blank categoryId and contentId
    
    * def blankCategoryId = ""
    * def blankContentId = ""
     
    * header Authorization = authToken   
    Given path 'categories/' + blankCategoryId + '/contents'
    And param pageNumber = 0
    And param pageSize = 10
    And param simpleSearchValue = blankContentId
    And param sortDirection = 'ASC'
    And param sortField = 'contentDetails'
    
    When method get
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message == "Parameter Missing"
    And karate.log('Test Completed !')
    
	  
	#REV2-8054 
  Scenario: GET - Validate Super Admin to perform simple search with blank categoryId and contentName
    
    * def blankCategoryId = ""
    * def blankContentName = ""
     
    * header Authorization = authToken
    Given path 'categories/' + blankCategoryId + '/contents'
    And param pageNumber = 0
    And param pageSize = 10
    And param simpleSearchValue = blankContentName
    And param sortDirection = 'ASC'
    And param sortField = 'contentDetails'
    
    When method get
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message == "Parameter Missing"
    And karate.log('Test Completed !')
    
  
	#REV2-8071 
  Scenario: GET - Validate Super Admin to perform simple search with blank categoryId and attributeName
    
    * def blankCategoryId = ""
    * def blankAttributeName = ""
     
    * header Authorization = authToken   
    Given path 'categories/' + blankCategoryId + '/attributes'
    And param pageNumber = 0
    And param pageSize = 10
    And param simpleSearchValue = blankAttributeName
    And param sortDirection = 'ASC'
    And param sortField = 'attributeName'
    
    When method get
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message == "Invalid category id"
    And karate.log('Test Completed !')
    
	
  
	#REV2-8072 
  Scenario: GET - Validate Super Admin to perform simple search with blank categoryId and attributeValue
    
    * def blankCategoryId = ""
    * def blankAttributeValue = ""
     
    * header Authorization = authToken   
    Given path 'categories/' + blankCategoryId + '/attributes'
    And param pageNumber = 0
    And param pageSize = 10
    And param simpleSearchValue = blankAttributeValue
    And param sortDirection = 'ASC'
    And param sortField = 'attributeValue'
    
    When method get
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message == "Invalid category id"
    And karate.log('Test Completed !')
    

	#REV2-8089 
  Scenario: GET - Validate Super Admin to perform simple search with blank categoryId and categoryName
    
    * def blankCategoryId = ""
    * def blankCategoryName = ""
     
    * header Authorization = authToken   
    Given path 'categories/' + blankCategoryId + '/associations'
    And param pageNumber = 0
    And param pageSize = 10
    And param simpleSearchValue = blankCategoryName
    And param sortDirection = 'ASC'
    And param sortField = 'targetCategoryId'
    
    When method get
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message == "Parameter Missing"
    And karate.log('Test Completed !')
    

	#REV2-8090 
  Scenario: GET - Validate Super Admin to perform simple search with blank categoryId and associationId
    
    * def blankCategoryId = ""
    * def blankAssociationId = ""
     
    * header Authorization = authToken   
    Given path 'categories/' + blankCategoryId + '/associations'
    And param pageNumber = 0
    And param pageSize = 10
    And param simpleSearchValue = blankAssociationId
    And param sortDirection = 'ASC'
    And param sortField = 'targetCategoryId'
    
    When method get
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message == "Parameter Missing"
    And karate.log('Test Completed !')
