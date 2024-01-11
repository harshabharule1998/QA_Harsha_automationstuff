Feature: Party assign security groups to party login scenarios for super admin

	Background: 
	
		Given url backOfficeAPIBaseUrl
    And header Accept = 'application/json'
    And path 'simsim/v1/logins/'
    * def loginResult = callonce read('classpath:com/fnp/api/utils/generate-token.feature') {userType:"partyAdmin"}
    * def authToken = loginResult.accessToken
    * header Authorization = authToken
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/party/put-assign-security-groups.json')
   
  
	#REV2-18255
	Scenario: PUT - Verify super admin cannot assign security groups to Party Login with Invalid Authentication Token
		
		* def loginId = 'U_02905'
		* eval requestPayload[0] = "S_10502"
		* def invalidAuthToken = "eyJraWQiOiJmbnAyIiwiYWxnIjoiUlMyNTYifQ"
    * header Authorization = invalidAuthToken
		
		Given path '/' + loginId + '/securitygroups'
		And request requestPayload
		When method put
		Then status 401
		And karate.log('Status : 401')
		And match response.errors[0].errorCode contains "UNAUTHORIZED"
		And match response.errors[0].message contains "Token Invalid! Authentication Required"
		And karate.log('Test Completed !')
		
	
	#REV2-18254
	Scenario: PUT - Verify super admin cannot assign security groups to Party Login with Unsupported Method
		
		* def loginId = 'U_02905'
		* eval requestPayload[0] = "S_10502"
		
		Given path '/' + loginId + '/securitygroups'
		And request requestPayload
		When method post
		Then status 405
		And karate.log('Status : 405')
		And match response.errors[0].errorCode contains "unsupported.http.method"
		And match response.errors[0].message contains "Unsupported request Method. Contact the site administrator"
		And karate.log('Test Completed !')
		
	
	#REV2-18253
	Scenario: PUT - Verify super admin cannot assign security groups to Party Login with Invalid value in Endpoint URL
		
		* def loginId = 'U_02905'
		* eval requestPayload[0] = "S_10502"
		
		Given path '/' + loginId + '/test' + '/securitygroups'
		And request requestPayload
		When method put
		Then status 404
		And karate.log('Status : 404')
		And match response.errors[0].errorCode contains "NOT_FOUND"
		And match response.errors[0].message contains "http.request.not.found"
		And karate.log('Test Completed !')
		
		
	#REV2-18252
	Scenario: PUT - Verify super admin cannot assign security groups to Party Login with multiple valid values in loginId and multiple valid values in securityGroups
		
		* def loginId = 'U_02905,U_00853'
		* eval requestPayload = ["S_10502","S_10103"]
		
		Given path '/' + loginId + '/securitygroups'
		And request requestPayload
		When method put
		Then status 404
		And karate.log(requestPayload)
		And karate.log('Status : 404')
		And match response.errors[0].errorCode contains "user.not_found"
		And match response.errors[0].message contains "User Not Found"
		And karate.log('Test Completed !')
		
			
	#REV2-18251
	Scenario: PUT - Verify super admin can assign security groups to Party Login with valid value in loginId and multiple valid values in securityGroups
		
		* def loginId = 'U_00853'
		* def requestPayload =
		
      """
      [
      	"U_00502",
      	"U_00607"
      ]
      """
      
		Given path '/' + loginId + '/securitygroups'
		And request requestPayload
		When method put
		Then status 200
		And karate.log (requestPayload)
		And karate.log('Status : 200')
		#Deactivating the assigned Security Group
		And call read('./party-edit-security-groups-superadmin-test.feature@deactivateSecurityGroup') {loginId: "#(loginId)", securityGrpId: "U_00502"}
		And call read('./party-edit-security-groups-superadmin-test.feature@deactivateSecurityGroup') {loginId: "#(loginId)", securityGrpId: "U_00607"}
		And karate.log('Test Completed !')
	
	
	#REV2-18250
	Scenario: PUT - Verify super admin cannot assign security groups to Party Login with valid value in loginId and leading & trailing spaces in securityGroups
		
		* def loginId = 'U_00853'
		* eval requestPayload[0] = "  S_10502   "
		
		Given path '/' + loginId + '/securitygroups'
		And request requestPayload
		When method put
		Then status 400
		And karate.log(requestPayload)
		And karate.log('Status : 400')
		And match response.errors[0].errorCode contains "securityGroup.security_group_not_present"
		And match response.errors[0].message contains "Security group is not present"
		And karate.log('Test Completed !')
		
	
	#REV2-18249
	Scenario: PUT - Verify super admin cannot assign security groups to Party Login with valid value in loginId and blank value in securityGroups
		
		* def loginId = 'U_00853'
		* eval requestPayload[0] = ""
		
		Given path '/' + loginId + '/securitygroups'
		And request requestPayload
		When method put
		Then status 400
		And karate.log(requestPayload)
		And karate.log('Status : 400')
		And match response.errors[0].errorCode contains "securityGroup.security_group_not_present"
		And match response.errors[0].message contains "Security group is not present"
		And karate.log('Test Completed !')
		
		
	#REV2-18248
	Scenario: PUT - Verify super admin cannot assign security groups to Party Login with valid value in loginId and invalid value in securityGroups
		
		* def loginId = 'U_00853'
		* eval requestPayload[0] = "90RDG4"
		
		Given path '/' + loginId + '/securitygroups'
		And request requestPayload
		When method put
		Then status 400
		And karate.log(requestPayload)
		And karate.log('Status : 400')
		And match response.errors[0].errorCode contains "securityGroup.security_group_not_present"
		And match response.errors[0].message contains "Security group is not present"
		And karate.log('Test Completed !')
		
		
	#REV2-18247
	Scenario: PUT - Verify super admin cannot assign security groups to Party Login with leading & trailing spaces in loginId and valid securityGroups
		
		* def loginId = '  U_00853  '
		* eval requestPayload[0] = "S_10502"
		
		Given path '/' + loginId + '/securitygroups'
		And request requestPayload
		When method put
		Then status 404
		And karate.log(requestPayload)
		And karate.log('Status : 404')
		And match response.errors[0].errorCode contains "user.not_found"
		And match response.errors[0].message contains "User Not Found"
		And karate.log('Test Completed !')
		
		
	#REV2-18246
	Scenario: PUT - Verify super admin cannot assign security groups to Party Login with blank value in loginId and valid securityGroups
		
		* def loginId = ' '
		* eval requestPayload[0] = "S_10502"
		
		Given path '/' + loginId + '/securitygroups'
		And request requestPayload
		When method put
		Then status 404
		And karate.log(requestPayload)
		And karate.log('Status : 404')
		And match response.errors[0].errorCode contains "user.not_found"
		And match response.errors[0].message contains "User Not Found"
		And karate.log('Test Completed !')
		
	
	#REV2-18245
	Scenario: PUT - Verify super admin cannot assign security groups to Party Login with invalid value in loginId and valid securityGroups
		
		* def loginId = 'UP008'
		* eval requestPayload[0] = "S_10502"
		
		Given path '/' + loginId + '/securitygroups'
		And request requestPayload
		When method put
		Then status 404
		And karate.log(requestPayload)
		And karate.log('Status : 404')
		And match response.errors[0].errorCode contains "user.not_found"
		And match response.errors[0].message contains "User Not Found"
		And karate.log('Test Completed !')
		
		
	#REV2-18244
	Scenario: PUT - Verify super admin can assign security groups to Party Login with valid values in loginId and securityGroups
    
		* def loginId = 'U_00853'
    * eval requestPayload[0] = "S_10502"
    * def securityGrpId = requestPayload[0]
              
		Given path '/' + loginId + '/securitygroups'
    And request requestPayload
    When method put
    Then status 200
    #Deactivating the assigned Security Group
    And call read('./party-edit-security-groups-superadmin-test.feature@deactivateSecurityGroup') {loginId: "#(loginId)", securityGrpId: "#(securityGrpId)"}
  
                       
	@deactivateSecurityGroup
	Scenario: PUT - Deactivate assigned security group
		
		* def loginId = __arg.loginId
    * def securityGrpId = __arg.securityGrpId
    
		Given path '/' + loginId + '/securitygroups/' + securityGrpId
    And request {}
    When method put
    Then status 200
    And karate.log('Status : 200')
    
    