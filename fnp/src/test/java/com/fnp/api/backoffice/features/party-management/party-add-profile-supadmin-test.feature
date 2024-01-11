Feature: Party Add Profile API Scenarios feature

  Background: 
    Given url backOfficeAPIBaseUrl
    And header Accept = 'application/json'
    And path '/simsim/v1/logins'
    * def loginResult = callonce read('classpath:com/fnp/api/utils/generate-token.feature') {userType:"partyAdmin"}
    * def authToken = loginResult.accessToken
    * header Authorization = authToken
    * def today = new java.util.Date().time
    * def num = today + ""
    * def num = num.substring(8)
    * def partyId = 'P_00007'
    * def invalidPartyId = 'P_0x0c07'
    
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/party/party.json')
    
       	
    #@Regression
    #REV2-15651
    Scenario: POST - Validate Party Admin can create profile for valid partyId and request body
      
			* eval requestPayload.username = "QATest" + num
	
			Given param partyId = partyId		
			And request requestPayload
			When method post
			Then status 201
			And karate.log('Status : 201')
			And match response.successCode == "party.new_username_created"
			And match response.message contains "New Username created"
			And karate.log('Test Completed !')
		
		
		#REV2-15652
    Scenario: POST - Validate Party Admin can create profile for valid partyId and only required parameters
    			
			* eval requestPayload.username = num + "QATest@fnp.com"
			* eval requestPayload.isActive = 'true'
					
			Given param partyId = partyId	
			And request requestPayload  
			When method post
			Then status 201
			And karate.log('Status : 201')
			And match response.successCode == "party.new_username_created"
			And match response.message contains "New Username created"
			And karate.log('Test Completed !')
		
		
		#REV2-15653
    Scenario: POST - Validate Party Admin can create profile for valid partyId and only optional parameters
    			
			* eval requestPayload.accessTransferLogin = ""
			* eval requestPayload.confirmPassword = ""
			* eval requestPayload.disabledDate = ""
			* eval requestPayload.password = ""
			* eval requestPayload.username = ""
			* eval requestPayload.isActive = ""
			* eval requestPayload.resetPasswordChange = ""
						
			Given param partyId = partyId	
			And request requestPayload
			When method post
			Then status 400
			And karate.log('Status : 400')
			And match response.errors[*].message contains "Invalid input data"
			And karate.log('Test Completed !')
		
		
		#REV2-15654
    Scenario: POST - Validate Party Admin can create profile for invalid partyId
    	    
			* eval requestPayload.username = "QATest" + num
						
			Given param partyId = invalidPartyId		
			And request requestPayload
			When method post
			Then status 404
			And karate.log('Status : 404')
			And match response.errors[*].message == ["Party Not Found"]
			And karate.log('Test Completed !')
		 
		
	  #REV2-15655
    Scenario: POST - Validate Party Admin can create profile for blank partyId
    	    
			* eval requestPayload.username = "QATest" + num
				
			Given param partyId = ''		
			And request requestPayload
			When method post
			Then status 404
			And karate.log('Status : 404')
			And match response.errors[*].message == ["Party Not Found"]
			And karate.log('Test Completed !')
		
		
		#REV2-15656
		Scenario: POST - Validate Party Admin can create profile for blank value with leading & trailing spaces in partyId
		
			* eval requestPayload.username = "QATest" + num
			
			Given param partyId = ' ' + partyId + ' '		
			And request requestPayload
			When method post
			Then status 404
			And karate.log('Status : 404')
			And match response.errors[*].message == ["Party Not Found"]
			And karate.log('Test Completed !')
	
		
		#REV2-15657
		Scenario: POST - Validate Party Admin can create profile for not allowed value in partyId
			  
			* eval requestPayload.username = "QATest" + num
			
	  	Given param partyId = invalidPartyId	
			And request requestPayload
			When method post
			Then status 404
			And karate.log('Status : 404')
			And match response.errors[*].message == ["Party Not Found"]
			And karate.log('Test Completed !')
		
		
		#REV2-15658
		Scenario: POST - Validate Party Admin can create profile for with Duplicate data in partyId & request body.
			    
			* eval requestPayload.username = "QATest92179"
			
	  	Given param partyId = partyId		
			And request requestPayload
			When method post
			Then status 400
			And karate.log('Status : 400')
			And match response.errors[*].message == ["User is already registered..Try registering with different email & phone-number"]
			And karate.log('Test Completed !')
	  
   
    #REV2-15659  
    Scenario: POST - Validate Party Admin can create profile for valid partyId and blank values in request body
    
			* eval requestPayload.accessTransferLogin = ""
			* eval requestPayload.confirmPassword = ""
			* eval requestPayload.disabledDate = ""
			* eval requestPayload.password = ""
			* eval requestPayload.username = ""
			* eval requestPayload.isActive = ""
			* eval requestPayload.resetPasswordChange = ""
			
			
			Given param partyId = partyId	
			And request requestPayload
			When method post
			Then status 400
			And karate.log('Status : 400')
			And match response.errors[*].message contains "Invalid input data"
			And karate.log('Test Completed !')
		
		
		#REV2-15660    
		Scenario: POST - Validate Party Admin can create profile for valid partyId and blank values with leading & trailing spaces in request body
				
			* eval requestPayload.accessTransferLogin = " null "
			* eval requestPayload.confirmPassword = " Password@123 "
			* eval requestPayload.disabledDate = " 2022-06-24T07:55:44 "
			* eval requestPayload.password = " Password@123 "
			* eval requestPayload.username = " manQA@fnp.com "
			* eval requestPayload.isActive = " true "
			* eval requestPayload.resetPasswordChange = " true "
						
			Given param partyId = partyId		
			And request requestPayload
			When method post
			Then status 400
			And karate.log('Status : 400')
			And match response.errors[*].message contains "Invalid input data"
			And karate.log('Test Completed !')
		

	#REV2-15661    
		Scenario: POST - Validate Party Admin can create profile for valid partyId and Invalid Username
					
			* eval requestPayload.username = "@#$%^&"
		
			Given param partyId = partyId		
			And request requestPayload
			When method post
			Then status 400
			And karate.log('Status : 400')
			And match response.errors[*].message contains "Invalid input data"
			And karate.log('Test Completed !')
		
			
	#REV2-15662    
		Scenario: POST - Validate Party Admin can create profile for valid partyId Invalid Password
						
			* eval requestPayload.password = "#$%^???"
			* eval requestPayload.username = "QATest" + num

			Given param partyId = partyId		
			And request requestPayload
			When method post
			Then status 400
			And karate.log('Status : 400')
			And match response.errors[*].message contains ["The password must be at least 8 character password contains at least one uppercase character, at least one special character, and at least one number"]
			And karate.log('Test Completed !')
		
		
		#REV2-15663 
		Scenario: POST - Validate Party Admin can create profile for valid partyId and Invalid Confirm Password
					
			* eval requestPayload.confirmPassword = "#$%^???kk"
			* eval requestPayload.username = "fnp"	
						
			Given param partyId = partyId		
			And request requestPayload
			When method post
			Then status 400
			And karate.log('Status : 400')
			And match response.errors[*].message contains ["The password must be at least 8 character password contains at least one uppercase character, at least one special character, and at least one number"]
			And karate.log('Test Completed !')
		
		
		#REV2-15664 
		Scenario: POST - Validate Party Admin can create profile for valid partyId and Invalid disableDate
				
			* eval requestPayload.disabledDate = "#$@WE"
		
			Given param partyId = partyId		
			And request requestPayload
			When method post
			Then status 400
			And karate.log('Status : 400')
			And match response.errors[*].message contains "Invalid input data"
			And karate.log('Test Completed !')
		
		
		#REV2-15665 
		Scenario: POST - Validate Party Admin can create profile for valid partyId and with Invalid accessTransferLogin
				
			* eval requestPayload.accessTransferLogin = "@#$%&@&"
			* eval requestPayload.username = "fnp" + num
			
			Given param partyId = partyId		
			And request requestPayload
			When method post
			Then status 400
			And karate.log('Status : 400')
			And match response.errors[*].message contains "Party login not found to transfer access or Login is active"
			And karate.log('Test Completed !')
		
		
		#REV2-15666
		Scenario: POST - Validate Party Admin can create profile for valid partyId and with Invalid isActive
				
			* eval requestPayload.username = "fnp" + num
			* eval requestPayload.isActive = "*&^%#?"
					
			Given param partyId = partyId		
			And request requestPayload
			When method post
			Then status 400
			And karate.log('Status : 400')
			And match response.errors[*].message contains "Invalid input data"
			And karate.log('Test Completed !')
		

		#REV2-15667
		Scenario: POST - Validate Party Admin can create profile for valid partyId and Invalid resetPasswordChange.
				
			* eval requestPayload.username = num + "QATest"
			* eval requestPayload.resetPasswordChange = "dgsfsdfgW@123"
						
			Given param partyId = partyId		
			And request requestPayload
			When method post
			Then status 400
			And karate.log('Status : 400')
			And match response.errors[*].message contains ["Invalid input data"]
			And karate.log('Test Completed !')
		
		
		#REV2-15668
		Scenario: POST - Validate Party Admin can create profile for valid partyId and Invalid Endpoint
				
			* eval requestPayload.username = num + "QATest"
			* eval requestPayload.password = "dgsfsdfgW@123"
				
			Given path 'gtetsj'
			And param partyId = partyId		
			And request requestPayload
			When method post
			Then status 405
			And karate.log('Status : 405')
			And match response.errors[*].message contains "Unsupported request Method. Contact the site administrator"
			And karate.log('Test Completed !')
		
		
		#REV2-15669
		Scenario: PUT - Unsupported Method for Party admin access with Valid Endpoint
					
			* eval requestPayload.username = num + "QATest"
			* eval requestPayload.password = "dgsfsdfgW@123"
			
			Given param partyId = partyId		
			And request requestPayload
			When method put
			Then status 405
			And karate.log('Status : 405')
			And match response.errors[*].message contains "Unsupported request Method. Contact the site administrator"
			And karate.log('Test Completed !') 
		
	
		#REV2-15670
		Scenario: POST - Verify 500 error for post New Username API
					
			* eval requestPayload.username = num + "QATest"
			* eval requestPayload.password = "dgsfsdfgW@123"
			
			Given param partyId = partyId		
			And request requestPayload
			When method put
			Then status 405
			And karate.log('Status : 405')
			And match response.errors[*].message contains "Unsupported request Method. Contact the site administrator"
			And karate.log('Test Completed !') 
		
		
		#REV2-15671
		Scenario: POST - Verify new username api with Invalid Authentication Token
		
			* def invalidAuthToken = "eyJraWQiOiJmbnAyIiwiYWxnIjoiUlMyNTYifQ"
			* header Authorization = invalidAuthToken
			
			* eval requestPayload.username = num + "QATest"
			Given param partyId = partyId		
			And request requestPayload
			When method post
			Then status 403
			And karate.log('Status : 403')
			And match response.errors[*].message contains "Access Denied"
			And karate.log('Test Completed !') 
			
		
		
		#REV2-15673
		Scenario: POST - Verify new username api with password & confirmPassword should be same
			    
			* eval requestPayload.username = "QATest" + num
	
			Given param partyId = partyId		
			And request requestPayload
			When method post
			Then status 201
			And karate.log('Status : 201')
			And match response.successCode == "party.new_username_created"
			And match response.message contains "New Username created"
			And karate.log('Test Completed !')
		

		#REV2-15674
		Scenario: POST - Verify new username api with at least 8 character for password & confirmPassword
			    
			* eval requestPayload.username = "QATest" + num
			* eval requestPayload.confirmPassword = "Pass@123"
			* eval requestPayload.password = "Pass@123"
	
			Given param partyId = partyId		
			And request requestPayload
			When method post
			Then status 201
			And karate.log('Status : 201')
			And match response.successCode == "party.new_username_created"
			And match response.message contains "New Username created"
			And karate.log('Test Completed !')
		
		
		#REV2-15675
		Scenario: POST - Verify new username api with size of username should be of maximum 50 characters
			
			* eval requestPayload.username = "QATestfjsfhsfsfgfhsafhfjdadgadgaagadadaadaadagdg" + num
	
			Given param partyId = partyId		
			And request requestPayload
			When method post
			Then status 400
			And karate.log('Status : 400')
			And match response.errors[0].message contains "Login id/Username must not be greater than 50"
			And karate.log('Test Completed !')
		
		
		#REV2-15676
		Scenario: POST - Verify new username api with blank value in username
			    
			* eval requestPayload.username = " "
	
			Given param partyId = partyId		
			And request requestPayload
			When method post
			Then status 400
			And karate.log('Status : 400')
			And match response.errors[*].message == ["The Login id/Username field is empty"]
			And karate.log('Test Completed !')
		
	
		#REV2-15677
		Scenario: POST - Verify new username api with blank value in password
				    
			* eval requestPayload.username = "QATest" + num
			* eval requestPayload.password = " "
	
			Given param partyId = partyId		
			And request requestPayload
			When method post
			Then status 400
			And karate.log('Status : 400')
			And match response.errors[*].message contains "The password must be at least 8 character password contains at least one uppercase character, at least one special character, and at least one number"
			And karate.log('Test Completed !')
		
		
		
		#REV2-15678
		Scenario: POST - Verify new username api with blank value in confirmPassword
			
			* eval requestPayload.username = "QATest" + num
			* eval requestPayload.confirmPassword = " "
	
			Given param partyId = partyId		
			And request requestPayload
			When method post
			Then status 400
			And karate.log('Status : 400')
			And match response.errors[*].message contains "The password must be at least 8 character password contains at least one uppercase character, at least one special character, and at least one number"
			And karate.log('Test Completed !')
		

		#REV2-15679
		Scenario: POST - Verify new username api with in blank value in isActive
			    
			* eval requestPayload.username = "QATest" + num
			* eval requestPayload.isActive = " "
	
			Given param partyId = partyId		
			And request requestPayload
			When method post
			Then status 400
			And karate.log('Status : 400')
			And match response.errors[*].message == ["isActive is null"]
			And karate.log('Test Completed !')
		
		
		#REV2-15680
		Scenario: POST - Verify new username api with in blank value in resetPasswordChange
			    
			* eval requestPayload.username = "QATest" + num
			* eval requestPayload.resetPasswordChange = " "
	
			Given param partyId = partyId		
			And request requestPayload
			When method post
			Then status 400
			And karate.log('Status : 400')
			And match response.errors[*].message == ["resetPasswordChange field must not be null"]
			And karate.log('Test Completed !')
		
		
		
		#REV2-15681
		Scenario: POST - Verify new username api with isActive & resetPasswordChange should accept only true & false
		
			* eval requestPayload.username = "QATest" + num		
	
			Given param partyId = partyId		
			And request requestPayload
			When method post
			Then status 201
			And karate.log('Status : 201')
			And karate.log('Test Completed !')