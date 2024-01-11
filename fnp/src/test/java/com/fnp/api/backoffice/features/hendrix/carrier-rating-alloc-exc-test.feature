Feature: Carrier rating scenarios for Allocation Executive role


  Background: 
    Given url backOfficeAPIBaseUrl
    And header Accept = "application/json"
    And path '/hendrix/v1/carrier-ratings'
    * def loginResult = callonce read('classpath:com/fnp/api/utils/generate-token.feature') {userType:"allocExc"}
    * def authToken = loginResult.accessToken
    * header Authorization = authToken


  #REV2-11487
  Scenario: GET - Verify Allocation executive user can fetch Carrier rating for valid input
    Given param deliveryMode = 'hd'
    And param fieldName = 'vendorId'
    And param fieldValues = 'Carrier_101'
    And param fieldValues = 'Carrier_115'
    And param operator = 'EQUAL_TO'
    And param page = 0
    And param size = 10
    When method get
    Then status 200
    And karate.log('status : 200')
    And match each response.data[*].deliveryMode contains "hd"
    And match response.currentPage == 0
    And karate.log('Test Completed !')


  #REV2-11488
  Scenario: GET -Verify Method: GET request for Carrier Rating Configuration with Allocation Executive Role access for - Invalid Delivery Mode
  
  	Given param deliveryMode = 'abc@abc.com'
    When method get
    Then status 400
    And karate.log('status : 400')
    And match response.errors[0].message == "Invalid characters found."   
    
    And karate.log('Test Completed !')
  
  #REV2-11489
  Scenario: GET - Verify Allocation executive user cannot fetch Carrier rating for blank input
    Given param deliveryMode = ''
    When method get
    Then status 400
    And karate.log('status : 400')
    And match response.errors[0].message == "The Delivery mode field is mandatory"
    And match response.errorCount == 1
    And karate.log('Test Completed !')


  #REV2-14621
  Scenario: POST - Verify Allocation Executive cannot create Carrier rating configuration with all invalid values
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/carrier-rating.json')
    * eval requestPayload.deliveryMode = "Hand Delivery"
    * eval requestPayload.rating = 11
    * eval requestPayload.vendorId = "Carrier_300"
    * karate.log(requestPayload)
    When request requestPayload
    And method post
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message == "Rating value should be between 1 to 5"
    And match response.errorCount == 1
    And karate.log('Test Completed !')


  #REV2-14622
  Scenario: POST - Verify Allocation Executive cannot create Carrier rating configuration with blank values
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/carrier-rating.json')
    * eval requestPayload.deliveryMode = ""
    * eval requestPayload.rating = null
    * eval requestPayload.vendorId = ""
    * karate.log(requestPayload)
    When request requestPayload
    And method post
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[*].message contains "Rating should not be blank!"
    And match response.errors[*].message contains "deliveryMode should not be blank!"
    And match response.errors[*].message contains "vendorId should not be blank!"
    And match response.errorCount == 3
    And karate.log('Test Completed !')


  #REV2-14623
  Scenario: POST -  Verify Allocation Executive cannot create Carrier rating configuration if any invalid value in request
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/carrier-rating.json')
    * eval requestPayload.deliveryMode = "Courier"
    * eval requestPayload.rating = 12
    * eval requestPayload.vendorId = "Carrier_106"
    * karate.log(requestPayload)
    When request requestPayload
    And method post
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message == "Rating value should be between 1 to 5"
    And match response.errorCount == 1
    And karate.log('Test Completed !')


  #REV2-11549
  Scenario: PUT - Verify Allocation Executive can update Carrier Rating Configuration with valid values
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/carrier-rating-put.json')
    * eval requestPayload[0].deliveryMode = "Courier"
    * eval requestPayload[0].rating = 1
    * eval requestPayload[0].vendorId = "Carrier_101"
    * eval requestPayload[1].deliveryMode = "Courier"
    * eval requestPayload[1].rating = 2
    * eval requestPayload[1].vendorId = "Carrier_102"
    * karate.log(requestPayload)
    When request requestPayload
    And method put
    Then status 200
    And karate.log('Status : 200')
    And match response.successCode == "update.done"
    # Verify updated changes on GET method
    * def authToken = loginResult.accessToken
    * header Authorization = authToken
    And path '/hendrix/v1/carrier-ratings'
    Given param deliveryMode = 'Courier'
    And param page = 0
    And param size = 20
    When method get
    Then status 200
    And karate.log('status : 200')
    And match response.data[0].deliveryMode == "Courier"
    And match response.data[0].rating == 1
    And match response.data[0].vendorId == "Carrier_101"
    And match response.data[1].deliveryMode == "Courier"
    And match response.data[1].rating == 2
    And match response.data[1].vendorId == "Carrier_102"
    And match response.currentPage == 0
    And karate.log('Test Completed !')


  #REV2-11550
  Scenario: PUT - Verify Allocation Executive cannot update Carrier Rating Configuration with invalid values
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/carrier-rating-put.json')
    * eval requestPayload[0].deliveryMode = "Hand Delivery"
    * eval requestPayload[0].rating = 10
    * eval requestPayload[0].vendorId = "Carrier_200"
    * karate.log(requestPayload)
    When request requestPayload
    And method put
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message == "Rating value should be between 1 to 5"
    And match response.errorCount == 1
    And karate.log('Test Completed !')


  #REV2-11551
  Scenario: PUT - Verify Allocation Executive cannot update Carrier Rating Configuration with blank Carrier Rating and Carrier Id
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/carrier-rating-put.json')
    * eval requestPayload[0].deliveryMode = "Courier"
    * eval requestPayload[0].rating = null
    * eval requestPayload[0].vendorId = ""
    * karate.log(requestPayload)
    When request requestPayload
    And method put
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[*].message contains "vendorId should not be blank!"
    And match response.errors[*].message contains "Rating should not be blank!"
    And match response.errorCount == 2
    And karate.log('Test Completed !')

    