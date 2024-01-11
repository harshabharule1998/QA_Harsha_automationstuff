Feature: Carrier rating scenarios for Super Admin role


  Background: 
    Given url backOfficeAPIBaseUrl
    And header Accept = "application/json"
    And path '/hendrix/v1/carrier-ratings'
    * def loginResult = callonce read('classpath:com/fnp/api/utils/generate-token.feature') {userType:"superAdminQA"}
    * def authToken = loginResult.accessToken
    * header Authorization = authToken


  #REV2-11479
  Scenario: GET - Verify Method: GET request for Carrier Rating Configuration with Super Admin access for - Valid Delivery Mode

    Given param deliveryMode = "hd"
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


	#REV2-11480
	Scenario: GET - Verify Method: GET request for Carrier Rating Configuration with Super Admin access for - Invalid
	 Delivery Mode
	 
	  Given param deliveryMode = "abc@fnp.com"
    And param page = 0
    And param size = 10
    When method get
    Then status 400
    And karate.log('status : 400')
    And match response.errors[0].message == "Invalid characters found."   
    And karate.log('Test Completed !')
	
	
  #REV2-11481
  Scenario: GET - Verify Super admin user cannot fetch Carrier rating for blank input
    Given param deliveryMode = ' '
    When method get
    Then status 400
    And karate.log('status : 400')
    And match response.errors[0].message == "The Delivery mode field is mandatory"
    And match response.errorCount == 1
    And karate.log('Test Completed !')


  #REV2-11482
  Scenario: GET - Verify 404 error for Carrier rating invalid endpoint URL
    Given path '/hendrix/v1/arrier-ratings'
    And param deliveryMode = "Courier"
    When method get
    Then status 404
    And karate.log('status : 404')
    And match response.errors[0].message == "http.request.not.found"
    And match response.errorCount == 1
    And karate.log('Test Completed !')


  #REV2-11484
  Scenario: GET - Verify 405 error for unsupported method
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/carrier-rating.json')
    * eval requestPayload.deliveryMode = "hd"
    When request requestPayload
    And method patch
    Then status 405
    And karate.log('status : 405')
    And match response.errors[0].message == "METHOD_NOT_ALLOWED"
    And match response.errorCount == 1
    And karate.log('Test Completed !')


  #REV2-11486
  Scenario: GET - Verify error for invalid authorization token
    * def invalidAuthToken = "eyJraWQiOiJmbnAyIiwiYWxnIjoiUlMyNTYifQ"
    * header Authorization = invalidAuthToken
    Given param deliveryMode = "hd"
    When method get
    Then status 401
    And karate.log('Status : 401')
    And match response.errors[0].message == "Token Invalid! Authentication Required"
    And match response.errorCount == 1
    And karate.log('Test Completed !')


  #REV2-14605
  Scenario: POST - Verify Super Admin cannot create Carrier rating configuration with all invalid values
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/carrier-rating.json')
    * eval requestPayload.deliveryMode = "Hand Delivery"
    * eval requestPayload.rating = 10
    * eval requestPayload.vendorId = "Carrier_200"
    * karate.log(requestPayload)
    When request requestPayload
    And method post
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message == "Rating value should be between 1 to 5"
    And match response.errorCount == 1
    And karate.log('Test Completed !')


  #REV2-14606
  Scenario: POST - Verify Super Admin cannot create Carrier rating configuration with blank values
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


  #REV2-14609
  Scenario: POST - Verify 405 error for unsupported method for Carrier rating configuration
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/carrier-rating.json')
    * eval requestPayload.deliveryMode = "Courier"
    * eval requestPayload.rating = 3
    * eval requestPayload.vendorId = "Carrier_105"
    * karate.log(requestPayload)
    When request requestPayload
    And method patch
    Then status 405
    And karate.log('status : 405')
    And match response.errors[0].message == "METHOD_NOT_ALLOWED"
    And match response.errorCount == 1
    And karate.log('Test Completed !')


  #REV2-14611
  Scenario: POST - Verify Super Admin cannot create Carrier rating configuration if any invalid value in request
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/carrier-rating.json')
    * eval requestPayload.deliveryMode = "Courier"
    * eval requestPayload.rating = 10
    * eval requestPayload.vendorId = "Carrier_105"
    * karate.log(requestPayload)
    When request requestPayload
    And method post
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message == "Rating value should be between 1 to 5"
    And match response.errorCount == 1
    And karate.log('Test Completed !')


  #REV2-14615
  Scenario: POST - Verify Super Admin cannot create Carrier rating configuration with duplicate vendor Id
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/carrier-rating.json')
    * eval requestPayload.deliveryMode = "Courier"
    * eval requestPayload.rating = 3
    * eval requestPayload.vendorId = "Carrier_105"
    * karate.log(requestPayload)
    When request requestPayload
    And method post
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message == "Carrier Rating already exists."
    And match response.errorCount == 1
    And karate.log('Test Completed !')


  #REV2-14617
  Scenario: POST - Verify 401 error for invalid authorization token for Carrier rating configuration
    * def invalidAuthToken = "eyJraWQiOiJmbnAyIiwiYWxnIjoiUlMyNTYifQ"
    * header Authorization = invalidAuthToken
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/carrier-rating.json')
    * eval requestPayload.deliveryMode = "Courier"
    * eval requestPayload.rating = 3
    * eval requestPayload.vendorId = "Carrier_105"
    * karate.log(requestPayload)
    When request requestPayload
    And method post
    Then status 401
    And karate.log('Status : 401')
    And match response.errors[0].message == "Token Invalid! Authentication Required"
    And match response.errorCount == 1
    And karate.log('Test Completed !')


  #REV2-14618
  Scenario: POST - Verify 404 error for Carrier rating configuration invalid endpoint URL
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/carrier-rating.json')
    * eval requestPayload.deliveryMode = "Courier"
    * eval requestPayload.rating = 3
    * eval requestPayload.vendorId = "Carrier_108"
    * eval requestPayload.test = "test"
    * karate.log(requestPayload)
    Given path '/hendrix/v1/arrier-ratings'
    When request requestPayload
    And method post
    Then status 404
    And karate.log('status : 404')
    And match response.errors[0].message == "http.request.not.found"
    And match response.errorCount == 1
    And karate.log('Test Completed !')


  #REV2-14619
  Scenario: POST - Verify error for Carrier rating configuration if there are invalid data in request body
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/carrier-rating.json')
    * eval requestPayload.deliveryMode = "Courier"
    * eval requestPayload.rating = 3
    * eval requestPayload.vendorId = "Carrier_107"
    * eval requestPayload.test = "test"
    * karate.log(requestPayload)
    When request requestPayload
    And method post
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message == "Invalid_Input_Data"
    And match response.errorCount == 1
    And karate.log('Test Completed !')


  #REV2-11532, REV2-11535, REV2-11547
  Scenario: PUT - Verify Super Admin can update Carrier Rating Configuration with valid values
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/carrier-rating-put.json')
    * eval requestPayload[0].deliveryMode = "Courier"
    * eval requestPayload[0].rating = 2
    * eval requestPayload[0].vendorId = "Carrier_101"
    * eval requestPayload[1].deliveryMode = "Courier"
    * eval requestPayload[1].rating = 4
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
    And match response.data[0].rating == 2
    And match response.data[0].vendorId == "Carrier_101"
    And match response.data[1].deliveryMode == "Courier"
    And match response.data[1].rating == 4
    And match response.data[1].vendorId == "Carrier_102"
    And match response.currentPage == 0
    And karate.log('Test Completed !')


  #REV2-11534
  Scenario: PUT - Verify Super Admin cannot update Carrier rating Configuration with blank Carrier rating
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/carrier-rating-put.json')
    * eval requestPayload[0].deliveryMode = "Courier"
    * eval requestPayload[0].rating = null
    * eval requestPayload[0].vendorId = "Carrier_106"
    * karate.log(requestPayload)
    When request requestPayload
    And method put
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message == "Rating should not be blank!"
    And match response.errorCount == 1
    And karate.log('Test Completed !')


  #REV2-11537
  Scenario: PUT - Verify Super Admin cannot update Carrier rating Configuration with blank Carrier Id
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/carrier-rating-put.json')
    * eval requestPayload[0].deliveryMode = "Courier"
    * eval requestPayload[0].rating = 4
    * eval requestPayload[0].vendorId = ""
    * karate.log(requestPayload)
    When request requestPayload
    And method put
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message == "vendorId should not be blank!"
    And match response.errorCount == 1
    And karate.log('Test Completed !')


  #REV2-11533, REV2-11548
  Scenario: PUT - Verify Super Admin cannot update Carrier Rating Configuration with invalid values
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


  #REV2-11545
  Scenario: PUT - Verify Super Admin cannot update Carrier Rating Configuration with valid Carrier Id and invalid Carrier Rating
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/carrier-rating-put.json')
    * eval requestPayload[0].deliveryMode = "Courier"
    * eval requestPayload[0].rating = 10
    * eval requestPayload[0].vendorId = "Carrier_111"
    * eval requestPayload[1].deliveryMode = "Courier"
    * eval requestPayload[1].rating = 12
    * eval requestPayload[1].vendorId = "Carrier_112"
    * karate.log(requestPayload)
    When request requestPayload
    And method put
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message == "Rating value should be between 1 to 5"
    And match response.errors[1].message == "Rating value should be between 1 to 5"
    And match response.errorCount == 2
    And karate.log('Test Completed !')


  #REV2-11536, REV2-11546
  Scenario: PUT - Verify Super Admin cannot update Carrier Rating Configuration with invalid Carrier ID and valid Carrier Rating
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/carrier-rating-put.json')
    * eval requestPayload[0].deliveryMode = "Courier"
    * eval requestPayload[0].rating = 4
    * eval requestPayload[0].vendorId = "Carrier_200"
    * karate.log(requestPayload)
    When request requestPayload
    And method put
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message == "Unknown Vendor(Id,Info) added to request"
    And match response.errorCount == 1
    And karate.log('Test Completed !')


  #REV2-11540
  Scenario: PUT - Verify 404 error for invalid Carrier Rating Configuration endpoint URL
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/carrier-rating-put.json')
    * eval requestPayload[0].deliveryMode = "Courier"
    * eval requestPayload[0].rating = 4
    * eval requestPayload[0].vendorId = "Carrier_109"
    * karate.log(requestPayload)
    Given path '/hendrix/v1/arrier-ratings'
    When request requestPayload
    And method put
    Then status 404
    And karate.log('status : 404')
    And match response.errors[0].message == "http.request.not.found"
    And match response.errorCount == 1
    And karate.log('Test Completed !')


  #REV2-11542
  Scenario: PUT - Verify 405 error for unsupported method for Carrier Rating Configuration
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/carrier-rating-put.json')
    * eval requestPayload[0].deliveryMode = "Courier"
    * eval requestPayload[0].rating = 4
    * eval requestPayload[0].vendorId = "Carrier_109"
    * karate.log(requestPayload)
    When request requestPayload
    And method patch
    Then status 405
    And karate.log('status : 405')
    And match response.errors[0].message == "METHOD_NOT_ALLOWED"
    And match response.errorCount == 1
    And karate.log('Test Completed !')


  #REV2-11543
  Scenario: PUT - Verify 401 error for invalid authorization token for Carrier rating configuration
    * def invalidAuthToken = "eyJraWQiOiJmbnAyIiwiYWxnIjoiUlMyNTYifQ"
    * header Authorization = invalidAuthToken
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/carrier-rating-put.json')
    * eval requestPayload[0].deliveryMode = "Courier"
    * eval requestPayload[0].rating = 5
    * eval requestPayload[0].vendorId = "Carrier_105"
    * karate.log(requestPayload)
    When request requestPayload
    And method put
    Then status 401
    And karate.log('Status : 401')
    And match response.errors[0].message == "Token Invalid! Authentication Required"
    And match response.errorCount == 1
    And karate.log('Test Completed !')

    