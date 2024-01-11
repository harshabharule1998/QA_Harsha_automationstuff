Feature: Category content crud for Agent view permission .

  Background: 
    Given url 'https://api-test-r2.fnp.com'
    And path '/categoryservice/v1'
    And header Accept = 'application/json'
    * def loginResult = callonce read('classpath:com/fnp/api/utils/generate-token.feature') {userType:"categoryAgentViewQA"}
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

  #REV2-4222
  Scenario: POST- Verify when the provided category id does not exists
    * def data = read('classpath:com/fnp/api/backoffice/data/category-content.json')
    * def requestPayload = data[0]
    * karate.log(requestPayload)
    Given path '/categories/' + invalidCategoryId + '/content'
    And request requestPayload
    When method post
    Then status 403
    And karate.log('Status : 403')
    And match response.errors[0].message contains "Access Denied"
    And karate.log('Response is:', response)
    And karate.log('Test Completed !')

  #REV2-4221
  Scenario: POST- Validate request to create Category content for blankContent ID
    * def result = call read('./category-master-supadmin-test.feature@createBaseURLCategory')
    * def categoryId = result.responseData.data
    * karate.log(categoryId)
    * def data = read('classpath:com/fnp/api/backoffice/data/category-content.json')
    * def requestPayload = data[0]
    * eval requestPayload.contentId = ""
    * karate.log(requestPayload)
    Given path '/categories/' + categoryId + '/content'
    And request requestPayload
    When method post
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message contains "Content id should not contain blank spaces"
    And karate.log('Response is:', response)
    And karate.log('Test Completed !')

  #REV2-4220/REV2-4250
  Scenario: POST- Validate request to create Category content
    * def result = call read('./category-master-supadmin-test.feature@createBaseURLCategory')
    * def categoryId = result.responseData.data
    And karate.log('Category ID ' + categoryId)
    * def data = read('classpath:com/fnp/api/backoffice/data/category-content.json')
    * def requestPayload = data[0]
    * karate.log(requestPayload)
    Given path '/categories/' + categoryId + '/content'
    And request requestPayload
    When method post
    Then status 403
    And karate.log('Status : 403')
    And match response.errors[0].message contains "Access Denied"
    And karate.log('Response is:', response)
    And karate.log('Test Completed !')

  #REV2-4270
  Scenario: GET - validate category content for blank Category id
    * def categoryId = " "
    Given path '/categories/' + categoryId + '/contents'
    And form field pageNumber = 0
    And form field pageSize = 10
    And form field sortDirection = "ASC"
    And form field sortField = "categoryName"
    When method get
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message contains "Invalid category id"
    And karate.log('Test Completed !')

  #REV2-4266
  Scenario: GET - validate category content for invalid Category id
    Given path '/categories/' + invalidCategoryId + '/contents'
    And form field pageNumber = 0
    And form field pageSize = 10
    And form field sortDirection = "ASC"
    And form field sortField = "categoryName"
    When method get
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message contains "Invalid category id"
    And karate.log('Test Completed !')

  #REV2-4263
  Scenario: GET - validate category content for valid Category id
    * def categoryId = "1392966"
    Given path '/categories/' + categoryId + '/contents'
    And form field pageNumber = 0
    And form field pageSize = 10
    And form field sortDirection = "ASC"
    And form field sortField = "categoryName"
    When method get
    Then status 200
    And karate.log('Status : 200')
    And karate.log('Total Records found : ', response.data.totalRecords)
    And assert response.data.totalRecords >= 1
    And karate.log('Test Completed !')

  #REV2-4230
  Scenario: Delete - validate category content for valid category id and valid Content association id
    * def result = call read('./category-content-crud-supadmin-test.feature@createCategoryContent')
    * def categoryId = result.categoryId
    * def contentAssociationId = result.responseData.data
    Given path '/categories/' + categoryId + '/contents/' + contentAssociationId
    When method delete
    Then status 403
    And karate.log('Status : 403')
    And match response.errors[0].message contains "Access Denied"
    And karate.log('Test Completed !')
