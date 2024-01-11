Feature: API to Search Inactive Username scenarios


  Background: 
    Given url backOfficeAPIBaseUrl
    And header Accept = 'application/json'
    And path 'simsim/v1/logins/'
    * def loginResult = callonce read('classpath:com/fnp/api/utils/generate-token.feature') {userType:"superAdminQA"}
    * def authToken = loginResult.accessToken
    * header Authorization = authToken
  
  #REV2-15549
  Scenario: GET - Verify Super admin is able to fetch username for valid inactive username
    Given path '/search-inactive-username'  
    And param userName = 'te'
    When method get
		Then status 200
		And karate.log('Status : 200')
		And karate.log(' Records found : ', response)
		And match response.loginName contains '#notnull'
		And match response.id contains '#notnull'
		And match response.status contains false
		
	#REV2-15549
  Scenario: GET - Verify Super admin is able to fetch username for valid inactive username
    Given path '/search-inactive-username'  
    And param userName = 'testingfinal@gmail.com'
    When method get
		Then status 200
		And karate.log('Status : 200')
		And karate.log(' Records found : ', response)
		And match response.loginName contains '#notnull'
		And match response.id contains '#notnull'
		And match response.status contains true
		
		
	#REV2-15557
  Scenario: GET - Verify Super admin is able to fetch username unsupported Method
    Given path '/search-inactive-username'  
    And param userName = 'testingfinal@gmail.com'
    When method delete
		Then status 405
		And karate.log('Status : 405')
		And karate.log(' Records found : ', response)
		And match response.errors[0].errorCode contains 'unsupported.http.method'	
		And match response.errors[0].message contains 'Unsupported request Method. Contact the site administrator'
		
		
		
	#REV2-15556
  Scenario: GET - Verify Super admin is able to fetch username for invalid endpoint URL
    Given path 'simsim/v1/loginss//search-inactive-username'  
    And param userName = 'testingfinal@gmail.com'
    When method get
		Then status 404
		And karate.log('Status : 404')
		And karate.log(' Records found : ', response)
		And match response.errors[0].errorCode contains 'NOT_FOUND'	
		And match response.errors[0].message contains 'http.request.not.found'	
		
		
	#REV2-15554
  Scenario: GET - Verify Super admin is able to fetch username for invalid authorization token.
    * def invalidAuthToken = "eyJraWQiOiJmbnAyIiwiYWxnIjoiUlMyNTYifQ"
    * header Authorization = invalidAuthToken
    Given path '/search-inactive-username'  
    And param userName = 'testingfinal@gmail.com'
    When method get
		Then status 401
		And karate.log('Status : 401')
		And karate.log(' Records found : ', response)
		And match response.errors[0].errorCode contains 'UNAUTHORIZED'	
		And match response.errors[0].message contains 'Token Invalid! Authentication Required'
		
	
	#REV2-15553
  Scenario: GET - Verify Super admin is able to fetch username for not allowed values in userName.
    Given path '/search-inactive-username'  
    And param userName = '%25%25#$#'
    When method get
		Then status 404
		And karate.log('Status : 404')
		And karate.log(' Records found : ', response)
		And match response.errors[0].errorCode contains 'NOT_FOUND'	
		And match response.errors[0].message contains 'Username not found.'
		
		
	#REV2-15552
  Scenario: GET - Verify Super admin is able to fetch username for leading & trailing spaces in userName.
    Given path '/search-inactive-username'  
    And param userName = '  te  '
    When method get
		Then status 404
		And karate.log('Status : 404')
		And karate.log(' Records found : ', response)
		And match response.errors[0].errorCode contains 'NOT_FOUND'	
		And match response.errors[0].message contains 'Username not found.'	
		
	
		
	#REV2-15551
  Scenario: GET - Verify Super admin is able to fetch username for blank values in userName.
    Given path '/search-inactive-username'  
    And param userName = ''
    When method get
		Then status 404
		And karate.log('Status : 404')
		And karate.log(' Records found : ', response)
		And match response.errors[0].errorCode contains 'NOT_FOUND'	
		And match response.errors[0].message contains 'Username not found.'		
		
	
		
	#REV2-15550
  Scenario: GET - Verify Super admin is able to fetch username for invalid values in userName.
    Given path '/search-inactive-username'  
    And param userName = 'yzdd'
    When method get
		Then status 404
		And karate.log('Status : 404')
		And karate.log(' Records found : ', response)
		And match response.errors[0].errorCode contains 'NOT_FOUND'	
		And match response.errors[0].message contains 'Username not found.'		
