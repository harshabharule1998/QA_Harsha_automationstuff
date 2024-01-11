Feature: Create new role for party API

	Background:

		Given url backOfficeAPIBaseUrl
		And header Accept = 'application/json'
		And path '/simsim/v1'
		* def loginResult = callonce read('classpath:com/fnp/api/utils/generate-token.feature') {userType:"partyAdmin"}
		* def authToken = loginResult.accessToken
		* header Authorization = authToken
		* def requestPayload = read('classpath:com/fnp/api/backoffice/data/party/create-role-party.json')
		* def random_string =
					"""
					function(s) {
					var text = "";
					var possible = "qwertyuiopasdfghjklxcvbnm";
					
					for (var i = 0; i < s; i++)
					text += possible.charAt(Math.floor(Math.random() * possible.length));
					
					return text;
					}
					"""
					* def randomText = random_string(4)

  
	#REV2-14275
	Scenario: POST -  Verify Method to create role with Name & Description fields - Valid
	
		* eval requestPayload.name = "Role N  " + randomText
		* eval requestPayload.description = "Role Des " + randomText
		* eval requestPayload.partyTypeId = 'S_70001'
		
		Given path '/roles'
		And request requestPayload
		When method post
		Then status 201
		And karate.log('Status : 201')
		And match response.name contains 'Role N'
		And karate.log('Test Completed !')
	
	#REV2-14276
	Scenario: POST - Verify Method to create role with Name & Description fields - Invalid
	
		* eval requestPayload.name = "@#$5  " + randomText
		* eval requestPayload.description = "#$$$$ " + randomText
		* eval requestPayload.partyTypeId = 'S_70001'
		
		Given path '/roles'
		And request requestPayload
		When method post
		Then status 400
		And karate.log('Status : 400')
		And match response.errors[*].errorCode == ["INVALID_DATA","INVALID_DATA"]
		And match response.errorCount == 2
		And karate.log('Test Completed !')
	
	
	#REV2-14277
	Scenario: POST - Verify Method to create role with Name & Description fields - Blank
	
		* eval requestPayload.name = "" 
		* eval requestPayload.description = ""
		* eval requestPayload.partyTypeId = 'S_70001'
		
		Given path '/roles'
		And request requestPayload
		When method post
		Then status 400
		And karate.log('Status : 400')
		And match response.errors[*].errorCode == ["INVALID_DATA"]
		And match response.errorCount == 1
		And karate.log('Test Completed !')
		
	
	#REV2-14281
	Scenario: POST -  Verify to create role with duplicate values in request body
	
		* eval requestPayload.name = "ManagerCofig"
		* eval requestPayload.description = "Configuration Manager"
		* eval requestPayload.partyTypeId = 'S_70001'
		
		Given path '/roles'
		And request requestPayload
		When method post
		Then status 400
		And karate.log('Status : 400')
		And match response.errors[*].errorCode contains "BAD_REQUEST"
		And match response.errors[*].message contains "Role already exist"
		And karate.log('Test Completed !')
	
	
	
	#Defect ID : REV2-30438
	#New Added
	Scenario: POST - Verify Create new role with leading and trailing spaces in request body 
	
		* eval requestPayload.name = "Role N  " + randomText + "  "
		* eval requestPayload.description = "Role Des " + randomText + "  "
		* eval requestPayload.partyTypeId = 'S_70001'
		
		Given path '/roles'
		And request requestPayload
		When method post
		Then status 400
		And karate.log('Status : 400')
		And match response.errors.errorCode == "INVALID_DATA"
		And karate.log('Test Completed !')
	
	
	#REV2-14278
	Scenario: POST - Verify Create new role with Invalid value in Endpoint (URL) for super admin access.
	
		* eval requestPayload.name = "Role N  " + randomText 
		* eval requestPayload.description = "Role Des " + randomText
		* eval requestPayload.partyTypeId = 'S_70001'
		
		Given path '/role'
		And request requestPayload
		When method post
		Then status 404
		And karate.log('Status : 404')
		And match response.errors[*].errorCode contains "NOT_FOUND"
		And match response.errors[*].message contains "http.request.not.found"
		And karate.log('Test Completed !')
	
	
	#REV2-14280
	Scenario: PUT - Verify Create new role for Unsupported Method for super admin access.
	
		* eval requestPayload.name = "Role N  " + randomText 
		* eval requestPayload.description = "Role Des " + randomText
		* eval requestPayload.partyTypeId = 'S_70001'
		
		Given path '/roles'
		And request requestPayload
		When method put
		Then status 405
		And karate.log('Status : 405')
		And match response.errors[*].errorCode contains "unsupported.http.method"
		And match response.errors[*].message contains "Unsupported request Method. Contact the site administrator"
		And karate.log('Test Completed !')
	
	
	#REV2-14279
	Scenario: POST - Verify Create new role for Invalid Authentication Token for super admin access.
	
		* def invalidAuthToken = "eyJraWQiOiJmbnAyIiwiYWxnIjoiUlMyNTYifQ"
		* header Authorization = invalidAuthToken
		* eval requestPayload.name = "Role N  " + randomText 
		* eval requestPayload.description = "Role Des " + randomText
		* eval requestPayload.partyTypeId = 'S_70001'
		
		Given path '/roles'
		And request requestPayload
		When method post
		Then status 401
		And karate.log('Status : 401')
		And karate.log('Test Completed !')