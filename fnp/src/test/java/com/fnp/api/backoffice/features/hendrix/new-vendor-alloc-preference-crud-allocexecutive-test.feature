Feature: New vendor alloc preference CRUD with allocation executive user role

  Background: 
  
    Given url backOfficeAPIBaseUrl
    And header Accept = 'application/json'
    And path '/hendrix/v1/new-vendor-allocation-preferences'
    * def loginResult = callonce read('classpath:com/fnp/api/utils/generate-token.feature') {userType:'allocExc'}
    * def authToken = loginResult.accessToken
    * header Authorization = authToken
    
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/hendrix/new-vendor-alloc.json')
    * def requestPayloadCreate = requestPayload[0]
    * def requestPayloadUpdate = requestPayload[1]
    
    * def today = new java.util.Date().time
    * def num = today + ""
    * def num = num.substring(8)
    
    * def toTime =
      """
      	function(s) {
       		var SimpleDateFormat = Java.type('java.text.SimpleDateFormat');
       		var sdf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss");
       		return sdf.format(new java.util.Date());           
      	}
      """
      
   * def fromTime =
     """
      	function(s) {
       		var SimpleDateFormat = Java.type('java.text.SimpleDateFormat');
       		var sdf = new SimpleDateFormat("dd-MM-yyyy");
       		return sdf.format(new java.util.Date());           
      	}
      """
      
   * def random_number =
      """
          function(s) {
          var text = "";
          var possible = "0123456789";
              
              for (var i = 0; i < s; i++)
                text += possible.charAt(Math.floor(Math.random() * possible.length));
          
          return text;
          }
      """
      
		* def randomVendorId =  random_number(1)

	
	#REV2-15798
  Scenario: POST - Verify new vendor alloc preference POST Rule for only mandatory fields with allocation executive user
       
    * def Id = "FC_13" + randomVendorId
    * eval requestPayloadCreate[0].vendorId = Id
    * eval requestPayloadCreate[0].geoId = "india"
    * eval requestPayloadCreate[0].geoGroupId = "kolkata"
    * eval requestPayloadCreate[0].deliveryMode = "hd"
    * eval requestPayloadCreate[0].quotas["pgId"] = "5"
    * eval requestPayloadCreate[0].fromDate = fromTime()
    * eval requestPayloadCreate[0].thruDate = fromTime()
    * eval requestPayloadCreate[0].baseGeoId = "411014"
    * eval requestPayloadCreate[0].quotas["value"] = ""
    
    Given request requestPayloadCreate
    When method post
    Then status 201
    And match $[*].id == "#notnull"
    And karate.log('Response is : ', response)
    And karate.log('Status : 201')
    And karate.log('Test Completed !')

 
  #REV2-15795
  Scenario: POST - Verify new vendor POST Rule for missing values in mandatory fields with allocation executive user
  
    * eval requestPayloadCreate[0].quotas["pgId"] = " "
    * eval requestPayloadCreate[0].vendorId = " "
    
    Given request requestPayloadCreate
    When method post
    Then status 400
    And karate.log('Response is : ', response)
    And match response.errorId == "#notnull"
    And karate.log('Status : 400')
    And karate.log('Test Completed !')
    

  #REV2-15794
  Scenario: POST - Verify new vendor POST  Rule for blank values with allocation executive user
  
    * eval requestPayloadCreate[0].baseGeoId = ""
    * eval requestPayloadCreate[0].deliveryMode = ""
    * eval requestPayloadCreate[0].fromDate = ""
    * eval requestPayloadCreate[0].geoGroupId = ""
    * eval requestPayloadCreate[0].geoId = ""
    * eval requestPayloadCreate[0].thruDate = ""
    * eval requestPayloadCreate[0].vendorId = ""
    
    * karate.log(requestPayloadCreate)
    
    Given request requestPayloadCreate
    When method post
    Then status 400
    And karate.log('Response is : ', response)
    And match response.errorId == "#notnull"
    And karate.log('Status : 400')
    And karate.log('Test Completed !')
    

	#REV2-15793
  Scenario: POST - Verify new vendor alloc preference POST Rule for any of the invalid values with allocation executive user
  
    * eval requestPayloadCreate[0].baseGeoId = "!@###"
    * eval requestPayloadCreate[0].deliveryMode = "asd"
    
    * karate.log(requestPayloadCreate)
   
    Given request requestPayloadCreate
    When method post
    Then status 400
    And karate.log('Response is : ', response)
    And match response.errorId == "#notnull"
    And karate.log('Status : 400')
    And karate.log('Test Completed !')
    

  #REV2-15792
  Scenario: POST - Verify new vendor alloc preference POST  Rule for all invalid values with allocation executive user
  
    * eval requestPayloadCreate[0].baseGeoId = "4521333"
    * eval requestPayloadCreate[0].deliveryMode = "free"
    * eval requestPayloadCreate[0].fromDate = "1212:10:32"
    * eval requestPayloadCreate[0].geoGroupId = "@##"
    * eval requestPayloadCreate[0].geoId = "@@@"
    * eval requestPayloadCreate[0].thruDate = "1212:10:32"
    * eval requestPayloadCreate[0].vendorId = "carr"

    * karate.log(requestPayloadCreate)
    
    Given request requestPayloadCreate
    When method post
    Then status 400
    And karate.log('Response is : ', response)
    And match response.errorId == "#notnull"
    And karate.log('Status : 400')
    And karate.log('Test Completed !')


 #REV2-15791
  Scenario: POST - Verify new vendor alloc preference POST Rule for Valid values with allocation executive user
  
    * def Id = "FC_14" + randomVendorId
    * eval requestPayloadCreate[0].vendorId = Id
    
    * karate.log(requestPayloadCreate)
    
    Given request requestPayloadCreate
    When method post
    Then status 201
    And match response[*].id == "#notnull"
    And karate.log('Response is : ', response)
    And karate.log('Status : 201')
    And karate.log('Test Completed !')


	#REV2-16754 
  Scenario: PUT - Verify new vendor alloc preference PUT Rule for invalid data in request body with allocation executive user role
   
    * eval requestPayloadUpdate[0].fromDate = fromTime()
    * eval requestPayloadUpdate[0].xyz = "wwww"
    * eval requestPayloadUpdate[0].namee = "321"
    * karate.log("Updated data - ", requestPayloadUpdate)
    
    Given request requestPayloadUpdate
    When method put
    Then status 400
    And karate.log("Response is : ", response)
    And match response.errors[0].message == "Invalid_Input_Data"
    And karate.log('Status : 400')
    And karate.log('Test Completed !')


  #REV2-16751
  Scenario: PUT -  Verify new vendor alloc preference PUT Rule for Invalid URL with allocation executive
    
    Given path '/hendrix/v1/aaaabbbbb'
    And request requestPayloadUpdate
    When method put
    Then status 404
    And karate.log('Response Errors are :', response.errors)
    And match response.errors[0].message == 'http.request.not.found'
    And karate.log('Status : 404')
    And karate.log('Test Completed !')


	#REV2-16748 
	Scenario: PUT - Verify any method with Unsupported methods for allocation executive user role

    * karate.log(requestPayloadUpdate)
    
	  Given request requestPayloadUpdate
	  
    When method patch
    Then status 405
    And match response.errors[0].message == 'METHOD_NOT_ALLOWED'
    And karate.log('Status : 405')
    And karate.log('Test Completed !')
	
	
  #REV2-16747 
  Scenario: PUT - Verify new vendor alloc prefernce PUT Rule when Auth code not added for allocation executive user role
    
    * def invalidAuthToken = ""
    * header Authorization = invalidAuthToken
    
    Given request requestPayloadUpdate
    When method put
    Then status 401
    And karate.log('Response Errors are :', response.errors)
    And match response.errors[0].message == 'Token Invalid! Authentication Required'
    And karate.log('Status : 401')
    And karate.log('Test Completed !')


  #REV2-16746 
  Scenario: PUT - Verify new vendor alloc preference PUT  Rule when Invalid Auth token given for Allocation executive user role
    
    * eval requestPayloadUpdate.fromDate = fromTime()
    * eval loginResult.accessToken = "UYGJE763bbmJFHBDRHGVRDJ"
    * def saveToken = 'Bearer' + " " + loginResult.accessToken
    * header Authorization = saveToken
    
    Given request requestPayloadUpdate
    When method put
    Then status 401
    And karate.log('Response Errors are :', response.errors)
    And karate.log('Status : 401')
    And karate.log('Test Completed !')

  
  #REV2-16744
  Scenario: PUT - Verify new vendor alloc preference PUT Rule for Same date and time for fromDate and thruDate with allocation executive user role
   
   	* eval requestPayloadUpdate[0].fromDate = '15-09-2022'
	  * eval requestPayloadUpdate[0].baseGeoId = '11735'	
    * eval requestPayloadUpdate[0].deliveryMode = 'hd' 	
    * eval requestPayloadUpdate[0].geoGroupId = 'Pune' 	
	  * eval requestPayloadUpdate[0].geoId = 'India'
	  * eval requestPayloadUpdate[0].id = '61caf0ce61f5400500bacb9a'
	  * eval requestPayloadUpdate[0].thruDate = '15-09-2022' 
	  * eval requestPayloadUpdate[0].vendorId = "FC_142"
	  * eval requestPayloadUpdate[0].pgId = '4' 
	  * eval requestPayloadUpdate[0].value = '60' 

    * karate.log(requestPayloadUpdate)
    
    Given request requestPayloadUpdate
    When method put
    Then status 400
    And karate.log('Response is : ', response)
    And match response.errorId == "#notnull"
    And karate.log('Status : 400')
    And match response.errors[0].message == 'Invalid_Input_Data'   
    And karate.log('Test Completed !')


  #REV2-16743 
  Scenario: PUT - Verify new vendor alloc preference PUT Rule for From Date greater than Thru Date with allocation executive user role
   
   	* eval requestPayloadUpdate[0].fromDate = '15-01-2022'
	  * eval requestPayloadUpdate[0].id = '61caf0ce61f5400500bacb9a'
	  * eval requestPayloadUpdate[0].thruDate = '13-01-2022' 
    * karate.log(requestPayloadUpdate)
    
    Given request requestPayloadUpdate
    When method put
    Then status 400
    And karate.log('Response is : ', response)
    And match response.errorId == "#notnull"
    And karate.log('Status : 400')
    And karate.log('Test Completed !')


  #REV2-16742 
  Scenario: PUT - Verify new vendor alloc preference PUT  Rule for invalid Thru Date with allocation executive user role
   
    * eval requestPayloadUpdate[0].thruDate = '2022-11-22'
   	* eval requestPayloadUpdate[0].fromDate = '11-01-2022'  
	  * eval requestPayloadUpdate[0].id = '61caf0ce61f5400500bacb9a'

		* karate.log(requestPayloadUpdate)

    Given request requestPayloadUpdate
    When method put
    Then status 400
    And karate.log('Response is : ', response)
    And match response.errorId == "#notnull"
    And karate.log('Status : 400')
    And karate.log('Test Completed !')


  #REV2-16741 
  Scenario: PUT - Verify new vendor alloc preference PUT Rule for invalid from Date with allocation executive user role
    
   	* eval requestPayloadUpdate[0].fromDate = '2022-11-22'
    * karate.log(requestPayloadUpdate)
    
    Given request requestPayloadUpdate
    When method put
    Then status 400
    And karate.log('Response is : ', response)
    And match response.errorId == "#notnull"
    And karate.log('Status : 400')
    And match response.errors[0].message == 'Date fields having invalid value or format[Valid Format (ex. dd-MM-yyyy)].'  
    And karate.log('Test Completed !')


  #REV2-16738 
  Scenario: PUT - Verify new vendor alloc PUT Rule for combination of valid/invalid/blank/spaces values with allocation executive user role
   
    * eval requestPayloadUpdate[0].baseGeoId = '11735'	
   	* eval requestPayloadUpdate[0].fromDate = '11-01-2022'
    * eval requestPayloadUpdate[0].deliveryMode = ' ' 	
    * eval requestPayloadUpdate[0].geoGroupId = 'abc' 	
	  * eval requestPayloadUpdate[0].geoId = ' '
	  * eval requestPayloadUpdate[0].id = '61caf0ce61f5400500bacb9a'
	  * eval requestPayloadUpdate[0].thruDate = '13-01-2022' 
	  * eval requestPayloadUpdate[0].vendorId = "pqr"
	  * eval requestPayloadUpdate[0].quotas["pgId"] = " "
	  * eval requestPayloadUpdate[0].quotas["value"] = "60"
	  
    * karate.log(requestPayloadUpdate)
    
    Given request requestPayloadUpdate
    When method put
    Then status 400
    And karate.log('Response is : ', response)
    And match response.errorId == "#notnull"
    And karate.log('Status : 400')
    And match response.errors[0].message == 'The Geography field is mandatory.'  
    And karate.log('Test Completed !')


  #REV2-16735 
  Scenario: PUT - Verify new vendor alloc preference PUT Rule for missing any value in any mandatory fields with allocation executive user role
   
    * eval requestPayloadUpdate[0].baseGeoId = '11735'	
   	* eval requestPayloadUpdate[0].fromDate = '11-01-2022'
    * eval requestPayloadUpdate[0].deliveryMode = ' ' 	
    * eval requestPayloadUpdate[0].geoGroupId = 'Pune' 	
	  * eval requestPayloadUpdate[0].geoId = ' '
	  * eval requestPayloadUpdate[0].id = '61caf0ce61f5400500bacb9a'
	  * eval requestPayloadUpdate[0].thruDate = '13-01-2022' 
	  * eval requestPayloadUpdate[0].vendorId = "FC_142"
		* eval requestPayloadUpdate[0].quotas["pgId"] = " "
	  * eval requestPayloadUpdate[0].quotas["value"] = "60"
    * karate.log(requestPayloadUpdate)
    
    Given request requestPayloadUpdate
    When method put
    Then status 400
    And karate.log('Response is : ', response)
    And match response.errorId == '#notnull'
    And karate.log('Status : 400')
    And match response.errors[0].message == 'The Delivery mode field is mandatory.'
    And karate.log('Test Completed !')


  #REV2-16734
  Scenario: PUT - Verify new vendor alloc preference PUT Rule for blank values with allocation executive user role
   
    * eval requestPayloadUpdate[0].baseGeoId = ' '	
   	* eval requestPayloadUpdate[0].fromDate = ' '
    * eval requestPayloadUpdate[0].deliveryMode = ' ' 
    * eval requestPayloadUpdate[0].geoGroupId = ' ' 	
	  * eval requestPayloadUpdate[0].geoId = ' ' 
	  * eval requestPayloadUpdate[0].id = ' '
	  * eval requestPayloadUpdate[0].thruDate = ' ' 
	  * eval requestPayloadUpdate[0].vendorId = " "
		* eval requestPayloadUpdate[0].quotas["pgId"] = " "
	  * eval requestPayloadUpdate[0].quotas["value"] = " "
    
    * karate.log(requestPayloadUpdate)
    
    Given request requestPayloadUpdate
    When method put
    Then status 400
    And karate.log('Response is : ', response)
    And match response.errorId == "#notnull"
    And karate.log('Status : 400')
    And karate.log('Test Completed !')


  #REV2-16730 
  Scenario: PUT - Verify new vendor alloc preference PUT Rule for all valid values with allocation executive user role
  
	 	* eval requestPayloadUpdate[0].fromDate = '22-11-2022'
	  * eval requestPayloadUpdate[0].id = '61caf0ce61f5400500bacb9a'
	  * eval requestPayloadUpdate[0].thruDate = '22-12-2022' 
	  * eval requestPayloadUpdate[0].baseGeoId = '11735'	
    * eval requestPayloadUpdate[0].deliveryMode = 'hd' 	
    * eval requestPayloadUpdate[0].geoGroupId = 'Pune' 	
	  * eval requestPayloadUpdate[0].geoId = 'India'
	  * eval requestPayloadUpdate[0].vendorId = "FC_142"
	  * eval requestPayloadUpdate[0].quotas["pgId"] = "4"
	  * eval requestPayloadUpdate[0].quotas["value"] = "60"
	  
    * karate.log(requestPayloadUpdate)
    
    Given request requestPayloadUpdate
    When method put
    Then status 200
    And karate.log('Status : 200')
    And karate.log("Response is : ",response)
    And match response.message == 'Record(s) Updated Successfully.'
  
 
  #REV2-16731 
  Scenario: Verify Method: PUT request for New Order Preference Quota Configuration with Allocation Executive access - try 
  updating with Invalid data
   	
   	* eval requestPayloadUpdate[0].baseGeoId = 'abc'	
   	* eval requestPayloadUpdate[0].fromDate = '2022-01-11'
    * eval requestPayloadUpdate[0].deliveryMode = 'h' 
    * eval requestPayloadUpdate[0].geoGroupId = 'abc' 	
	  * eval requestPayloadUpdate[0].geoId = 'ab'
	  * eval requestPayloadUpdate[0].id = 'ab'
	  * eval requestPayloadUpdate[0].thruDate = '2022-01-13' 
	  * eval requestPayloadUpdate[0].vendorId = "pqr"
		* eval requestPayloadUpdate[0].quotas["pgId"] = "abc"
	  * eval requestPayloadUpdate[0].quotas["value"] = "xyz"
	  
	  * karate.log(requestPayloadUpdate)
    
    Given request requestPayloadUpdate
    When method put
    Then status 400
    And karate.log('Status : 400')
    And karate.log("Response is : ",response)
    And match response.errors[0].message contains "Date fields having invalid value or format[Valid Format (ex. dd-MM-yyyy)]."

 
  #REV2-16732 
  Scenario: PUT - Verify new vendor alloc preference PUT Rule for only mandatory values with allocation executive user role
  
   	* eval requestPayloadUpdate[0].fromDate = '17-09-2022'
	  * eval requestPayloadUpdate[0].id = '61cefd7ab9b6da591c2369f4'
	  * eval requestPayloadUpdate[0].thruDate = '20-09-2022' 


	  * karate.log(requestPayloadUpdate)

    Given request requestPayloadUpdate
    When method put
    Then status 200
    And karate.log('Status : 200')
    And karate.log("Response is : ",response)
    And match response.message == 'Record(s) Updated Successfully.'
	

	#REV2-16674
  Scenario: DELETE - Verify Allocation Executive to delete New Vendor Allocation Preference Configuration for invalid endpoint url
    
    * def createNewVendor = call read('./new-vendor-alloc-preference-crud-superadmin-test.feature@createNewVendor')
    * def generatedId = createNewVendor.response.id
    
    Given path '/delete/' + generatedId + '/id1'
    When method delete
    
    
    Then status 404
    And match response.errors[0].message == "http.request.not.found"
    And karate.log('Status : 404')
    And karate.log('Test Completed !')
    
 
  #REV2-16671
  Scenario: DELETE - Verify Allocation Executive to delete New Vendor Allocation Preference Configuration with Invalid Auth token
  
    * def createNewVendor = call read('./new-vendor-alloc-preference-crud-superadmin-test.feature@createNewVendor')
    * def generatedId = createNewVendor.response.id
    * eval loginResult.accessToken = "UYGJEFGESJFHBDRHGVRDJ"
    * def saveToken = 'Bearer' + " " + loginResult.accessToken
    * header Authorization = saveToken
    
    Given path '/id/' + generatedId
    When method delete
    Then status 401
    And match response.errors[0].message == 'Token Invalid! Authentication Required'
    And karate.log('Status : 401')
    And karate.log('Test Completed !')
    
    
  #REV2-16669
  Scenario: DELETE - Verify Allocation Executive to delete New Vendor Allocation Preference Configuration with duplicate data/id
    
    * def createNewVendor = call read('./new-vendor-alloc-preference-crud-superadmin-test.feature@createNewVendor')
    * def generatedId = createNewVendor.response.id
    
    Given path '/id/' + generatedId
    When method delete
    Then status 200
    
    * header Authorization = authToken
    
    Given path '/hendrix/v1/new-vendor-allocation-preferences/id/' + generatedId
    When method delete
    Then status 404
    And match response.errors[0].message == "There is no such New Vendor Preference to delete"
    And karate.log('Status : 404')
    And karate.log('Test Completed !')
    
     
  #REV2-16667
  Scenario: DELETE - Verify Allocation Executive to delete New Vendor Allocation Preference Configuration with blank id
    
    Given path '/id/' + ""
    When method delete
    Then status 404
    And match response.errors[0].message == "http.request.not.found"
    And karate.log('Status : 404')
    And karate.log('Test Completed !')
    
 
  #REV2-16666
  Scenario: DELETE - Verify Allocation Executive to delete New Vendor Allocation Preference Configuration with invalid id
   
   	* def createNewVendor = call read('./new-vendor-alloc-preference-crud-superadmin-test.feature@createNewVendor')
    * def generatedId = createNewVendor.response.id 
    
    Given path '/id/' + generatedId + num
    When method delete
    Then status 404
    And match response.errors[0].message == "There is no such New Vendor Preference to delete"
    And karate.log('Status : 404')
    And karate.log('Test Completed !')
    
      
  #REV2-16665
  Scenario: DELETE - Verify Allocation Executive to delete New Vendor Allocation Preference Configuration with valid id
    
    * def createNewVendor = call read('./new-vendor-alloc-preference-crud-superadmin-test.feature@createNewVendor')
    * def generatedId = createNewVendor.response.id
    
    Given path '/id/' + generatedId
    When method delete
    Then status 200
    And match response.message == "Record(s) Deleted Successfully."
    And karate.log('Status : 200')
    And karate.log('Test Completed !')

    