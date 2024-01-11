Feature: Create new party individual API

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
    
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/party/create-party-individual.json')
    
    * def sleep =
			"""
			function(seconds) {
				for(i = 0; i <= seconds; i++) {
					java.lang.Thread.sleep(1*1000);
				}
			}
			"""
  
	#REV2-21393
  Scenario: POST - Validate Party Admin can create party individual for valid values
    	
		* eval requestPayload.loginEmailId = "test" + num + "@cybage.com"
		* eval requestPayload.loginPhoneNumber = num
			
		Given path '/parties'
		And request requestPayload
		When method post
		Then status 201
		And karate.log('Status : 201')
		And match response.requestId == "#notnull"
		
		* def requestId = response.requestId
		
		* header Authorization = authToken
		Given path '/pawri/v1/request-status/' + requestId
		When method get
		Then status 200
		And karate.log('Status : 200')
		And match response.id == requestId
		
		And karate.log('Test Completed !')
		
  
	#REV2-21394
  Scenario: POST - Validate Party Admin can create party individual with only required values
    	
		* eval requestPayload.loginEmailId = "test" + num + "@cybage.com"
		* eval requestPayload.loginPhoneNumber = null
			
		Given path '/parties'
		And request requestPayload
		When method post
		Then status 201
		And karate.log('Status : 201')
		And match response.requestId == "#notnull"
		
		* def requestId = response.requestId
		
		* header Authorization = authToken
		Given path '/pawri/v1/request-status/' + requestId
		When method get
		Then status 200
		And karate.log('Status : 200')
		And match response.id == requestId
		
		And karate.log('Test Completed !')


	#REV2-21395
  Scenario: POST - Validate Party Admin cannot create party individual with only optional values
    	
		* eval requestPayload.loginEmailId = null
		* eval requestPayload.loginPhoneNumber = null
			
		Given path '/parties'
		And request requestPayload
		When method post
		Then status 400
		And karate.log('Status : 400')
		And match response.errors[0].message == "Please provide emailId and phoneNumber or username"
		
		And karate.log('Test Completed !')
		
  
	#REV2-21396
  Scenario: POST - Validate Party Admin cannot create party individual with duplicate values
    	
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
		

	#REV2-21397
  Scenario: POST - Validate Party Admin cannot create party individual with duplicate values with leading and trailing spaces
    	
		* eval requestPayload.loginEmailId = " test" + num + "@cybage.com "
		* eval requestPayload.loginPhoneNumber = num
			
		Given path '/parties'
		And request requestPayload
		When method post
		Then status 400
		And karate.log('Status : 400')
		And match response.errors[0].message == "The e-mail address entered is invalid"
		
		And karate.log('Test Completed !')
		

	#REV2-21398
  Scenario: POST - Validate Party Admin cannot create party individual with invalid endpoint url
    	
		* eval requestPayload.loginEmailId = "test" + num + "@cybage.com"
		* eval requestPayload.loginPhoneNumber = num
			
		Given path '/parties1'
		And request requestPayload
		When method post
		Then status 404
		And karate.log('Status : 404')
		
		And karate.log('Test Completed !')


	#REV2-21399
  Scenario: POST - Verify unsupported method for Party Admin to create party individual
    	
		* eval requestPayload.loginEmailId = "test" + num + "@cybage.com"
		* eval requestPayload.loginPhoneNumber = num
			
		Given path '/parties'
		And request requestPayload
		When method patch
		Then status 405
		And karate.log('Status : 405')
		And match response.errors[0].message contains "Unsupported request Method"
		
		And karate.log('Test Completed !')
			
	
	#REV2-21401
  Scenario: POST - Verify invalid authentication token error to create party individual
    
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
		
	
	#REV2-21402
  Scenario: POST - Validate Party Admin cannot create party individual with invalid partyType
    
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
		

	#REV2-21403
  Scenario: POST - Validate Party Admin cannot create party individual with invalid role
    
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


	#REV2-21404
  Scenario: POST - Validate Party Admin cannot create party individual with invalid classifications
    
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

	
	#REV2-21405
  Scenario: POST - Validate Party Admin cannot create party individual with invalid title
    
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
		
	
	#REV2-21406
  Scenario: POST - Validate Party Admin cannot create party individual with invalid name
    
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
		

	#REV2-21407
  Scenario: POST - Validate Party Admin cannot create party individual with invalid gender
    
    * def invalidGender = "ABC-123"
    
		* eval requestPayload.loginEmailId = "test" + num + "@cybage.com"
		* eval requestPayload.loginPhoneNumber = num
		* eval requestPayload.gender = invalidGender
			
		Given path '/parties'
		And request requestPayload
		When method post
		Then status 400
		And karate.log('Status : 400')
		And match response.errors[0].message == "Gender is invalid"
		
		And karate.log('Test Completed !')
		

	#REV2-21408
  Scenario: POST - Validate Party Admin cannot create party individual with invalid dateOfBirth
    
    * def invalidDateOfBirth = "1950-03-15"
    
		* eval requestPayload.loginEmailId = "test" + num + "@cybage.com"
		* eval requestPayload.loginPhoneNumber = num
		* eval requestPayload.dateOfBirth = invalidDateOfBirth
			
		Given path '/parties'
		And request requestPayload
		When method post
		Then status 400
		And karate.log('Status : 400')
		And match response.errors[0].message == "Invalid input data"
		
		And karate.log('Test Completed !')
		

	#REV2-21409
  Scenario: POST - Validate Party Admin cannot create party individual with invalid dateOfAnniversary
    
    * def invalidDateOfAnniversary = "1981-03-15"
    
		* eval requestPayload.loginEmailId = "test" + num + "@cybage.com"
		* eval requestPayload.loginPhoneNumber = num
		* eval requestPayload.dateOfAnniversary = invalidDateOfAnniversary
			
		Given path '/parties'
		And request requestPayload
		When method post
		Then status 400
		And karate.log('Status : 400')
		And match response.errors[0].message == "Invalid input data"
		
		And karate.log('Test Completed !')
		
	
	#REV2-21410
  Scenario: POST - Validate Party Admin cannot create party individual with invalid loginPhoneNumber
    
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
		

	#REV2-21411
  Scenario: POST - Validate Party Admin cannot create party individual with invalid loginEmailId
    
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
		

	#REV2-21412
  Scenario: POST - Validate Party Admin cannot create party individual with invalid contactPhone
    
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
		

	#REV2-21413
  Scenario: POST - Validate Party Admin cannot create party individual with invalid contactEmail
    
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
		

	#REV2-21414
  Scenario: POST - Validate Party Admin cannot create party individual with invalid isPrimaryRole
    
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
		

	#REV2-21415
  Scenario: POST - Validate Party Admin cannot create party individual with invalid otherRoles
    
    * def invalidOtherRoles = "123"
    
		* eval requestPayload.loginEmailId = "test" + num + "@cybage.com"
		* eval requestPayload.loginPhoneNumber = num
		* eval requestPayload.otherRoles = invalidOtherRoles
			
		Given path '/parties'
		And request requestPayload
		When method post
		Then status 400
		And karate.log('Status : 400')
		And match response.errors[0].message contains "Invalid input data"
		
		And karate.log('Test Completed !')
		

	#REV2-21416
  Scenario: POST - Validate Party Admin cannot create party individual with invalid notAvailable
    
    * def invalidNotAvailable = "123"
    
		* eval requestPayload.loginEmailId = "test" + num + "@cybage.com"
		* eval requestPayload.loginPhoneNumber = num
		* eval requestPayload.notAvailable = invalidNotAvailable
			
		Given path '/parties'
		And request requestPayload
		When method post
		Then status 400
		And karate.log('Status : 400')
		And match response.errors[0].message contains "Invalid input data"
		
		And karate.log('Test Completed !')
		
	
	#REV2-21417
  Scenario: POST - Validate Party Admin cannot create party individual with invalid username
    
    * def invalidUserName = "@123-$ "
    
		* eval requestPayload.loginEmailId = "test" + num + "@cybage.com"
		* eval requestPayload.loginPhoneNumber = num
		* eval requestPayload.notAvailable = true
		* eval requestPayload.username = invalidUserName
			
		Given path '/parties'
		And request requestPayload
		When method post
		Then status 400
		And karate.log('Status : 400')
		And match response.errors[0].message contains "The username is invalid"
		
		And karate.log('Test Completed !')
		
	
	#REV2-21418
  Scenario: POST - Validate Party Admin cannot create party individual with blank partyType
    
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
		

	#REV2-21419
  Scenario: POST - Validate Party Admin cannot create party individual with blank role
    
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


	#REV2-21420
  Scenario: POST - Validate Party Admin cannot create party individual with blank classifications
    
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
		
	
	#REV2-21421
  Scenario: POST - Validate Party Admin cannot create party individual with blank name
    
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
		
	
	#REV2-21422
  Scenario: POST - Validate Party Admin cannot create party individual with blank loginPhoneNumber
    
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
		

	#REV2-21423
  Scenario: POST - Validate Party Admin cannot create party individual with blank loginEmailId
    
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
		

	#REV2-21424
  Scenario: POST - Validate Party Admin cannot create party individual with blank username
    
    * def blankUserName = ""
    
		* eval requestPayload.loginEmailId = "test" + num + "@cybage.com"
		* eval requestPayload.loginPhoneNumber = num
		* eval requestPayload.notAvailable = true
		* eval requestPayload.username = blankUserName
			
		Given path '/parties'
		And request requestPayload
		When method post
		Then status 400
		And karate.log('Status : 400')
		And match response.errors[0].message contains "Please provide username"
		
		And karate.log('Test Completed !')
		
	
	#REV2-21426
  Scenario: POST - Validate Party Admin cannot create party individual with name more than 50 characters
    
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
	
	
	#REV2-21427
  Scenario: POST - Validate Party Admin cannot create party individual with duplicate loginPhoneNumber
    
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
			
		
	#REV2-21428
  Scenario: POST - Validate Party Admin cannot create party individual with duplicate loginEmailId
    
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
		

	#REV2-21429
  Scenario: POST - Validate Party Admin cannot create party individual with not available true
    
    * def num = num.substring(4)
    
    * def userName = "test" + num
    
		* eval requestPayload.loginEmailId = "test" + num + "@cybage.com"
		* eval requestPayload.loginPhoneNumber = num
		* eval requestPayload.notAvailable = true
		* eval requestPayload.username = userName
			
		Given path '/parties'
		And request requestPayload
		When method post
		Then status 201
		And karate.log('Status : 201')
		And match response.requestId == "#notnull"
		
		* def requestId = response.requestId
		
		* header Authorization = authToken
		Given path '/pawri/v1/request-status/' + requestId
		When method get
		Then status 200
		And karate.log('Status : 200')
		And match response.id == requestId
		
		And karate.log('Test Completed !')
		

	#REV2-21430
  Scenario: POST - Validate Party Admin cannot create party individual with blank values in contactPhone and contactEmail and notAvailable true
    
    * def randomNum = num.substring(4)
    
    * def userName = "test" + randomNum
    
		* eval requestPayload.loginEmailId = "test" + num + "@cybage.com"
		* eval requestPayload.loginPhoneNumber = num
		* eval requestPayload.notAvailable = true
		* eval requestPayload.username = userName
		* eval requestPayload.contactEmail = ""
		* eval requestPayload.contactPhone = ""
			
		Given path '/parties'
		And request requestPayload
		When method post
		Then status 400
		And karate.log('Status : 400')
		
		And karate.log('Test Completed !')


	#REV2-21431
  Scenario: POST - Validate Party Admin cannot create party individual with multiple otherRoles
    
		* eval requestPayload.loginEmailId = "test" + num + "@cybage.com"
		* eval requestPayload.loginPhoneNumber = num
		* eval requestPayload.otherRoles = ["U_00203", "S_00301"]
			
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


	#REV2-21432
  Scenario: POST - Validate Party Admin cannot create party individual with multiple classifications
    
		* eval requestPayload.loginEmailId = "test" + num + "@cybage.com"
		* eval requestPayload.loginPhoneNumber = num
		* eval requestPayload.classifications = ["S_70701", "S_70704"]
			
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
		

	#REV2-21433
  Scenario: POST - Validate Party Admin cannot create party individual with existing username
        
    * def existingUserName = "test86677"
    
		* eval requestPayload.loginEmailId = "test" + num + "@cybage.com"
		* eval requestPayload.loginPhoneNumber = num
		* eval requestPayload.notAvailable = true
		* eval requestPayload.username = existingUserName
			
		Given path '/parties'
		And request requestPayload
		When method post
		Then status 201
		And karate.log('Status : 201')
		
		* def requestId = response.requestId
		
		* call sleep 3
		
		* header Authorization = authToken
		Given path '/pawri/v1/request-status/' + requestId
		When method get
		Then status 200
		And karate.log('Status : 200')
		And match response.id == requestId
		And match response.errors[0].message == "Username is already in used"
		
		And karate.log('Test Completed !')
		

	#REV2-21434
  Scenario: POST - Validate Party Admin cannot create party individual with username having more than 10 characters
        
    * def userName = "testUserName86677"
    
		* eval requestPayload.loginEmailId = "test" + num + "@cybage.com"
		* eval requestPayload.loginPhoneNumber = num
		* eval requestPayload.notAvailable = true
		* eval requestPayload.username = userName
			
		Given path '/parties'
		And request requestPayload
		When method post
		Then status 400
		And karate.log('Status : 400')
		And match response.errors[0].message == "Username must not be greater than 10"
		
		And karate.log('Test Completed !')
		
		
	#REV2-21435
  Scenario: POST - Validate Party Admin cannot create party individual without loginEmailId and loginPhoneNumber when notAvailable is false
        
		* eval requestPayload.loginEmailId = ""
		* eval requestPayload.loginPhoneNumber = ""
		* eval requestPayload.notAvailable = false
			
		Given path '/parties'
		And request requestPayload
		When method post
		Then status 400
		And karate.log('Status : 400')
		And match response.errors[0].message contains "The phone number is invalid"
		
		And karate.log('Test Completed !')
		
	
	#REV2-21436
  Scenario: POST - Validate Party Admin can create party individual without contactEmail and contactPhone when notAvailable is false
        
		* eval requestPayload.loginEmailId = "test" + num + "@cybage.com"
		* eval requestPayload.loginPhoneNumber = num
		* eval requestPayload.notAvailable = false
		* eval requestPayload.contactEmail = null
		* eval requestPayload.contactPhone = null
			
		Given path '/parties'
		And request requestPayload
		When method post
		Then status 201
		And karate.log('Status : 201')
		
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
		

	#REV2-21437
  Scenario: POST - Validate Party Admin cannot create party individual without contactEmail and contactPhone when notAvailable is true
        
		* eval requestPayload.loginEmailId = "test" + num + "@cybage.com"
		* eval requestPayload.loginPhoneNumber = num
		* eval requestPayload.notAvailable = true
		* eval requestPayload.contactEmail = ""
		* eval requestPayload.contactPhone = ""
		* eval requestPayload.username = "test123"
			
		Given path '/parties'
		And request requestPayload
		When method post
		Then status 201
		And karate.log('Status : 201')
		
		And karate.log('Test Completed !')