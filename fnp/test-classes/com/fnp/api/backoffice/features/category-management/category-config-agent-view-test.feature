Feature: Category Configuration Category Agent with view permission CRUD feature

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
    * def result = call read('./category-master-supadmin-test.feature@createBaseURLCategory')
		* def categoryId = result.responseData.id
    
    * def invalidCategoryId = '534cvv009'

	@Regression
	# REV2-4275	
	Scenario: GET - Validate Category Agent with view permission can fetch category configuration details for valid categoryId
			
		Given path '/configurations'
		And param categoryId = categoryId
		When method get
		Then status 200
		And karate.log('Status : 200')
		And karate.log('Category Configuration Id : ', response.id)
		And match response contains {id: "#notnull"}
		And karate.log('Test Completed !')		


	# REV2-4279	
	Scenario: GET - Validate error message for Category Agent with view permission to fetch category configuration details for invalid categoryId
			
		Given path '/configurations'
		And param categoryId = invalidCategoryId	
		When method get
		Then status 400
		And karate.log('Status : 400')
		And match response.errors[0].message == "Invalid category id"
		And karate.log('Test Completed !')

	
	# REV2-4283
	Scenario: GET - Validate error message for Category Agent with view permission to fetch category configuration details for blank categoryId
		
		* def blankCategoryId = " "
		
		Given path '/configurations'
		And param categoryId = blankCategoryId		
		When method get
		Then status 400
		And karate.log('Status : 400')
		And match response.errors[0].message == "must not be blank"	
		And karate.log('Test Completed !')

@Regression
	# REV2-4317	
	Scenario: PATCH - Validate Category Agent with view permission cannot update category configuration for valid categoryId with propagationChildCategories not mentioned  
	
		* def requestPayload = read('classpath:com/fnp/api/backoffice/data/category-config.json')
  
    Given path '/configurations'
		And param categoryId = categoryId
    And request requestPayload
    When method patch
    Then status 403
    And karate.log('Status : 403')
    And karate.log('Test Completed !')

	