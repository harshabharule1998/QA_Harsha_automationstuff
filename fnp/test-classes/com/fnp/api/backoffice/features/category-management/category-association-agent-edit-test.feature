Feature: Category Association Agent with Edit permission CRUD feature

  Background: 
    Given url backOfficeAPIBaseUrl
    And header Accept = 'application/json'
    And path '/galleria/v1/categories'
    * def loginResult = callonce read('classpath:com/fnp/api/utils/generate-token.feature') {userType:"categoryAgentQA"}
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
  #REV2-4602
  Scenario: GET - Validate Category Agent with Edit permission can fetch all associations for valid categoryId
    
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

  @Regression
  #REV2-4603
  Scenario: GET - Validate Category Agent with Edit permission can fetch specific category associations for valid attributeId
    
    Given path '/associations/association'
    And param categoryId = categoryId
    And param associationId = associationId
    When method get
    Then status 200
    And karate.log('Status : 200')
    And match response.id == associationId
    And karate.log('Test Completed !')


  @Regression
  #REV2-4604
  Scenario: POST - Validate Category Agent with Edit permission can create association with only required parameters
    
    * def result = call read('./category-master-supadmin-test.feature@createBaseURLCategory')
    * def catId = result.responseData.id
		
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/category-association.json')
    Given path '/associations'
    And param categoryId = catId
    And request requestPayload
    When method post
    Then status 201
    And karate.log('Status : 201')
    * def assocId = response.id
    And karate.log('Association created with ID : ', assocId)
    And match response.id == "#notnull"
    
    # Verify created category association
    
    * header Authorization = authToken
    Given path '/galleria/v1/categories/associations/association'
    And param categoryId = catId
    And param associationId = assocId
    When method get
    Then status 200
    And karate.log('Status : 200')
    And match response.id == assocId
    And karate.log('Test Completed !')
    
    # delete association
    * call read('./category-association-supadmin-test.feature@deleteAssociation') {assocId: "#(assocId)", catId: "#(catId)"}
    And karate.log('Test Completed !')
    

	
  #REV2-4605
  Scenario: POST - Validate Category Agent with Edit permission cannot create association with only optional parameters
    
    * def requestPayload =
      """
      {
       "comment": "Automation update association",
       "isEnabled": "true"
      }
      """
    Given path '/associations'
    And param categoryId = categoryId
    And request requestPayload
    When method post
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[*].message contains 'Target category should not be empty'
    And match response.errors[*].message contains 'Primary can not be null'
    And match response.errors[*].message contains 'Association type should not be empty'
    And karate.log('Test Completed !')
  
  
  #Fail
  #REV2-4606
  Scenario: POST - Validate Category Agent with Edit permission cannot create association with all blank parameters
    
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
    And match response.errors[*].message contains 'Invalid date format'
    And karate.log('Test Completed !')

  
  Scenario: POST - Validate Category Agent with Edit permission cannot create association with duplicate data
    
    * def result = call read('./category-association-supadmin-test.feature@createAssociation')
    * def assocId = result.assocId
    * def catId = result.baseCategoryId
    
    * def requestPayload = result.requestPayload
    
    # try creating association with all duplicate parameters
    Given path '/associations'
    And param categoryId = catId
    And request requestPayload
    When method post
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message == "Category association already exists"

    And karate.log('Test Completed !')
  
  #fail
  #REV2-4609
  Scenario: POST - Validate Category Agent with Edit permission cannot create association with duplicate values with spaces
    
    * def result = call read('./category-association-supadmin-test.feature@createAssociation')
    * def assocId = result.assocId
    * def catId = result.baseCategoryId
    * def requestPayload = result.requestPayload
    
    # try creating association with all duplicate values with leading and trailing spaces
    * eval requestPayload.associationType = " " + requestPayload.associationType + " "
    * eval requestPayload.fromDate = " " + requestPayload.fromDate + " "
    * eval requestPayload.isPrimary = " " + requestPayload.isPrimary + " "
    * eval requestPayload.sequence = " " + requestPayload.sequence + " "
    * eval requestPayload.targetCategoryId = " " + requestPayload.targetCategoryId + " "
    * eval requestPayload.thruDate = " " + requestPayload.thruDate + " "
    
    Given path '/associations'
    And param categoryId = catId
    And request requestPayload
    When method post
    Then status 400
    And karate.log('Status : 400')
    #And match response.errors[0].message == "Category association already exists"
  	And karate.log('Test Completed !')
  
  #fail
  #REV2-4608
  Scenario: POST - Validate Category Agent with Edit permission cannot create association with invalid values
    
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/category-association.json')
    * eval requestPayload.associationType = "abc123q"
    * eval requestPayload.fromDate = "abc123q"
    * eval requestPayload.isPrimary = "abc123q"
    * eval requestPayload.sequence = "abc123q"
    * eval requestPayload.targetCategoryId = "abc123q"
    * eval requestPayload.thruDate = "abc123q"
    
    Given path '/associations'
    And param categoryId = categoryId
    And request requestPayload
    When method post
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[*].message contains "Invalid date format"
    And karate.log('Test Completed !')

  @Regression
  #REV2-4610
  Scenario: PATCH - Validate Category Agent with Edit permission can update association for valid categoryId
    
    * def result = call read('./category-association-supadmin-test.feature@createAssociation')
    * def assocId = result.assocId
    * def catId = result.baseCategoryId
    
    * def requestPayload = result.requestPayload
    * eval requestPayload.sequence = "11"
    * eval requestPayload.comment = "Automation update association"
    * eval requestPayload.isEnabled = "true"
    
    # update association
    Given path '/associations'
    And param categoryId = catId
    And param associationId = assocId
    And request requestPayload
    When method patch
    Then status 202
    And karate.log('Status : 202')
    And match response.message == "Category association updated successfully"
    
    # Verify updated association
    
    * def result = call read('./category-association-supadmin-test.feature@getAssociation') {assocId: "#(assocId)", catId: "#(catId)"}
    And match result.responseData.id == assocId
    And match result.responseData.sequence == 11
    And match result.responseData.comment == requestPayload.comment
    And karate.log('Association updated	successfully !')
  	And karate.log('Test Completed !')
  	
  	# delete association
    * call read('./category-association-supadmin-test.feature@deleteAssociation') {assocId: "#(assocId)", catId: "#(catId)"}
    And karate.log('Test Completed !')
	
	
  #REV2-4611
  Scenario: PATCH - Validate Category Agent with Edit permission cannot update association with duplicate data
    
    * def result = call read('./category-association-supadmin-test.feature@createAssociation')
    * def assocId = result.assocId
    * def catId = result.baseCategoryId
    
    * def requestPayload = result.requestPayload
    * eval requestPayload.isEnabled = true
    * eval requestPayload.comment = "Automation update association"
    
    # try updating association with duplicate data
    Given path '/associations'
    And param categoryId = catId
    And param associationId = assocId
    And request requestPayload
    When method patch
    Then status 200
    And karate.log('Status : 200')   
    And match response.message == "There is nothing to update"
    And karate.log('Test Completed !')
    
	
	#Fail
  #REV2-4612
  Scenario: PATCH - Validate Category Agent with Edit permission cannot update association for invalid data
    
    * def result = call read('./category-association-supadmin-test.feature@createAssociation')
    * def assocId = result.assocId
    * def catId = result.baseCategoryId
    * def requestPayload = result.fail= "abc123q"
    * eval requestPayload.isEnabled = "abc123q"
    * eval requestPayload.associationType = "abc123q"
    * eval requestPayload.fromDate = "abc123q"
    * eval requestPayload.isPrimary = "abc123q"
    * eval requestPayload.sequence = "abc123q"
    * eval requestPayload.targetCategoryId = "abc123q"
    * eval requestPayload.thruDate = "abc123q"
    
    # update association
    Given path '/associations'
    And param categoryId = catId
    And param associationId = assocId
    And request requestPayload
    When method patch
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message contains "Invalid date format"
    And karate.log('Test Completed !')

  @Regression
  #REV2-4613
  Scenario: DELETE - Validate Category Agent with Edit permission cannot delete association for valid categoryId
    
    Given path '/associations'
    And param categoryId = categoryId
    And param associationId = associationId
    When method delete
    Then status 403
    And karate.log('Status : 403')
    And match response.errors[0].message == 'Access Denied'
    And karate.log('Test Completed !')
    # delete association
    * def catId = categoryId
    * def assocId = associationId
    * call read('./category-association-supadmin-test.feature@deleteAssociation') {assocId: "#(assocId)", catId: "#(catId)"}
    And karate.log('Test Completed !')
   
  