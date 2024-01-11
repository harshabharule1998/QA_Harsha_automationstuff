Feature: Category SEO Category Agent with edit permission CRUD feature

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
    
    * def invalidCategoryId = '534cvv009'
		* def invalidAssociationId = '605wcx318'

	@Regression
	# REV2-5603	
	Scenario: GET - Validate Category Agent with edit permission can fetch SEO content for valid categoryId 
		
	  * def result = call read('./category-master-supadmin-test.feature@createBaseURLCategory')
		* def catId = result.responseData.id
		Given path '/seo'
		And param categoryId = catId
		When method get
		Then status 200
		And karate.log('Status : 200')
		And match response.id == "#notnull"		
		And karate.log('Test Completed !')
	

	# REV2-5604	
	Scenario: GET - Validate Category Agent with edit permission cannot fetch SEO content for invalid categoryId 
		
		Given path '/seo'
		And param categoryId = invalidCategoryId
		When method get
		Then status 400
		And karate.log('Status : 400')
		And match response.errors[0].message == "Invalid category id"		
		And karate.log('Test Completed !')
	
	@Regression
	# REV2-5669
	Scenario: PUT - Validate Category Agent with edit permission can update SEO configuration for valid categoryId
		
		# Create Category
		* def result = call read('./category-master-supadmin-test.feature@createBaseURLCategory')
		* def catId = result.responseData.id
		* def canonicalUrl = result.requestPayload.categorySeoRequest.canonical.url
		
		* def requestPayload = read('classpath:com/fnp/api/backoffice/data/category-seo.json')   
    * eval requestPayload.canonical.url = canonicalUrl
    
    Given path '/seo'
		And param categoryId = catId
		And request requestPayload
		When method put
		Then status 202
		And karate.log('Status : 202')
		And match response.message == "Category SEO updated successfully"
		And karate.log('Test Completed !')

	
	# REV2-5671
	Scenario: PUT - Validate Category Agent with edit permission cannot update SEO configuration for invalid categoryId
		
		* def requestPayload = read('classpath:com/fnp/api/backoffice/data/category-seo.json')
  
    Given path '/seo'
		And param categoryId = invalidCategoryId
		And request requestPayload
		When method put
		Then status 400
		And karate.log('Status : 400')
		And match response.errors[0].message == "Invalid category id"
		And karate.log('Test Completed !')
		

	# REV2-5677
	Scenario: PUT - Validate Category Agent with edit permission cannot update SEO configuration for blank categoryId
		
		* def blankCategoryId = "  "
		* def requestPayload = read('classpath:com/fnp/api/backoffice/data/category-seo.json')
  
    Given path '/seo'
		And param categoryId = blankCategoryId
		And request requestPayload
		When method put
		Then status 400
		And karate.log('Status : 400')
		And match response.errors[0].message == "Invalid category id"
		And karate.log('Test Completed !')


	# REV2-5680
	Scenario: PUT - Validate Category Agent with edit permission cannot update SEO configuration with blank values
		
		# Create Category
		* def result = call read('./category-master-supadmin-test.feature@createBaseURLCategory')
		* def catId = result.responseData.id
		
		* def requestPayload = read('classpath:com/fnp/api/backoffice/data/category-seo.json')   
    * eval requestPayload.canonical.type = " "
    * eval requestPayload.canonical.url = " "
    
    Given path '/seo'
		And param categoryId = catId
		And request requestPayload
		When method put
		Then status 400
		And karate.log('Status : 400')
		And match response.errors[*].message contains 'Invalid canonical type'
		And match response.errors[*].message contains 'Canonical URL should not be empty'
		And karate.log('Test Completed !')

