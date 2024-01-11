Feature: Category Relation Agent with View permission CRUD feature

  Background: 
    Given url backOfficeAPIBaseUrl
    And header Accept = 'application/json'
    And path '/galleria/v1/categories'
    * def loginResult = callonce read('classpath:com/fnp/api/utils/generate-token.feature') {userType:"categoryAgentViewQA"}
    * def authToken = loginResult.accessToken
    * header Authorization = authToken
    * configure readTimeout = 40000
    * def today = new java.util.Date().time
    * def num = today + ""
    * def num = num.substring(8)
    * def result = callonce read('./category-association-supadmin-test.feature@createAssociation')
    * def associationId = result.assocId
    * def categoryId = result.baseCategoryId
   
    * def invalidCategoryId = '534cvv009'
    * def invalidAssociationId = '605wcx318'

	@Regression
  #REV2-4597
  Scenario: GET - Validate Category Agent with View permission can fetch all associations for valid categoryId
    
    Given path '/associations'
    And param categoryId = categoryId
    And param page = 0
    And param size = 10
    And param sortParam = "targetCategoryId:asc"
    When method get
    Then status 200
    And karate.log('Status : 200')
    And karate.log('Total Records found : ', response.total)
    And assert response.total >= 1
    And karate.log('Test Completed !')


  #REV2-4598
  Scenario: GET - Validate Category Agent with View permission can fetch specific category associations for valid attributeId
    
    Given path '/associations/association'
    And param categoryId = categoryId
    And param associationId = associationId
    When method get
    Then status 200
    And karate.log('Status : 200')
    And match response.id == associationId
    And karate.log('Test Completed !')

	@Regression
  #REV2-4600
  Scenario: POST - Validate Category Agent with View permission cannot create association for valid categoryId
    
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/category-association.json')
    
    Given path '/associations'
    And param categoryId = categoryId
    And request requestPayload
    When method post
    Then status 403
    And karate.log('Status : 403')
    And karate.log('Test Completed !')

	@Regression
  #REV2-4599
  Scenario: PATCH - Validate Category Agent with View permission cannot update association for valid categoryId
    
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/category-association.json')
    
    * eval requestPayload.sequence = "11"
    * eval requestPayload.comment = "Automation update association"
    * eval requestPayload.isEnabled = "true"
    
    # update association
    Given path '/associations'
    And param categoryId = categoryId
    And param associationId = associationId
    And request requestPayload
    When method patch
    Then status 403
    And karate.log('Status : 403')
    And karate.log('Test Completed !')
	
	@Regression
  #REV2-4601
  Scenario: DELETE - Validate Category Agent with View permission cannot delete association for valid categoryId
    
    Given path '/associations'
    And param categoryId = categoryId
    And param associationId = associationId
    When method delete
    Then status 403
    And karate.log('Status : 403')
    And karate.log('Test Completed !')
    # delete association
    * def catId = categoryId
    * def assocId = associationId
    * call read('./category-association-supadmin-test.feature@deleteAssociation') {assocId: "#(assocId)", catId: "#(catId)"}
    And karate.log('Test Completed !')
