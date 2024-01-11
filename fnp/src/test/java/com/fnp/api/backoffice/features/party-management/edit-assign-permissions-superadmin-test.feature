Feature: Edit assign permission to Party Login scenarios for super admin user

	Background: 
       
    Given url backOfficeAPIBaseUrl
    And header Accept = 'application/json'
    And path 'simsim/v1/logins/'
    * def loginResult = callonce read('classpath:com/fnp/api/utils/generate-token.feature') {userType:"partyAdmin"}
    * def authToken = loginResult.accessToken
    * header Authorization = authToken
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/party/put-assign-permission.json')
   
    
	#REV2-18205
	Scenario: PUT - Verify super admin can assign permissions to Party Login with valid values.
    
		* def id = 'U_02905'
    * eval requestPayload[0] = "S_20216"
    * def permissionId =  requestPayload[0]
              
		Given path '/' + id + '/permissions'
    And request requestPayload
    When method put
    Then status 200
    And karate.log('Status : 200')
    And call read('./edit-assign-permissions-superadmin-test.feature@deactivatePermission') {id: "#(id)", permissionId: "#(permissionId)"}
              
              
	@deactivatePermission
  Scenario: deactivate the permission id
              
    * def id = __arg.id
    * def permissionId = __arg.permissionId
   
    Given path '/' + id + '/permissions/' + permissionId
    And request {}
    When method put
    Then status 200
    And karate.log('Status : 200')
    And karate.log('Test Completed !')
    
              
	#REV2-18206
  Scenario: PUT - Verify super admin cannot access permissions with invalid values in id.
    
    * def id = 'U_02904'
    * eval requestPayload[0] = "S_20216"
              
		Given path '/' + id + '/permissions'
    And request requestPayload
    When method put
    Then status 400
    And karate.log('Status : 400')
    And karate.log('Test Completed !')
    
    
	#REV2-18207
	Scenario: PUT - Verify super admin cannot access permissions with blank value in id 
    
		* def id = ''
    * eval requestPayload[0] = "S_20216"
    
    Given path '/' + id + '/permissions'
		And request requestPayload
		When method put
		Then status 400
		And karate.log('Status : 400')
		And match response.errors[*].errorCode contains "unprocessable.input.data"
		And match response.errors[*].message contains "Invalid input data"
		And karate.log('Test Completed !')
		
		
	#REV2-18208
	Scenario: PUT - Verify super admin cannot access permissions with blank value and spaces in id 
    
    * def id = '  '
    * eval requestPayload[0] = "S_20216"
    
    Given path '/' + id + '/permissions'
		And request requestPayload
		When method put
		Then status 404
		And karate.log('Status : 404')
		And match response.errors[*].errorCode contains "user.not_found"
		And match response.errors[*].message contains "User Not Found"
		And karate.log('Test Completed !')
		
	
	#REV2-18209
  Scenario: PUT - Verify super admin cannot access permission with not allowed value in id
    
    * def id = '!@#$%'
    * eval requestPayload[0] = "S_20216"
    
    Given path '/' + id + '/permissions'
		And request requestPayload
		When method put
		Then status 400
		And karate.log('Status : 400')
		And match response.errors[*].errorCode contains 'BAD_REQUEST'
		And match response.errors[*].message contains "http.request.rejected"
		And karate.log('Test Completed !')
		
	
	#REV2-18210
  Scenario: PUT - Verify super admin cannot access permissions with invalid values in permission id.
    
		* def id = 'U_02904'
    * eval requestPayload[0] = "ABCXYZ"
              
		Given path '/' + id + '/permissions'
    And request requestPayload
    When method put
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[*].errorCode contains 'permission.permission_not_present'
		And match response.errors[*].message contains "Permission is not present"
    And karate.log('Test Completed !')
    
 
	#REV2-18211
	Scenario: PUT - Verify super admin cannot access permissions with blank value in permission id 
    
    * def id = 'U_02904'
    * eval requestPayload[0] = ""
    
    Given path '/' + id + '/permissions'
		And request requestPayload
		When method put
		Then status 400
		And karate.log('Status : 400')
		And match response.errors[*].errorCode contains "permission.permission_not_present"
		And match response.errors[*].message contains "Permission is not present"
		And karate.log('Test Completed !')
		
		
	#REV2-18212
	Scenario: PUT - Verify super admin cannot access permissions with blank value and spaces in permission id 
    
    * def id = 'U_02904'
    * eval requestPayload[0] = "  "
    
    Given path '/' + id + '/permissions'
		And request requestPayload
		When method put
		Then status 400
		And karate.log('Status : 400')
		And match response.errors[*].errorCode contains "permission.permission_not_present"
		And match response.errors[*].message contains "Permission is not present"
		And karate.log('Test Completed !')
		
		
	#REV2-18213
	Scenario: PUT - Verify super admin cannot access permissions with not allowed values in permission id 
    
    * def id = 'U_02904'
    * eval requestPayload[0] = "!@#$%"
    
    Given path '/' + id + '/permissions'
		And request requestPayload
		When method put
		Then status 400
		And karate.log('Status : 400')
		And match response.errors[*].errorCode contains "permission.permission_not_present"
		And match response.errors[*].message contains "Permission is not present"
		And karate.log('Test Completed !')
		
   
	#REV2-18214
	Scenario: PUT - Verify super admin can assign permissions to Party Login with multiple permission valid values.
    
		* def id = 'U_02905'
    * def requestPayload =
		
      """
      [
      	"S_20216",
      	"S_20228"
      ]
      """
              
		Given path '/' + id + '/permissions'
    And request requestPayload
    When method put
    Then status 200
    And karate.log('Status : 200')
    And call read('./edit-assign-permissions-superadmin-test.feature@deactivatePermission') {id: "#(id)", permissionId: "S_20216"}
    And call read('./edit-assign-permissions-superadmin-test.feature@deactivatePermission') {id: "#(id)", permissionId: "S_20228"}
    And karate.log('Test Completed !')
   
  
	#REV2-18215
	Scenario: PUT - Verify super admin can assign permissions to Party Login with multiple valid values and permission id.
    
		* def id = 'U_02905','U_00853'
    * def requestPayload =
		
      """
      [
      	"S_20216",
      	"S_20217"
      ]
      """
               
		Given path '/' + id + '/permissions'
    And request requestPayload
    When method put
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[*].errorCode contains "permission.permission_already_exist"
		And match response.errors[*].message contains "Permission is already Present"
    And karate.log('Test Completed !')
		
	
	#REV2-18216
	Scenario: PUT - Verify super admin cannot accesss with Invalid Authentication Token
    	
    * def invalidAuthToken = "eyJraWQiOiJmbnAyIiwiYWxnIjoiUlMyNTYifQ"
    * header Authorization = invalidAuthToken
    * def id = 'U_02905'
    * eval requestPayload[0] = "S_20216"
    	
		Given path '/' + id + '/permissions'
		And request requestPayload
		When method put
		Then status 401
		And karate.log('Status : 401')
		And match response.errors[*].errorCode contains "UNAUTHORIZED"
		And match response.errors[*].message contains "Token Invalid! Authentication Required"
		And karate.log('Test Completed !')
			
		
	#REV2-18218
	Scenario: PUT - Verify super admin cannot access with Invalid value in Endpoint (URL)
    	
		* def id = 'U_02905'
    * eval requestPayload[0] = "S_20216"
    
		Given path '/' + id + '/permission'
		And request requestPayload
		When method put
		Then status 404
		And karate.log('Status : 404')
		And match response.errors[*].errorCode contains "NOT_FOUND"
  	And match response.errors[*].message contains "http.request.not.found"
		And karate.log('Test Completed !')
	
	
	#REV2-18219
	Scenario: GET - Verify super admin with Unsupported - Valid value in Endpoint URL
	
		* def id = 'U_02905'
    * eval requestPayload[0] = "S_20216"
			
		Given path '/' + id + '/permissions'
		When request requestPayload
		And method patch
	  Then status 405
		And karate.log('Status : 405')
		And match response.errors[0].message contains "Unsupported request Method"
		And karate.log('Test Completed !')
		
		
        
        
