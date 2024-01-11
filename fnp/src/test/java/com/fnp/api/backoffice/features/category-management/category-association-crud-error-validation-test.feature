Feature: Category Association error validation feature

  Background: 
    Given url backOfficeAPIBaseUrl
    And header Accept = 'application/json'
    And path '/galleria/v1/categories'
    * def loginResult = callonce read('classpath:com/fnp/api/utils/generate-token.feature') {userType:"superAdminQA"}
    * def authToken = loginResult.accessToken
    * header Authorization = authToken
    * configure readTimeout = 40000
    * def today = new java.util.Date().time
    * def num = today + ""
    * def num = num.substring(8)
    * def categoryId = '7343439'
    * def invalidCategoryId = '534cvv009'
    * def associationId = '7343786'
    * def invalidAssociationId = '605wcx318'
  
  
  #REV2-4592
  Scenario: GET - verify 404 error for invalid categoryId

    Given path '/associations'
    And param categoryId = invalidCategoryId
    And param page = 0
    And param size = 10
    And param sortParam = "targetCategoryId:asc"
    When method get
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[*].message contains 'Invalid category id'
    And karate.log('Test Completed !')
  
  # defect id :https://revvit2fnp.atlassian.net/browse/REV2-4614
  #REV2-4589/90
  Scenario: POST - verify 405 error for category relation endpoint
  
    * def requestPayload = {}
    
    Given path '/associations/association'
    And param categoryId = categoryId
    And param associationId = associationId
    When request requestPayload
    And method post
    Then status 405
    And karate.log('Status : 405')
    And karate.log('Test Completed !')
  
  
  #REV2-4591
  Scenario: GET - verify with invalid authorization token
    
    * def invalidAuthToken = "eyJraWQiOiJmbnAyIiwiYWxnIjoiUlMyNTYifQ"
    * header Authorization = invalidAuthToken
   
    Given path '/associations/association'
    And param categoryId = categoryId
    And param associationId = associationId
    When method get
    Then status 401
    And karate.log('Status : 401')
    #	And match response.message == "Token Invalid! Authentication Required"
    And karate.log('Test Completed !')
    
    
  #@Regression 
  #REV2-4567
  Scenario: POST-Association with Blank values in all parameters
  
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/category-association.json')
    * eval requestPayload.associationType = " "
    * eval requestPayload.fromDate = " "
    * eval requestPayload.isPrimary = " "
    * eval requestPayload.sequence = " "
    * eval requestPayload.targetCategoryId = " "
    * eval requestPayload.thruDate = " "
    
    Given path '/associations'
    And param categoryId = categoryId
    And request requestPayload
    When method post
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[*].message contains "Invalid date format"
 
    And karate.log('Test Completed !')
    
  #@Regression
  #REV2-4583
  Scenario: PATCH- Verify association with Invalid data - Invalid relation_Id 
    
    * def result = call read('./category-association-supadmin-test.feature@createAssociation')
    * def assocId = result.assocId
    * def catId = result.baseCategoryId
    
    * def requestPayload = result.requestPayload
    * eval requestPayload.comment = "Automation update association"
    * eval requestPayload.isEnabled = true
    * eval requestPayload.associationType = " " + requestPayload.associationType + " "
    
    Given path '/associations'
    And param categoryId = catId
    And param associationId = invalidAssociationId
    And request requestPayload
    When method patch
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message contains "Invalid association type"
    
    
	#REV2-4570
  Scenario: POST- Verify association with Invalid data - Invalid relation_Id 
    
    * def result = call read('./category-association-supadmin-test.feature@createAssociation')
    * def assocId = result.assocId
    * def catId = result.baseCategoryId
    
    * def requestPayload = result.requestPayload
    * eval requestPayload.comment = "Automation update association"
    * eval requestPayload.isEnabled = true
    * eval requestPayload.associationType = " " + requestPayload.associationType + " "
    
    Given path '/associations'
    And param categoryId = catId
    And param associationId = invalidAssociationId
    And request requestPayload
    When method post
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message contains "Invalid association type"
    
	  
	  

  #REV2-4590
  Scenario: POST - verify unsupported method for endpoint
    
    * def requestPayload = {}
    
		Given path '/associations/association'
    And param categoryId = categoryId
    And param associationId = associationId
    When request requestPayload
    And method post
    Then status 405
    And karate.log('Status : 405')
    And match response.errors[0].message contains "Unsupported request Method"
    And karate.log('Test Completed !')
