Feature: Fetch Plp sequence list feature

  Background: 
    Given url backOfficeAPIBaseUrl
    And header Accept = 'application/json'
    And path '/columbus/v1/categories'
    * def loginResult = callonce read('classpath:com/fnp/api/utils/generate-token.feature') {userType:"superAdminQA"}
    * def authToken = loginResult.accessToken
    * header Authorization = authToken
    * configure readTimeout = 10000
    * def today = new java.util.Date().time
    * def num = today + ""
    * def num = num.substring(8)
    * def categoryId = '8210100'
    * def invalidCategoryId = '821001X'
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/plp/product-sequence.json')
    

  #REV2-24521
  Scenario: GET - Verify product list sequencing based on valid CategoryID
  
    Given path '/productinsequences'
    And param categoryId = categoryId
    When method get
    Then status 200
    And karate.log('Status : 200')
    And karate.log('Response is:', response)
    And karate.log('Test Completed !')

  #REV2-24522-Failed testCases
  Scenario: GET - Verify product list sequencing based on invalid CategoryID
  
    Given path '/productinsequences'
    And param categoryId = invalidCategoryId
    When method get
    Then status 400
    And karate.log('Status : 400')
    And karate.log('Response is:', response)
    And karate.log('Test Completed !')

  #REV2-24523
  Scenario: GET - Verify product list sequencing based on blank CategoryID
  
    Given path '/productinsequences'
    And param categoryId = " "
    When method get
    Then status 400
    And karate.log('Status : 400')
    And karate.log('Response is:', response)
    And match response.errors[0].message contains "categoryId should not be blank or null"
    And match response.errors[0].field contains "categoryId"
    And karate.log('Test Completed !')

  #REV2-24524
  Scenario: GET - Verify product list sequencing based on invalid end point
  
    Given path '/productinsequenceses'
    And param categoryId = categoryId
    When method get
    Then status 404
    And karate.log('Status : 404')
    And karate.log('Response is:', response)
    And match response.errors[0].message contains "http.request.not.found"
    And karate.log('Test Completed !')

  Scenario: GET - Verify product list sequencing based on invalid end point
  
    Given path '/products/sequence/find/' + categoryId
    And param fromDate = "2022-01-09T18:30:00"
    And param toDate = "2022-02-09T18:30:00"
    When method get
    Then status 200
    And karate.log('Status : 200')
    And karate.log('Response is:', response)
    And match response contains "CAKE10042"
    And karate.log('Test Completed !')

  #REV2-24539
  Scenario: PUT - Verify update the sequence in sequencing page with valid category id
  
    * def requestPayload = requestPayload.sequence
    * eval requestPayload[0].sequence = 2
    * karate.log(requestPayload)
    Given path '/products/list/sequence/' + categoryId
    And request requestPayload
    When method put
    Then status 200
    And karate.log('Status : 200')
    And karate.log('Response is:', response)
    And match response.message contains "products updated successfully"
    And match response.categoryId == categoryId
    And karate.log('Test Completed !')

  #REV2-24540
  Scenario: PUT - Verify update the sequence in sequencing page with inValid category id
  
    * def categoryId = invalidCategoryId
    * def requestPayload = requestPayload.sequence
    * eval requestPayload[2].sequence = 2
    * karate.log(requestPayload)
    Given path '/products/list/sequence/' + categoryId
    And request requestPayload
    When method put
    Then status 400
    And karate.log('Status : 400')
    And karate.log('Response is:', response)
    And match response.errors[0].message contains "Invalid product ids"
    And karate.log('Test Completed !')

  #REV2-24541
  Scenario: PUT - Verify update the sequence in sequencing page with blank category id
  
    * def categoryId = ""
    * def requestPayload = requestPayload.sequence
    * eval requestPayload[1].sequence = 2
    * karate.log(requestPayload)
    Given path '/products/list/sequence/' + categoryId
    And request requestPayload
    When method put
    Then status 404
    And karate.log('Status : 404')
    And karate.log('Response is:', response)
    And match response.errors[0].message contains "http.request.not.found"
    And karate.log('Test Completed !')

  #REV2-24542
  Scenario: PUT - Verify update the sequence in sequencing page with invalid end point
  
    * def categoryId = categoryId
    * def requestPayload = requestPayload.sequence
    * eval requestPayload[1].sequence = 1
    * karate.log(requestPayload)
    Given path '/products/list/sequences/' + categoryId
    And request requestPayload
    When method put
    Then status 404
    And karate.log('Status : 404')
    And karate.log('Response is:', response)
    And match response.errors[0].message contains "http.request.not.found"
    And karate.log('Test Completed !')

  #REV2-24543
  Scenario: PUT - Verify update the multiple product sequence in sequencing page
  
    * def categoryId = categoryId
    * def requestPayload = requestPayload.sequence
    * eval requestPayload[0].sequence = 2
    * eval requestPayload[1].sequence = 1
    * karate.log(requestPayload)
    Given path '/products/list/sequence/' + categoryId
    And request requestPayload
    When method put
    Then status 200
    And karate.log('Status : 200')
    And karate.log('Response is:', response)
    And match response.message contains "products updated successfully"
    And karate.log('Test Completed !')

  #REV2-24544
  Scenario: PUT - Verify update the multiple product sequence in sequencing page based on all valid input combination
  
    * def categoryId = categoryId
    * def requestPayload = requestPayload.sequence
    * eval requestPayload[0].sequence = 3
    * eval requestPayload[1].sequence = 1
    * karate.log(requestPayload)
    Given path '/products/list/sequence/' + categoryId
    And request requestPayload
    When method put
    Then status 200
    And karate.log('Status : 200')
    And karate.log('Response is:', response)
    And match response.message contains "products updated successfully"
    And karate.log('Test Completed !')

  #REV2-24545
  Scenario: PUT - Verify update the multiple product sequence in sequencing page based on all inValid input combination
  
    * def categoryId = categoryId
    * def requestPayload = requestPayload.sequence
    * eval requestPayload[0].sequence = 3
    * eval requestPayload[1].sequence = 9999999999999999
    * karate.log(requestPayload)
    Given path '/products/list/sequence/' + categoryId
    And request requestPayload
    When method put
    Then status 400
    And karate.log('Status : 400')
    And karate.log('Response is:', response)
    And match response.errors[0].message contains "Invalid input data"
    And karate.log('Test Completed !')

  #REV2-24546/REV2-24547
  Scenario: PUT - Verify Move courier into bottom in sequencing page
  
    * def categoryId = categoryId
    * def requestPayload = {}
    * karate.log(requestPayload)
    Given path '/products/movecourierbottom/' + categoryId
    And request requestPayload
    When method put
    Then status 200
    And karate.log('Status : 200')
    And karate.log('Response is:', response)
    And match response.message contains "Products moved to bottom"
    And karate.log('Test Completed !')

  #REV2-24548
  Scenario: PUT - Verify Move courier into bottom in sequencing page with invalid id
  
    * def categoryId = invalidCategoryId
    * def requestPayload = { }
    * karate.log(requestPayload)
    Given path '/products/movecourierbottom/' + categoryId
    And request requestPayload
    When method put
    Then status 400
    And karate.log('Status : 400')
    And karate.log('Response is:', response)
    And match response.errors[0].message contains "Product does not exist for CategoryId"
    And karate.log('Test Completed !')

  #REV2-24549
  Scenario: PUT - Verify Move courier into bottom in sequencing page with blank id
  
    * def categoryId = " "
    * def requestPayload = { }
    * karate.log(requestPayload)
    Given path '/products/movecourierbottom/' + categoryId
    And request requestPayload
    When method put
    Then status 400
    And karate.log('Status : 400')
    And karate.log('Response is:', response)
    And match response.errors[0].message contains "id should not be blank or null"
    And karate.log('Test Completed !')

  #REV2-24550
  Scenario: PUT - Verify Move courier into bottom in sequencing page with invalid end point
  
    * def categoryId = categoryId
    * def requestPayload = { }
    * karate.log(requestPayload)
    Given path '/products/movecourierbottoms/' + categoryId
    And request requestPayload
    When method put
    Then status 404
    And karate.log('Status : 404')
    And karate.log('Response is:', response)
    And match response.errors[0].message contains "http.request.not.found"
    And karate.log('Test Completed !')

  #REV2-24551
  Scenario: PUT - Verify update the sequence in sequencing page with valid id and sequence Number
  
    * def requestPayload = requestPayload.sequence
    * eval requestPayload[0].sequence = 2
    * karate.log(requestPayload)
    Given path '/products/list/sequence/' + categoryId
    And request requestPayload
    When method put
    Then status 200
    And karate.log('Status : 200')
    And karate.log('Response is:', response)
    And match response.message contains "products updated successfully"
    And match response.categoryId == categoryId
    And karate.log('Test Completed !')

  #REV2-24552
  Scenario: PUT - Verify update the sequence in sequencing page with inValid id and sequence number
  
    * def categoryId = invalidCategoryId
    * def requestPayload = requestPayload.sequence
    * eval requestPayload[2].sequence = 999999999999
    * karate.log(requestPayload)
    Given path '/products/list/sequence/' + categoryId
    And request requestPayload
    When method put
    Then status 400
    And karate.log('Status : 400')
    And karate.log('Response is:', response)
    And match response.errors[0].message contains "Invalid input data"
    And karate.log('Test Completed !')

  #REV2-24553
  Scenario: PUT - Verify update the sequence in sequencing page with blank id and sequence number
  
    * def categoryId = ""
    * def requestPayload = requestPayload.sequence
    * eval requestPayload[1].sequence = ""
    * karate.log(requestPayload)
    Given path '/products/list/sequence/' + categoryId
    And request requestPayload
    When method put
    Then status 404
    And karate.log('Status : 404')
    And karate.log('Response is:', response)
    And match response.errors[0].message contains "http.request.not.found"
    And karate.log('Test Completed !')

  #REV2-24554
  Scenario: PUT - Verify update the sequence in sequencing page with invalid end point
  
    * def categoryId = categoryId
    * def requestPayload = requestPayload.sequence
    * eval requestPayload[1].sequence = 1
    * karate.log(requestPayload)
    Given path '/products/list/sequences/' + categoryId
    And request requestPayload
    When method put
    Then status 404
    And karate.log('Status : 404')
    And karate.log('Response is:', response)
    And match response.errors[0].message contains "http.request.not.found"
    And karate.log('Test Completed !')
  
 
  #REV2-24555
  Scenario: PUT - Verify update and move products to top with valid id
  
    * def requestPayload = requestPayload.filterAction
    * karate.log(requestPayload)
    Given path '/products/sequence/move/' + categoryId
    And request requestPayload
    When method put
    Then status 200
    And karate.log('Status : 200')
    And karate.log('Response is:', response)
    And match response.message contains "products moved to top"
    And match response.categoryId == categoryId
    And karate.log('Test Completed !')

 
  #REV2-24556
  Scenario: PUT - Verify update and move products to top with inValid id
  
    * def categoryId = invalidCategoryId
    * def requestPayload = requestPayload.filterAction
    * karate.log(requestPayload)
    Given path '/products/sequence/move/' + categoryId
    And request requestPayload
    When method put
    Then status 400
    And karate.log('Status : 400')
    And karate.log('Response is:', response)
    And match response.errors[0].message contains "Product does not exist for CategoryId"
    And karate.log('Test Completed !')
    
  
  #REV2-24557
  Scenario: PUT - Verify update and move products to top with blank id
  
    * def categoryId = " "
    * def requestPayload = requestPayload.filterAction
    * karate.log(requestPayload)
    Given path '/products/sequence/move/' + categoryId
    And request requestPayload
    When method put
    Then status 400
    And karate.log('Status : 400')
    And karate.log('Response is:', response)
    And match response.errors[0].field == "id"
    And match response.errors[0].message contains "id should not be blank or null"
    And karate.log('Test Completed !')
    
   
  #REV2-24558
  Scenario: PUT - Verify update and move products to top with inValid end point
  
    * def categoryId = categoryId
    * def requestPayload = requestPayload.filterAction
    * karate.log(requestPayload)
    Given path '/products/sequence/moves/' + categoryId
    And request requestPayload
    When method put
    Then status 404
    And karate.log('Status : 404')
    And karate.log('Response is:', response)    
    And match response.errors[0].message contains "http.request.not.found"
    And karate.log('Test Completed !')