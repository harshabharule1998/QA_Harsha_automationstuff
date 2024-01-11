Feature: Create new party organization API

	Background: 
	
		Given url backOfficeAPIBaseUrl
    And header Accept = 'application/json'
    And path '/pawri/v1'
    
    * def loginResult = callonce read('classpath:com/fnp/api/utils/generate-token.feature') {userType:"partyAdmin"}
    * def authToken = loginResult.accessToken
    
    * header Authorization = authToken
    * def today = new java.util.Date().time
    * def num = today + ""
    * def num = num.substring(4)
    
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
    
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/party/create-party-organization.json')
    
    * def sleep =
			"""
			function(seconds) {
				for(i = 0; i <= seconds; i++) {
					java.lang.Thread.sleep(1*1000);
				}
			}
			"""
  
  
	#REV2-21440
  Scenario: POST - Validate Party Admin can create party organization for valid values
    	
		* eval requestPayload.loginEmailId = "test" + num + "@cybage.com"
		* eval requestPayload.loginPhoneNumber = num
			
		Given path '/parties'
		And request requestPayload
		When method post
		Then status 201
		And karate.log('Status : 201')
		And match response.requestId == "#notnull"
		
		* def requestId = response.requestId
		
		* call sleep 3
		
		* header Authorization = authToken
		Given path '/pawri/v1/request-status/' + requestId
		When method get
		Then status 200
		And karate.log('Status : 200')
		And match response.id == requestId
		And match response.status == "SUCCESS"
		
		And karate.log('Test Completed !')
		
  
	#REV2-21441
  Scenario: POST - Validate Party Admin can create party organization with only required values
    	
		* eval requestPayload.loginEmailId = "test" + num + "@cybage.com"
		* eval requestPayload.loginPhoneNumber = null
			
		Given path '/parties'
		And request requestPayload
		When method post
		Then status 201
		And karate.log('Status : 201')
		And match response.requestId == "#notnull"
		
		* def requestId = response.requestId
		
		* call sleep 3
		
		* header Authorization = authToken
		Given path '/pawri/v1/request-status/' + requestId
		When method get
		Then status 200
		And karate.log('Status : 200')
		And match response.id == requestId
		And match response.status == "SUCCESS"
		
		And karate.log('Test Completed !')


	#REV2-21442
  Scenario: POST - Validate Party Admin cannot create party organization with only optional values
    	
		* eval requestPayload.loginEmailId = "test" + num + "@cybage.com"
		* eval requestPayload.loginPhoneNumber = null
		* eval requestPayload.franchiseName = null
			
		Given path '/parties'
		And request requestPayload
		When method post
		Then status 400
		And karate.log('Status : 400')
		And match response.errors[0].message == "Please provide franchise name"
		
		And karate.log('Test Completed !')
		
  
	#REV2-21443
  Scenario: POST - Validate Party Admin cannot create party organization with duplicate values
    	
		* eval requestPayload.loginEmailId = "test" + num + "@cybage.com"
		* eval requestPayload.loginPhoneNumber = num
			
		Given path '/parties'
		And request requestPayload
		When method post
		Then status 201
		And karate.log('Status : 201')
		And match response.requestId == "#notnull"
		
		* header Authorization = authToken
		Given path '/pawri/v1/parties'
		And request requestPayload
		When method post
		Then status 201
		And karate.log('Status : 201')
		
		* call sleep 3
		
		* def requestId = response.requestId
		
		* header Authorization = authToken
		Given path '/pawri/v1/request-status/' + requestId
		When method get
		Then status 200
		And karate.log('Status : 200')
		And match response.status == "FAILED"
		And match response.errors[0].message == "The email id is already in used"
		
		And karate.log('Test Completed !')
		

	#REV2-21444
  Scenario: POST - Validate Party Admin cannot create party organization with duplicate values with leading and trailing spaces
    	
		* eval requestPayload.loginEmailId = " test" + num + "@cybage.com "
		* eval requestPayload.loginPhoneNumber = num
			
		Given path '/parties'
		And request requestPayload
		When method post
		Then status 400
		And karate.log('Status : 400')
		And match response.errors[0].message == "The e-mail address entered is invalid"
		
		And karate.log('Test Completed !')
		

	#REV2-21445
  Scenario: POST - Validate Party Admin cannot create party organization with invalid endpoint url
    	
		* eval requestPayload.loginEmailId = "test" + num + "@cybage.com"
		* eval requestPayload.loginPhoneNumber = num
			
		Given path '/parties1'
		And request requestPayload
		When method post
		Then status 404
		And karate.log('Status : 404')
		
		And karate.log('Test Completed !')


	#REV2-21446
  Scenario: POST - Verify unsupported method for Party Admin to create party organization
    	
		* eval requestPayload.loginEmailId = "test" + num + "@cybage.com"
		* eval requestPayload.loginPhoneNumber = num
			
		Given path '/parties'
		And request requestPayload
		When method patch
		Then status 405
		And karate.log('Status : 405')
		And match response.errors[0].message contains "Unsupported request Method"
		
		And karate.log('Test Completed !')
			
	
	#REV2-21448
  Scenario: POST - Verify invalid authentication token error to create party organization
    
    * def invalidAuthToken = "eyJraWQiOiJmbnAyIiwiYWxnIjoiUlMyNTYifQ"
    		
		* eval requestPayload.loginEmailId = "test" + num + "@cybage.com"
		* eval requestPayload.loginPhoneNumber = num
		
		* header Authorization = invalidAuthToken	
		Given path '/parties'
		And request requestPayload
		When method post
		Then status 403
		And karate.log('Status : 403')
		And match response.errors[0].message contains "Access Denied"
		
		And karate.log('Test Completed !')
		
	
	#REV2-21450
  Scenario: POST - Validate Party Admin cannot create party organization with invalid partyType
    
    * def invalidPartyType = "A_101"	
    
		* eval requestPayload.loginEmailId = "test" + num + "@cybage.com"
		* eval requestPayload.loginPhoneNumber = num
		* eval requestPayload.partyType = invalidPartyType
			
		Given path '/parties'
		And request requestPayload
		When method post
		Then status 400
		And karate.log('Status : 400')
		And match response.errors[0].message == "Party Type Id Not Found"
		
		And karate.log('Test Completed !')
		

	#REV2-21451
  Scenario: POST - Validate Party Admin cannot create party organization with invalid role
    
    * def invalidRole = "@123"	
    
		* eval requestPayload.loginEmailId = "test" + num + "@cybage.com"
		* eval requestPayload.loginPhoneNumber = num
		* eval requestPayload.role = invalidRole
			
		Given path '/parties'
		And request requestPayload
		When method post
		Then status 201
		
		* call sleep 3
		
		* def requestId = response.requestId
		
		* header Authorization = authToken
		Given path '/pawri/v1/request-status/' + requestId
		When method get
		Then status 200
		And karate.log('Status : 200')
		And match response.status == "FAILED"
		And match response.errors[0].message == "Role does not exist"
		
		And karate.log('Test Completed !')


	#REV2-21452
  Scenario: POST - Validate Party Admin cannot create party organization with invalid classifications
    
    * def invalidClassifications = ["@123"]	
    
		* eval requestPayload.loginEmailId = "test" + num + "@cybage.com"
		* eval requestPayload.loginPhoneNumber = num
		* eval requestPayload.classifications = invalidClassifications
			
		Given path '/parties'
		And request requestPayload
		When method post
		Then status 400
		And karate.log('Status : 400')
		And match response.errors[0].message == "Specified classification does not exist for used party type"
		
		And karate.log('Test Completed !')


	#REV2-21453
  Scenario: POST - Validate Party Admin cannot create party organization with invalid title
    
    * def invalidTitle = "ABCDXYZ-123"
    
		* eval requestPayload.loginEmailId = "test" + num + "@cybage.com"
		* eval requestPayload.loginPhoneNumber = num
		* eval requestPayload.title = invalidTitle
			
		Given path '/parties'
		And request requestPayload
		When method post
		Then status 201
		
		* call sleep 3
		
		* def requestId = response.requestId
		
		* header Authorization = authToken
		Given path '/pawri/v1/request-status/' + requestId
		When method get
		Then status 200
		And karate.log('Status : 200')
		And match response.status == "FAILED"
		And match response.errors[0].message == "Invalid title"
		
		And karate.log('Test Completed !')
		

	#REV2-21454
  Scenario: POST - Validate Party Admin cannot create party organization with invalid name
    
    * def invalidName = "ABC-123"
    
		* eval requestPayload.loginEmailId = "test" + num + "@cybage.com"
		* eval requestPayload.loginPhoneNumber = num
		* eval requestPayload.name = invalidName
			
		Given path '/parties'
		And request requestPayload
		When method post
		Then status 400
		And karate.log('Status : 400')
		And match response.errors[0].message == "Party name is invalid"
		
		And karate.log('Test Completed !')
		

	#REV2-21455
  Scenario: POST - Validate Party Admin cannot create party organization with invalid designation
    
    * def invalidDesignation = "ABC-123"
    
		* eval requestPayload.loginEmailId = "test" + num + "@cybage.com"
		* eval requestPayload.loginPhoneNumber = num
		* eval requestPayload.designation = invalidDesignation
			
		Given path '/parties'
		And request requestPayload
		When method post
		Then status 400
		And karate.log('Status : 400')
		And match response.errors[0].message == "The designation is invalid"
		
		And karate.log('Test Completed !')
		
	
	#REV2-21456
  Scenario: POST - Validate Party Admin cannot create party organization with invalid loginPhoneNumber
    
    * def invalidLoginPhoneNumber = "@xyz123"
    
		* eval requestPayload.loginEmailId = "test" + num + "@cybage.com"
		* eval requestPayload.loginPhoneNumber = invalidLoginPhoneNumber
			
		Given path '/parties'
		And request requestPayload
		When method post
		Then status 400
		And karate.log('Status : 400')
		And match response.errors[0].message contains "The phone number is invalid"
		
		And karate.log('Test Completed !')
		

	#REV2-21457
  Scenario: POST - Validate Party Admin cannot create party organization with invalid loginEmailId
    
    * def invalidLoginEmailId = "xyz123-@-"
    
		* eval requestPayload.loginEmailId = invalidLoginEmailId
		* eval requestPayload.loginPhoneNumber = num
			
		Given path '/parties'
		And request requestPayload
		When method post
		Then status 400
		And karate.log('Status : 400')
		And match response.errors[0].message contains "The e-mail address entered is invalid"
		
		And karate.log('Test Completed !')
		

	#REV2-21458
  Scenario: POST - Validate Party Admin cannot create party organization with invalid franchiseName
    
    * def invalidFranchiseName = "xyz123-@-"
    
		* eval requestPayload.loginEmailId = "test" + num + "@cybage.com"
		* eval requestPayload.loginPhoneNumber = num
		* eval requestPayload.franchiseName = invalidFranchiseName
			
		Given path '/parties'
		And request requestPayload
		When method post
		Then status 400
		And karate.log('Status : 400')
		And match response.errors[0].message contains "The franchise name is invalid"
		
		And karate.log('Test Completed !')
		
		
	#REV2-21459
  Scenario: POST - Validate Party Admin cannot create party organization with invalid taxNumber
    
    * def invalidTaxNumber = "xyz123-@-"
    
		* eval requestPayload.loginEmailId = "test" + num + "@cybage.com"
		* eval requestPayload.loginPhoneNumber = num
		* eval requestPayload.taxNumber = invalidTaxNumber
			
		Given path '/parties'
		And request requestPayload
		When method post
		Then status 400
		And karate.log('Status : 400')
		And match response.errors[0].message contains "The Tax/Vat number is invalid"
		
		And karate.log('Test Completed !')
		
		
	#REV2-21460
  Scenario: POST - Validate Party Admin cannot create party organization with invalid faxNumber
    
    * def invalidFaxNumber = "xyz123-@-"
    
		* eval requestPayload.loginEmailId = "test" + num + "@cybage.com"
		* eval requestPayload.loginPhoneNumber = num
		* eval requestPayload.faxNumber = invalidFaxNumber
			
		Given path '/parties'
		And request requestPayload
		When method post
		Then status 400
		And karate.log('Status : 400')
		And match response.errors[0].message contains "The fax number is invalid"
		
		And karate.log('Test Completed !')
		
				
	#REV2-21461
  Scenario: POST - Validate Party Admin cannot create party organization with invalid contactPhone
    
    * def invalidContactPhone = "@abc"
    
		* eval requestPayload.loginEmailId = "test" + num + "@cybage.com"
		* eval requestPayload.loginPhoneNumber = num
		* eval requestPayload.contactPhone = invalidContactPhone
			
		Given path '/parties'
		And request requestPayload
		When method post
		Then status 400
		And karate.log('Status : 400')
		And match response.errors[0].message contains "The phone number is invalid"
		
		And karate.log('Test Completed !')
		
				
	#REV2-21462
  Scenario: POST - Validate Party Admin cannot create party organization with invalid contactEmail
    
    * def invalidContactEmail = "123abc-@"
    
		* eval requestPayload.loginEmailId = "test" + num + "@cybage.com"
		* eval requestPayload.loginPhoneNumber = num
		* eval requestPayload.contactEmail = invalidContactEmail
			
		Given path '/parties'
		And request requestPayload
		When method post
		Then status 400
		And karate.log('Status : 400')
		And match response.errors[0].message contains "The e-mail address entered is invalid"
		
		And karate.log('Test Completed !')
		

	#REV2-21463
  Scenario: POST - Validate Party Admin cannot create party organization with invalid isPrimaryRole
    
    * def invalidIsPrimaryRole = "123"
    
		* eval requestPayload.loginEmailId = "test" + num + "@cybage.com"
		* eval requestPayload.loginPhoneNumber = num
		* eval requestPayload.isPrimaryRole = invalidIsPrimaryRole
			
		Given path '/parties'
		And request requestPayload
		When method post
		Then status 400
		And karate.log('Status : 400')
		And match response.errors[0].message contains "Invalid input data"
		
		And karate.log('Test Completed !')
		

	#REV2-21464
  Scenario: POST - Validate Party Admin cannot create party organization with invalid otherRoles
    
    * def invalidOtherRoles = "123"
    
		* eval requestPayload.loginEmailId = "test" + num + "@cybage.com"
		* eval requestPayload.loginPhoneNumber = num
		* eval requestPayload.isPrimaryRole = true
		* eval requestPayload.otherRoles = invalidOtherRoles
			
		Given path '/parties'
		And request requestPayload
		When method post
		Then status 400
		And karate.log('Status : 400')
		And match response.errors[0].message contains "Invalid input data"
		
		And karate.log('Test Completed !')
		

	#REV2-21465
  Scenario: POST - Validate Party Admin cannot create party organization with blank partyType
    
    * def blankPartyType = ""	
    
		* eval requestPayload.loginEmailId = "test" + num + "@cybage.com"
		* eval requestPayload.loginPhoneNumber = num
		* eval requestPayload.partyType = blankPartyType
			
		Given path '/parties'
		And request requestPayload
		When method post
		Then status 400
		And karate.log('Status : 400')
		And match response.errors[0].message == "must not be blank"
		
		And karate.log('Test Completed !')
		

	#REV2-21466
  Scenario: POST - Validate Party Admin cannot create party organization with blank role
    
    * def blankRole = ""	
    
		* eval requestPayload.loginEmailId = "test" + num + "@cybage.com"
		* eval requestPayload.loginPhoneNumber = num
		* eval requestPayload.role = blankRole
			
		Given path '/parties'
		And request requestPayload
		When method post
		Then status 400
		And karate.log('Status : 400')
		And match response.errors[0].message == "must not be blank"
		
		And karate.log('Test Completed !')


	#REV2-21467
  Scenario: POST - Validate Party Admin cannot create party organization with blank classifications
    
    * def blankClassifications = ""
    
		* eval requestPayload.loginEmailId = "test" + num + "@cybage.com"
		* eval requestPayload.loginPhoneNumber = num
		* eval requestPayload.classifications = blankClassifications
			
		Given path '/parties'
		And request requestPayload
		When method post
		Then status 400
		And karate.log('Status : 400')
		And match response.errors[0].message == "Invalid input data"
		
		And karate.log('Test Completed !')
		
	
	#REV2-21468
  Scenario: POST - Validate Party Admin cannot create party organization with blank name
    
    * def blankName = ""
    
		* eval requestPayload.loginEmailId = "test" + num + "@cybage.com"
		* eval requestPayload.loginPhoneNumber = num
		* eval requestPayload.name = blankName
			
		Given path '/parties'
		And request requestPayload
		When method post
		Then status 400
		And karate.log('Status : 400')
		And match response.errors[0].message == "Name field is mandatory"
		
		And karate.log('Test Completed !')
		
	
	#REV2-21469
  Scenario: POST - Validate Party Admin cannot create party organization with blank loginPhoneNumber
    
    * def blankLoginPhoneNumber = ""
    
		* eval requestPayload.loginEmailId = "test" + num + "@cybage.com"
		* eval requestPayload.loginPhoneNumber = blankLoginPhoneNumber
			
		Given path '/parties'
		And request requestPayload
		When method post
		Then status 400
		And karate.log('Status : 400')
		And match response.errors[0].message contains "The phone number is invalid"
		
		And karate.log('Test Completed !')
		

	#REV2-21470
  Scenario: POST - Validate Party Admin cannot create party organization with blank loginEmailId
    
    * def blankLoginEmailId = " "
    
		* eval requestPayload.loginEmailId = blankLoginEmailId
		* eval requestPayload.loginPhoneNumber = num
			
		Given path '/parties'
		And request requestPayload
		When method post
		Then status 400
		And karate.log('Status : 400')
		And match response.errors[0].message contains "The e-mail address entered is invalid"
		
		And karate.log('Test Completed !')
		

	#REV2-21471
  Scenario: POST - Validate Party Admin cannot create party organization with name more than 50 characters
    
    * def name = "TestDemoNameTestDemoNameTestDemoNameTestDemoNameTestDemoName"
    
		* eval requestPayload.loginEmailId = "test" + num + "@cybage.com"
		* eval requestPayload.loginPhoneNumber = num
		* eval requestPayload.name = name
			
		Given path '/parties'
		And request requestPayload
		When method post
		Then status 400
		And karate.log('Status : 400')
		And match response.errors[0].message contains "Party name must not be greater than 50"
		
		And karate.log('Test Completed !')
	

	#REV2-21472
  Scenario: POST - Validate Party Admin cannot create party organization with duplicate loginPhoneNumber
    
    * def duplicateLoginPhoneNumber = "505108269"
    
		* eval requestPayload.loginEmailId = "test" + num + "@cybage.com"
		* eval requestPayload.loginPhoneNumber = duplicateLoginPhoneNumber
			
		Given path '/parties'
		And request requestPayload
		When method post
		Then status 201
		
		* call sleep 3
		
		* def requestId = response.requestId
		
		* header Authorization = authToken
		Given path '/pawri/v1/request-status/' + requestId
		When method get
		Then status 200
		And karate.log('Status : 200')
		And match response.status == "FAILED"
		And match response.errors[0].message == "The Phone Number is already in use"
		
		And karate.log('Test Completed !')
			
		
	#REV2-21473
  Scenario: POST - Validate Party Admin cannot create party organization with duplicate loginEmailId
    
    * def duplicateLoginEmailId = "test695708822@cybage.com"
    
		* eval requestPayload.loginEmailId = duplicateLoginEmailId
		* eval requestPayload.loginPhoneNumber = num
			
		Given path '/parties'
		And request requestPayload
		When method post
		Then status 201
		
		* call sleep 3
		
		* def requestId = response.requestId
		
		* header Authorization = authToken
		Given path '/pawri/v1/request-status/' + requestId
		When method get
		Then status 200
		And karate.log('Status : 200')
		And match response.status == "FAILED"
		And match response.errors[0].message == "The Email Id is already in use"
		
		And karate.log('Test Completed !')
