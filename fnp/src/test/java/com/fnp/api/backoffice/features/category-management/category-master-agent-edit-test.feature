Feature: Create category, search, edit and delete it for Category Agent with Edit permission

	Background: 
		Given url backOfficeAPIBaseUrl
		And path '/galleria/v1'
		And header Accept = 'application/json'
		
		* def loginResult = callonce read('classpath:com/fnp/api/utils/generate-token.feature') {userType:"categoryAgentQA"}
		* def authToken = loginResult.accessToken
		
		* def supAdminLoginResult = call read('classpath:com/fnp/api/utils/generate-token.feature') {userType:"superAdminQA"}
		* def supAdminAuthToken = supAdminLoginResult.accessToken
		
		* header Authorization = authToken
		* configure readTimeout = 40000
		* def result = call read('./category-master-supadmin-test.feature@createBaseURLCategory')
		* def categoryId = result.responseData.id
		* def today = new java.util.Date().time
    * def num = today + ""
    * def num = num.substring(8)
    * def domaintagName = 'tagName: test'+num+'-tag-domain'
    * def prodtagName = 'tagName: test'+num+'-tag-product'
    * def categoryName = 'testCategory'+num
    * def domainTagId = 'fnp.com'
    * def derivedDomainTagId = 'fnp.sg'
    * def geoTagId = 'india'
    
		* def randomNum = 
			"""
			function() { 
				return Math.floor(Math.random() * 99) 
			}
			"""


	 @Regression
	 #REV2-4194
   Scenario: POST- Validate request to create Base URL Category for category Agent with Edit permission 
	
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
    * def categoryId = response.id
    And karate.log('Response is:', responseData)
    And karate.log('Category created')
   
    # Verify created category

		* header Authorization = authToken
		
    Given path '/galleria/v1/categories/' + categoryId

		When method get
		Then status 200
		And karate.log('Status : 200')
	  And karate.log('Response is:', response)
    And match response.id == categoryId
    And karate.log('Test Completed !')
   
   
   @Regression
   #REV2-4195
   Scenario: POST- Validate request to create Base NON-URL Category for category Agent with Edit permission 
		
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
    * def categoryId = response.id
    And karate.log('Response is:', responseData)
    And karate.log('Category created')
    
    # Verify created category

		* header Authorization = authToken
		
    Given path '/galleria/v1/categories/' + categoryId

		When method get
		Then status 200
		And karate.log('Status : 200')
	  And karate.log('Response is:', response)
    And match response.id == categoryId
    And karate.log('Test Completed !')
    
 	 @Regression
 	 @createDerivedURLCategory
   #REV2-4196
   Scenario: POST- Validate request to create Derived URL Category for category Agent with Edit permission
   
		#Create productTag
	  * def result = call read('../../common/create-tag.feature')  {tagType: 'PT',token: "#(supAdminAuthToken)"}
		* def productTagId = result.requestPayload.tagName
		
		#Create derivedDomainTag
	  * def result = call read('../../common/create-tag.feature') {tagType: 'D',token: "#(supAdminAuthToken)"}
		* def derivedDomainTagId = 'fnp.sg'
		
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
    * def categoryId = derivedCategoryId
    
    And karate.log('Test Completed !')
    
    # Verify created category

		* header Authorization = authToken
		
    Given path '/galleria/v1/categories/' + categoryId

		When method get
		Then status 200
		And karate.log('Status : 200')
	  And karate.log('Response is:', response)
    And match response.id == categoryId
    And karate.log('Test Completed !')
  
   @Regression
 	 @createDerivedNonURLCategory
   #REV2-4197
   Scenario: POST- Validate request to create Derived NON-URL Category for category Agent with Edit permission 
    
		
		#Create productTag
	  * def result = call read('../../common/create-tag.feature')  {tagType: 'PT',token: "#(supAdminAuthToken)"}
		* def productTagId = result.requestPayload.tagName
	
		* def derivedDomainTagId = 'fnp.sg'
		
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
    
    And karate.log('Test Completed !')
    
    # Verify created category

		* header Authorization = authToken
		
    Given path '/galleria/v1/categories/' + categoryId

		When method get
		Then status 200
		And karate.log('Status : 200')
	  And karate.log('Response is:', response)
    And match response.id == categoryId
    And karate.log('Test Completed !') 
    
 
  #REV2-4198 
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
    And match response.message contains "updated"
    And karate.log('Category updated') 
    
    # Verify Updated category

		* header Authorization = authToken
		
    Given path '/galleria/v1/categories/' + categoryId

		When method get
		Then status 200
		And karate.log('Status : 200')
	  And karate.log('Response is:', response)
    And match response.id == categoryId
    And karate.log('Test Completed !')  
  
    
  #REV2-4199 
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
    
    # Verify Updated category

		* header Authorization = authToken
		
    Given path '/galleria/v1/categories/' + categoryId

		When method get
		Then status 200
		And karate.log('Status : 200')
	  And karate.log('Response is:', response)
    And match response.id == categoryId
    And karate.log('Test Completed !')    
  
 
  @Regression 
  #REV2-4201 and 4203
	Scenario: PATCH - Validate user can update Derived URL Category with Valid data
	 
	 * def result = call read('./category-master-agent-edit-test.feature@createDerivedURLCategory')
		* def derivedCategoryId = result.derivedCategoryId
		* def categoryId = derivedCategoryId
		
	  * def requestPayload =
      """
      {
			  "categoryName": {
			    "inheritedValueFromBase": false,
			    "value": "testDerivedUrlCategoryUpdated"
			  },
			  "categoryType": {
			    "inheritedValueFromBase": false,
          "value": "6370958"
        },
			  "categoryUrl": "tagautobnntking.com/tag-auto-10207/tag-auto-10282",
			  "comment": "Updated derived category",
			  "fromDate": "2022-04-13T16:00:00",
			  "isEnabled": true,
			  "propagationChildCategories": [],
			  "thruDate": "2022-10-12T16:00:00"
			}
      """
    
    * eval requestPayload.categoryUrl = result.requestPayload.categoryRequest.categoryUrl
    * eval requestPayload.categoryName.value = result.requestPayload.categoryRequest.categoryName
    
    * karate.log(requestPayload)
    Given path '/categories/' + derivedCategoryId
    And request requestPayload
    When method patch
    Then status 202
    And karate.log('Status : 202')
    * def responseData = response
    And karate.log('Response is:', response)
    And match response.message contains "Category updated successfully"
    And karate.log('Category updated') 
    
    # Verify Updated category

		* header Authorization = authToken
		
    Given path '/galleria/v1/categories/' + categoryId

		When method get
		Then status 200
		And karate.log('Status : 200')
	  And karate.log('Response is:', response)
    And match response.id == categoryId
    And karate.log('Test Completed !')   
  
   
  @Regression 
  #REV2-4202
	Scenario: PATCH - Validate user can update Derived Non URL Category with Valid data
	  
	  * def result = call read('./category-master-agent-edit-test.feature@createDerivedNonURLCategory')
		* def derivedCategoryId = result.derivedCategoryId
		* def categoryId = derivedCategoryId
		
	  * def requestPayload =
      """
      {
			  "categoryName": {
			    "inheritedValueFromBase": false,
			    "value": "testDerivedNonUrlCategoryUpdated"
			  },
			  "categoryType": {
			    "inheritedValueFromBase": false,
          "value": "6370958"
         },
			  "categoryUrl": "tagautobnntking.com/tag-auto-10207/tag-auto-10282",
			  "comment": "Updated derived category",
			  "fromDate": "2022-04-13T16:00:00",
			  "isEnabled": true,
			  "propagationChildCategories": [],
			  "thruDate": "2022-10-12T16:00:00"
			}
      """
    
    * eval requestPayload.categoryUrl = result.requestPayload.categoryRequest.categoryUrl
    * eval requestPayload.categoryName.value = result.requestPayload.categoryRequest.categoryName

    * karate.log(requestPayload)
    Given path '/categories/' + derivedCategoryId
    And request requestPayload
    When method patch
    Then status 202
    And karate.log('Status : 202')
    * def responseData = response
    And karate.log('Response is:', response)
    And match response.message contains "Category updated successfully"
    And karate.log('Category updated')
    
    # Verify Updated category

		* header Authorization = authToken
		
    Given path '/galleria/v1/categories/' + categoryId

		When method get
		Then status 200
		And karate.log('Status : 200')
	  And karate.log('Response is:', response)
    And match response.id == categoryId
    And karate.log('Test Completed !')    
    

  @Regression
  #REV2-4192 and 4193
	Scenario: GET - Validate for categoryAgentQA by using Valid categoryID

		Given path '/categories/' + categoryId

		When method get
		Then status 200
		And karate.log('Status : 200')
	  And karate.log('Response is:', response)
    And match response.id == categoryId
    And karate.log('Test Completed !')
  
  
   @Regression
	 Scenario: DELETE - Validate user cannot delete valid category id
		
		Given path '/categories/' + categoryId 
	 	When method delete
		Then status 403
		And karate.log('Status : 403')
		And karate.log('Test Completed !')