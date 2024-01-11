Feature: Create new party contact for super admin role

	Background: 
	
		Given url backOfficeAPIBaseUrl
    And header Accept = 'application/json'
    And path '/pawri/v1'
    
    * def loginResult = callonce read('classpath:com/fnp/api/utils/generate-token.feature') {userType:"partyAdmin"}
    * def authToken = loginResult.accessToken
    
    * header Authorization = authToken
    * def today = new java.util.Date().time
    * def num = today + ""
    * def num = num.substring(10)
       
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/party/create-party-contact.json')
    * def requestPayloadPostalAddress = requestPayload[0] 
    * def requestPayloadEmailContact = requestPayload[1]
    * def requestPayloadPhoneContact = requestPayload[2]
    
    * def validPartyId = "P_01157"
    * def invalidPartyId = "P_01A5Z"
    	
  	
	#REV2-19169
  Scenario: POST - Validate Party Admin can create party contact for postal address with valid partyId
    
		* eval requestPayloadPostalAddress.addressContact.toName = "Friend" + num
		
		Given path '/partycontacts/' + validPartyId
		And request requestPayloadPostalAddress
		When method post
		Then status 201
		And karate.log('Status : 201')
		And match response.message contains "Contact information created"
		
		And karate.log('Test Completed !')
		
		
	#REV2-19170
  Scenario: POST - Validate Party Admin cannot create party contact for postal address with invalid partyId
    
		* eval requestPayloadPostalAddress.addressContact.toName = "Friend" + num
		
		Given path '/partycontacts/' + invalidPartyId
		And request requestPayloadPostalAddress
		When method post
		Then status 404
		And karate.log('Status : 404')
		And match response.errors[0].message contains "Party not found"
		
		And karate.log('Test Completed !')

		
	#REV2-19171
  Scenario: POST - Validate Party Admin cannot create party contact for postal address with invalid address1
    
		* eval requestPayloadPostalAddress.addressContact.toName = "Friend" + num
		* eval requestPayloadPostalAddress.addressContact.address1 = null
		
		Given path '/partycontacts/' + validPartyId
		And request requestPayloadPostalAddress
		When method post
		Then status 400
		And karate.log('Status : 400')
		
		And karate.log('Test Completed !')

	
	#REV2-19172
  Scenario: POST - Validate Party Admin cannot create party contact for postal address with invalid address2
    
		* eval requestPayloadPostalAddress.addressContact.toName = "Friend" + num
		* eval requestPayloadPostalAddress.addressContact.address2 = null
		
		Given path '/partycontacts/' + validPartyId
		And request requestPayloadPostalAddress
		When method post
		Then status 400
		And karate.log('Status : 400')
		
		And karate.log('Test Completed !')
	

	#REV2-19173
  Scenario: POST - Validate Party Admin cannot create party contact for postal address with invalid attentionName
    
		* eval requestPayloadPostalAddress.addressContact.toName = "Friend" + num
		* eval requestPayloadPostalAddress.addressContact.attentionName = "@!%$#{}-123"
		
		Given path '/partycontacts/' + validPartyId
		And request requestPayloadPostalAddress
		When method post
		Then status 400
		And karate.log('Status : 400')
		
		And karate.log('Test Completed !')
	
	
	#REV2-19174
  Scenario: POST - Validate Party Admin cannot create party contact for postal address with invalid doorbell
    
		* eval requestPayloadPostalAddress.addressContact.toName = "Friend" + num
		* eval requestPayloadPostalAddress.addressContact.doorbell = "@!%$#{}-123"
		
		Given path '/partycontacts/' + validPartyId
		And request requestPayloadPostalAddress
		When method post
		Then status 400
		And karate.log('Status : 400')
		
		And karate.log('Test Completed !')

	
	#REV2-19175
  Scenario: POST - Validate Party Admin cannot create party contact for postal address with invalid pincode
    
		* eval requestPayloadPostalAddress.addressContact.toName = "Friend" + num
		* eval requestPayloadPostalAddress.addressContact.pincode = "xyz-abc"
		
		Given path '/partycontacts/' + validPartyId
		And request requestPayloadPostalAddress
		When method post
		Then status 400
		And karate.log('Status : 400')
		
		And karate.log('Test Completed !')
	
		
	#REV2-19176
  Scenario: POST - Validate Party Admin cannot create party contact for postal address with invalid toName
    
		* eval requestPayloadPostalAddress.addressContact.toName = "@!%$#{}-123"
		
		Given path '/partycontacts/' + validPartyId
		And request requestPayloadPostalAddress
		When method post
		Then status 400
		And karate.log('Status : 400')
		
		And karate.log('Test Completed !')


	#REV2-19177
  Scenario: POST - Validate Party Admin cannot create party contact for postal address with invalid cityId
    
		* eval requestPayloadPostalAddress.addressContact.toName = "Friend" + num
		* eval requestPayloadPostalAddress.addressContact.cityId = "@!%$#{}-123"
		
		Given path '/partycontacts/' + validPartyId
		And request requestPayloadPostalAddress
		When method post
		Then status 400
		And karate.log('Status : 400')
		
		And karate.log('Test Completed !')
		

	#REV2-19178
  Scenario: POST - Validate Party Admin cannot create party contact for postal address with invalid contactPurposeId
    
		* eval requestPayloadPostalAddress.addressContact.toName = "Friend" + num
		* eval requestPayloadPostalAddress.contactPurposeId = "@!%$#{}-123"
		
		Given path '/partycontacts/' + validPartyId
		And request requestPayloadPostalAddress
		When method post
		Then status 400
		And karate.log('Status : 400')
		And match response.errors[0].message contains "Contact purpose not found"
		And karate.log('Test Completed !')
		

	#REV2-19179
  Scenario: POST - Validate Party Admin cannot create party contact for postal address with invalid contactTypeId
    
		* eval requestPayloadPostalAddress.addressContact.toName = "Friend" + num
		* eval requestPayloadPostalAddress.contactTypeId = "@!%$#{}-123"
		
		Given path '/partycontacts/' + validPartyId
		And request requestPayloadPostalAddress
		When method post
		Then status 400
		And karate.log('Status : 400')
		And match response.errors[0].message contains "Contact type not found"
		And karate.log('Test Completed !')
		

	#REV2-19180
  Scenario: POST - Validate Party Admin cannot create party contact for postal address with invalid countryId
    
		* eval requestPayloadPostalAddress.addressContact.toName = "Friend" + num
		* eval requestPayloadPostalAddress.addressContact.countryId = "@!%$#{}-123"
		
		Given path '/partycontacts/' + validPartyId
		And request requestPayloadPostalAddress
		When method post
		Then status 400
		And karate.log('Status : 400')
		And karate.log('Test Completed !')
		
	
	#REV2-19181
  Scenario: POST - Validate Party Admin cannot create party contact for postal address with invalid stateId
    
		* eval requestPayloadPostalAddress.addressContact.toName = "Friend" + num
		* eval requestPayloadPostalAddress.addressContact.stateId = "@!%$#{}-123"
		
		Given path '/partycontacts/' + validPartyId
		And request requestPayloadPostalAddress
		When method post
		Then status 400
		And karate.log('Status : 400')
		And karate.log('Test Completed !')
		
	
	#REV2-19182
  Scenario: POST - Validate Party Admin cannot create party contact for postal address with multiple values in cityId
    
		* eval requestPayloadPostalAddress.addressContact.toName = "Friend" + num
		* eval requestPayloadPostalAddress.addressContact.cityId = ["pune", "delhi"]
		
		Given path '/partycontacts/' + validPartyId
		And request requestPayloadPostalAddress
		When method post
		Then status 400
		And karate.log('Status : 400')
		And match response.errors[0].message contains "Invalid input data"
		
		And karate.log('Test Completed !')
		

	#REV2-19183
  Scenario: POST - Validate Party Admin cannot create party contact for postal address with multiple values in contactPurposeId
    
		* eval requestPayloadPostalAddress.addressContact.toName = "Friend" + num
		* eval requestPayloadPostalAddress.contactPurposeId = ["S_70401", "S_70402"]
		
		Given path '/partycontacts/' + validPartyId
		And request requestPayloadPostalAddress
		When method post
		Then status 400
		And karate.log('Status : 400')
		And match response.errors[0].message contains "Invalid input data"
		And karate.log('Test Completed !')
		

	#REV2-19184
  Scenario: POST - Validate Party Admin cannot create party contact for postal address with multiple values in contactTypeId
    
		* eval requestPayloadPostalAddress.addressContact.toName = "Friend" + num
		* eval requestPayloadPostalAddress.contactTypeId = ["S_70201", "S_70202"]
		
		Given path '/partycontacts/' + validPartyId
		And request requestPayloadPostalAddress
		When method post
		Then status 400
		And karate.log('Status : 400')
		And match response.errors[0].message contains "Invalid input data"
		And karate.log('Test Completed !')
		

	#REV2-19185
  Scenario: POST - Validate Party Admin cannot create party contact for postal address with multiple values in countryId
    
		* eval requestPayloadPostalAddress.addressContact.toName = "Friend" + num
		* eval requestPayloadPostalAddress.addressContact.countryId = ["IND", "USA"]
		
		Given path '/partycontacts/' + validPartyId
		And request requestPayloadPostalAddress
		When method post
		Then status 400
		And karate.log('Status : 400')
		And match response.errors[0].message contains "Invalid input data"
		And karate.log('Test Completed !')
		

	#REV2-19186
  Scenario: POST - Validate Party Admin cannot create party contact for postal address with multiple values in stateId
    
		* eval requestPayloadPostalAddress.addressContact.toName = "Friend" + num
		* eval requestPayloadPostalAddress.addressContact.stateId = ["IN-MH", "IN-UP"]
		
		Given path '/partycontacts/' + validPartyId
		And request requestPayloadPostalAddress
		When method post
		Then status 400
		And karate.log('Status : 400')
		And match response.errors[0].message contains "Invalid input data"
		And karate.log('Test Completed !')
		
	
	#REV2-19187
  Scenario: POST - Validate Party Admin cannot create party contact for postal address with blank PartyId
    
    * def blankPartyId = ""
		* eval requestPayloadPostalAddress.addressContact.toName = "Friend" + num
		
		Given path '/partycontacts/' + blankPartyId
		And request requestPayloadPostalAddress
		When method post
		Then status 404
		And karate.log('Status : 404')
		And karate.log('Test Completed !')
		
	
	#REV2-19188
  Scenario: POST - Validate Party Admin cannot create party contact for postal address with all blank values
    
		* eval requestPayloadPostalAddress.addressContact.toName = "Friend" + num
		* eval requestPayloadPostalAddress.contactPurposeId = ""
		* eval requestPayloadPostalAddress.contactTypeId = ""
		* eval requestPayloadPostalAddress.addressContact = ""
		
		Given path '/partycontacts/' + validPartyId
		And request requestPayloadPostalAddress
		When method post
		Then status 400
		And karate.log('Status : 400')
		And match response.errors[0].message contains "Invalid input data"
		And karate.log('Test Completed !')


	#REV2-19189 and REV2-19190
  Scenario: POST - Validate Party Admin cannot create party contact for postal address with duplicate data
    
		* eval requestPayloadPostalAddress.addressContact.toName = "Friend" + num
		
		Given path '/partycontacts/' + validPartyId
		And request requestPayloadPostalAddress
		When method post
		Then status 201
		And karate.log('Status : 201')
		And match response.message contains "Contact information created"
		
		#create party contact with duplicate data		
		* header Authorization = authToken
		
		Given path '/pawri/v1/partycontacts/' + validPartyId
		And request requestPayloadPostalAddress
		When method post
		Then status 400
		And karate.log('Status : 400')
		
		And karate.log('Test Completed !')
		
		
	#REV2-19191
  Scenario: POST - Validate Party Admin cannot create party contact for postal address with multiple spaces for partyId
    
    * def partyIdWithSpaces = " " + validPartyId + " "
		* eval requestPayloadPostalAddress.addressContact.toName = "Friend" + num
		
		Given path '/partycontacts/' + partyIdWithSpaces
		And request requestPayloadPostalAddress
		When method post
		Then status 404
		And karate.log('Status : 404')
		And karate.log('Test Completed !')

		
	#REV2-19192		
	Scenario: POST - Validate Party Admin cannot create party contact for postal address with multiple spaces in all values
    
		* eval requestPayloadPostalAddress.addressContact.toName = "Friend" + num
		* eval requestPayloadPostalAddress.contactPurposeId = " " + requestPayloadPostalAddress.contactPurposeId + " "
		* eval requestPayloadPostalAddress.contactTypeId = " " + requestPayloadPostalAddress.contactTypeId + " "
		* eval requestPayloadPostalAddress.addressContact = " " + requestPayloadPostalAddress.addressContact + " "
		
		Given path '/partycontacts/' + validPartyId
		And request requestPayloadPostalAddress
		When method post
		Then status 400
		And karate.log('Status : 400')
		And match response.errors[0].message contains "Invalid input data"
		And karate.log('Test Completed !')

	
	#REV2-19194		
	Scenario: POST - Validate Party Admin cannot create party contact for postal address with invalid endpoint
    
		* eval requestPayloadPostalAddress.addressContact.toName = "Friend" + num
		
		Given path '/partycontacts1/' + validPartyId
		And request requestPayloadPostalAddress
		When method post
		Then status 404
		And karate.log('Status : 404')
		And karate.log('Test Completed !')
		
		
	#REV2-19195		
	Scenario: POST - Validate Party Admin cannot create party contact for postal address with unsupported method
    
		* eval requestPayloadPostalAddress.addressContact.toName = "Friend" + num
		
		Given path '/partycontacts/' + validPartyId
		And request requestPayloadPostalAddress
		When method put
		Then status 405
		And karate.log('Status : 405')
		And match response.errors[0].message contains "Unsupported request Method"
		And karate.log('Test Completed !')
		
			
	#REV2-19196	
	Scenario: POST - Validate invalid authentication token error to create party contact for postal address
    
    * def invalidAuthToken = "eyJraWQiOiJmbnAyIiwiYWxnIjoiUlMyNTYifQ"
    
		* eval requestPayloadPostalAddress.addressContact.toName = "Friend" + num
		
		* header Authorization = invalidAuthToken
		
		Given path '/partycontacts/' + validPartyId
		And request requestPayloadPostalAddress
		When method post
		Then status 403
		And karate.log('Status : 403')
		And match response.errors[0].message contains "Access Denied"
		And karate.log('Test Completed !')
		
			
	#REV2-19200	
	Scenario: POST - Validate Party Admin cannot create party contact with alphabetical values for fromDate & throughDate
    
		* eval requestPayloadPostalAddress.addressContact.toName = "Friend" + num
		* eval requestPayloadPostalAddress.fromDate = "1 Jan,2022"
		* eval requestPayloadPostalAddress.throughDate = "1 Aug,2022"
		
		Given path '/partycontacts/' + validPartyId
		And request requestPayloadPostalAddress
		When method post
		Then status 400
		And karate.log('Status : 400')
		And match response.errors[0].message contains "Invalid input data"
		And karate.log('Test Completed !')

			
	#REV2-19201	
	Scenario: POST - Validate Party Admin cannot create party contact with special characters for fromDate & throughDate
    
		* eval requestPayloadPostalAddress.addressContact.toName = "Friend" + num
		* eval requestPayloadPostalAddress.fromDate = "!@#$%"
		* eval requestPayloadPostalAddress.throughDate = "!@#$%"
		
		Given path '/partycontacts/' + validPartyId
		And request requestPayloadPostalAddress
		When method post
		Then status 400
		And karate.log('Status : 400')
		And match response.errors[0].message contains "Invalid input data"
		And karate.log('Test Completed !')
	
	
	#REV2-19202
  Scenario: POST - Validate Party Admin cannot create party contact for phone contact with invalid phone
    
		* eval requestPayloadPhoneContact.phoneContact.phone = "ABC1234"
		
		Given path '/partycontacts/' + validPartyId
		And request requestPayloadPhoneContact
		When method post
		Then status 400
		And karate.log('Status : 400')
		And match response.errors[0].message contains "Invalid input data"
		
		And karate.log('Test Completed !')	
		

	#REV2-19203
  Scenario: POST - Validate Party Admin cannot create party contact for phone contact with blank phone
    
		* eval requestPayloadPhoneContact.phoneContact.phone = ""
		
		Given path '/partycontacts/' + validPartyId
		And request requestPayloadPhoneContact
		When method post
		Then status 400
		And karate.log('Status : 400')
		And match response.errors[0].message contains "Invalid input data"
		
		And karate.log('Test Completed !')	
		
		
	#REV2-19204 and REV2-19206
  Scenario: POST - Validate Party Admin can create party contact for phone contact with duplicate phone
    
		* eval requestPayloadPhoneContact.phoneContact.phone = "9821234567"
		
		Given path '/partycontacts/' + validPartyId
		And request requestPayloadPhoneContact
		When method post
		Then status 201
		And karate.log('Status : 201')
		And match response.message contains "Contact information created"
		
		#create party contact with duplicate phone
		
		* header Authorization = authToken
		
		Given path '/pawri/v1/partycontacts/' + validPartyId
		And request requestPayloadPhoneContact
		When method post
		Then status 201
		And karate.log('Status : 201')
		And match response.message contains "Contact information created"
		
		And karate.log('Test Completed !')	
		

	#REV2-19205
  Scenario: POST - Validate Party Admin cannot create party contact for phone contact with spaces in phone number
    
		* eval requestPayloadPhoneContact.phoneContact.phone = " 9821234567 "
		
		Given path '/partycontacts/' + validPartyId
		And request requestPayloadPhoneContact
		When method post
		Then status 400
		And karate.log('Status : 400')
		And match response.errors[0].message contains "Invalid phone number"
		
		And karate.log('Test Completed !')	


	#REV2-19207
  Scenario: POST - Validate Party Admin cannot create party contact for email contact with invalid email
    
		* eval requestPayloadEmailContact.emailContact.email = "ABC1234"
		
		Given path '/partycontacts/' + validPartyId
		And request requestPayloadEmailContact
		When method post
		Then status 400
		And karate.log('Status : 400')
		And match response.errors[0].message contains "Invalid email address"
		
		And karate.log('Test Completed !')	
		

	#REV2-19208
  Scenario: POST - Validate Party Admin cannot create party contact for email contact with blank email
    
		* eval requestPayloadEmailContact.emailContact.email = ""
		
		Given path '/partycontacts/' + validPartyId
		And request requestPayloadEmailContact
		When method post
		Then status 400
		And karate.log('Status : 400')
		And match response.errors[0].message contains "Email must not be blank"
		
		And karate.log('Test Completed !')	
		
	
	#REV2-19209 and REV2-19211
  Scenario: POST - Validate Party Admin can create party contact for email contact with duplicate email
    
		* eval requestPayloadEmailContact.emailContact.email = "test@cybage.com"
		
		Given path '/partycontacts/' + validPartyId
		And request requestPayloadEmailContact
		When method post
		Then status 201
		And karate.log('Status : 201')
		And match response.message contains "Contact information created"
		
		#create party contact with duplicate email
		
		* header Authorization = authToken
		
		Given path '/pawri/v1/partycontacts/' + validPartyId
		And request requestPayloadEmailContact
		When method post
		Then status 201
		And karate.log('Status : 201')
		And match response.message contains "Contact information created"
		
		And karate.log('Test Completed !')	
		

	#REV2-19210
  Scenario: POST - Validate Party Admin cannot create party contact for email contact with spaces in email
    
		* eval requestPayloadEmailContact.emailContact.email = " test@cybage.com "
		
		Given path '/partycontacts/' + validPartyId
		And request requestPayloadEmailContact
		When method post
		Then status 400
		And karate.log('Status : 400')
		And match response.errors[0].message contains "Invalid email address"
		
		And karate.log('Test Completed !')	
	
