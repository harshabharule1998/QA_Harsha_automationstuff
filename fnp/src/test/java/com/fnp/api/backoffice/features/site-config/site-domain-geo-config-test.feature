Feature: Site Domain Geo Config management APIs feature

  Background: 
    Given url backOfficeAPIBaseUrl
    And header Accept = 'application/json'
    And path '/beautyplus/v1'
    * def loginResult = callonce read('classpath:com/fnp/api/utils/generate-token.feature') {userType:"superAdminQA"}
    * def authToken = loginResult.accessToken
    * header Authorization = authToken

  @Regression
  Scenario: GET - Validate Currencies and Languages Based On valid Geos
    Given path '/geo-preference'
    And param geoIds = 'BGD,IND'
    And param isDefault = 'false'
    And param language = 'false'
    When method get
    Then status 200
    And karate.log('Status: 200')
    And match response[*].id == ["BGD","IND"]
    And karate.log('Response : ', response)
    And karate.log('Test Completed !')

  Scenario: GET - Validate Currencies and Languages Based On inValid Geos
    Given path '/geo-preference'
    And param geoIds = 'xyz'
    And param isDefault = 'false'
    And param language = 'false'
    When method get
    Then status 400
    And karate.log('Status: 400')
    And match response.errors[0].message contains 'Invalid geoIds'
    And karate.log('Response : ', response)
    And karate.log('Test Completed !')

  Scenario: GET - Validate Currencies and Languages Based On inValid end point
    Given path '/geo-preferences'
    And param geoIds = 'IND'
    And param isDefault = 'false'
    And param language = 'false'
    When method get
    Then status 404
    And karate.log('Status: 404')
    And match response.errors[0].message contains 'not.found'
    And karate.log('Response : ', response)
    And karate.log('Test Completed !')

  Scenario: GET - Validate Currencies and Languages Based On Blank Geos
    Given path '/geo-preference'
    And param geoIds = '  '
    And param isDefault = 'false'
    And param language = 'false'
    When method get
    Then status 400
    And karate.log('Status: 400')
    And match response.errors[0].message contains 'Invalid geoIds'
    And karate.log('Response : ', response)
    And karate.log('Test Completed !')

  Scenario: GET - Validate Currencies and Languages Based On Geos with invalid Authorization
    * def authToken = 'fjwasfsjgdsghdsjffasf'
    * header Authorization = authToken
    Given path '/geo-preference'
    And param geoIds = '  '
    And param isDefault = 'false'
    And param language = 'false'
    When method get
    Then status 401
    And karate.log('Status: 401')
    And match response.errors[0].message contains 'Authentication Required'
    And karate.log('Response : ', response)
    And karate.log('Test Completed !')

  @Regression
  Scenario: GET - Validate list of domain
    Given path '/sites'
    When method get
    Then status 200
    And karate.log('Status: 200')
    And assert response.total >= 0
    And match response.data[*].id contains 'fnp.com'
    And karate.log('Response : ', response)
    And karate.log('Test Completed !')

  Scenario: GET - Validate list of domain with inValid end point
    Given path '/sitess'
    When method get
    Then status 404
    And karate.log('Status: 404')
    And match response.errors[0].message contains 'not.found'
    And karate.log('Response : ', response)
    And karate.log('Test Completed !')

  Scenario: GET - Validate list of domain with invalid Authorization
    * def authToken = 'fjwasfsjgdsghdsjffasf'
    * header Authorization = authToken
    Given path '/sites'
    When method get
    Then status 401
    And karate.log('Status: 401')
    And match response.errors[0].message contains 'Authentication Required'
    And karate.log('Response : ', response)
    And karate.log('Test Completed !')

  @Regression
  Scenario: GET - Validate Geos, Currencies and Languages Based On valid Domain
    * def id = 'fnp.com'
    Given path '/sites/preference'
    And param siteId = id
    And param isDefault = 'false'
    And param language = 'false'
    And param geo = 'true'
    And param currency = 'false'
    When method get
    Then status 200
    And karate.log('Status: 200')
    And match response.id == id
    And karate.log('Response : ', response)
    And karate.log('Test Completed !')

  Scenario: GET - Validate Geos, Currencies and Languages Based On inValid Domain
    Given path '/sites/preference'
    And param siteId = 'xyz'
    And param isDefault = 'false'
    And param language = 'false'
    And param geo = 'true'
    And param currency = 'false'
    When method get
    Then status 400
    And karate.log('Status: 400')
    And match response.errors[0].message contains 'siteId not found'
    And karate.log('Response : ', response)
    And karate.log('Test Completed !')

  Scenario: GET - Validate Geos, Currencies and Languages Based On valid Domain with inValid end point
    Given path '/sites/preferences'
    And param siteId = 'fnp.com'
    And param isDefault = 'false'
    And param language = 'false'
    And param geo = 'true'
    And param currency = 'false'
    When method get
    Then status 404
    And karate.log('Status: 404')
    And match response.errors[0].message contains 'not.found'
    And karate.log('Response : ', response)
    And karate.log('Test Completed !')

  Scenario: GET - Validate Geos, Currencies and Languages Based On blank Domain
    Given path '/sites/preference'
    And param siteId = '  '
    And param isDefault = 'false'
    And param language = 'false'
    And param geo = 'true'
    And param currency = 'false'
    When method get
    Then status 400
    And karate.log('Status: 400')
    And match response.errors[0].message contains 'siteId not found'
    And karate.log('Response : ', response)
    And karate.log('Test Completed !')

  Scenario: GET - Validate Geos, Currencies and Languages Based On domain with invalid Authorization
    * def authToken = 'fjwasfsjgdsghdsjffasf'
    * header Authorization = authToken
    Given path '/sites/preference'
    And param siteId = 'fnp.com'
    And param isDefault = 'false'
    And param language = 'false'
    And param geo = 'true'
    And param currency = 'false'
    When method get
    Then status 401
    And karate.log('Status: 401')
    And match response.errors[0].message contains 'Authentication Required'
    And karate.log('Response : ', response)
    And karate.log('Test Completed !')

  @Regression
  Scenario: GET - Validate get All Domain geo Details
    Given path '/sites/preference/all'
    And param isDefault = 'false'
    And param language = 'false'
    And param geo = 'true'
    And param currency = 'false'
    When method get
    Then status 200
    And karate.log('Status: 200')
    And match response[*].id contains ["fnp.com","fnp.sg","fnp.ae","fnp.uk","man.uk"]
    And karate.log('Response : ', response)
    And karate.log('Test Completed !')

  Scenario: GET - Validate get All Domain geo Details with inValid end point
    Given path '/sites/preferences/all'
    And param isDefault = 'false'
    And param language = 'false'
    And param geo = 'true'
    And param currency = 'false'
    When method get
    Then status 404
    And karate.log('Status: 404')
    And match response.errors[0].message contains 'not.found'
    And karate.log('Response : ', response)
    And karate.log('Test Completed !')

  Scenario: GET - Validate get All Domain geo Details with invalid Authorization
    * def authToken = 'fjwasfsjgdsghdsjffasf'
    * header Authorization = authToken
    Given path '/sites/preference/all'
    And param isDefault = 'false'
    And param language = 'false'
    And param geo = 'true'
    And param currency = 'false'
    When method get
    Then status 401
    And karate.log('Status: 401')
    And match response.errors[0].message contains 'Authentication Required'
    And karate.log('Response : ', response)
    And karate.log('Test Completed !')
