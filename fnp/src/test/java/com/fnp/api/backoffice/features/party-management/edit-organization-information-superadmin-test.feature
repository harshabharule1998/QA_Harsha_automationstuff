Feature: Party edit organization information scenarios for super admin

  Background: 
    Given url backOfficeAPIBaseUrl
    And header Accept = 'application/json'
    And path '/pawri/v1'
    * def loginResult = callonce read('classpath:com/fnp/api/utils/generate-token.feature') {userType:"partyAdmin"}
    * def authToken = loginResult.accessToken
    * header Authorization = authToken
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/party/edit-organization-information.json')
   
   
  #REV2-15520 
	Scenario: PUT - Verify superadmin update Party Organization By PartyId for  All valid values in Request Body and partyId.
	
   * def partyId = 'C_01160'
   
  	Given path '/party-organizations/' + partyId
  	And request requestPayload
		When method put
		Then status 200
    And karate.log('Status : 200')
    And karate.log('Response is:', response)
    And karate.log('Test Completed !')
    
   
	#REV2-15521
	Scenario: PUT - Verify superadmin update Party Organization By PartyId for with Blank values in partyId.
	 
	  
	  * def partyId = ' '
   
  	Given path '/party-organizations/' + partyId
  	And request requestPayload
		When method put
		Then status 404
    And karate.log('Status : 404')
    And karate.log('Response is:', response)
    And karate.log('Test Completed !')
    
     
	#REV2-15522
	Scenario: PUT - Verify superadmin update Party Organization By PartyId for with Blank values in Request Body.
	   
	 	* eval requestPayload.contactPersonName = " " 
		* eval requestPayload.designation = " " 
	  * eval requestPayload.faxNumber = " " 
		* eval requestPayload.organizationName = " " 
	  * eval requestPayload.taxNumber = " " 
	  	
	  * def partyId = 'C_01160'
   
  	Given path '/party-organizations/' + partyId
  	And request requestPayload
		When method put
		Then status 400
    And karate.log('Status : 400')
    And karate.log('Response is:', response)
    And karate.log('Test Completed !')
    
 
  #REV2-15523
  Scenario: PUT - Verify super admin update Party Organization By PartyId for optional parameters in Request Body.
		
		* eval requestPayload.contactPersonName = " " 
		* eval requestPayload.designation = "QA engg" 
	  * eval requestPayload.faxNumber = "123456" 
	  * eval requestPayload.organizationName = " " 
	  * eval requestPayload.taxNumber = "1234" 
	  	
		* def partyId = 'C_01160'
   
  	Given path '/party-organizations/' + partyId 
  	And request requestPayload
		When method put
		Then status 400
    And karate.log('Status : 400')
    And karate.log('Response is:', response)
    #And match response.errors[0].message contains
    And karate.log('Test Completed !')   
    
     
	#REV2-15525
	Scenario: PUT - Verify superadmin update Party Organization By PartyId for try inserting with leading and trailing spaces in partyId.
		
		* def partyId = 'C_01160'
   
  	Given path '/party-organizations/' + " " + partyId + " "
  	And request requestPayload
		When method put
		Then status 404
    And karate.log('Status : 404')
    And karate.log('Response is:', response)
    And karate.log('Test Completed !')
	
	
	#REV2-15526 
	Scenario: PUT - Verify superadmin update Party Organization By PartyId for try inserting with leading and trailing spaces in Request Body.
	 	
	 	* eval requestPayload.contactPersonName = " " + " harsha " + " "
	  * eval requestPayload.designation = " " + "QA engg" + " "
	  * eval requestPayload.faxNumber = " " + "123456" + " "
	  * eval requestPayload.organizationName = " " + "viit" + " " 
	  * eval requestPayload.taxNumber = " " + "1234" + " "
	  
		* def partyId = 'C_01160'
   
  	Given path '/party-organizations/' + partyId 
  	And request requestPayload
		When method put
		Then status 400
    And karate.log('Status : 400')
    And karate.log('Response is:', response)
    And karate.log('Test Completed !')
	 

	#REV2-15527
	Scenario: PUT - Verify superadmin to update Party Organization By PartyId for with Invalid partyId
	 	
	 	* def partyId = '@%$&GB,65'
   
  	Given path '/party-organizations/' + partyId 
  	And request requestPayload
		When method put
		Then status 400
    And karate.log('Status : 404')
    And karate.log('Response is:', response)
    And karate.log('Test Completed !')
	  
  
	#REV2-15528
	Scenario: PUT - Verify superadmin update Party Organization By PartyId for Invalid Contact Person Name
	  
	  * eval requestPayload.contactPersonName = "@^&(.87"
	   
	  * def partyId = 'C_01160'
   
  	Given path '/party-organizations/' + partyId 
  	And request requestPayload
		When method put
		Then status 400
    And karate.log('Status : 400')
    And karate.log('Response is:', response)
    And karate.log('Test Completed !')
	   
	
	#REV2-15529
	Scenario: PUT - Verify superadmin to update Party Organization By PartyId for Invalid Designation
		
		* eval requestPayload.designation = "D53, %@#" 
		
	  * def partyId = 'C_01160'
   
  	Given path '/party-organizations/' + partyId 
  	And request requestPayload
		When method put
		Then status 400
    And karate.log('Status : 400')
    And karate.log('Response is:', response)
    And karate.log('Test Completed !')
	
	
	#REV2-15530
	Scenario: PUT - Verify superadmin to update Party Organization By PartyId for Invalid Fax Number
	
	  * eval requestPayload.faxNumber = "@#3, &^$" 
	 
		* def partyId = 'C_01160'
   
  	Given path '/party-organizations/' + partyId 
  	And request requestPayload
		When method put
		Then status 400
    And karate.log('Status : 400')
    And karate.log('Response is:', response)
    And karate.log('Test Completed !')
	 
	
	#REV2-15531
	Scenario: PUT - Verify superadmin to update Party Organization By PartyId for Invalid organization Name
	
		* eval requestPayload.organizationName = "%$, 89T4" 
	
		* def partyId = 'C_01160'
   
  	Given path '/party-organizations/' + partyId 
  	And request requestPayload
		When method put
		Then status 400
    And karate.log('Status : 400')
    And karate.log('Response is:', response)
    And karate.log('Test Completed !')
    
  
  #REV2-15532
  Scenario: PUT - Verify superadmin to update Party Organization By PartyId for Invalid Tax Number
  
    * eval requestPayload.taxNumber = "*%@, G5#$" 
    
    * def partyId = 'C_01160'
   
  	Given path '/party-organizations/' + partyId 
  	And request requestPayload
		When method put
		Then status 400
    And karate.log('Status : 400')
    And karate.log('Response is:', response)
    And karate.log('Test Completed !')
    
  
	#REV2-15533
	Scenario: PUT - Verify superadmin to update Party Organization By PartyId for Invalid value in endpoint URL
	
		* def partyId = 'C_01160'
   
  	Given path '/party-organization/' + partyId 
  	And request requestPayload
		When method put
		Then status 404
    And karate.log('Status : 404')
    And karate.log('Response is:', response)
    And karate.log('Test Completed !') 
    

	#REV2-15534
	Scenario: PUT - Verify superadmin to update Party Organization By PartyId for Unsupported Method.
		
		* def partyId = 'C_01160'
   
  	Given path '/party-organizations/' + partyId 
  	And request requestPayload
		When method delete
		Then status 405
    And karate.log('Status : 405')
    And karate.log('Response is:', response)
    And match response.errors[*].errorCode contains "unsupported.http.method"
		And match response.errors[*].message contains "Unsupported request Method. Contact the site administrator"
    And karate.log('Test Completed !')   
    
    
	
	#REV2-15535
	Scenario: PUT - Verify superadmin to update Party Organization By PartyId with Invalid Authentication Token
		
		* def invalidAuthToken = loginResult.accessToken
    * header Authorization = invalidAuthToken + "75ssbhz64"
    
		* def partyId = 'C_01160'
   
  	Given path '/party-organizations/' + partyId 
  	And request requestPayload
		When method put
		Then status 401
    And karate.log('Status : 401')
    And karate.log('Response is:', response)
    And karate.log('Test Completed !')   
    
  
	