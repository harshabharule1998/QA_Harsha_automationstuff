Feature: To check if user is able to create permissions and security groups and validate them
	
	Background:
		
		* url 'http://172.27.133.21:8090'
	 	* header Accept = 'application/json'

	
	@createNewPermission
	Scenario: Validate user is able to create new permissions
		
		* def today = new java.util.Date().time
		* def num = today + ""
		* def num = num.substring(9)
		* def permissionCode = 'auto' + num
		* def permissionName = 'auto' + num
		
		* def payload = read('classpath:com/fnp/api/backoffice/data/permissions.json')
		* def requestPayload = payload[0]
		* karate.log('Creating new permission')

		* eval requestPayload.permissionCode = permissionCode
		* eval requestPayload.permissionName = permissionName
		
		* karate.log(requestPayload)
		
		Given path '/iam/v1/permissions'
		And request requestPayload
		When method post
		Then status 200
		And karate.log('Status : 200')
		* karate.log('New permission created')
		And match response.code == permissionCode
		And match response.name == permissionName
		

	Scenario: Validate user is not able to create duplicate permission
		
		* def result = call read('./security-permission-test.feature@createNewPermission')
		
		# try creating duplicate permission
		Given path '/iam/v1/permissions'
		And request result.requestPayload
		When method post
		Then status 404
		And karate.log('Status : 404')
		And match response[0].errorCode == "406 NOT_ACCEPTABLE"
		And match response[0].message contains "Permission is already Present"
		

	Scenario: Validate user is able to fetch all permissions
		
		Given path '/iam/v1/permissions'
		When method get
		Then status 200
		And karate.log('Status : 200')
		And match each response contains { name: '#notnull', code: '#notnull' }
		# verify values not blank
		#And match each response contains { name: "#? _ != ''", code: "#? _ != ''" }


	@createNewSecurityGroup
	Scenario: Validate user is able to create new security group
		
		* def today = new java.util.Date().time
		* def num = today + ""
		* def num = num.substring(9)
		* def securityGroupCode = 'autosg' + num
		* def securityGroupName = 'autosg' + num
		
		* def payload = read('classpath:com/fnp/api/backoffice/data/permissions.json')
		* def requestPayload = payload[1]
		* karate.log('Creating new security group')

		* eval requestPayload.securityGroupCode = securityGroupCode
		* eval requestPayload.securityGroupName = securityGroupName
		
		* karate.log(requestPayload)
		
		Given path '/iam/v1/securityGroup'
		And request requestPayload
		When method post
		Then status 200
		And karate.log('Status : 200')
		* karate.log('New security group created')
		And match response.code == securityGroupCode
		And match response.name == securityGroupName
		
			
	Scenario: Validate user is able to update permissions for security group
		
		* def result = call read('./security-permission-test.feature@createNewSecurityGroup')
		
		# update permissions for security group
		* eval result.requestPayload.permissions[0] = "d1"
		
		Given path '/iam/v1/permissions'
		And request result.requestPayload
		When method put
		Then status 200
		And karate.log('Status : 200')
		

	Scenario: Validate user is able to fetch all security groups
		
		Given path '/iam/v1/securityGroup'
		When method get
		Then status 200
		And karate.log('Status : 200')
		And match each response contains { name: '#notnull', code: '#notnull' }
		# verify values not blank
		And match each response contains { name: "#? _ != ''", code: "#? _ != ''" }
