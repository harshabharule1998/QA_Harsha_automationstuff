Feature: Category Configuration Super Admin CRUD feature

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
    
    * def result = call read('./category-master-supadmin-test.feature@createBaseURLCategory')
		* def categoryId = result.responseData.id
		
    * def invalidCategoryId = '534cvv009'

 	@Regression
	# REV2-4273	
	Scenario: GET - Validate Super Admin can fetch category configuration details for valid categoryId
			
		Given path '/configurations'
		And param categoryId = categoryId
		When method get
		Then status 200
		And karate.log('Status : 200')
		And karate.log('Category Configuration Id : ', response.id)
		And match response contains {id: "#notnull"}
		And karate.log('Test Completed !')		
  

	# REV2-4277	
	Scenario: GET - Validate error message for Super Admin to fetch category configuration details for invalid categoryId
				
		Given path '/configurations'
		And param categoryId = invalidCategoryId
		When method get
		Then status 400
		And karate.log('Status : 400')
		And match response.errors[0].message == "Invalid category id"
		And karate.log('Test Completed !')


	# REV2-4281	
	Scenario: GET - Validate error message for Super Admin to fetch category configuration details for blank categoryId
		
		* def blankCategoryId = " "
		
		Given path '/configurations'
		And param categoryId = blankCategoryId	
		When method get
		Then status 400
		And karate.log('Status : 400')
		And match response.errors[0].message == "must not be blank"	
		And karate.log('Test Completed !')

 	@Regression
	# REV2-4307	
	Scenario: PATCH - Validate Super Admin can update category configuration for valid categoryId with propagationChildCategories not mentioned  
	
		* def result = call read('./category-master-supadmin-test.feature@createBaseURLCategory')
		* def catId = result.responseData.id
		
		* def requestPayload = read('classpath:com/fnp/api/backoffice/data/category-config.json')
  
    * karate.log(requestPayload)
    
    Given path '/configurations'
		And param categoryId = catId	
    And request requestPayload
    When method patch
    Then status 202
    And karate.log('Status : 202')
    And karate.log('Response is:', response)
    And match response.message == "Category configuration updated successfully"
    And karate.log('Test Completed !')
    
    # Verify Updated category Configuration

		* header Authorization = authToken
		
		Given path '/galleria/v1/categories/' + '/configurations'
		
		And param categoryId = categoryId
		When method get
		Then status 200
		And karate.log('Status : 200')
		And karate.log('Category Configuration Id : ', response.id)
		And match response contains {id: "#notnull"}
		And karate.log('Test Completed !')


	# REV2-4308
	Scenario: PATCH - Validate error message for Super Admin to update category configuration with invalid categoryId    
		
		* def requestPayload = read('classpath:com/fnp/api/backoffice/data/category-config.json')
  
    * karate.log(requestPayload)
    
    Given path '/configurations'
		And param categoryId = invalidCategoryId
    And request requestPayload
    When method patch
    Then status 400
		And karate.log('Status : 400')
		And match response.errors[0].message == "Invalid category id"
		And karate.log('Test Completed !')

	
	# REV2-4309
	Scenario: PATCH - Validate error message for Super Admin to update category configuration with blank categoryId    
		
		* def requestPayload = read('classpath:com/fnp/api/backoffice/data/category-config.json')
  
    * def blankCategoryId = " "
		
		Given path '/configurations'
		And param categoryId = blankCategoryId	
    And request requestPayload
    When method patch
    Then status 400
		And karate.log('Status : 400')
		And match response.errors[0].message == "must not be blank"	
		And karate.log('Test Completed !')
	
  @Regression
	# REV2-4310	
	Scenario: PATCH - Validate Super Admin can update category configuration for valid categoryId with propagationChildCategories mentioned  
		
		* def result = call read('./category-master-supadmin-test.feature@createDerivedURLCategory')
		* def baseCategoryId = result.baseCategoryId
		* def derivedCategoryId = result.derivedCategoryId
		
		* def requestPayload = read('classpath:com/fnp/api/backoffice/data/category-config.json')
  	* eval requestPayload.propagationChildCategories = [derivedCategoryId]
  	
    * karate.log(requestPayload)
		
    Given path '/configurations'
    And param categoryId = baseCategoryId	
    And request requestPayload
    When method patch
    Then status 202
    And karate.log('Status : 202')
    And karate.log('Response is:', response)
    And match response.message == "Category configuration updated successfully"
    And karate.log('Test Completed !')
    
    # Verify Updated category Configuration

		* header Authorization = authToken
		
		Given path '/galleria/v1/categories/' + '/configurations'
		
		And param categoryId = categoryId
		When method get
		Then status 200
		And karate.log('Status : 200')
		And karate.log('Category Configuration Id : ', response.id)
		And match response contains {id: "#notnull"}
		And karate.log('Test Completed !')


	# REV2-4311	
	Scenario: PATCH - Validate Super Admin can update category configuration for valid categoryId with invalid propagationChildCategories  
		
		* def requestPayload = read('classpath:com/fnp/api/backoffice/data/category-config.json')
  
    * eval requestPayload.propagationChildCategories = [1008002]
    * karate.log(requestPayload)
    
    Given path '/configurations'
    And param categoryId = categoryId
    And request requestPayload
    When method patch
    Then status 400
    And karate.log('Status : 400')
    And karate.log('Response is:', response)
    And match response.errors[0].message == "Propagation list not valid"
    And karate.log('Test Completed !')

	