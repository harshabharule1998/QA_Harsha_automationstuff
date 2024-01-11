Feature: Create category, search, edit and delete it.

	Background: 
		Given url backOfficeAPIBaseUrl
		And path '/galleria/v1'
		And header Accept = 'application/json'
		* def loginResult = callonce read('classpath:com/fnp/api/utils/generate-token.feature') {userType:"superAdminQA"}
		* def authToken = loginResult.accessToken
		* header Authorization = authToken
		* def today = new java.util.Date().time
    * def num = today + ""
    * def num = num.substring(8)
    * def domaintagName = 'tagName: test'+num+'-tag-domain'
    * def prodtagName = 'tagName: test'+num+'-tag-product'
    * def categoryName = 'testCategory'+num
		* def randomNum = 
			"""
			function() { 
				return Math.floor(Math.random() * 99) 
			}
			"""
			
	
   Scenario: POST - Verify field length validation error for POST request
					
		* def result = call read('../../common/create-tag.feature') {tagType: 'D',token: "#(authToken)"}
		* def domainTagId = result.requestPayload.tagName
		
	  * def requestPayload = read('classpath:com/fnp/api/backoffice/data/category.json')
    
    * eval requestPayload.categoryRequest.domain = domainTagId
    * eval requestPayload.categoryRequest.productType = null
    * eval requestPayload.categoryRequest.categoryClassification = 'NON-URL' 
    * eval requestPayload.categoryRequest.categoryName = categoryName
    * eval requestPayload.categoryRequest.categoryUrl = domainTagId+'/'+categoryName
    * karate.log(requestPayload)
    Given path '/categories'
    And request requestPayload
		When method post
		Then status 201
		And karate.log('Status : 201')
		And match response.message == 'Category created successfully'
	  And karate.log('Test Completed !')
		

	Scenario: PATCH - Verify field length validation error for PUT request
	
	  * def requestPayload =
      """
      {
        "categoryName": "testCategor3385",
        "categoryType": "9270639",
        "categoryUrl": "test3552-tag-domain/test3552-tag-product/testCategor3385",
        "comment": "TestComment12333",
        "isEnabled": true,
        "fromDate": null,
        "thruDate": null
      }
      """
    * karate.log(requestPayload)
    
    Given path '/categories/320@@@4'
    And request requestPayload
    When method patch
    Then status 200
    And karate.log('Status : 200')
    * def responseData = response
    And karate.log('Response is:', response)
    And match response.message contains "Category updated successfully"
    And karate.log('Category updated')   
   
		Given path '/' + tagId + '/relations'
		When request requestPayload
		And method put
		Then status 400
		And karate.log('Status : 400')
		And match response.message == 'Invalid category id'
		And karate.log('Test Completed !')

  @Regression
	Scenario: GET - Verify 400 error for invalid TagId
		
		Given path '/categories/aaa'
	  When method get
		Then status 400
		And karate.log('Status : 400')
		And match response.errors[0].message == 'Invalid category id'
	  And karate.log('Test Completed !')
	  
  @Regression
  Scenario: GET - Verify GET method with invalid authorization token
		
		* def invalidAuthToken = "eyJraWQiOiJmbnAyIiwiYWxnIjoiUlMyNTYifQ"
		* header Authorization = invalidAuthToken
		Given path '/categories/aaa'
	  When method get
		Then status 401
		And karate.log('Status : 401')
		And match response.errors[0].message == "Token Invalid! Authentication Required"
  	And karate.log('Test Completed !')
		
  