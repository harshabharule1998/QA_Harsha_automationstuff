Feature: FC Capacity Configuration with Super Admin

  Background: 
    Given url backOfficeAPIBaseUrl
    And header Accept = 'application/json'
    And path '/hendrix/v1/capacities/configurations'
    
    * def loginResult = callonce read('classpath:com/fnp/api/utils/generate-token.feature') {userType:'superAdminQA'}
    * def authToken = loginResult.accessToken
    * header Authorization = authToken
    
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/hendrix/capacity-config-fc.json')
    * def requestPayloadCreate = requestPayload[0]
    * def requestPayloadEditNonGlobalData = requestPayload[1]
    * def requestPayloadEditGlobalData = requestPayload[2]
    
    
    * def today = new java.util.Date().time
    * def num = today + ""
    * def num = num.substring(8)
    
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
		
		
	@createCapacityConfig
  #REV2-13778
  Scenario: POST - Verify Super Admin can create FC Capacity Configuration for all valid values
    
    * eval requestPayloadCreate.configName = "holi" + num
    * karate.log(requestPayloadCreate)
    
    Given request requestPayloadCreate
    When method post
    Then status 201
    And karate.log('Status : 201')
    And match response.id == "#notnull"
    And match response.configName == requestPayloadCreate.configName
    And match response.capacity == requestPayloadCreate.capacity
    * def configId = response.id
    And karate.log('Test Completed !')

 
  #REV2-13779
  Scenario: POST - Verify Super Admin cannot create FC Capacity Configuration for all invalid values
    
    * eval requestPayloadCreate.capacity = "abc"
    * eval requestPayloadCreate.configName = "--@@123"
    * eval requestPayloadCreate.deliveryMode = "123"
    * eval requestPayloadCreate.fromDate = "3021-10-08T00:00:11"
    * eval requestPayloadCreate.geoGroupId = "abc"
    * eval requestPayloadCreate.geoId = "abc"
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
    

  #REV2-13780
  Scenario: POST - Verify Super Admin cannot create FC Capacity Configuration for all blank values
    
    * eval requestPayloadCreate.capacity = ""
    * eval requestPayloadCreate.configName = ""
    * eval requestPayloadCreate.deliveryMode = ""
    * eval requestPayloadCreate.fromDate = ""
    * eval requestPayloadCreate.geoGroupId = ""
    * eval requestPayloadCreate.geoId = ""
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
    
	
  #REV2-13783
  Scenario: PATCH - Verify FC Capacity Configuration for Unsupported Method
    
    And request requestPayloadCreate
    When method patch
    Then status 405
    And karate.log('Response is : ', response)
    And match response.errors[0].message == 'METHOD_NOT_ALLOWED'
    
    And path '/hendrix/v1/capacities/configurations'
    * header Authorization = authToken
    When method delete
    Then status 405
    And karate.log('Status : 405')
    
    And match response.errors[0].message == 'METHOD_NOT_ALLOWED'
    And karate.log('Status : 405')
    And karate.log('Test Completed !')
  
   
  #REV2-13784
  Scenario: POST - Verify FC Capacity Configuration for Invalid Auth token
    
    * header Authorization = "eyJraWQiOiJmbnAyIiwiYWxnIjoiUlMyNTYifQ.eyJzdWIiOiJTXzAwMDAyIiwiYXVkIjoiaHR0cHM6XC9cL3d3dy5mbnAuY29tIiwidWFsIjoiU0df"
    
    Given request requestPayloadCreate
    When method post
    Then status 401
    And karate.log('Status : 401')
    And match response.errors[0].message contains 'Token Invalid! Authentication Required'
    And karate.log('Test Completed !')


  #REV2-13786
  Scenario: POST - Verify Super Admin cannot create FC Capacity Configuration for duplicate values
    
    * karate.log(requestPayloadCreate)
    
    Given request requestPayloadCreate
    When method post
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message contains 'The Config name is already in use.'  
    And karate.log('Test Completed !')


  #REV2-13787
  Scenario: POST - Verify FC Capacity Configuration for invalid endpoint url
    
    Given path '/add'
    And request requestPayloadCreate
    When method post
    Then status 404
    And karate.log('Status : 404')
    And karate.log('Test Completed !')


	#REV2-13814
  Scenario: PUT - Verify Super Admin can edit FC Capacity Configuration with all valid values for Non Global Data
    
    * eval requestPayloadEditNonGlobalData[0].capacity = randomCapacity
    * karate.log(requestPayloadEditNonGlobalData)
    
    Given request requestPayloadEditNonGlobalData
    When method put
    Then status 200
    And karate.log('Status : 200')
    And match response.message contains "Updated Successfully"
    And karate.log('Test Completed !')
    
	
	Scenario: PUT - Verify Super Admin can edit FC Capacity Configuration with all valid values for Global Data
    
    * eval requestPayloadEditGlobalData[0].capacity = randomCapacity
    * eval requestPayloadEditGlobalData[0].vendorId= 'FC_1' + randomVendorId + randomLastNum
    * karate.log(requestPayloadEditGlobalData)
    
    Given request requestPayloadEditGlobalData
    When method put
    Then status 200
    And karate.log('Status : 200')
    And match response.message contains "Updated Successfully"
    And karate.log('Test Completed !')
    	
	
	#REV2-13815
  Scenario: PUT - Verify Super Admin cannot edit FC Capacity Configuration for all invalid values
    
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
    

	#REV2-13816
  Scenario: PUT - Verify Super Admin cannot edit FC Capacity Configuration for invalid capacity value
    
    * eval requestPayloadEditGlobalData[0].capacity = 11.5
    * karate.log(requestPayloadEditGlobalData)
    
    Given request requestPayloadEditGlobalData
    When method put
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message contains "Invalid_Input_Data"
    And karate.log('Test Completed !')
    

	#REV2-13817
  Scenario: PUT - Verify Super Admin cannot edit FC Capacity Configuration for all blank values
    
    * eval requestPayloadEditNonGlobalData[0].capacity = ""
    * eval requestPayloadEditNonGlobalData[0].configName = ""
    * eval requestPayloadEditNonGlobalData[0].fromDate = ""
    * eval requestPayloadEditNonGlobalData[0].thruDate = ""
    * karate.log(requestPayloadEditNonGlobalData)
    
    Given request requestPayloadEditNonGlobalData
    When method put
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message contains "Date fields having invalid value or format[Valid Format (ex. dd-MM-yyyy)]."
    And karate.log('Test Completed !')
    
     
	#REV2-13818
  Scenario: PUT - Verify Super Admin cannot edit FC Capacity Configuration for blank capacity value
    
    * eval requestPayloadEditGlobalData[0].capacity = ""
    * karate.log(requestPayloadEditGlobalData)
    
    Given request requestPayloadEditGlobalData
    When method put
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message contains "The Capacity field is mandatory."
    And karate.log('Test Completed !')
    
    
	#REV2-13821
  Scenario: PUT - Verify Edit FC Capacity Configuration for invalid endpoint url
    
    Given path '/edit'
    And request requestPayloadEditGlobalData
    When method put
    Then status 404
    And karate.log('Status : 404')
    And karate.log('Test Completed !')
  
   
  #REV2-13823
  Scenario: PATCH - Verify Edit FC Capacity Configuration for Unsupported Method
    
    Given request requestPayloadEditGlobalData
    When method patch
    Then status 405
    And karate.log('Response is : ', response)
    And match response.errors[0].message == 'METHOD_NOT_ALLOWED'
    And karate.log('Test Completed !')

    
	#REV2-13824
  Scenario: PUT - Verify Edit FC Capacity Configuration for Invalid Auth token
    
    * header Authorization = "eyJraWQiOiJmbnAyIiwiYWxnIjoiUlMyNTYifQ.eyJzdWIiOiJTXzAwMDAyIiwiYXVkIjoiaHR0cHM6XC9cL3d3dy5mbnAuY29tIiwidWFsIjoiU0df"
    
    Given request requestPayloadEditNonGlobalData
    When method put
    Then status 401
    And karate.log('Status : 401')
    And match response.errors[0].message contains 'Token Invalid! Authentication Required'
    And karate.log('Test Completed !')

  
	#REV2-13853
  Scenario: DELETE - Verify Super Admin can delete FC Capacity Configuration for valid configId
    
    * def result = call read('./capacity-config-fc-superadmin-test.feature@createCapacityConfig')
    * def configId = result.configId
    
    Given path '/id/' + configId
    When method delete
    Then status 200
    And karate.log('Status : 200')
    And match response.message contains "Deleted Successfully"
    And karate.log('Test Completed !')
	

	#REV2-13854
  Scenario: DELETE - Verify Super Admin to delete FC Capacity Configuration for invalid configId
    
    * def invalidConfigId = "61304d41621"
    
    Given path '/id/' + invalidConfigId
    When method delete
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message contains "There is no such Capacity exception to delete"
    And karate.log('Test Completed !')
    
    
	#REV2-13855 and REV2-13856
  Scenario: DELETE - Verify Super Admin to delete FC Capacity Configuration for blank configId
    
    * def blankConfigId = ""
    
    Given path '/id/' + blankConfigId
    When method delete
    Then status 404
    And karate.log('Status : 404')
    And karate.log('Test Completed !')
    
  
	#REV2-13858
  Scenario: GET - Verify unsupported method for Super Admin to delete FC Capacity Configuration
    
    * def configId = "61304d4162188428b2b84ebf"
    
    Given path '/id/' + configId
    When method get
    Then status 405
    And karate.log('Status : 405')
    And match response.errors[0].message == 'METHOD_NOT_ALLOWED'
    And karate.log('Test Completed !')
	
	
	#REV2-13859
  Scenario: DELETE - Verify deleting FC Capacity Configuration with Invalid Auth token
    
    * header Authorization = "eyJraWQiOiJmbnAyIiwiYWxnIjoiUlMyNTYifQ.eyJzdWIiOiJTXzAwMDAyIiwiYXVkIjoiaHR0cHM6XC9cL3d3dy5mbnAuY29tIiwidWFsIjoiU0df"
    * def configId = "61304d4162188428b2b84ebf"
    
    Given path '/id/' + configId
    When method delete
    Then status 401
    And karate.log('Status : 401')
    And match response.errors[0].message contains 'Token Invalid! Authentication Required'
    And karate.log('Test Completed !')
	

	#REV2-13861
  Scenario: DELETE - Verify Super Admin to delete FC Capacity Configuration for duplicate configId
    
    * def deletedConfigId = "61304d4162188428b2b84ebf"
    
    Given path '/id/' + deletedConfigId
    When method delete
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message contains "There is no such Capacity exception to delete"
    And karate.log('Test Completed !')
    

	#REV2-13861
  Scenario: DELETE - Verify Super Admin to delete FC Capacity Configuration for duplicate configId with spaces
    
    * def deletedConfigId = " 61304d4162188428b2b84ebf "
    
    Given path '/id/' + deletedConfigId
    When method delete
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message contains "There is no such Capacity exception to delete"
    And karate.log('Test Completed !')
    
 
	#REV2-13803
	Scenario: GET - Verify Super Admin cannot access FC Capacity Config with invalid authorization token
	
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
    
    
	#REV2-13802
	Scenario: POST - Verify Super Admin cannot access Capacity Config FC for Unsupported methods.
	
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
    
  
  #REV2-13800
  Scenario: GET - Verify Super Admin cannot access Capacity Config for FC with Invalid URL
    
    Given path '/cr'
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
    When method get
    Then status 404
    And karate.log('Status : 404')
    And match response.errors[0].message contains "http.request.not.found"
    And karate.log('Test Completed !')
    
     
  #REV2-13799
	Scenario: GET - Verify that Super Admin cannot access Capacity Config for FC with Blank Values
  
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
    
   
  #REV2-13798
	Scenario: GET - Verify that Super Admin cannot access Capacity Config for FC with invalid values
  
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
    
  
	#REV2-13797
	Scenario: GET - Verify that Super Admin can access Capacity Config for FC with valid values
    
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
     
     
  #REV2-29237/#REV2-29238/#REV2-29249/#REV2-29250/#REV2-29251/#REV2-29252
	Scenario: GET - Verify Super admin can search capacity Configuration fc with valid values
    
    Given param deliveryMode = 'hd'
    And param fieldname = 'vendorId'
    And param fieldvalue = 'fc_103'
    And param fieldvalues = 'fc_104'
    And param geoGroupId = 'pune'
    And param geoId = 'india'
    And param operator = 'EQUAL_TO','NOT_EQUAL_TO','CONTAINS','DOES_NOT_CONTAIN'
    And param page = '0'
    And param size = '10'
    And param vendorType = 'FC'
    When method get
    Then status 200
    And karate.log('Status : 200')
    And karate.log('Test Completed !')
    
  
  #REV2-29239/#REV2-29240
	Scenario: GET - Verify Super admin can search capacity Configuration fc with invalid values
  
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
    
    
  #REV2-29241/#REV2-29242
	Scenario: GET - Verify Super admin can search capacity Configuration fc with blank mandatory values
  
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
    
    
  #REV2-29243
  Scenario: GET - Verify Super admin can search capacity Configuration fc with Invalid URL
    
    Given path '/cr'
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
    When method get
    Then status 404
    And karate.log('Status : 404')
    And match response.errors[0].message contains "http.request.not.found"
    And karate.log('Test Completed !')
    
    
  #REV2-29245
	Scenario: POST - Verify Super admin can search capacity Configuration fc for Unsupported methods.
	
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
    
    
  #REV2-29246/#REV2-29247
	Scenario: GET - Verify Super admin can search capacity Configuration fc with invalid authorization token
	
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
    
    
  #REV2-29253/#REV2-29254
	Scenario: GET - Verify Super admin can search capacity Configuration fc with field values separated by comma 
    
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
     
     
    