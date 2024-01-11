Feature: Category Association Super Admin CRUD feature

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

  @Regression
  #REV2-4563
  Scenario: GET - Validate Super Admin can fetch all associations for valid categoryId
    
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
  
  
  #REV2-4565
  Scenario: GET - Validate error message for Super Admin to fetch associations for invalid categoryId
    
    Given path '/associations'
    And param categoryId = invalidCategoryId
    And param page = 0
    And param size = 10
    And param sortParam = "targetCategoryId:asc"
    When method get
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message == "Invalid category id"
    And karate.log('Test Completed !')
  
  
  @Regression
  Scenario: GET - Validate Super Admin can fetch specific category associations for valid associationId
    
    Given path '/associations/association'
    And param categoryId = categoryId
    And param associationId = associationId
    When method get
    Then status 200
    And karate.log('Status : 200')
    And match response.id == associationId
    And karate.log('Test Completed !')
  
 
  
  @Regression
  #REV2-4566
  Scenario: POST - Validate Super Admin can create association for valid categoryId
    
    * def result = call read('./category-association-supadmin-test.feature@createAssociation')
    * def assocId = result.assocId
    * def catId = result.baseCategoryId
    
    # Verify created association
    * def result = call read('./category-association-supadmin-test.feature@getAssociation') {assocId: "#(assocId)", catId: "#(catId)"}
     And match result.responseData.id == assocId
    
    # delete association
    * call read('./category-association-supadmin-test.feature@deleteAssociation') {assocId: "#(assocId)", catId: "#(catId)"}
    And karate.log('Test Completed !')
    
  #fail
  #REV2-4568
  Scenario: POST - Validate Super Admin cannot create association with all blank parameters
    
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
	
	
  #REV2-4569
  Scenario: POST - Validate Super Admin cannot create association with duplicate data
    
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
    
    # delete association
    * call read('./category-association-supadmin-test.feature@deleteAssociation') {assocId: "#(assocId)", catId: "#(catId)"}
    And karate.log('Test Completed !')
 
  #fail
  #REV2-4577
  Scenario: POST - Validate Super Admin cannot create association with duplicate values with spaces
    
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
    
    # delete association
    * call read('./category-association-supadmin-test.feature@deleteAssociation') {assocId: "#(assocId)", catId: "#(catId)"}
    And karate.log('Test Completed !')

  
  #REV2-4572
  Scenario: POST - Validate Super Admin cannot create association with invalid associationType
    
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/category-association.json')
    * eval requestPayload.associationType = "abc123q"
    
    Given path '/associations'
    And param categoryId = categoryId
    And request requestPayload
    When method post
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message == 'Invalid association type'
    And karate.log('Test Completed !')
  
  #fail 
  #REV2-4574
  Scenario: POST - Validate Super Admin cannot create association with invalid fromDate
    
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/category-association.json')
    * eval requestPayload.fromDate = "abc123q"
    
    Given path '/associations'
    And param categoryId = categoryId
    And request requestPayload
    When method post
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message == 'Invalid date format'
    And karate.log('Test Completed !')

  
  #REV2-4573
  Scenario: POST - Validate Super Admin cannot create association with invalid isPrimary
    
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/category-association.json')
    * eval requestPayload.isPrimary = "abc123q"
    
    Given path '/associations'
    And param categoryId = categoryId
    And request requestPayload
    When method post
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message == "Invalid input data"
    And karate.log('Test Completed !')
  
  
  #REV2-4576
  Scenario: POST - Validate Super Admin cannot create association with invalid sequence
    
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/category-association.json')
    * eval requestPayload.sequence = "abc123q"
    
    Given path '/associations'
    And param categoryId = categoryId
    And request requestPayload
    When method post
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message == "Invalid input data"
    And karate.log('Test Completed !')
    
  
  #REV2-4571
  Scenario: POST - Validate Super Admin cannot create association with invalid targetCategoryId
    
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/category-association.json')
    * eval requestPayload.targetCategoryId = "abc123q"
    
    Given path '/associations'
    And param categoryId = categoryId
    And request requestPayload
    When method post
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message == "Invalid target category id"
    And karate.log('Test Completed !')
  
  #fail
  #REV2-4575
  Scenario: POST - Validate Super Admin cannot create association with invalid thruDate
    
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/category-association.json')
    * eval requestPayload.thruDate = "abc123q"
    
    Given path '/associations'
    And param categoryId = categoryId
    And request requestPayload
    When method post
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message == "Invalid date format"
    And karate.log('Test Completed !')
   
  @Regression
  #REV2-4578
  Scenario: PATCH - Validate Super Admin can update association for valid categoryId
    
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
    
    # delete association
    * call read('./category-association-supadmin-test.feature@deleteAssociation') {assocId: "#(assocId)", catId: "#(catId)"}
    And karate.log('Test Completed !')

  #fail
  #REV2-4581
  Scenario: PATCH - Validate Super Admin cannot update association with all blank parameters
    
    * def result = call read('./category-association-supadmin-test.feature@createAssociation')
    * def assocId = result.assocId
    * def catId = result.baseCategoryId
    
    * def requestPayload = result.requestPayload
    * eval requestPayload.comment = " "
    * eval requestPayload.isEnabled = " "
    * eval requestPayload.associationType = " "
    * eval requestPayload.fromDate = " "
    * eval requestPayload.isPrimary = " "
    * eval requestPayload.sequence = " "
    * eval requestPayload.targetCategoryId = " "
    * eval requestPayload.thruDate = " "
    
    # try updating association with all blank parameters
    Given path '/associations'
    And param categoryId = catId
    And param associationId = assocId
    And request requestPayload
    When method patch
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[*].message contains "Invalid date format"

    # delete association
    * call read('./category-association-supadmin-test.feature@deleteAssociation') {assocId: "#(assocId)", catId: "#(catId)"}
    And karate.log('Test Completed !')
  
  
  #REV2-4579
  Scenario: PATCH - Validate Super Admin cannot update association with duplicate data
    
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
    
    # delete association
    * call read('./category-association-supadmin-test.feature@deleteAssociation') {assocId: "#(assocId)", catId: "#(catId)"}
    And karate.log('Test Completed !')
  
  
  #REV2-4580
  Scenario: PATCH - Validate Super Admin cannot update association with duplicate values with spaces
    
    * def result = call read('./category-association-supadmin-test.feature@createAssociation')
    * def assocId = result.assocId
    * def catId = result.baseCategoryId
    
    * def requestPayload = result.requestPayload
    * eval requestPayload.comment = "Automation update association"
    * eval requestPayload.isEnabled = true
    
    # try updating association with all duplicate values with leading and trailing spaces
    * eval requestPayload.associationType = " " + requestPayload.associationType + " "
    * eval requestPayload.fromDate = "" + requestPayload.fromDate + ""
    * eval requestPayload.isPrimary = " " + requestPayload.isPrimary + " "
    * eval requestPayload.sequence = " " + requestPayload.sequence + " "
    * eval requestPayload.targetCategoryId = " " + requestPayload.targetCategoryId + " "
    * eval requestPayload.thruDate = "" + requestPayload.thruDate + ""
    
    Given path '/associations'
    And param categoryId = catId
    And param associationId = assocId
    And request requestPayload
    When method patch
    Then status 400
    And karate.log('Status : 400')
    #And match response.result.message == "Nothing to update"
    
    # delete association
    * call read('./category-association-supadmin-test.feature@deleteAssociation') {assocId: "#(assocId)", catId: "#(catId)"}
    And karate.log('Test Completed !')
  
   
  #REV2-4585
  Scenario: PATCH - Validate Super Admin cannot update association with invalid associationType
    
    * def result = call read('./category-association-supadmin-test.feature@createAssociation')
    * def assocId = result.assocId
    * def catId = result.baseCategoryId
    
    * def requestPayload = result.requestPayload
    * eval requestPayload.comment = "Automation update association"
    * eval requestPayload.isEnabled = true
    * eval requestPayload.associationType = "abc123q"
    
    Given path '/associations'
    And param categoryId = catId
    And param associationId = assocId
    And request requestPayload
    When method patch
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message contains "Invalid association type"
    
    # delete association
    * call read('./category-association-supadmin-test.feature@deleteAssociation') {assocId: "#(assocId)", catId: "#(catId)"}
    And karate.log('Test Completed !')

  #fail
  #REV2-4587
  Scenario: PATCH - Validate Super Admin cannot update association with invalid fromDate
    
    * def result = call read('./category-association-supadmin-test.feature@createAssociation')
    * def assocId = result.assocId
    * def catId = result.baseCategoryId
    
    * def requestPayload = result.requestPayload
    * eval requestPayload.comment = "Automation update association"
    * eval requestPayload.isEnabled = "true"
    * eval requestPayload.fromDate = "abc123q"
    
    Given path '/associations'
    And param categoryId = catId
    And param associationId = assocId
    And request requestPayload
    When method patch
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message contains "Invalid date format"
    
    # delete association
    * call read('./category-association-supadmin-test.feature@deleteAssociation') {assocId: "#(assocId)", catId: "#(catId)"}
    And karate.log('Test Completed !')
	
	
  #REV2-4586
  Scenario: PATCH - Validate Super Admin cannot update association with invalid isPrimary
    
    * def result = call read('./category-association-supadmin-test.feature@createAssociation')
    * def assocId = result.assocId
    * def catId = result.baseCategoryId
    
    * def requestPayload = result.requestPayload
    * eval requestPayload.comment = "Automation update association"
    * eval requestPayload.isEnabled = "true"
    * eval requestPayload.isPrimary = "abc123q"
    
    Given path '/associations'
    And param categoryId = catId
    And param associationId = assocId
    And request requestPayload
    When method patch
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message == "Invalid input data"
    
    # delete association
    * call read('./category-association-supadmin-test.feature@deleteAssociation') {assocId: "#(assocId)", catId: "#(catId)"}
    And karate.log('Test Completed !')
  

  #REV2-4584
  Scenario: PATCH - Validate Super Admin cannot update association with invalid sequence
    
    * def result = call read('./category-association-supadmin-test.feature@createAssociation')
    * def assocId = result.assocId
    * def catId = result.baseCategoryId
    
    * def requestPayload = result.requestPayload
    * eval requestPayload.comment = "Automation update association"
    * eval requestPayload.isEnabled = "true"
    * eval requestPayload.sequence = "abc123q"
    
    Given path '/associations'
    And param categoryId = catId
    And param associationId = assocId
    And request requestPayload
    When method patch
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message == "Invalid input data"
    
    # delete association
    * call read('./category-association-supadmin-test.feature@deleteAssociation') {assocId: "#(assocId)", catId: "#(catId)"}
    And karate.log('Test Completed !')


  #REV2-4582
  Scenario: PATCH - Validate Super Admin cannot update association with invalid targetCategoryId
    
    * def result = call read('./category-association-supadmin-test.feature@createAssociation')
    * def assocId = result.assocId
    * def catId = result.baseCategoryId
    
    * def requestPayload = result.requestPayload
    * eval requestPayload.comment = "Automation update association"
    * eval requestPayload.isEnabled = "true"
    * eval requestPayload.targetCategoryId = "abc123q"
    
    Given path '/associations'
    And param categoryId = catId
    And param associationId = assocId
    And request requestPayload
    When method patch
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message contains "Invalid target category id"
    
    # delete association
    * call read('./category-association-supadmin-test.feature@deleteAssociation') {assocId: "#(assocId)", catId: "#(catId)"}
    And karate.log('Test Completed !')
  
  #fail
  #REV2-4588
  Scenario: PATCH - Validate Super Admin cannot update association with invalid thruDate
    
    * def result = call read('./category-association-supadmin-test.feature@createAssociation')
    * def assocId = result.assocId
    * def catId = result.baseCategoryId
    
    * def requestPayload = result.requestPayload
    * eval requestPayload.comment = "Automation update association"
    * eval requestPayload.isEnabled = "true"
    * eval requestPayload.thruDate = "abc123q"
    
    Given path '/associations'
    And param categoryId = catId
    And param associationId = assocId
    And request requestPayload
    When method patch
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message contains "Invalid date format"
    
    # delete association
    * call read('./category-association-supadmin-test.feature@deleteAssociation') {assocId: "#(assocId)", catId: "#(catId)"}
    And karate.log('Test Completed !')
    

  #REV2-4595
  Scenario: DELETE - Validate Super Admin cannot delete association for invalid associationId
    
    Given path '/associations'
    And param categoryId = categoryId
    And param associationId = invalidAssociationId
    When method delete
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message == "Invalid association id"
    And karate.log('Test Completed !')


	@Regression
  @createAssociation
  Scenario: POST - create association for valid categoryId
  	
  	* def result = call read('./category-master-supadmin-test.feature@createBaseURLCategory')
		* def baseCategoryId = result.responseData.id
		
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/category-association.json')
    Given path '/associations'
    And param categoryId = baseCategoryId
    And request requestPayload
    When method post
    Then status 201
    And karate.log('Status : 201')
    * def assocId = response.id
    * def catID = response.categoryId
    And karate.log('Association created with ID : ', assocId)
    And match response.id == "#notnull"
  
    # Verify created association
    * def result = call read('./category-association-supadmin-test.feature@getAssociation') {assocId: "#(assocId)", catId: "#(catID)"}
     And match result.responseData.id == assocId
     

  @Regression
  Scenario: Delete - Validate Super Admin can create association for valid categoryId
    
    * def result = call read('./category-association-supadmin-test.feature@createAssociation')
    * def assocId = result.assocId
    * def catId = result.baseCategoryId
    
    # delete association
    * call read('./category-association-supadmin-test.feature@deleteAssociation') {assocId: "#(assocId)", catId: "#(catId)"}
    And karate.log('Test Completed !')
    
    # Verify deleted association
    
    * def authToken = loginResult.accessToken
    Given path '/associations/association'
    And param categoryId = catId
    And param associationId = assocId
    When method get
    Then status 400
    And karate.log('Status : 400')
  
  @deleteAssociation
  Scenario: DELETE - delete association for valid categoryId
    * def assocId = __arg.assocId
    * def catId = __arg.catId
    Given path '/associations'
    And param categoryId = catId
    And param associationId = assocId
    When method delete
    Then status 200
    And karate.log('Status : 200')
    And match response.message == "Category association deleted successfully"
    And karate.log('Association deleted !')

	
  @getAssociation
  Scenario: Get association for valid categoryId
    
    * def assocId = __arg.assocId
    * def catId = __arg.catId
    Given path '/associations/association'
    And param categoryId = catId
    And param associationId = assocId
    When method get
    Then status 200
    And karate.log('Status : 200')
    * def responseData = response
    And match response.id == assocId
