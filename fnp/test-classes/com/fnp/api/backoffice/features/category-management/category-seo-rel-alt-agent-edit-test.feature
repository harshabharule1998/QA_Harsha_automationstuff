Feature: Category SEO Management-Rel Alt validation with category Agent view and Edit

Background: 
    Given url backOfficeAPIBaseUrl
    And header Accept = 'application/json'
    And path '/galleria/v1/categories'
    * def loginResult = callonce read('classpath:com/fnp/api/utils/generate-token.feature') {userType:"categoryAgentQA"}
    * def authToken = loginResult.accessToken
    * configure readTimeout = 40000
    * header Authorization = authToken
    * def invalidCategoryId = '534cvv009'
		
	
 
  @Regression
	Scenario: GET - Validate category Agent with edit can fetch SEO content for valid categoryId 
		
		* def catId = '7343884'
		Given path '/seo/rel-alt'
		And param categoryId = catId
		When method get
		Then status 200
		And karate.log('Status : 200')
		And karate.log('output-'+ response)
		And match response[0].hrefLang == "null"
		And match response[0].href == "https://www.fnp.com/yesbankpt"
		And match response[1].hrefLang == "x-default"
		And match response[1].href == "https://www.fnp.com/yesbankpt"
		And karate.log('Test Completed !')

 
	Scenario: GET - Validate category Agent with edit gets blank response in case no rel-alt exists for a category 
		
		* def catId = '6376106'
		Given path '/seo/rel-alt'
		And param categoryId = catId
		When method get
		Then status 200
		And karate.log('Status : 200')
		And karate.log('output-'+ response)
		And match response == []
		And karate.log('Test Completed !')
		
		
		Scenario: GET - Validate category Agent with edit gets blank response in case no rel-alt exists for a category 
		
		* def catId = 'invalidCategoryId'
		Given path '/seo/rel-alt'
		And param categoryId = catId
		When method get
		Then status 400
		And karate.log('Status : 400')
		And karate.log('output-'+ response)
		And match response.errors[0].message == "Invalid category id"
		And karate.log('Test Completed !')
	
	