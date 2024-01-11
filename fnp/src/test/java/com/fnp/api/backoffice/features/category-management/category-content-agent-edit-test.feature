Feature: Category content crud for category Agent with Edit and View permission

  Background: 
    Given url 'https://api-test-r2.fnp.com'
    And path '/categoryservice/v1'
    And header Accept = 'application/json'
    * def loginResult = callonce read('classpath:com/fnp/api/utils/generate-token.feature') {userType:"categoryAgentQA"}
    * def authToken = loginResult.accessToken
    * header Authorization = authToken
    * def today = new java.util.Date().time
    * def num = today + ""
    * def num = num.substring(8)
    * def domaintagName = 'tagName: test'+num+'-tag-domain'
    * def prodtagName = 'tagName: test'+num+'-tag-product'
    * def invalidCategoryId = '534cvv009'
    * def categoryName = 'testCategory'+num
    * def randomNum =
      """
      function() { 
      	return Math.floor(Math.random() * 99) 
      }
      """

  @createCategory
  Scenario: Create Category contentID
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
    * def result = call read('./category-content-crud-supadmin-test.feature@createCategory')
    * def categoryId = result.responseData.data
    * karate.log(categoryId)
    * def data = read('classpath:com/fnp/api/backoffice/data/category-content.json')
    * def requestPayload = data[0]
    * karate.log(requestPayload)
    Given path '/categories/' + categoryId + '/content'
    And request requestPayload
    When method post
    Then status 200
    And karate.log('Status : 200')
    And karate.log('Response is:', response)
    And match response.result.message contains "Category content save successfully"
    * def responseData = response
    And karate.log('ContentID created')

  # REV2-4260
  Scenario: GET - Validate for all category content
    * def result = call read('./category-content-crud-supadmin-test.feature@createCategoryContent')
    * def categoryId = result.categoryId
    Given path '/categories/' + categoryId + '/content'
    When method get
    And karate.log('Response is:', response.message)
    Then status 200
    And karate.log('Status : 200')
    And karate.log('Test Completed !')

  #REV2-4267
  Scenario: GET - Validate for category content for invalid Category id
    Given path '/categories/' + invalidCategoryId + '/content'
    When method get
    And karate.log('Response is:', response.message)
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message contains "Invalid category id"
    And karate.log('Test Completed !')

  #REV2-4271
  Scenario: GET - Validate for category content for blank Category id
    * def categoryId = " "
    Given path '/categories/' + categoryId + '/content'
    When method get
    And karate.log('Response is:', response.message)
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message contains "Invalid category id"
    And karate.log('Test Completed !')

  #REV2-4249
  Scenario: PUT - Validate request  for  valid category id and content association
    * def data = read('classpath:com/fnp/api/backoffice/data/category-content.json')
    * def requestPayload = data[1]
    * karate.log(requestPayload)
    * def result = call read('./category-content-crud-supadmin-test.feature@createCategoryContent')
    * def categoryId = result.categoryId
    * def contentAssociationId = result.responseData.data
    Given path '/categories/' + categoryId + '/content/' + contentAssociationId
    And request requestPayload
    When method put
    Then status 202
    And karate.log('Status : 202')
    * def responseData = response
    And karate.log('Response is:', response)
    And match response.result.message contains "Content details updated"
    And karate.log('Test Completed !')

  #REV2-4231
  Scenario: DELETE - Validate user can delete valid category id and contentAssociationId
    * def result = call read('./category-content-crud-supadmin-test.feature@createCategoryContent')
    * def categoryId = result.categoryId
    * def contentAssociationId = result.responseData.data
    Given path '/categories/' + categoryId + '/content/' + contentAssociationId
    And karate.log('Content ID' +categoryId)
    When method delete
    Then status 403
    And match response.errors[0].message contains "Access Denied"
    And karate.log('Category deleted for Id : ', categoryId)
    And karate.log('Test Completed !')

  #REV2-4218
  Scenario: POST- Verify when the provided category id does not exists
    * def data = read('classpath:com/fnp/api/backoffice/data/category-content.json')
    * def requestPayload = data[0]
    * karate.log(requestPayload)
    Given path '/categories/' + invalidCategoryId + '/content'
    And request requestPayload
    When method post
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message contains "Invalid category id"
    And karate.log('Response is:', response)
    And karate.log('Test Completed !')

  #REV2-4219
  Scenario: POST- Verify to create when the provided Content Type is invalid
    * def result = call read('./category-content-crud-supadmin-test.feature@createCategory')
    * def categoryId = result.responseData.data
    * karate.log(categoryId)
    * def data = read('classpath:com/fnp/api/backoffice/data/category-content.json')
    * def requestPayload = data[0]
    * eval requestPayload.contentTypeId = "1234566"
    * karate.log(requestPayload)
    Given path '/categories/' + categoryId +'/content'
    And request requestPayload
    When method post
    Then status 400
    And karate.log('Status : 400')
    And karate.log('Response is:', response)
    And match response.errors[0].message contains "Enter exiting content type id"
    And karate.log('Test Completed !')

  #REV2-4251
  Scenario: PUT - Validate request  for valid invalid category id and content association
    * def data = read('classpath:com/fnp/api/backoffice/data/category-content.json')
    * def requestPayload = data[1]
    * karate.log(requestPayload)
    Given path '/categories/658412/content/658412'
    And request requestPayload
    When method put
    Then status 400
    And karate.log('Status : 400')
    * def responseData = response
    And karate.log('Response is:', response)
    And match response.errors[0].message contains "Invalid content association id"
    And karate.log('Test Completed !')

  #REV2-4216
  Scenario: POST- Verify to create when the provided Content Type is valid
    * def result = call read('./category-content-crud-supadmin-test.feature@createCategory')
    * def categoryId = result.responseData.data
    * karate.log(categoryId)
    * def data = read('classpath:com/fnp/api/backoffice/data/category-content.json')
    * def requestPayload = data[0]
    * karate.log(requestPayload)
    Given path '/categories/' + categoryId +'/content'
    And request requestPayload
    When method post
    Then status 201
    And karate.log('Status : 201')
    And karate.log('Response is:', response)
    And match response.result.message contains "Category content save successfully"
    And karate.log('Test Completed !')

  #REV2-4217
  Scenario: POST- Verify with valid Content Type and category id when Content id=Blank
    * def result = call read('./category-content-crud-supadmin-test.feature@createCategory')
    * def categoryId = result.responseData.data
    * karate.log(categoryId)
    * def data = read('classpath:com/fnp/api/backoffice/data/category-content.json')
    * def requestPayload = data[0]
    * eval requestPayload.contentTypeId = " "
    * karate.log(requestPayload)
    Given path '/categories/' + categoryId +'/content'
    And request requestPayload
    When method post
    Then status 400
    And karate.log('Status : 400')
    And karate.log('Response is:', response)
    And match response.result.message contains "Enter exiting content type id"
    And karate.log('Test Completed !')
