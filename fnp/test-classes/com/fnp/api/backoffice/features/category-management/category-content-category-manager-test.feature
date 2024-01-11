Feature: Category content crud for category manager

  Background: 
    Given url 'https://api-test-r2.fnp.com'
    And path '/categoryservice/v1'
    And header Accept = 'application/json'
    * def loginResult = callonce read('classpath:com/fnp/api/utils/generate-token.feature') {userType:"tagManager"}
    * def authToken = loginResult.accessToken
    * header Authorization = authToken
    * def today = new java.util.Date().time
    * def num = today + ""
    * def num = num.substring(8)
    * def domaintagName = 'tagName: test'+num+'-tag-domain'
    * def prodtagName = 'tagName: test'+num+'-tag-product'
    * def categoryName = 'testCategory'+num
    * def invalidCategoryId = '534cvv009'
    * def randomNum =
      """
      function() { 
      	return Math.floor(Math.random() * 99) 
      }
      """

  @createCategory
  Scenario: Create Category
    #Create domainTag
    * def result = call read('../../common/create-tag.feature') {tagType: 'D',token: "#(authToken)"}
    * def domainTagId = result.requestPayload.tagName
    * def data = read('classpath:com/fnp/api/backoffice/data/category.json')
    * def requestPayload = data[0]
    * eval requestPayload.domain = domainTagId
    * eval requestPayload.productType = null
    * eval requestPayload.categoryClassification = 'NON-URL'
    * eval requestPayload.categoryName = categoryName
    * eval requestPayload.categoryUrl = domainTagId+'/'+categoryName
    * karate.log(requestPayload)
    Given path '/categories/category'
    And request requestPayload
    When method post
    Then status 201
    And karate.log('Status : 201')
    And karate.log('Response is:', response)
    And karate.log('Category created')
    * def responseData = response

  @createCategoryContent
  Scenario: Create Category contentID
    * def result = call read('./category-content-crud-category-manager-test.feature@createCategory')
    * def categoryId = result.responseData.data
    * karate.log(categoryId)
    * def data = read('classpath:com/fnp/api/backoffice/data/category-content.json')
    * def requestPayload = data[0]
    * karate.log(requestPayload)
    Given path '/categories/' + categoryId + '/content'
    And request requestPayload
    When method post
    Then status 201
    And karate.log('Status : 201')
    And karate.log('Response is:', response)
    And match response.result.message contains "Category content save successfully"
    * def responseData = response
    And karate.log('ContentID created')

  #REV2-4208
  Scenario: POST- Validate request to create Category content
    * def result = call read('./category-content-crud-category-manager-test.feature@createCategory')
    * def contentID = result.responseData.data
    And karate.log('Content ID' +contentID)
    And karate.log('Test Completed !')

  #REV2-4209
  Scenario: POST- Validate request to create Category content for blank ContentID
    * def result = call read('./category-content-crud-category-manager-test.feature@createCategory')
    * def categoryId = result.responseData.data
    * karate.log(categoryId)
    * def data = read('classpath:com/fnp/api/backoffice/data/category-content.json')
    * def requestPayload = data[0]
    * eval requestPayload.contentId = null
    * karate.log(requestPayload)
    Given path '/categories/' + categoryId + '/content'
    And request requestPayload
    When method post
    Then status 201
    And karate.log('Status : 201')
    And karate.log('Response is:', response)
    And match response.result.message contains "Category content save successfully"
    And karate.log('Test Completed !')

  #REV2-4215 and 4214
  Scenario: POST- Validate request to create Category content for Invalid ContentID
    * def result = call read('./category-content-crud-category-manager-test.feature@createCategory')
    * def categoryId = result.responseData.data
    * karate.log(categoryId)
    * def data = read('classpath:com/fnp/api/backoffice/data/category-content.json')
    * def requestPayload = data[0]
    * karate.log(requestPayload)
    Given path '/categories/@@@@/content'
    And request requestPayload
    When method post
    Then status 400
    And karate.log('Status : 400')
    And karate.log('Response is:', response)
    And match response.errors[0].message contains "Invalid category id"
    And karate.log('Test Completed !')

  #REV2-4246
  Scenario: PUT - Validate request  for invalid category id and content association
    * def data = read('classpath:com/fnp/api/backoffice/data/category-content.json')
    * def requestPayload = data[1]
    * karate.log(requestPayload)
    Given path '/categories/contents/658412/content/658412'
    And request requestPayload
    When method put
    Then status 406
    And karate.log('Status : 406')
    * def responseData = response
    And karate.log('Response is:', response)
    And match response.errors[0].message contains "Invalid content association id"
    And karate.log('Test Completed !')

  #REV2-4245
  Scenario: PUT - Validate request  for valid category id and content association
    * def data = read('classpath:com/fnp/api/backoffice/data/category-content.json')
    * def requestPayload = data[1]
    * karate.log(requestPayload)
    * def result = call read('./category-content-crud-supadmin-test.feature@createCategoryContent')
    * def categoryId = result.categoryId
    * def contentAssociationId = result.responseData.data
    Given path '/categories/contents/' + categoryId + '/content/' + contentAssociationId
    And request requestPayload
    When method put
    Then status 202
    And karate.log('Status : 202')
    * def responseData = response
    And karate.log('Response is:', response)
    And match response.result.message contains "Content details updated"
    And karate.log('Test Completed !')

  #REV2-4257
  Scenario: GET - Validate for all category content
    * def result = call read('./category-content-crud-supadmin-test.feature@createCategoryContent')
    * def categoryId = result.categoryId
    Given path '/categories/' + categoryId + '/content'
    And form field pageNumber = 0
    And form field pageSize = 10
    And form field sortDirection = "ASC"
    And form field sortField = "categoryName"
    When method get
    When method get
    And karate.log('Response is:', response.message)
    Then status 200
    And karate.log('Status : 200')
    And karate.log('Test Completed !')

  #REV2-4261
  Scenario: GET - Validate for valid category content
    * def result = call read('./category-content-crud-supadmin-test.feature@createCategoryContent')
    * def categoryId = result.categoryId
    And karate.log('Content ID' +categoryId)
    Given path '/categories/'+categoryId+'/contents'
    When method get
    And karate.log('Response is:', response.message)
    Then status 200
    And karate.log('Status : 200')
    And karate.log('Test Completed !')

  #REV2-4264
  Scenario: GET - Validate  for invalid category content
    Given path '/categories/'+invalidCategoryId+'/contents'
    When method get
    And karate.log('Response is:', response.message)
    And karate.log('Response is:', response.message)
    Then status 404
    And karate.log('Status : 404')
    And match response.error contains "Not Found"

  #REV2-4268
  Scenario: GET - Validate for blank category content
    Given path '/categories/  /contents'
    When method get
    And karate.log('Response is:', response.message)
    And karate.log('Response is:', response.message)
    Then status 404
    And karate.log('Status : 404')
    And match response.error contains "Not Found"

  #REV2-4226
  Scenario: DELETE - Validate user can delete valid category content
    * def result = call read('./category-content-crud-supadmin-test.feature@createCategoryContent')
    * def categoryId = result.categoryId
    * def contentAssociationId = result.responseData.data
    Given path '/categories/contents/' + categoryId + '/content/' + contentAssociationId
    And karate.log('Content ID' +categoryId)
    When method delete
    Then status 200
    And karate.log('Status : 200')
    And karate.log('Category deleted for Id : ', categoryId)
