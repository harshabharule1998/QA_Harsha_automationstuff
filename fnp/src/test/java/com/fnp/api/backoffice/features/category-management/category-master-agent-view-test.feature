Feature: Category Master Agent with View permission CRUD feature


	Background: 
		Given url backOfficeAPIBaseUrl
		And path '/galleria/v1'
		And header Accept = 'application/json'
		
		* def loginResult = callonce read('classpath:com/fnp/api/utils/generate-token.feature') {userType:"categoryAgentViewQA"}
		* def authToken = loginResult.accessToken
		
		
		* header Authorization = authToken
		* configure readTimeout = 40000
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
  
	@Regression 
	 #REV2-4191
	 Scenario: DELETE - Validate user cannot delete valid category id
	  
	  * def result = call read('./category-master-supadmin-test.feature@createBaseURLCategory')
		* def categoryId = result.responseData.id
		
		Given path '/categories/' + categoryId 
	 	When method delete
		Then status 403
		And karate.log('Status : 403')
		
		And karate.log('Test Completed !')
		
	 @Regression 
   #REV2-4190
	 Scenario:  - Validate user cannot update inheritValueFromBase flag equal true
	  
	  * def result = call read('./category-master-category-manager-test.feature@createBaseURLCategory')
		* def baseCategoryId = result.responseData.id
		
	  * def requestPayload =
      """
      {
			  "categoryName": {
			    "inheritedValueFromBase": true,
			    "value": "testUrlCategoryUpdated"
			  },
			  "categoryType": {
			    "inheritedValueFromBase": true,
          "value": "6370958"
         },
			  "categoryUrl": "tagautobnntking.com/tag-auto-10207/tag-auto-10282",
			  "comment": "Updated base category",
			  "fromDate": "2022-03-13T16:00:00",
			  "isEnabled": true,
			  "propagationChildCategories": [],
			  "thruDate": "2022-11-12T16:00:00"
			}
      """
    
    * eval requestPayload.categoryUrl = result.requestPayload.categoryRequest.categoryUrl
    * eval requestPayload.categoryName.value = result.requestPayload.categoryRequest.categoryName
    
    * karate.log(requestPayload)
    Given path '/categories/' + baseCategoryId
    And request requestPayload

    When method patch
    Then status 403
    And karate.log('Status : 403')
    * def responseData = response
    And karate.log('Response is:', response)
    And karate.log('Category not updated')    

  @Regression 
   #REV2-4187
	 Scenario: GET - Validate user can fetch specific category
		* def result = call read('./category-master-supadmin-test.feature@createBaseURLCategory')
		* def categoryId = result.responseData.id
		
		Given path '/categories/' + categoryId

		When method get
		Then status 200
		And karate.log('Status : 200')
	  And karate.log('Response is:', response)
	  And karate.log('Test Completed !')
    
  @Regression 
   #REV2-4189
   Scenario: POST- Validate request to create Base URL Category for Agent with View permission
    
    #Create domainTag
	  * def result = call read('../../common/create-tag.feature') {tagType: 'D',token: "#(supAdminAuthToken)"}
		* def domainTagId = result.requestPayload.tagName
		
		#Create geoTag
	  * def result = call read('../../common/create-tag.feature') {tagType: 'G',token: "#(supAdminAuthToken)"}
		* def geoTagId = result.requestPayload.tagName
		
		#Create productTag
	  * def result = call read('../../common/create-tag.feature')  {tagType: 'PT',token: "#(supAdminAuthToken)"}
		* def productTagId = result.requestPayload.tagName
		
		* def requestPayload = read('classpath:com/fnp/api/backoffice/data/category.json')
 
    
    * eval requestPayload.categoryRequest.categoryName = categoryName
    * eval requestPayload.categoryRequest.domain = domainTagId
    * eval requestPayload.categoryRequest.productType = productTagId
    * eval requestPayload.categoryRequest.geography = geoTagId
    * eval requestPayload.categoryRequest.categoryClassification = "Url"
    * eval requestPayload.categoryRequest.categoryUrl = domainTagId + '/' + geoTagId + '/' + productTagId
    
    * eval requestPayload.categorySeoRequest.canonical.url = "https://www." + domainTagId + '/' + geoTagId + '/' + productTagId
    
    * karate.log(requestPayload)
    
    Given path '/categories'
    And request requestPayload
    When method post
    Then status 403
    And karate.log('Status : 403')
    And karate.log('Response is:', response)
    And karate.log('Test Completed !')
    
    