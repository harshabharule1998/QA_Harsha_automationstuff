Feature: Edit permission security group super admin scenarios

	Background: 
       
    Given url backOfficeAPIBaseUrl
    And header Accept = 'application/json'
    And path 'simsim/v1'
    * def loginResult = callonce read('classpath:com/fnp/api/utils/generate-token.feature') {userType:"partyAdmin"}
    * def authToken = loginResult.accessToken
    * header Authorization = authToken
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/party/edit-permissions-security-group.json')
    

	#REV2-18411
	Scenario: PUT - Verify super admin cannot edit permissiom with blank value in requestbody 
		
		* eval requestPayload.permissions = [""]
		* eval requestPayload.securityGroupCode = ""
		* eval requestPayload.securityGroupName = ""
		
		Given path '/' + 'permissions'
		And request requestPayload
		When method put
		Then status 400
		And karate.log(requestPayload)
		And karate.log('Status : 400')
		And match response.errors[*].errorCode contains "INVALID_DATA"
		And match response.errors[*].message contains "Security group code must not be blank"
		And karate.log('Test Completed !')
	

	#REV2-18412
	Scenario: PUT - Verify super admin cannot edit permissions with leading & trailing spaces in request body
		
		* eval requestPayload.permissions = ["   "]
		* eval requestPayload.securityGroupCode = "   "
		* eval requestPayload.securityGroupName = "   "
		
		Given path '/' + 'permissions'
		And request requestPayload
		When method put
		Then status 400
		And karate.log(requestPayload)
		And karate.log('Status : 400')
		And match response.errors[*].errorCode contains "INVALID_DATA"
		And match response.errors[*].message contains "Security group code must not be blank"
		And karate.log('Test Completed !')
		
	
	#REV2-18413
	Scenario: PUT - Verify super admin cannot edit permission with invalid value in request body
		
		* eval requestPayload.permissions = ["P_FEED_ACTLE"]
		* eval requestPayload.securityGroupCode = "CUSTO"
		* eval requestPayload.securityGroupName = "Customers"
 		
		Given path '/' + 'permissions' 
		And request requestPayload
		When method put
		Then status 404
		And karate.log(requestPayload)
		And karate.log('Status : 404')
		And match response.errors[0].errorCode contains "securityGroup.security_group_not_found"
		And match response.errors[0].message contains "Security Group is not Present..Try adding security group"
		And karate.log('Test Completed !')
		

	#REV2-18414
	Scenario: PUT - Verify super admin cannot edit permission with invalid value in permisions
		
		* eval requestPayload.permissions = ["P_FEED_ACTLE"]
		* eval requestPayload.securityGroupCode = "CUST"
		* eval requestPayload.securityGroupName = "Customer"
 		
		Given path '/' + 'permissions' 
		And request requestPayload
		When method put
		Then status 404
		And karate.log(requestPayload)
		And karate.log('Status : 404')
		And match response.errors[0].errorCode contains "permission.permission_not_exist"
		And match response.errors[0].message contains "Permission P_FEED_ACTLE is not Present..Try adding permission in permission table"
		And karate.log('Test Completed !')
		
	
	#REV2-18415
	Scenario: PUT - Verify super admin cannot edit permissions with leading & trailing spaces in permission
		
		* eval requestPayload.permissions = [" P_FEED_ACTLE "]
		* eval requestPayload.securityGroupCode = "CUST"
		* eval requestPayload.securityGroupName = "Customer"
		
		Given path '/' + 'permissions' 
		And request requestPayload
		When method put
		Then status 404
		And karate.log(requestPayload)
		And karate.log('Status : 404')
		And match response.errors[0].errorCode contains "permission.permission_not_exist"
		And match response.errors[0].message contains "Permission  P_FEED_ACTLE  is not Present..Try adding permission in permission table"
		And karate.log('Test Completed !')
		

	#REV2-18416
	Scenario: PUT - Verify super admin cannot edit permission with blank value in permission 
		
		* eval requestPayload.permissions = [""]
		* eval requestPayload.securityGroupCode = "CUST"
		* eval requestPayload.securityGroupName = "Customer"
		
		Given path '/' + 'permissions'
		And request requestPayload
		When method put
		Then status 404
		And karate.log(requestPayload)
		And karate.log('Status : 404')
		And match response.errors[0].errorCode contains "permission.permission_not_exist"
		And match response.errors[0].message contains "Permission  is not Present..Try adding permission in permission table"
		And karate.log('Test Completed !')
		
	
	#REV2-18418
	Scenario: PUT - Verify super admin cannot edit permission with invalid value in security group code
		
		* eval requestPayload.permissions = ["P_FEED_ACTL"]
		* eval requestPayload.securityGroupCode = "CUSTO"
		* eval requestPayload.securityGroupName = "Customer"
 		
		Given path '/' + 'permissions' 
		And request requestPayload
		When method put
		Then status 404
		And karate.log(requestPayload)
		And karate.log('Status : 404')
		And match response.errors[0].errorCode contains "securityGroup.security_group_not_found"
		And match response.errors[0].message contains "Security Group is not Present..Try adding security group"
		And karate.log('Test Completed !')
		
	
	#REV2-18419
	Scenario: PUT - Verify super admin cannot edit permissions with spaces in securitygroupcode 
    
		* eval requestPayload.permissions = ["P_FEED_ACTL"]
		* eval requestPayload.securityGroupCode = " CUST  "
		* eval requestPayload.securityGroupName = "Customer"
    
    Given path '/' + 'permissions'
		And request requestPayload
		When method put
		Then status 400
		And karate.log('Status : 400')
		And match response.errors[*].errorCode contains "INVALID_DATA"
		And match response.errors[*].message contains "Security group code value can contain alphanumeric and underscore characters only"
		And karate.log('Test Completed !')
		

	#REV2-18420
	Scenario: PUT - Verify super admin cannot edit permission with blank value in securitygroupcode
		
		* eval requestPayload.permissions = ["P_FEED_ACTL"]
		* eval requestPayload.securityGroupCode = ""
		* eval requestPayload.securityGroupName = "Customer"
		
		Given path '/' + 'permissions'
		And request requestPayload
		When method put
		Then status 400
		And karate.log(requestPayload)
		And karate.log('Status : 400')
		And match response.errors[*].errorCode contains 'INVALID_DATA'
		And match response.errors[*].message contains 'Security group code must not be blank'
		And karate.log('Test Completed !')
		
		
	#REV2-18421
	Scenario: PUT - Verify super admin cannot edit permission with invalid value in security group name
		
		* eval requestPayload.permissions = ["P_FEED_ACTLE"]
		* eval requestPayload.securityGroupCode = "CUSTO"
		* eval requestPayload.securityGroupName = "#12RDE, @#%$"
 		
		Given path '/' + 'permissions' 
		And request requestPayload
		When method put
		Then status 400
		And karate.log(requestPayload)
		And karate.log('Status : 400')
		And match response.errors[0].errorCode contains "INVALID_DATA"
		And match response.errors[0].message contains "Security group name value can contain alphanumeric, space and underscore characters only"
		And karate.log('Test Completed !')
		
	
	#REV2-18422
	Scenario: PUT - Verify super admin cannot edit permissions with spaces in security group name 
    
		* eval requestPayload.permissions = ["P_FEED_ACTL"]
		* eval requestPayload.securityGroupCode = "CUST"
		* eval requestPayload.securityGroupName = " Customer "
    
    Given path '/' + 'permissions'
		And request requestPayload
		When method put
		Then status 400
		And karate.log('Status : 400')
		And match response.errors[0].errorCode contains "securityGroup.permission_already_exist"
		And match response.errors[0].message contains "Permission is already Present for security group"
		And karate.log('Test Completed !')
		
	
	#REV2-18423
	Scenario: PUT - Verify super admin cannot edit permission with blank value in security group name
		
		* eval requestPayload.permissions = ["P_FEED_ACTL"]
		* eval requestPayload.securityGroupCode = "CUST"
		* eval requestPayload.securityGroupName = " "
		
		Given path '/' + 'permissions'
		And request requestPayload
		When method put
		Then status 400
		And karate.log(requestPayload)
		And karate.log('Status : 400')
		And match response.errors[*].errorCode contains "INVALID_DATA"
		And match response.errors[*].message contains "Security group name must not be blank"
		And karate.log('Test Completed !')
		
		
	#REV2-18424
	Scenario: PUT - Verify super admin cannot edit permission with Invalid value in Endpoint URL
		
		* eval requestPayload.permissions = ["P_FEED_ACTL"]
		* eval requestPayload.securityGroupCode = "CUST"
		* eval requestPayload.securityGroupName = "Customer"
		
		Given path '/' + 'permission'
		And request requestPayload
		When method put
		Then status 404
		And karate.log('Status : 404')
		And match response.errors[0].errorCode contains "NOT_FOUND"
		And match response.errors[0].message contains "http.request.not.found"
		And karate.log('Test Completed !')
		

	#REV2-18425
	Scenario: PUT - Verify super admin cannot edit permission with Unsupported Method
		
		* eval requestPayload.permissions = ["P_FEED_ACTL"]
		* eval requestPayload.securityGroupCode = "CUST"
		* eval requestPayload.securityGroupName = "Customer"
		
		Given path '/' + 'permissions'
		And request requestPayload
		When method delete
		Then status 405
		And karate.log('Status : 405')
		And match response.errors[0].errorCode contains "unsupported.http.method"
		And match response.errors[0].message contains "Unsupported request Method. Contact the site administrator"
		And karate.log('Test Completed !')
		
	
	#REV2-32352
	Scenario: PUT - Verify super admin cannot edit permission with duplicate values in request body
		
		* eval requestPayload.permissions = ["P_FEED_ACTL"]
		* eval requestPayload.securityGroupCode = "CUST"
		* eval requestPayload.securityGroupName = "Customer"
		
		Given path '/' + 'permissions'
		And request requestPayload
		When method put
		Then status 400
		And karate.log(requestPayload)
		And karate.log('Status : 400')
		And match response.errors[*].errorCode contains "securityGroup.permission_already_exist"
		And match response.errors[*].message contains "Permission is already Present for security group"
		And karate.log('Test Completed !')
	
	
		
		
	
	
	
		
	
		
		
		
		
		
		
		