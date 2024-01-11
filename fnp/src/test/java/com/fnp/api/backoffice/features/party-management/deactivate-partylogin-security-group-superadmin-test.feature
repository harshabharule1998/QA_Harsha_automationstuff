Feature: Deactivate PartyLogin Security group Scenarios for Super Admin 

  Background: 
    Given url backOfficeAPIBaseUrl
    And header Accept = 'application/json'
    And path '/simsim/v1/logins'
    * def loginResultPartyView = callonce read('classpath:com/fnp/api/utils/generate-token.feature') {userType:"partyAdmin"}
    * def authTokenPartyView = loginResultPartyView.accessToken
    * header Authorization = authTokenPartyView
    * def id = 'U_02905'
    * def securityGroupId = 'S_10502'
    * def invalidId = 'U_02904'
    * def invalidsecurityGroupId = 'S_10504'
    * def deactivatedsecurityGroupId = 'S_10501'
    
	
  #REV2-18322
  Scenario: PUT - Verify SuperAdmin cannot access with invalid value in id
  
    Given path '/' + id + '/securitygroups/' + securityGroupId + invalidId
    And request {}
    When method put
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[*].message contains "securityGroup.security_group_not_found"
    And karate.log('Test Completed !')
    

  #REV2-18323
  Scenario: PUT - Verify SuperAdmin cannot access for invalid value in securityGroupId 
  
    Given path '/' + id + '/securitygroups/' + securityGroupId + invalidsecurityGroupId
    And request {}
    When method put
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[*].message contains "securityGroup.security_group_not_found"
    And karate.log('Test Completed !')
    

  #REV2-18324
  Scenario: PUT - Verify SuperAdmin cannot access for blank value in Id 
  
    Given path '/' + '' + '/securitygroups/' + securityGroupId
    And request {}
    When method put
    Then status 404
    And karate.log('Status : 404')
    And match response.errors[*].message contains "http.request.not.found"
    And karate.log('Test Completed !')

  
  #REV2-18325
  Scenario: PUT - Verify SuperAdmin cannot access for blank value in securityGroupId
  
    Given path '/' + id + '/securitygroups/' + ' '
    And request {}
    When method put
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[*].message contains "securityGroup.security_group_not_found"
    And karate.log('Test Completed !')


  #REV2-18326
  Scenario: PUT - Verify SuperAdmin cannot access for not allowed value in Id 
  
    Given path '/' + id + '/securitygroups/' + securityGroupId + deactivatedsecurityGroupId
    And request {}
    When method put
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[*].message contains "securityGroup.security_group_not_found"
    And karate.log('Test Completed !')

  
  #REV2-18327
  Scenario: PUT - Verify SuperAdmin cannot access for blank value with leading & trailing spaces in Id
   
    Given path '/' +' id ' + '/securitygroups/' + securityGroupId
    And request {}
    When method put
    Then status 404
    And karate.log('Status : 404')
    And match response.errors[*].message contains "User Not Found"
    And karate.log('Test Completed !')

  
  #REV2-18328
  Scenario: PUT - Verify SuperAdmin cannot access for blank value with leading & trailing spaces in Securitygroupid
  
    Given path '/' + id  + '/securitygroups/' + ' securityGroupId '
    And request {}
    When method put
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[*].message contains "securityGroup.security_group_not_found"
    And karate.log('Test Completed !')

  
  #REV2-18329
  Scenario: PUT - Verify SuperAdmin cannot access with Invalid value in Endpoint (URL)
  
    Given path '/' + id + '/securitygroup/' + securityGroupId
    And request {}
    When method put
    Then status 404
    And karate.log('Status : 404')
    And match response.errors[*].message contains "http.request.not.found"
    And karate.log('Test Completed !')

	
  #REV2-18330
  Scenario: Verify SuperAdmin cannot access with Unsupported Method  
  
    Given path '/' + id + '/securitygroups/' + securityGroupId
    And request {}
    When method delete
    Then status 405
    And karate.log('Status : 405')
    And match response.errors[*].message contains "Unsupported request Method. Contact the site administrator"
    And karate.log('Test Completed !')

  
  #REV2-18331
  Scenario: PUT - Verify Invalid Authentication Token for SuperAdmin access.
  
    * def invalidAuthToken = "eyJraWQiOiJmbnAyIiwiYWxnIjoiUlMyNTYifQ"
    * header Authorization = invalidAuthToken
    
    Given path '/' + id + '/securitygroups/' + securityGroupId
    And request {}
    When method put
    Then status 401
    And karate.log('Status : 401')
    And match response.errors[*].message contains "Token Invalid! Authentication Required"
    And karate.log('Test Completed !')
