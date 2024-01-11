Feature: Party Create a new Permission API Scenarios feature

  Background: 
    Given url backOfficeAPIBaseUrl
    And header Accept = 'application/json'
    And path '/simsim/v1/permissions'
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/create-permissions.json')
    * def loginResult = callonce read('classpath:com/fnp/api/utils/generate-token.feature') {userType:"superAdminQA"}
    * def authToken = loginResult.accessToken
    * header Authorization = authToken
    
    * def random_string =
      """
          function(s) {
          var text = "";
          var possible = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
              
              for (var i = 0; i < s; i++)
                text += possible.charAt(Math.floor(Math.random() * possible.length));
          
          return text;
          }
      """
    * def randomText =  random_string(4)


  #REV2-18397
  Scenario: POST - Verify the API Response to create new permission for valid permissionCode & permissionName in request body
  
    * eval requestPayload.permissionCode = "P_PM_" + randomText
    * eval requestPayload.permissionName = "Create User"
    
    Given request requestPayload
    When method post
    Then status 201
    And karate.log('Status : 201')
    And match response.permissionCode contains "P_PM_"
    And match response.permissionName contains "Create User"
    And karate.log('Test Completed !')
    

  #REV2-18398
  Scenario: POST - Verify the API Response to create new permission for invalid data in permissionCode in request body
  
    * eval requestPayload.permissionCode = "!@##"
    * eval requestPayload.permissionName = "Create User"
    
    Given request requestPayload
    When method post
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].errorCode == "INVALID_DATA"
    And match response.errors[0].message == "Permission code value can contain alphanumeric and underscore characters only"
    And karate.log('Test Completed !')
    

  Scenario: POST - Verify the API Response to create new permission for invalid permissionCode (must not be greater than 16) in request body
  
    * eval requestPayload.permissionCode = "P_PER_AAAAOKIHYTGGFFFG"
    * eval requestPayload.permissionName = "Create User"
    
    Given request requestPayload
    When method post
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].errorCode == "INVALID_DATA"
    And match response.errors[0].message == "Permission code must not be greater than 16"
    And karate.log('Test Completed !')


  #REV2-18399
  Scenario: POST - Verify the API Response to create new permission for invalid data in permissionName in request body
  
    * eval requestPayload.permissionCode = "P_C_SUP"
    * eval requestPayload.permissionName = "!@#$"
    
    Given request requestPayload
    When method post
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].errorCode == "INVALID_DATA"
    And match response.errors[0].message == "Permission name value can contain alphanumeric, space and underscore characters only"
    And karate.log('Test Completed !')


  Scenario: POST - Verify the API Response to create new permission for invalid permissionName (must not be greater than 60) in request body
  
    * eval requestPayload.permissionCode = "P_PER_AM"
    * eval requestPayload.permissionName = "Create User Managemnt Cycle Party Management Roles Personal Dashboard Relationship"
    
    Given request requestPayload
    When method post
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].errorCode == "INVALID_DATA"
    And match response.errors[0].message == "Permission name must not be greater than 60"
    And karate.log('Test Completed !')


  #REV2-18400
  Scenario: POST - Verify the API Response to create new permission for blank fields in request body
  
    * eval requestPayload.permissionCode = ""
    * eval requestPayload.permissionName = ""
    
    Given request requestPayload
    When method post
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].errorCode == "INVALID_DATA"
    And match response.errors[0].message == "Permission code must not be blank"
    And match response.errors[1].errorCode == "INVALID_DATA"
    And match response.errors[1].message == "Permission name must not be blank"
    And karate.log('Test Completed !')


  #REV2-18401
  Scenario: POST - Verify the API Response to create new permission for duplicate values in request body
  
    * eval requestPayload.permissionCode = "P_PM_" + randomText
    * eval requestPayload.permissionName = "Create User"
    
    Given request requestPayload
    When method post
    Then status 201
    And karate.log('Status : 201')
    And match response.permissionCode contains "P_PM_"
    And match response.permissionName contains "Create User"
    
    #Duplicate Permission Created
    
    * header Authorization = authToken
    
    Given path '/simsim/v1/permissions'
    And request requestPayload
    When method post
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].errorCode == "permission.permission_already_exist"
    And match response.errors[0].message == "Permission is already Present"
    And karate.log('Test Completed !')


  #REV2-18402
  Scenario: POST - Verify the API Response to create new permission for leading and trailing spaces in valid permissionCode
  
    * eval requestPayload.permissionCode = " P_PER_C "
    * eval requestPayload.permissionName = "Create Permission"
    
    Given request requestPayload
    When method post
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].errorCode == "INVALID_DATA"
    And match response.errors[0].message == "Permission code value can contain alphanumeric and underscore characters only"
    And karate.log('Test Completed !')


  #REV2-18404
  Scenario: POST - Verify the API Response to create new permission for valid request body and Invalid Endpoint URL
  
    * eval requestPayload.permissionCode = "P_PER_CA"
    * eval requestPayload.permissionName = "Party Management"
    
    Given path 'permis'
    And request requestPayload
    When method post
    Then status 404
    And karate.log('Status : 404')
    And match response.errors[0].errorCode == "NOT_FOUND"
    And match response.errors[0].message contains "not.found"
    And karate.log('Test Completed !')


  #REV2-18405
  Scenario: PATCH - Unsupported Method to create new permission for valid Endpoint URL
  
    * eval requestPayload.permissionCode = "P_PER_CA"
    * eval requestPayload.permissionName = "Party Management"
    
    Given request requestPayload
    When method patch
    Then status 405
    And karate.log('Status : 405')
    And match response.errors[*].message contains "Unsupported request Method. Contact the site administrator"
    And karate.log('Test Completed !')
