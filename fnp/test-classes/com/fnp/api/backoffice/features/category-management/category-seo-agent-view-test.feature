Feature: Category SEO Category Agent with view permission CRUD feature

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
    
    * def invalidCategoryId = '534cvv009'
		* def invalidAssociationId = '605wcx318'
		
	@Regression
	# REV2-5605	
	Scenario: GET - Validate Category Agent with view permission can fetch SEO content for valid categoryId 
		
		* def result = call read('./category-master-supadmin-test.feature@createBaseURLCategory')
		* def catId = result.responseData.id
	
		Given path '/seo'
		And param categoryId = catId
		When method get
		Then status 200
		And karate.log('Status : 200')
		And match response.id == "#notnull"		
		And karate.log('Test Completed !')
	

	# REV2-5606	
	Scenario: GET - Validate Category Agent with view permission cannot fetch SEO content for invalid categoryId 
		
		Given path '/seo'
		And param categoryId = invalidCategoryId
		When method get
		Then status 400
		And karate.log('Status : 400')
		And match response.errors[0].message == "Invalid category id"		
		And karate.log('Test Completed !')
		

	@Regression
	# REV2-5672
	Scenario: PUT - Validate Category Agent with view permission cannot update SEO configuration for valid categoryId
		
		* def result = call read('./category-master-supadmin-test.feature@createBaseURLCategory')
		* def catId = result.responseData.id
		
		* def requestPayload = read('classpath:com/fnp/api/backoffice/data/category-seo.json')   
    
    Given path '/seo'
		And param categoryId = catId
		And request requestPayload
		When method put
		Then status 403
		And karate.log('Status : 403')
		And karate.log('Test Completed !')

