Feature: FC Capacity Configuration with Allocation Manager

  Background: 
    Given url backOfficeAPIBaseUrl
    And header Accept = 'application/json'
    And path '/hendrix/v1/capacities/configurations'
    
    * def loginResult = callonce read('classpath:com/fnp/api/utils/generate-token.feature') {userType:'allocMgr'}
    * def authToken = loginResult.accessToken
    * header Authorization = authToken
    
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/hendrix/capacity-config-fc.json')
    * def requestPayloadCreate = requestPayload[0]
    * def requestPayloadEditNonGlobalData = requestPayload[1]
    * def requestPayloadEditGlobalData = requestPayload[2]
    
    * def today = new java.util.Date().time
    * def num = today + ""
    * def num = num.substring(8)
    
     * def getRandomCapacity = 
      """
      	function() {
       		var min = 100, max = 900;      		
       		return Math.round(Math.random() * (max - min + 1)) + min;           
      	}
      """
    
    * def randomCapacity = ~~Math.round(getRandomCapacity())
    
    * def random_number =
      """
          function() {
       		var min = 0, max = 3;      		
       		return Math.round(Math.random() * (max - min + 1)) + min;           
      	}
      """
 	
 		* def randomVendorId = ~~Math.round(random_number())
 		
 		* def random =
      """
          function(s) {
          var text = "";
          var possible = "0123456789";
              
              for (var i = 0; i < s; i++)
                text += possible.charAt(Math.floor(Math.random() * possible.length));
          
          return text;
          }
      """
      
		* def randomLastNum =  random(1)


  #REV2-13785, REV2-13788 and REV2-13792
  Scenario: POST - Verify Allocation Manager can create FC Capacity Configuration
    
    * eval requestPayloadCreate.configName = "easter" + num
    * karate.log(requestPayloadCreate)
    
    Given request requestPayloadCreate
    When method post
    Then status 201
    And karate.log('Status : 201')
    And karate.log('Response is : ', response)
    And karate.log('Test Completed !')


	#REV2-13825 and REV2-13831
  Scenario: PUT - Verify Allocation Manager can edit FC Capacity Configuration for all valid values(Non Global Data)
    
    * karate.log(requestPayloadEditNonGlobalData)
    
    And request requestPayloadEditNonGlobalData
    When method put
    Then status 200
    And karate.log('Status : 200')
    And match response.message contains "Updated Successfully"
    And karate.log('Test Completed !')
   
	
	Scenario: PUT - Verify Allocation Manager can edit FC Capacity Configuration with all valid values for Global Data
      
		* eval requestPayloadEditGlobalData[0].capacity = randomCapacity
		* eval requestPayloadEditGlobalData[0].vendorId= 'FC_1' + randomVendorId + randomLastNum
    * karate.log(requestPayloadEditGlobalData)
    
    Given request requestPayloadEditGlobalData
    When method put
    Then status 200
    And karate.log('Status : 200')
    And match response.message contains "Updated Successfully"
    And karate.log('Test Completed !')
  
  
	#REV2-13860
  Scenario: DELETE - Verify 403 error for Allocation Manager to delete FC Capacity Configuration for valid configId
    
    * def configId = "6104046c562de00797b1e6f2"
    
    Given path '/id/' + configId
    When method delete
    Then status 403
    And karate.log('Status : 403')
    And match response.errors[0].message == "Access_Denied"
    And karate.log('Test Completed !')
    
   
	#REV2-13808/13804
	Scenario: GET - Verify 403 error for FC Capacity Config with Allocation Manager access
	 
    Given param deliveryMode = 'hd'
    And param geoGroupId = 'pune'
    And param geoId = 'india'
    And param vendorType = 'FC'
    When method get
    Then status 403
    And karate.log('Status : 403')
    And match response.errors[0].message == "Access_Denied"
    And karate.log('Test Completed !')
    
    
     #***********************GET FC SEARCH SCENARIOS****************************
    
  #REV2-29255
	Scenario: GET - Verify 403 error can search FC Capacity Config with Allocation Manager access
	 
    Given param deliveryMode = 'hd'
    And param fieldname = 'vendorId'
    And param fieldvalue = 'fc_103'
    And param fieldvalues = 'fc_104'
    And param geoGroupId = 'pune'
    And param geoId = 'india'
    And param operator = 'EQUAL_TO'
    And param page = '0'
    And param size = '10'
    And param vendorType = 'FC'
    When method get
    Then status 200
    And karate.log('Status : 200')
    And karate.log('Test Completed !')
   
   