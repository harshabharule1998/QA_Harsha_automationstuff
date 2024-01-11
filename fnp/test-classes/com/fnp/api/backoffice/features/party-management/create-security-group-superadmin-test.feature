Feature: Create new security group API

	Background: 
	
		Given url backOfficeAPIBaseUrl
    And header Accept = 'application/json'
    And path '/simsim/v1'
    * def loginResult = callonce read('classpath:com/fnp/api/utils/generate-token.feature') {userType:"partyAdmin"}
    * def authToken = loginResult.accessToken
    * header Authorization = authToken
    * def today = new java.util.Date().time
    * def num = today + ""
    * def num = num.substring(8)
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/party/create-security-group.json')
    
    #REV2-18436
    Scenario: POST - Validate Party Admin can create security group for valid values in request body
    	
			* eval requestPayload.securityGroupCode = "QASec_Grp" + num
			
			Given path '/securitygroups'
			And request requestPayload
			When method post
			Then status 201
			And karate.log('Status : 201')
			And match response.securityGroupCode contains "QASec_Grp"
			And karate.log('Test Completed !')
		
		
		#REV2-18437
		Scenario: POST - Validate Party Admin cannot create security group for invalid values in request body
		
			* eval requestPayload.securityGroupCode = "@#$%"
			* eval requestPayload.securityGroupName = "%$#@"
			* eval requestPayload.permissions[0] = "abc123"
			
			Given path '/securitygroups'
			And request requestPayload
			When method post
			Then status 400
			And karate.log('Status : 400')
			And assert response.errorCount == 2
			And karate.log('Test Completed !')
		
			
		#REV2-18438
		Scenario: POST - Validate Party Admin cannot create security group for blank values in request body
			
			* eval requestPayload.securityGroupCode = ""
			* eval requestPayload.securityGroupName = ""
			* eval requestPayload.permissions[0] = ""
				
			Given path '/securitygroups'	
			And request requestPayload
			When method post
			Then status 400
			And karate.log('Status : 400')
			And assert response.errorCount == 2
			And karate.log('Test Completed !')
			
			
		#REV2-18439	
		Scenario: POST - Validate Party Admin cannot create security group for duplicate values in request body
				
			Given path '/securitygroups'
			And request requestPayload
			When method post
			Then status 400
			And karate.log('Status : 400')
			And match response.errors[*].message contains "Security group is already Present"
			And karate.log('Test Completed !')
			
		
		#REV2-18440
  	Scenario: POST - Validate Party Admin cannot create security group with leading and trailing spaces in request body
    
			* eval requestPayload.securityGroupCode = "  QASec_Grp" + num + "  "
			* eval requestPayload.securityGroupName = "  Test Security Group  "
			* eval requestPayload.permissions[0] = "  P_FEED_ACTL  "
			
			Given path '/securitygroups'
			And request requestPayload
			When method post
			Then status 400
			And karate.log('Status : 400')
			And match response.errors[*].errorCode contains "INVALID_DATA"
			And karate.log('Test Completed !')
			
	
		#REV2-18441
  	Scenario: POST - Validate Party Admin cannot create security group with Invalid Endpoint URL.
    
			* eval requestPayload.securityGroupCode = "QASec_Grp" + num
			
			Given path '/securit'
			And request requestPayload
			When method post
			Then status 404
			And karate.log('Status : 404')
			And match response.errors[*].errorCode contains "NOT_FOUND"
			And karate.log('Test Completed !')
			
			
		#REV2-18442
  	Scenario: Validate Party Admin cannot create security group for Unsupported Method.
    
			* eval requestPayload.securityGroupCode = "QASec_Grp" + num
			
			Given path '/securitygroups'
			And request requestPayload
			When method put
			Then status 405
			And karate.log('Status : 405')
			And match response.errors[*].message contains "Unsupported request Method. Contact the site administrator"
			And karate.log('Test Completed !') 
				
			
		#REV2-18445
		Scenario: POST - Validate Party Admin can create security group with multiple values in permissions in request body
    
			* eval requestPayload.securityGroupCode = "QASec_Grp" + num
			* eval requestPayload.permissions = ["P_FEED_ACTL", "P_CAT_ASS_C"]
			
			Given path '/securitygroups'
			And request requestPayload
			When method post
			Then status 201
			And karate.log('Status : 201')
			And match response.securityGroupCode contains "QASec_Grp"
			And karate.log('Test Completed !')
				
				
				