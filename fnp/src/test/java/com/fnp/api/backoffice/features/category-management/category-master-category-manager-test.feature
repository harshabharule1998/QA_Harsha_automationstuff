Feature: Create category, search, edit and delete it for Category manager

	Background: 
		Given url backOfficeAPIBaseUrl
		And path '/galleria/v1'
		And header Accept = 'application/json'
		
		* def loginResult = callonce read('classpath:com/fnp/api/utils/generate-token.feature') {userType:"categoryManagerQA"}
		* def authToken = loginResult.accessToken
		
		* def supAdminLoginResult = call read('classpath:com/fnp/api/utils/generate-token.feature') {userType:"superAdminQA"}
		* def supAdminAuthToken = supAdminLoginResult.accessToken
		
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
	 #REV2-4177
   Scenario: POST- Validate request to create Base URL Category for category manager
   
		* def result = call read('./category-master-category-manager-test.feature@createBaseURLCategory')
    And match result.responseData.id == "#notnull"
    * def categoryId = result.responseData.id
    And karate.log('Response is:', result.responseData)
    And karate.log('Test Completed !')
    
    # Verify created category Id

		* header Authorization = authToken
		
    Given path '/categories/' + categoryId

		When method get
		Then status 200
		And karate.log('Status : 200')
	  And karate.log('Response is:', response)
    And match response.id == categoryId
    And karate.log('Test Completed !')  
   
  
   #REV2-4185
   Scenario: POST- Validate request to create Base NON-URL Category for category manager
   
    * def result = call read('./category-master-category-manager-test.feature@createBaseNonURLCategory')
    And match result.responseData.id == "#notnull"
    * def categoryId = result.responseData.id
    And karate.log('Response is:', result.responseData)
    And karate.log('Test Completed !')
    
    # Verify created category Id

		* header Authorization = authToken
		
    Given path '/categories/' + categoryId

		When method get
		Then status 200
		And karate.log('Status : 200')
	  And karate.log('Response is:', response)
    And match response.id == categoryId
    And karate.log('Test Completed !') 
    
     
 	 @Regression
   #REV2-4184
   Scenario: POST- Validate request to create Derived URL Category for category manager

		* def domainTagId = 'fnp.com'

		* def geoTagId = 'india'
		
		#Create productTag
	  * def result = call read('../../common/create-tag.feature')  {tagType: 'PT',token: "#(supAdminAuthToken)"}
		* def productTagId = result.requestPayload.tagName
		* def derivedDomainTagId = 'fng.sg'
		
	  * def requestPayload = read('classpath:com/fnp/api/backoffice/data/category.json')
    
    * eval requestPayload.categoryRequest.categoryName = categoryName
    * eval requestPayload.categoryRequest.domain = domainTagId
    * eval requestPayload.categoryRequest.productType = productTagId
    * eval requestPayload.categoryRequest.geography = geoTagId
    * eval requestPayload.categoryRequest.categoryClassification = "Url"
    * eval requestPayload.categoryRequest.categoryUrl = domainTagId + '/' + productTagId
    
    * eval requestPayload.categorySeoRequest.canonical.url = "https://www." + domainTagId + '/' + productTagId
    
    * karate.log(requestPayload)
    
    Given path '/categories'
    And request requestPayload
    When method post
    Then status 201
    And karate.log('Status : 201')
    And match response.id == "#notnull"
    And karate.log('Base Category Response is:', response)
    
    * def baseCategoryId = response.id
    * def derivedDomainTagId = 'fnp.sg'
    
	  * def requestPayload = read('classpath:com/fnp/api/backoffice/data/category.json')
    
    * eval requestPayload.categoryRequest.baseCategory = baseCategoryId
    * eval requestPayload.categoryRequest.categoryName = categoryName + "der"
    * eval requestPayload.categoryRequest.domain = derivedDomainTagId
    * eval requestPayload.categoryRequest.productType = productTagId
    * eval requestPayload.categoryRequest.geography = geoTagId
    * eval requestPayload.categoryRequest.categoryClassification = "Url"
    * eval requestPayload.categoryRequest.categoryUrl = derivedDomainTagId + '/' + geoTagId + '/' + productTagId
    
    * eval requestPayload.categorySeoRequest.canonical.url = "https://www." + derivedDomainTagId + '/' + geoTagId + '/' + productTagId
    
    * karate.log(requestPayload)
    
    * header Authorization = authToken
    Given path '/galleria/v1/categories'
    And request requestPayload
    When method post
    Then status 201
    And karate.log('Status : 201')
    And match response.id == "#notnull"
    And match response.baseCategory == baseCategoryId
    And karate.log('Derived Category Response is:', response)
    * def derivedCategoryId = response.id
    * def categoryId = baseCategoryId
    
    And karate.log('Test Completed !')
    
    # Verify created Derived category Id

		* header Authorization = authToken
		
    Given path '/galleria/v1/categories/' + categoryId

		When method get
		Then status 200
		And karate.log('Status : 200')
	  And karate.log('Response is:', response)
    And match response.id == baseCategoryId
    And karate.log('Test Completed !') 
    
   
    @Regression
   #REV2-4180 and 4178
   Scenario: POST- Validate request to create Derived NON-URL Category for category manager
   
    * def domainTagId = 'fnp.com'
		* def geoTagId = 'india'

		#Create productTag
	  * def result = call read('../../common/create-tag.feature')  {tagType: 'PT',token: "#(supAdminAuthToken)"}
		* def productTagId = result.requestPayload.tagName
		
		
	  * def requestPayload = read('classpath:com/fnp/api/backoffice/data/category.json')
    
    * eval requestPayload.categoryRequest.categoryName = categoryName
    * eval requestPayload.categoryRequest.domain = domainTagId
    * eval requestPayload.categoryRequest.productType = productTagId
    * eval requestPayload.categoryRequest.geography = geoTagId
    * eval requestPayload.categoryRequest.categoryUrl = domainTagId + '/' + productTagId
    
    * eval requestPayload.categorySeoRequest.canonical.url = "https://www." + domainTagId + '/' + productTagId
    
    * karate.log(requestPayload)
    
    Given path '/categories'
    And request requestPayload
    When method post
    Then status 201
    And karate.log('Status : 201')
    And match response.id == "#notnull"
    And karate.log('Base Category Response is:', response)
    
    * def baseCategoryId = response.id
    * def derivedDomainTagId = 'fnp.sg'
    
	  * def requestPayload = read('classpath:com/fnp/api/backoffice/data/category.json')
    
    * eval requestPayload.categoryRequest.baseCategory = baseCategoryId
    * eval requestPayload.categoryRequest.categoryName = categoryName + "der"
    * eval requestPayload.categoryRequest.domain = derivedDomainTagId
    * eval requestPayload.categoryRequest.productType = productTagId
    * eval requestPayload.categoryRequest.geography = geoTagId
    * eval requestPayload.categoryRequest.categoryUrl = derivedDomainTagId + '/' + geoTagId + '/' + productTagId
    
    * eval requestPayload.categorySeoRequest.canonical.url = "https://www." + derivedDomainTagId + '/' + geoTagId + '/' + productTagId
    
    * karate.log(requestPayload)
    
    * header Authorization = authToken
    Given path '/galleria/v1/categories'
    And request requestPayload
    When method post
    Then status 201
    And karate.log('Status : 201')
    And match response.id == "#notnull"
    And match response.baseCategory == baseCategoryId
    And karate.log('Derived Category Response is:', response)
    * def derivedCategoryId = response.id
    * def categoryId = derivedCategoryId 
    
    And karate.log('Category Created!')
    
    # Verify created Derived category Id

		* header Authorization = authToken
		
    Given path '/galleria/v1/categories/' + categoryId

		When method get
		Then status 200
		And karate.log('Status : 200')
	  And karate.log('Response is:', response)
    And match response.id == categoryId
    And karate.log('Test Completed !') 
   

	@Regression 
  #REV2-4182 
	Scenario: PATCH - Validate user can update inheritValueFromBase flag equal true 
	  
	  * def result = call read('./category-master-category-manager-test.feature@createBaseURLCategory')
		* def baseCategoryId = result.responseData.id
		* def categoryId = baseCategoryId
		
	  * def requestPayload =
      """
      {
			  "categoryName": {
			    "inheritedValueFromBase": true,
			    "value": "testUrlCategoryUpdated"
			  },
			  "categoryType": {
			    "inheritedValueFromBase": false,
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
    Then status 202
    And karate.log('Status : 202')
    * def responseData = response
    And karate.log('Response is:', response)
    And match response.message contains "Category updated successfully"
    And karate.log('Category updated') 
    
    # Verify updated Derived category Id

		* header Authorization = authToken
		
    Given path '/galleria/v1/categories/' + categoryId

		When method get
		Then status 200
		And karate.log('Status : 200')
	  And karate.log('Response is:', response)
    And match response.id == categoryId
    And karate.log('Test Completed !') 
      
  
  #REV2-4183 
	Scenario: PATCH - Validate user can update inheritValueFromBase flag equal false
	  
	  * def result = call read('./category-master-category-manager-test.feature@createBaseURLCategory')
		* def baseCategoryId = result.responseData.id
		* def categoryId = baseCategoryId
		
	  * def requestPayload =
      """
      {
			  "categoryName": {
			    "inheritedValueFromBase": false,
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
    Then status 202
    And karate.log('Status : 202')
    * def responseData = response
    And karate.log('Response is:', response)
    And match response.message contains "Category updated successfully"
    And karate.log('Category updated')
    
    # Verify updated Derived category Id

		* header Authorization = authToken
		
    Given path '/galleria/v1/categories/' + categoryId

		When method get
		Then status 200
		And karate.log('Status : 200')
	  And karate.log('Response is:', response)
    And match response.id == categoryId
    And karate.log('Test Completed !')     
     
	 @Regression 
   #REV2-4176 and 4193
	 Scenario: GET - Validate for categoryManager by using Valid categoryID

	  * def result = call read('./category-master-category-manager-test.feature@createBaseURLCategory')
		* def categoryId = result.responseData.id
		Given path '/categories/' + categoryId

		When method get
		Then status 200
		And karate.log('Status : 200')
		And karate.log('Response is:', response)
    And match response.id == categoryId
    And karate.log('Test Completed !')
	 
	 @Regression
   #REV2-4186
	 Scenario: DELETE - Validate user can delete valid category id
	  * def result = call read('./category-master-category-manager-test.feature@createBaseURLCategory')
		* def categoryId = result.responseData.id
		
		Given path '/categories/' + categoryId 
	 	When method delete
		Then status 200
		And karate.log('Status : 200')
		And karate.log('Category deleted for Id : ', categoryId)
		And match response.message == 'Category deleted successfully'
		And karate.log('Test Completed !')
		
		 # Verify updated Derived category Id

		* header Authorization = authToken
		
    Given path '/galleria/v1/categories/' + categoryId

		When method get
		Then status 400
		And karate.log('Status : 400')
	  And karate.log('Response is:', response)
    And match response.errors[0].message == 'Invalid category id'
    And karate.log('Test Completed !')     
		 
   @Regression
	 @createBaseURLCategory
	 Scenario: POST - Validate user can create new category with name, type and url parameters
  
		* def domainTagId = 'fnp.com'
		* def geoTagId = 'india'
		
		#Create productTag
	  * def result = call read('../../common/create-tag.feature')  {tagType: 'PT',token: "#(supAdminAuthToken)"}
		* def productTagId = result.requestPayload.tagName
		
		* def requestPayload = read('classpath:com/fnp/api/backoffice/data/category.json')
 
    
    * eval requestPayload.categoryRequest.categoryName = categoryName
    * eval requestPayload.categoryRequest.domain = domainTagId
    * eval requestPayload.categoryRequest.productType = productTagId
    * eval requestPayload.categoryRequest.geography = geoTagId
    * eval requestPayload.categoryRequest.categoryClassification = "Url"
    * eval requestPayload.categoryRequest.categoryUrl = domainTagId + '/' + productTagId
    
    * eval requestPayload.categorySeoRequest.canonical.url = "https://www." + domainTagId + '/' + productTagId
    
    * karate.log(requestPayload)
    
    Given path '/categories'
    And request requestPayload
    When method post
    Then status 201
    And karate.log('Status : 201')
    * def responseData = response
    And karate.log('Response is:', responseData)
    And karate.log('Category created')
    
	@Regression 
	@createBaseNonURLCategory
	Scenario: POST - Validate user can create new category with name, type and url parameters
		
		#Create productTag  
		* def domainTagId = 'fnp.com'
		* def geoTagId = 'india'
	
		#Create productTag
	  * def result = call read('../../common/create-tag.feature')  {tagType: 'PT',token: "#(supAdminAuthToken)"}
		* def productTagId = result.requestPayload.tagName
		
		* def requestPayload = read('classpath:com/fnp/api/backoffice/data/category.json')
    * eval requestPayload.categoryRequest.categoryName = categoryName
    * eval requestPayload.categoryRequest.domain = domainTagId
    * eval requestPayload.categoryRequest.productType = productTagId
    * eval requestPayload.categoryRequest.geography = geoTagId
    * eval requestPayload.categoryRequest.categoryUrl = domainTagId + '/' + productTagId
    
    * eval requestPayload.categorySeoRequest.canonical.url = "https://www." + domainTagId + '/' + productTagId
    
    * karate.log(requestPayload)
    
    Given path '/categories'
    And request requestPayload
    When method post
    Then status 201
    And karate.log('Status : 201')
    * def responseData = response
    And karate.log('Response is:', responseData)
    And karate.log('Category created')
    
		
		