Feature: FC Capacity Configuration with Allocation Executive

  Background: 
    Given url backOfficeAPIBaseUrl
    And header Accept = 'application/json'
    And path '/hendrix/v1/capacities/configurations'
 
    * def loginResult = callonce read('classpath:com/fnp/api/utils/generate-token.feature') {userType:'allocExc'}
    * def authToken = loginResult.accessToken
    * header Authorization = authToken
    
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/hendrix/capacity-config-fc.json')
    * def requestPayloadCreate = requestPayload[0]
    * def requestPayloadEditNonGlobalData = requestPayload[1]
    * def requestPayloadEditGlobalData = requestPayload[2]
    
    * def today = new java.util.Date().time
    * def num = today + ""
    * def num = num.substring(8)
    * def number = num.substring(1)
    
    * def configId = "6104046c562de00797b1e6f2"
    
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
       		var min = 0, max = 4;      		
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
 		
 		
	#REV2-13789
	Scenario: POST - Verify Allocation Executive can create FC Capacity Configuration for all valid values
    
    * eval requestPayloadCreate.configName = "diwali" + num
    * karate.log(requestPayloadCreate)
    
    Given request requestPayloadCreate
    When method post
    Then status 201
    And karate.log('Status : 201')
    And match response.id == "#notnull"
    And match response.configName == requestPayloadCreate.configName
    And match response.capacity == requestPayloadCreate.capacity
    And karate.log('Test Completed !')


  #REV2-13790
  Scenario: POST - Verify Allocation Executive cannot create FC Capacity Configuration for all invalid values
    
    * eval requestPayloadCreate.capacity = "abc"
    * eval requestPayloadCreate.configName = "--@@123"
    * eval requestPayloadCreate.deliveryMode = "123"
    * eval requestPayloadCreate.fromDate = "3021-10-08T00:00:11"
    * eval requestPayloadCreate.geoGroupId = "abc"
    * eval requestPayloadCreate.geoId = "abc"
    * eval requestPayloadCreate.pgId = "abc"
    * eval requestPayloadCreate.thruDate = "3021-12-08T00:00:11"
    * eval requestPayloadCreate.vendorId = "xyz"
    * eval requestPayloadCreate.vendorType = "xyz"
    
    * karate.log(requestPayloadCreate)
    
    Given request requestPayloadCreate
    When method post
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message == "Invalid_Input_Data"  
    And karate.log('Test Completed !')
    

  #REV2-13791
  Scenario: POST - Verify Allocation Executive cannot create FC Capacity Configuration for all blank values
    
    * eval requestPayloadCreate.capacity = ""
    * eval requestPayloadCreate.configName = ""
    * eval requestPayloadCreate.deliveryMode = ""
    * eval requestPayloadCreate.fromDate = ""
    * eval requestPayloadCreate.geoGroupId = ""
    * eval requestPayloadCreate.geoId = ""
    * eval requestPayloadCreate.pgId = ""
    * eval requestPayloadCreate.thruDate = ""
    * eval requestPayloadCreate.vendorId = ""
    * eval requestPayloadCreate.vendorType = ""
    
    * karate.log(requestPayloadCreate)
    
    Given request requestPayloadCreate
    When method post
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message contains "Date fields having invalid value or format[Valid Format (ex. dd-MM-yyyy)]."  
    And karate.log('Test Completed !')
    
	
	#REV2-13826
  Scenario: PUT - Verify Allocation Executive can edit FC Capacity Configuration with all valid values for Non Global Data
    
    * eval requestPayloadEditNonGlobalData[0].capacity = randomCapacity
    * karate.log(requestPayloadEditNonGlobalData)
    
    Given request requestPayloadEditNonGlobalData
    When method put
    Then status 200
    And karate.log('Status : 200')
    And match response.message contains "Updated Successfully"
    And karate.log('Test Completed !')
    
  
	Scenario: PUT - Verify Allocation Executive can edit FC Capacity Configuration with all valid values for Global Data
      
		* eval requestPayloadEditGlobalData[0].capacity = randomCapacity
		* eval requestPayloadEditGlobalData[0].vendorId= 'FC_1' + randomVendorId + randomLastNum
    * karate.log(requestPayloadEditGlobalData)
    
    Given request requestPayloadEditGlobalData
    When method put
    Then status 200
    And karate.log('Status : 200')
    And match response.message contains "Updated Successfully"
    And karate.log('Test Completed !')
    	

	#REV2-13827
  Scenario: PUT - Verify Allocation Executive cannot edit FC Capacity Configuration for all invalid values
    
    * eval requestPayloadEditNonGlobalData[0].capacity = 11.5
    * eval requestPayloadEditNonGlobalData[0].configName = "--@@123"
    * eval requestPayloadEditNonGlobalData[0].fromDate = "3021-10-08T00:00:11"
    * eval requestPayloadEditNonGlobalData[0].thruDate = "3021-12-08T00:00:11"
    * karate.log(requestPayloadEditNonGlobalData)
   
    Given request requestPayloadEditNonGlobalData
    When method put
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message contains "Invalid_Input_Data"
    And karate.log('Test Completed !')
    
	  
	#REV2-13828
  Scenario: PUT - Verify Allocation Executive cannot edit FC Capacity Configuration for invalid capacity value
    
    * eval requestPayloadEditGlobalData[0].capacity = 11.5
    * karate.log(requestPayloadEditGlobalData)
    
    Given request requestPayloadEditGlobalData
    When method put
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message contains "Invalid_Input_Data"
    And karate.log('Test Completed !')
    

	#REV2-13829
  Scenario: PUT - Verify Allocation Executive cannot edit FC Capacity Configuration for all blank values
    
    * eval requestPayloadEditGlobalData[0].capacity = ""
    * eval requestPayloadEditGlobalData[0].configName = ""
    * eval requestPayloadEditGlobalData[0].fromDate = ""
    * eval requestPayloadEditGlobalData[0].thruDate = ""
    * karate.log(requestPayloadEditGlobalData)
    
    Given request requestPayloadEditGlobalData
    When method put
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message contains 'Date fields having invalid value or format[Valid Format (ex. dd-MM-yyyy)].'
    And karate.log('Test Completed !')
    
   
	#REV2-13830
  Scenario: PUT - Verify Allocation Executive cannot edit FC Capacity Configuration for blank capacity value
    
    * eval requestPayloadEditNonGlobalData[0].capacity = ""
    * karate.log(requestPayloadEditNonGlobalData)
    
    Given request requestPayloadEditNonGlobalData
    When method put
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message contains "The Capacity field is mandatory."
    And karate.log('Test Completed !')
    
    
	#REV2-13864
  Scenario: DELETE - Verify Allocation Executive can delete FC Capacity Configuration for valid configId
    
    * def result = call read('./capacity-config-fc-superadmin-test.feature@createCapacityConfig')
    * def configId = result.configId
    
    Given path '/id/' + configId
    When method delete
    Then status 200
    And karate.log('Status : 200')
    And match response.message contains "Deleted Successfully"
    And karate.log('Test Completed !')
	

	#REV2-13865
  Scenario: DELETE - Verify Allocation Executive to delete FC Capacity Configuration for invalid configId
    
    * def invalidConfigId = "61304d41621"
    
    Given path '/id/' + invalidConfigId
    When method delete
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message contains "There is no such Capacity exception to delete"
    And karate.log('Test Completed !')
    
   
	#REV2-13866
  Scenario: DELETE - Verify Allocation Executive to delete FC Capacity Configuration for blank configId
    
    * def blankConfigId = ""
    
    Given path '/id/' + blankConfigId
    When method delete
    Then status 404
    And karate.log('Status : 404')
    And karate.log('Test Completed !')
    
 	 
	#REV2-13807
	Scenario: GET - Verify that user cannot access allocation executive role with blank geoId
	    
		Given param deliveryMode = 'hd'
    And param fieldname = 'vendorId'
    And param fieldvalue = 'fc_103'
    And param fieldvalues = 'fc_104'
    And param geoGroupId = 'pune'
    And param geoId = ''
    And param operator = 'EQUAL_TO'
    And param page = '0'
    And param size = '10'
    And param vendorType = 'FC'
    When method get
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message contains "The Geography field is mandatory."
    And karate.log('Test Completed !')
    
   
	#REV2-13806
	Scenario: GET - Verify that user cannot access allocation executive role with invalid values
  
    Given param deliveryMode = 'hd'
    And param fieldname = 'vendorId'
    And param fieldvalue = 'fc_103'
    And param fieldvalues = 'fc_104'
    And param geoGroupId = 'pune'
    And param geoId = 'india'
    And param operator = 'EQUAL_TO'
    And param page = '0'
    And param size = '10'
    And param vendorType = 'CR'
    When method get
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message contains "Vendor Type Has Unknown Value, Allowed Values -> FC"
    And karate.log('Test Completed !')
    
  
	#REV2-13805
	Scenario: GET - Verify that user can access allocation executive role with valid values
    
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
    
    
    #***********************GET FC SEARCH SCENARIOS****************************
    
    
  #REV2-29256/#REV2-29264/#REV2-29265
	Scenario: GET - Verify allocation executive can search capacity Configuration fc with valid values
    
    Given param deliveryMode = 'hd'
    And param fieldname = 'vendorId'
    And param fieldvalue = 'fc_103'
    And param fieldvalues = 'fc_104'
    And param geoGroupId = 'pune'
    And param geoId = 'india'
    And param operator = 'EQUAL_TO','DOES_NOT_CONTAIN','',
    And param page = '0'
    And param size = '10'
    And param vendorType = 'FC'
    When method get
    Then status 200
    And karate.log('Status : 200')
    And karate.log('Test Completed !')
    
    
  #REV2-29257/#REV2-29259/#REV2-29260
	Scenario: GET - Verify allocation executive can search capacity Configuration fc with blank mandatory values
  
  	Given param deliveryMode = 'hd'
    And param fieldname = 'vendorId'
    And param fieldvalue = 'fc_103'
    And param fieldvalues = ''
    And param geoGroupId = 'pune'
    And param geoId = ''
    And param operator = 'EQUAL_TO'
    And param page = '0'
    And param size = '10'
    And param vendorType = 'FC'
    When method get
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message contains "The Geography field is mandatory."
    And karate.log('Test Completed !')
  
    
  #REV2-29258
	Scenario: GET - Verify allocation executive can search capacity Configuration fc with invalid values
  
    Given param deliveryMode = 'hd'
    And param fieldname = 'vendorId'
    And param fieldvalue = 'fc_103@'
    And param fieldvalues = 'fc_104!'
    And param geoGroupId = 'pune'
    And param geoId = 'india'
    And param operator = 'EQUAL_TO'
    And param page = '0'
    And param size = '10'
    And param vendorType = 'CR'
    When method get
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message contains "Vendor Type Has Unknown Value, Allowed Values -> FC"
    And karate.log('Test Completed !')
    
    
  #REV2-29262
	Scenario: POST - Verify allocation executive can search capacity Configuration fc for Unsupported methods.
	
    Given request '' 
    And param deliveryMode = 'hd'
    And param fieldname = 'vendorId'
    And param fieldvalue = 'fc_103'
    And param fieldvalues = 'fc_104'
    And param geoGroupId = 'pune'
    And param geoId = 'india'
    And param operator = 'EQUAL_TO'
    And param page = '0'
    And param size = '10'
    And param vendorType = 'FC'
    When method post
    Then status 405
    And karate.log('Status : 405')
    And match response.errors[0].message contains "METHOD_NOT_ALLOWED"
    And karate.log('Test Completed !')
    
  
  #REV2-29263
	Scenario: GET - Verify allocation executive can search capacity Configuration fc with invalid authorization token
	
    * def invalidAuthToken = loginResult.accessToken + "aaaaasssssssssdddddd"
    * header Authorization = invalidAuthToken
    
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
    Then status 401
    And karate.log('Status : 401')
    And karate.log('Test Completed !')
   
    
  #REV2-29266
	Scenario: GET - Verify allocation executive can search capacity Configuration fc with field values separated by comma 
    
    Given param deliveryMode = 'hd'
    And param fieldname = 'vendorId'
    And param fieldvalue = 'fc_103','fc_105','fc_106'
    And param fieldvalues = 'fc_carrier'
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
    
    