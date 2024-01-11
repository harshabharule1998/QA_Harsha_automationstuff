Feature: Create new relation type for party API

	Background: 
	
		Given url backOfficeAPIBaseUrl
    And header Accept = 'application/json'
    And path '/pawri/v1'
    * def loginResult = callonce read('classpath:com/fnp/api/utils/generate-token.feature') {userType:"partyAdmin"}
    * def authToken = loginResult.accessToken
    * header Authorization = authToken
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/create-party-relationtype.json')
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
    
  	
  	#REV2-16224
  	Scenario: POST - Verify Create new relation type for party for valid values in request body for super admin access.
  	
  		* eval requestPayload.name = "Rel Type " + randomText
    	* eval requestPayload.description = "Relation Type " + randomText
  	
  		Given path '/relation-types'
			And request requestPayload
			When method post
			Then status 201
			And karate.log('Status : 201')
			And match response.successCode == "party.new_relation_type_created"
			And karate.log('Test Completed !')
			
		
  	#REV2-16225
  	Scenario: POST - Verify Create new relation type for party for invalid values in request body for super admin access.
  	
  		* eval requestPayload.name = "123@#$"
    	* eval requestPayload.description = "789&%$"
  	
  		Given path '/relation-types'
			And request requestPayload
			When method post
			Then status 400
			And karate.log('Status : 400')
			And match response.errors[*].errorCode == ["INVALID_DATA","INVALID_DATA"]
			And match response.errorCount == 2
			And karate.log('Test Completed !')
  	
  	
  	#REV2-16226
  	Scenario: POST - Verify Create new relation type for party for blank values in request body for super admin access.
  	
  		* eval requestPayload.name = ""
    	* eval requestPayload.description = ""
  	
  		Given path '/relation-types'
			And request requestPayload
			When method post
			Then status 400
			And karate.log('Status : 400')
			And match response.errors[*].errorCode == ["INVALID_DATA","INVALID_DATA"]
			And match response.errorCount == 2
			And karate.log('Test Completed !')
  	
  	
  	#REV2-16227
  	Scenario: POST - Verify Create new relation type for party for duplicate values in request body for super admin access.
  	
  		* eval requestPayload.name = "Supervisor"
    	* eval requestPayload.description = "Store Supervisor"
    	
  		Given path '/relation-types'
			And request requestPayload
			When method post
			Then status 400
			And karate.log('Status : 400')
			And match response.errors[*].errorCode contains "BAD_REQUEST"
  		And match response.errors[*].message contains "Relation type is already registered..Try adding with different name"
			And karate.log('Test Completed !')
  	
  	
  	#Defect: REV2-30332
  	#REV2-16228
  	Scenario: POST - Verify Create new relation type for party with leading and trailing spaces in request body for super admin access.
  	
  		* eval requestPayload.name = "  Rel Type " + randomText + " "
    	* eval requestPayload.description = " Relation Type " + randomText + " "
  	
  		Given path '/relation-types'
			And request requestPayload
			When method post
			Then status 400
			And karate.log('Status : 400')
			And match response.errors.errorCode == "INVALID_DATA"
			And karate.log('Test Completed !')
  	
  	
  	#REV2-16231
  	Scenario: POST - Verify Create new relation type for party with Invalid value in Endpoint (URL) for super admin access.
  	
  		* eval requestPayload.name = "Rel Type " + randomText
    	* eval requestPayload.description = "Relation Type " + randomText
  	
  		Given path '/relation-typ'
			And request requestPayload
			When method post
			Then status 404
			And karate.log('Status : 404')
			And match response.errors[*].errorCode contains "NOT_FOUND"
  		And match response.errors[*].message contains "http.request.not.found"
			And karate.log('Test Completed !')
			
		
		#REV2-16232
		Scenario: PUT - Verify Create new relation type for party for Unsupported Method for super admin access.
  	
  		* eval requestPayload.name = "Rel Type " + randomText
    	* eval requestPayload.description = "Relation Type " + randomText
  	
  		Given path '/relation-types'
			And request requestPayload
			When method put
			Then status 405
			And karate.log('Status : 405')
			And match response.errors[*].errorCode contains "unsupported.http.method"
			And match response.errors[*].message contains "Unsupported request Method. Contact the site administrator"
			And karate.log('Test Completed !')
			
		
		#REV2-16233
		Scenario: POST - Verify Create new relation type for party for Invalid Authentication Token for super admin access.
  	
  		* def invalidAuthToken = "eyJraWQiOiJmbnAyIiwiYWxnIjoiUlMyNTYifQ"
    	* header Authorization = invalidAuthToken
  		* eval requestPayload.name = "Rel Type " + randomText
    	* eval requestPayload.description = "Relation Type " + randomText
  		
  		Given path '/relation-types'
			And request requestPayload
			When method post
			Then status 403
			And karate.log('Status : 403')
			And karate.log('Test Completed !')
			
			
			
			
			
			
			
  	
  	
  	