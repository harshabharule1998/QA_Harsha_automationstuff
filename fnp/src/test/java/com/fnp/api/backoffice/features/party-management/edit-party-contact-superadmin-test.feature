Feature: Edit party contact for super admin role

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
       
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/party/edit-party-contact.json')
    * def requestPayloadPostalAddress = requestPayload[0] 
    * def requestPayloadEmailContact = requestPayload[1]
    * def requestPayloadPhoneContact = requestPayload[2]
    
    * def validPartyId = "P_01171"
    * def invalidPartyId = "P_01A5Z"
    
    * def validPartyContactId = "U_05108"
    * def invalidPartyContactId = "U_00000"
    	
  	
	#REV2-19384
  Scenario: PUT - Validate Party Admin can edit party contact for postal address with valid partyId and partyContactId
    
		* eval requestPayloadPostalAddress.addressContact.toName = "Friend" + num
		
		Given path '/partycontacts/' + validPartyId + "/" + validPartyContactId
		And request requestPayloadPostalAddress
		When method put
		Then status 202
		And karate.log('Status : 202')
		And match response.message contains "Contact information updated"
		
		And karate.log('Test Completed !')
		
	
	#REV2-19385 and REV2-19391
  Scenario: PUT - Validate Party Admin cannot edit party contact for postal address with valid partyId and invalid partyContactId
    
		* eval requestPayloadPostalAddress.addressContact.toName = "Friend" + num
		
		Given path '/partycontacts/' + validPartyId + "/" + invalidPartyContactId
		And request requestPayloadPostalAddress
		When method put
		Then status 400
		And karate.log('Status : 400')
		And match response.errors[0].message contains "Contact not found"
		
		And karate.log('Test Completed !')
		
		
	#REV2-19386
  Scenario: PUT - Validate Party Admin cannot edit party contact for postal address with invalid partyId and partyContactId
    
		* eval requestPayloadPostalAddress.addressContact.toName = "Friend" + num
		
		Given path '/partycontacts/' + invalidPartyId + "/" + invalidPartyContactId
		And request requestPayloadPostalAddress
		When method put
		Then status 404
		And karate.log('Status : 404')
		And match response.errors[0].message contains "Party not found"
		
		And karate.log('Test Completed !')
		
			
	#REV2-19387
  Scenario: PUT - Validate Party Admin cannot edit party contact for postal address with invalid partyId and valid partyContactId
    
		* eval requestPayloadPostalAddress.addressContact.toName = "Friend" + num
		
		Given path '/partycontacts/' + invalidPartyId + "/" + validPartyContactId
		And request requestPayloadPostalAddress
		When method put
		Then status 404
		And karate.log('Status : 404')
		And match response.errors[0].message contains "Party not found"
		
		And karate.log('Test Completed !')

		
	#REV2-19388
  Scenario: PUT - Validate Party Admin cannot edit party contact for postal address with blank partyId and valid partyContactId
    
    * def blankPartyId = ""
		* eval requestPayloadPostalAddress.addressContact.toName = "Friend" + num
		
		Given path '/partycontacts/' + blankPartyId + "/" + validPartyContactId
		And request requestPayloadPostalAddress
		When method put
		Then status 405
		And karate.log('Status : 405')
		
		And karate.log('Test Completed !')

		
	#REV2-19390
  Scenario: PUT - Validate Party Admin cannot edit party contact for postal address having partyId with spaces and valid partyContactId
    
    * def partyIdWithSpaces = " " + validPartyId + " "
		* eval requestPayloadPostalAddress.addressContact.toName = "Friend" + num
		
		Given path '/partycontacts/' + partyIdWithSpaces + "/" + validPartyContactId
		And request requestPayloadPostalAddress
		When method put
		Then status 404
		And karate.log('Status : 404')
		And match response.errors[0].message contains "Party not found"
		
		And karate.log('Test Completed !')
		
	
	#REV2-19392
  Scenario: PUT - Validate Party Admin cannot edit party contact for postal address with valid partyId and blank partyContactId
    
    * def blankPartyContactId = ""
		* eval requestPayloadPostalAddress.addressContact.toName = "Friend" + num
		
		Given path '/partycontacts/' + validPartyId + "/" + blankPartyContactId
		And request requestPayloadPostalAddress
		When method put
		Then status 405
		And karate.log('Status : 405')
		
		And karate.log('Test Completed !')

		
	#REV2-19394
  Scenario: PUT - Validate Party Admin cannot edit party contact for postal address with valid partyId and partyContactId having spaces
    
    * def partyContactIdWithSpaces = " " + validPartyContactId + " "
		* eval requestPayloadPostalAddress.addressContact.toName = "Friend" + num
		
		Given path '/partycontacts/' + validPartyId + "/" + partyContactIdWithSpaces
		And request requestPayloadPostalAddress
		When method put
		Then status 400
		And karate.log('Status : 400')
		
		And karate.log('Test Completed !')
		
				
	#REV2-19395
  Scenario: PUT - Validate Party Admin cannot edit party contact for postal address with invalid address1
    
		* eval requestPayloadPostalAddress.addressContact.toName = "Friend" + num
		* eval requestPayloadPostalAddress.addressContact.address1 = "{}]["
		
		Given path '/partycontacts/' + validPartyId + "/" + validPartyContactId
		And request requestPayloadPostalAddress
		When method put
		Then status 400
		And karate.log('Status : 400')
		
		And karate.log('Test Completed !')

	
			
	#REV2-19396
  Scenario: PUT - Validate Party Admin cannot edit party contact for postal address with invalid address2
    
		* eval requestPayloadPostalAddress.addressContact.toName = "Friend" + num
		* eval requestPayloadPostalAddress.addressContact.address2 = "{}]["
		
		Given path '/partycontacts/' + validPartyId + "/" + validPartyContactId
		And request requestPayloadPostalAddress
		When method put
		Then status 400
		And karate.log('Status : 400')
		
		And karate.log('Test Completed !')
	
					
	#REV2-19397
  Scenario: PUT - Validate Party Admin cannot edit party contact for postal address with invalid attentionName
    
		* eval requestPayloadPostalAddress.addressContact.toName = "Friend" + num
		* eval requestPayloadPostalAddress.addressContact.attentionName = "@!%$#{}-123{}]["
		
		Given path '/partycontacts/' + validPartyId + "/" + validPartyContactId
		And request requestPayloadPostalAddress
		When method put
		Then status 400
		And karate.log('Status : 400')
		
		And karate.log('Test Completed !')
		
				
	#REV2-19398
  Scenario: PUT - Validate Party Admin cannot edit party contact for postal address with invalid doorbell
    
		* eval requestPayloadPostalAddress.addressContact.toName = "Friend" + num
		* eval requestPayloadPostalAddress.addressContact.doorbell = "@!%$#{}-123{}]["
		
		Given path '/partycontacts/' + validPartyId + "/" + validPartyContactId
		And request requestPayloadPostalAddress
		When method put
		Then status 400
		And karate.log('Status : 400')
		
		And karate.log('Test Completed !')
	
					
	#REV2-19399
  Scenario: PUT - Validate Party Admin cannot edit party contact for postal address with invalid pincode
    
		* eval requestPayloadPostalAddress.addressContact.toName = "Friend" + num
		* eval requestPayloadPostalAddress.addressContact.pincode = "@!%$#{}-123{}]["
		
		Given path '/partycontacts/' + validPartyId + "/" + validPartyContactId
		And request requestPayloadPostalAddress
		When method put
		Then status 400
		And karate.log('Status : 400')
		
		And karate.log('Test Completed !')
				
			
	#REV2-19400
  Scenario: PUT - Validate Party Admin cannot edit party contact for postal address with invalid toName
    
		* eval requestPayloadPostalAddress.addressContact.toName = "@!%$#{}-123{}]["
		
		Given path '/partycontacts/' + validPartyId + "/" + validPartyContactId
		And request requestPayloadPostalAddress
		When method put
		Then status 400
		And karate.log('Status : 400')
		
		And karate.log('Test Completed !')
			

	#REV2-19401
  Scenario: PUT - Validate Party Admin cannot edit party contact for postal address with invalid cityId
    
		* eval requestPayloadPostalAddress.addressContact.toName = "Friend" + num
		* eval requestPayloadPostalAddress.addressContact.cityId = "@!%$#{}-123{}]["
		
		Given path '/partycontacts/' + validPartyId + "/" + validPartyContactId
		And request requestPayloadPostalAddress
		When method put
		Then status 400
		And karate.log('Status : 400')
		
		And karate.log('Test Completed !')
		
	
	#REV2-19402
  Scenario: PUT - Validate Party Admin cannot edit party contact for postal address with invalid stateId
    
		* eval requestPayloadPostalAddress.addressContact.toName = "Friend" + num
		* eval requestPayloadPostalAddress.addressContact.stateId = "@!%$#{}-123{}]["
		
		Given path '/partycontacts/' + validPartyId + "/" + validPartyContactId
		And request requestPayloadPostalAddress
		When method put
		Then status 400
		And karate.log('Status : 400')
		
		And karate.log('Test Completed !')
		
	
	#REV2-19403
  Scenario: PUT - Validate Party Admin cannot edit party contact for postal address with invalid countryId
    
		* eval requestPayloadPostalAddress.addressContact.toName = "Friend" + num
		* eval requestPayloadPostalAddress.addressContact.countryId = "@!%$#{}-123{}]["
		
		Given path '/partycontacts/' + validPartyId + "/" + validPartyContactId
		And request requestPayloadPostalAddress
		When method put
		Then status 400
		And karate.log('Status : 400')
		
		And karate.log('Test Completed !')
		

	#REV2-19404
  Scenario: PUT - Validate Party Admin cannot edit party contact for postal address with invalid contactPurposeId
    
		* eval requestPayloadPostalAddress.addressContact.toName = "Friend" + num
		* eval requestPayloadPostalAddress.contactPurposeId = "@!%$#{}-123{}]["
		
		Given path '/partycontacts/' + validPartyId + "/" + validPartyContactId
		And request requestPayloadPostalAddress
		When method put
		Then status 400
		And karate.log('Status : 400')
		And match response.errors[0].message contains "Contact purpose not found"
		
		And karate.log('Test Completed !')
		
	
	#REV2-19405
  Scenario: PUT - Validate Party Admin cannot edit party contact for postal address with multiple values in cityId
    
		* eval requestPayloadPostalAddress.addressContact.toName = "Friend" + num
		* eval requestPayloadPostalAddress.addressContact.cityId = ["pune", "delhi"]
		
		Given path '/partycontacts/' + validPartyId + "/" + validPartyContactId
		And request requestPayloadPostalAddress
		When method put
		Then status 400
		And karate.log('Status : 400')
		And match response.errors[0].message contains "Invalid input data"
		
		And karate.log('Test Completed !')
		
	
	#REV2-19406
  Scenario: PUT - Validate Party Admin cannot edit party contact for postal address with multiple values in stateId
    
		* eval requestPayloadPostalAddress.addressContact.toName = "Friend" + num
		* eval requestPayloadPostalAddress.addressContact.stateId = ["IN-MH", "IN-UP"]
		
		Given path '/partycontacts/' + validPartyId + "/" + validPartyContactId
		And request requestPayloadPostalAddress
		When method put
		Then status 400
		And karate.log('Status : 400')
		And match response.errors[0].message contains "Invalid input data"
		
		And karate.log('Test Completed !')
		
	
	#REV2-19407
  Scenario: PUT - Validate Party Admin cannot edit party contact for postal address with multiple values in countryId
    
		* eval requestPayloadPostalAddress.addressContact.toName = "Friend" + num
		* eval requestPayloadPostalAddress.addressContact.countryId = ["IND", "USA"]
		
		Given path '/partycontacts/' + validPartyId + "/" + validPartyContactId
		And request requestPayloadPostalAddress
		When method put
		Then status 400
		And karate.log('Status : 400')
		And match response.errors[0].message contains "Invalid input data"
		
		And karate.log('Test Completed !')
		

	#REV2-19408
  Scenario: PUT - Validate Party Admin cannot edit party contact for postal address with multiple values in contactPurposeId
    
		* eval requestPayloadPostalAddress.addressContact.toName = "Friend" + num
		* eval requestPayloadPostalAddress.contactPurposeId = ["S_70401", "S_70402"]
		
		Given path '/partycontacts/' + validPartyId + "/" + validPartyContactId
		And request requestPayloadPostalAddress
		When method put
		Then status 400
		And karate.log('Status : 400')
		And match response.errors[0].message contains "Invalid input data"
		
		And karate.log('Test Completed !')
		
							
	#REV2-19410		
	Scenario: PUT - Validate Party Admin cannot edit party contact for postal address with invalid endpoint
    
		* eval requestPayloadPostalAddress.addressContact.toName = "Friend" + num
		
		Given path '/partycontacts1/' + validPartyId + "/" + validPartyContactId
		And request requestPayloadPostalAddress
		When method put
		Then status 404
		And karate.log('Status : 404')
		And karate.log('Test Completed !')
		
		
	#REV2-19411		
	Scenario: PATCH - Validate Party Admin cannot edit party contact for postal address with unsupported method
    
		* eval requestPayloadPostalAddress.addressContact.toName = "Friend" + num
		
		Given path '/partycontacts/' + validPartyId + "/" + validPartyContactId
		And request requestPayloadPostalAddress
		When method patch
		Then status 405
		And karate.log('Status : 405')
		And match response.errors[0].message contains "Unsupported request Method"
		And karate.log('Test Completed !')
		
		
	#REV2-19412	
	Scenario: PUT - Validate invalid authentication token error to edit party contact for postal address
    
    * def invalidAuthToken = "eyJraWQiOiJmbnAyIiwiYWxnIjoiUlMyNTYifQ"
    
		* eval requestPayloadPostalAddress.addressContact.toName = "Friend" + num
		
		* header Authorization = invalidAuthToken
		
		Given path '/partycontacts/' + validPartyId + "/" + validPartyContactId
		And request requestPayloadPostalAddress
		When method put
		Then status 403
		And karate.log('Status : 403')
		And match response.errors[0].message contains "Access Denied"
		And karate.log('Test Completed !')
		
	
	#REV2-19415	
	Scenario: POST - Validate Party Admin cannot edit party contact with alphabetical values for throughDate
    
		* eval requestPayloadPostalAddress.addressContact.toName = "Friend" + num
		* eval requestPayloadPostalAddress.throughDate = "1 Aug,2022"
		
		Given path '/partycontacts/' + validPartyId + "/" + validPartyContactId
		And request requestPayloadPostalAddress
		When method put
		Then status 400
		And karate.log('Status : 400')
		And match response.errors[0].message contains "Invalid input data"
		And karate.log('Test Completed !')

	
	#REV2-19416	
	Scenario: POST - Validate Party Admin cannot edit party contact with special characters for throughDate
    
		* eval requestPayloadPostalAddress.addressContact.toName = "Friend" + num
		* eval requestPayloadPostalAddress.throughDate = "!@#$%"
		
		Given path '/partycontacts/' + validPartyId + "/" + validPartyContactId
		And request requestPayloadPostalAddress
		When method put
		Then status 400
		And karate.log('Status : 400')
		And match response.errors[0].message contains "Invalid input data"
		And karate.log('Test Completed !')

		
	#REV2-19417
  Scenario: POST - Validate Party Admin cannot edit party contact for phone contact with invalid phone
    
    * def validPartyContactId = "U_05106"
		* eval requestPayloadPhoneContact.phoneContact.phone = "ABC1234"
		
		Given path '/partycontacts/' + validPartyId + "/" + validPartyContactId
		And request requestPayloadPhoneContact
		When method put
		Then status 400
		And karate.log('Status : 400')
		And match response.errors[0].message contains "Invalid input data"
		
		And karate.log('Test Completed !')
		
		
	#REV2-19418
  Scenario: POST - Validate Party Admin cannot edit party contact for phone contact with blank phone
    
    * def validPartyContactId = "U_05106"
		* eval requestPayloadPhoneContact.phoneContact.phone = ""
		
		Given path '/partycontacts/' + validPartyId + "/" + validPartyContactId
		And request requestPayloadPhoneContact
		When method put
		Then status 400
		And karate.log('Status : 400')
		And match response.errors[0].message contains "Invalid input data"
		
		And karate.log('Test Completed !')
		
	
	#REV2-19420
  Scenario: POST - Validate Party Admin cannot edit party contact for phone contact with spaces in phone number
    
    * def validPartyContactId = "U_05106"
		* eval requestPayloadPhoneContact.phoneContact.phone = " 9821234567 "
		
		Given path '/partycontacts/' + validPartyId + "/" + validPartyContactId
		And request requestPayloadPhoneContact
		When method put
		Then status 400
		And karate.log('Status : 400')
		And match response.errors[0].message contains "Invalid input data"
		
		And karate.log('Test Completed !')
		
		
	#REV2-19421
  Scenario: POST - Validate Party Admin can edit party contact for phone contact with valid phone
    
    * def validPartyContactId = "U_05106"
		* eval requestPayloadPhoneContact.phoneContact.phone = "9821234567"
		
		Given path '/partycontacts/' + validPartyId + "/" + validPartyContactId
		And request requestPayloadPhoneContact
		When method put
		Then status 202
		And karate.log('Status : 202')
		And match response.message contains "Contact information updated"
		
		And karate.log('Test Completed !')

		
	#REV2-19422
  Scenario: POST - Validate Party Admin cannot edit party contact for email contact with invalid email
    
    * def validPartyContactId = "U_05105"
		* eval requestPayloadEmailContact.emailContact.email = "ABC1234"
		
		Given path '/partycontacts/' + validPartyId + "/" + validPartyContactId
		And request requestPayloadEmailContact
		When method put
		Then status 400
		And karate.log('Status : 400')
		And match response.errors[0].message contains "Invalid email address"
		
		And karate.log('Test Completed !')
		
		
	#REV2-19423
  Scenario: POST - Validate Party Admin cannot edit party contact for email contact with blank email
    
    * def validPartyContactId = "U_05105"
		* eval requestPayloadEmailContact.emailContact.email = ""
		
		Given path '/partycontacts/' + validPartyId + "/" + validPartyContactId
		And request requestPayloadEmailContact
		When method put
		Then status 400
		And karate.log('Status : 400')
		And match response.errors[0].message contains "Invalid email address"
		
		And karate.log('Test Completed !')
		

	#REV2-19425
  Scenario: POST - Validate Party Admin cannot edit party contact for email contact with spaces in email
    
    * def validPartyContactId = "U_05105"
		* eval requestPayloadEmailContact.emailContact.email = " test@cybage.com "
		
		Given path '/partycontacts/' + validPartyId + "/" + validPartyContactId
		And request requestPayloadEmailContact
		When method put
		Then status 400
		And karate.log('Status : 400')
		And match response.errors[0].message contains "Invalid email address"
		
		And karate.log('Test Completed !')
		
	
	#REV2-19426
  Scenario: POST - Validate Party Admin can edit party contact for email contact with valid email
    
    * def validPartyContactId = "U_05105"
		* eval requestPayloadEmailContact.emailContact.email = "test@cybage.com"
		
		Given path '/partycontacts/' + validPartyId + "/" + validPartyContactId
		And request requestPayloadEmailContact
		When method put
		Then status 202
		And karate.log('Status : 202')
		And match response.message contains "Contact information updated"
		
		And karate.log('Test Completed !')