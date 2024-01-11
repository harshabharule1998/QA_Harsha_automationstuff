Feature: New vendor alloc preference CRUD with Super Admin user role

  Background: 
  
    Given url backOfficeAPIBaseUrl
    And header Accept = 'application/json'
    And path '/hendrix/v1/new-vendor-allocation-preferences'
    
    * def loginResult = callonce read('classpath:com/fnp/api/utils/generate-token.feature') {userType:'superAdminQA'}
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
       		var newsdf = new SimpleDateFormat("dd-MM-yyyy");
       		return newsdf.format(new java.util.Date());           
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
   
   
  #REV2-15788
  Scenario: POST - Verify new vendor alloc preference POST Rule for Same date and time for fromDate and thruDate with super admin access
    
    * eval requestPayloadCreate[0].fromDate = "21-12-2021"
    * eval requestPayloadCreate[0].thruDate = "21-12-2021"
    * karate.log(requestPayloadCreate)
    
    Given request requestPayloadCreate
    When method post
    Then status 400
    And karate.log('Response is : ', response)
    And match response.errorId == "#notnull"
    And karate.log('Status : 400')
    And karate.log('Test Completed !')


  #REV2-15787
  Scenario: POST - Verify new vendor alloc preferenc POST Rule for thru Date less than from Date with super admin access
  
    * eval requestPayloadCreate[0].thruDate = '09-01-2022'
    * karate.log(requestPayloadCreate)
    
    Given request requestPayloadCreate
    When method post
    Then status 400
    And karate.log('Response is : ', response)
    And match response.errorId == "#notnull"
    And match response.errors[*].message contains "thruDate must be greater than or equal to fromDate."
    And karate.log('Status : 400')
    And karate.log('Test Completed !')


  #REV2-15786
  Scenario: POST - Verify new vendor alloc preferenc POST  Rule for invalid Thru Date with super admin access
  
    * eval requestPayloadCreate[0].thruDate = '111-10-08T00:00:11'
    * karate.log(requestPayloadCreate)
    
    Given request requestPayloadCreate
    When method post
    Then status 400
    And karate.log('Response is : ', response)
    And match response.errorId == "#notnull"
    And match response.errors[*].message contains 'Date fields having invalid value or format[Valid Format (ex. dd-MM-yyyy)].'
    And karate.log('Status : 400')
    And karate.log('Test Completed !')


  #REV2-15785
  Scenario: POST - Verify new vendor alloc preferenc POST  Rule for invalid from Date with super admin access
  
    * eval requestPayloadCreate[0].fromDate = '111-10-08T00:00:11'
    * karate.log(requestPayloadCreate)
    
    Given request requestPayloadCreate
    When method post
    Then status 400
    And karate.log('Response is : ', response)
    And match response.errorId == "#notnull"
    And match response.errors[*].message contains 'Date fields having invalid value or format[Valid Format (ex. dd-MM-yyyy)].'
    And karate.log('Status : 400')
    And karate.log('Test Completed !')


  #REV2-15784
  Scenario: POST - Verify new vendor alloc preferenc POST Rule for duplicate values without spaces with super admin access
  	
  	* karate.log(requestPayloadCreate)
  	
    Given request requestPayloadCreate
    When method post
    Then status 400
    And karate.log('Response is : ', response)
    And match response.errorId == "#notnull"
    And karate.log('Status : 400')
    And karate.log('Test Completed !')
    

  #REV2-15782
  Scenario: POST - Verify new vendor POST Rule with Invalid data in request body with super admin access
  
    * eval requestPayloadCreate[0].xyz = "xyz"
    * eval requestPayloadCreate[0].idddd = "1234"
    * karate.log(requestPayloadCreate)
    
    Given request requestPayloadCreate
    When method post
    Then status 400
    And karate.log('Response Errors are :', response.errors)
    And match response.errors[*].message contains "Invalid_Input_Data"
    And karate.log('Status : 400')
    And karate.log('Test Completed !')


  #REV2-15779
  Scenario: POST - Verify new vendor POST Rule when Invalid Auth token given for Super Admin
  
    * eval loginResult.accessToken = "UYGJEFGESJFHBDRHGVRDJ"
    * def saveToken = 'Bearer' + " " + loginResult.accessToken
    * header Authorization = saveToken
    
    Given request requestPayloadCreate
    When method post
    Then status 401
    And karate.log('Response Errors are :', response.errors)
    And match response.errors[0].message == 'Token Invalid! Authentication Required'
    And karate.log('Status : 401')
    And karate.log('Test Completed !')


  #REV2-15778
  Scenario: POST - Verify new vendor POST Rule for Unsupported Method with super admin access
  
    Given request requestPayloadCreate
    When method patch
    Then status 405
    And karate.log('Response is : ', response)
    And match response.errors[0].message == 'METHOD_NOT_ALLOWED'
    
    * header Authorization = authToken
    
    Given path '/hendrix/v1/new-vendor-allocation-preferences'
    When method delete
    Then status 405
    And karate.log('Response is : ', response)
    And match response.errors[0].message == 'METHOD_NOT_ALLOWED'
    And karate.log('Status : 405')
    And karate.log('Test Completed !')


  #REV2-15776
  Scenario: POST - Verify new vendor POST  Rule for Invalid URL with super admin access
  
    Given path '/hh/aabbcc'
    And request requestPayloadCreate
    When method post
    Then status 404
    And karate.log('Response Errors are :', response.errors)
    And match response.errorId == "#notnull"
    And match response.errors[0].errorCode == 'NOT_FOUND'
    And karate.log('Status : 404')
    And karate.log('Test Completed !')


  #REV2-15771
  Scenario: POST - Verify new vendor POST Rule for missing values in mandatory fields with super admin access
    
    * eval requestPayloadCreate[0].geoGroupId = ""
    * eval requestPayloadCreate[0].vendorId = " "
		
		* karate.log(requestPayloadCreate)
		
    Given request requestPayloadCreate
    When method post
    Then status 400
    And match response.errorId == "#notnull"
    And karate.log('Response is : ', response)
    And karate.log('Status : 400')
    
    
  #REV2-15774
  Scenario: POST - Verify new vendor alloc preference POST Rule for all values in mandatory fields with super admin access
  
   	* def Id = "FC_13" + randomVendorId
    * eval requestPayloadCreate[0].vendorId = Id
    * eval requestPayloadCreate[0].geoId = "india"
    * eval requestPayloadCreate[0].geoGroupId = "kolkata"
    * eval requestPayloadCreate[0].deliveryMode = "hd"
    * eval requestPayloadCreate[0].quotas["pgId"] = "5"
    * eval requestPayloadCreate[0].fromDate = toTime()
    * eval requestPayloadCreate[0].thruDate = toTime()
    * eval requestPayloadCreate[0].baseGeoId = "411003"
    * eval requestPayloadCreate[0].quotas["value"] = ""
    
    * karate.log(requestPayloadCreate)
    
    Given request requestPayloadCreate
    When method post
    Then status 201
    And match response[*].id == "#notnull"
    And karate.log('Response is : ', response)
    And karate.log('Status : 201')
    And karate.log('Test Completed !')
    

  #REV2-15770
  Scenario: POST - Verify new vendor alloc preference POST Rule for blank values with super admin access
  
    * eval requestPayloadCreate.configName = ""
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
    
 
	#REV2-15769
  Scenario: POST - Verify new vendor alloc preference POST Rule for any of the invalid values with super admin access
  
    * eval requestPayloadCreate[0].baseGeoId = "!@###"
    * eval requestPayloadCreate[0].geoGroupId = "asd"
    
    * karate.log(requestPayloadCreate)
    
    Given request requestPayloadCreate
    When method post
    Then status 400
    And karate.log('Response is : ', response)
    And match response.errorId == "#notnull"
    And karate.log('Status : 400')
    And karate.log('Test Completed !')

 
	@createNewVendor
  #REV2-15767
  Scenario: POST - Verify new vendor alloc preference POST Rule for Valid values with super admin access
  	
  	* def Id = "FC_14" + randomVendorId
    * eval requestPayloadCreate[0].vendorId = Id
    * eval requestPayloadCreate[0].fromDate = toTime()
    * eval requestPayloadCreate[0].thruDate = toTime()
    
    * karate.log(requestPayloadCreate)
    
    Given request requestPayloadCreate
    When method post
    Then status 201
    And match response[*].id == "#notnull"
    And karate.log('Response is : ', response)
    And karate.log('Status : 201')
    And karate.log('Test Completed !')


	#REV2-16768
  Scenario: PUT - Verify new vendor alloc preference PUT Rule for invalid data in request body with super admin
    
    * eval requestPayloadUpdate.fromDate = toTime()
    * eval requestPayloadUpdate.xyz = "wwww"
    * eval requestPayloadUpdate.namee = "321"
    
    * karate.log("Updated data - ", requestPayloadUpdate)
    
    Given request requestPayloadUpdate
    When method put
    Then status 400
    And karate.log("Response is : ",response)
    And match response.errors[0].message == "Invalid_Input_Data"
    And karate.log('Status : 400')
    And karate.log('Test Completed !')


  #REV2-16767
  Scenario: PUT -  Verify new vendor alloc preference PUT Rule for Invalid URL with super admin
   
    Given path '/hendrix/v1/aaaabbbbb'
    And request requestPayloadUpdate
    When method put
    Then status 404
    And karate.log('Response Errors are :', response.errors)
    And match response.errors[0].message == 'http.request.not.found'
    And karate.log('Status : 404')
    And karate.log('Test Completed !')


  #REV2-16766
  Scenario: PUT - Verify new vendor alloc preference PUT Rule for Same date and time for fromDate and thruDate with super admin
    
    * eval requestPayloadUpdate[0].baseGeoId = '11735'	
   	* eval requestPayloadUpdate[0].fromDate = '15-01-2022'
    * eval requestPayloadUpdate[0].deliveryMode = 'hd' 	
    * eval requestPayloadUpdate[0].geoGroupId = 'Pune' 	
	  * eval requestPayloadUpdate[0].geoId = 'India'
	  * eval requestPayloadUpdate[0].id = '61caf0ce61f5400500bacb9a'
	  * eval requestPayloadUpdate[0].thruDate = '15-01-2022' 
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
    And karate.log('Test Completed !')


  #REV2-16765
  Scenario: PUT - Verify new vendor alloc preference PUT Rule for From Date greater than Thru Date with super admin
   
	  * eval requestPayloadUpdate[0].baseGeoId = '11735'	
   	* eval requestPayloadUpdate[0].fromDate = '15-01-2022'
    * eval requestPayloadUpdate[0].deliveryMode = 'hd' 	
    * eval requestPayloadUpdate[0].geoGroupId = 'Pune' 	
	  * eval requestPayloadUpdate[0].geoId = 'India'
	  * eval requestPayloadUpdate[0].id = '61caf0ce61f5400500bacb9a'
	  * eval requestPayloadUpdate[0].thruDate = '13-9-2022' 
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
    And karate.log('Test Completed !')


  #REV2-16764
  Scenario: PUT - Verify new vendor alloc preference PUT Rule for invalid Thru Date with super admin
   
    * eval requestPayloadUpdate[0].baseGeoId = '11735'	
   	* eval requestPayloadUpdate[0].fromDate = '13-9-2022'
    * eval requestPayloadUpdate[0].deliveryMode = 'hd' 	
    * eval requestPayloadUpdate[0].geoGroupId = 'Pune' 	
	  * eval requestPayloadUpdate[0].geoId = 'India'
	  * eval requestPayloadUpdate[0].id = '61caf0ce61f5400500bacb9a'
	  * eval requestPayloadUpdate[0].thruDate = '2022-11-22' 
	  * eval requestPayloadUpdate[0].vendorId = "FC_142"
	  * eval requestPayloadUpdate[0].quotas["pgId"] = "4"
	  * eval requestPayloadUpdate[0].quotas["value"] = "60"
    
    * karate.log(requestPayloadUpdate)
    
    Given request requestPayloadUpdate
    When method put
    Then status 400
    And karate.log('Response is : ', response)
    And match response.errorId == "#notnull"
    And karate.log('Status : 400')
    And karate.log('Test Completed !')


  #REV2-16763
  Scenario: PUT - Verify new vendor alloc preference PUT Rule for invalid from Date with super admin
    
    * eval requestPayloadUpdate[0].baseGeoId = '11735'	
   	* eval requestPayloadUpdate[0].fromDate = '2022-11-22'
    * eval requestPayloadUpdate[0].deliveryMode = 'hd' 	
    * eval requestPayloadUpdate[0].geoGroupId = 'Pune' 	
	  * eval requestPayloadUpdate[0].geoId = 'India'
	  * eval requestPayloadUpdate[0].id = '61caf0ce61f5400500bacb9a'
	  * eval requestPayloadUpdate[0].thruDate = '13-9-2022' 
	  * eval requestPayloadUpdate[0].vendorId = "FC_142"
	  * eval requestPayloadUpdate[0].quotas["pgId"] = "4"
	  * eval requestPayloadUpdate[0].quotas["value"] = "60"

    * karate.log(requestPayloadUpdate)
    
    Given request requestPayloadUpdate
    When method put
    Then status 400
    And karate.log('Response is : ', response)
    And match response.errorId == "#notnull"
    And karate.log('Status : 400')
    And match response.errors[0].message == 'Date fields having invalid value or format[Valid Format (ex. dd-MM-yyyy)].'  
    And karate.log('Test Completed !')
    
    
  #REV2-16762
  Scenario: PUT - Verify new vendor alloc preference PUT Rule for duplicate values with spaces for super admin
   
    #* eval requestPayloadUpdate.fromDate = requestPayloadUpdate.fromDate
    #* eval requestPayloadUpdate.vendorType = "     "
    
    * eval requestPayloadUpdate[0].baseGeoId = '11735'	
    * eval requestPayloadUpdate[0].baseGeoId = '11735 '	  
   	* eval requestPayloadUpdate[0].fromDate = '15-01-2022'
    * eval requestPayloadUpdate[0].deliveryMode = 'hd' 	
    * eval requestPayloadUpdate[0].geoGroupId = 'Pune' 	
	  * eval requestPayloadUpdate[0].geoId = 'India'
	  * eval requestPayloadUpdate[0].id = '61caf0ce61f5400500bacb9a'
	  * eval requestPayloadUpdate[0].thruDate = '13-9-2022' 
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
    And karate.log('Test Completed !')

  
  #REV2-16760
  Scenario: PUT - Verify new vendor alloc preference PUT Rule for combination of valid/invalid/blank/spaces values with super admin
    
    * eval requestPayloadUpdate[0].baseGeoId = '11735'	
   	* eval requestPayloadUpdate[0].fromDate = '11-01-2022'
    * eval requestPayloadUpdate[0].deliveryMode = ' ' 	
    * eval requestPayloadUpdate[0].geoGroupId = 'abc' 	
	  * eval requestPayloadUpdate[0].geoId = ' '
	  * eval requestPayloadUpdate[0].id = '61caf0ce61f5400500bacb9a'
	  * eval requestPayloadUpdate[0].thruDate = '13-9-2022' 
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
    And karate.log('Test Completed !')
    
  
	#REV2-16759
  Scenario: PUT - Verify new vendor alloc preference PUT Rule for blank values with super admin
  
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
  
     
  #REV2-16755 
  Scenario: PUT - Verify new vendor alloc preference PUT Rule for all valid values with super admin user role
  
    #* def postResult = call read('./new-vendor-alloc-preference-crud-superadmin-test.feature@createNewVendor')
  
    * eval requestPayloadUpdate[0].baseGeoId = '11735'	
   	* eval requestPayloadUpdate[0].fromDate = '18-11-2022'
    * eval requestPayloadUpdate[0].deliveryMode = 'hd' 	
    * eval requestPayloadUpdate[0].geoGroupId = 'Pune' 	
	  * eval requestPayloadUpdate[0].geoId = 'India'
	  * eval requestPayloadUpdate[0].id = '61d2ccccb9b6da591c236a01'
	  * eval requestPayloadUpdate[0].thruDate = '18-12-2022' 
	  * eval requestPayloadUpdate[0].vendorId = "FC_143"
	  * eval requestPayloadUpdate[0].quotas["pgId"] = "4"
	  * eval requestPayloadUpdate[0].quotas["value"] = "60"
    
    Given request requestPayloadUpdate
    When method put
    Then status 200
    And karate.log('Status : 200')
    And karate.log("Response is : ",response)
    And match response.message == 'Record(s) Updated Successfully.'
  

  #REV2-16756
  Scenario: PUT -Verify Method: PUT request for New Order Preference Quota Configuration with Super Admin 
  access - try updating with Invalid data
  	
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
    
     
  #REV2-16757
  Scenario: PUT - Verify new vendor alloc preference PUT Rule for only mandatory values with super admin user role
  
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
	  
    Given request requestPayloadUpdate
    When method put
    Then status 200
    And karate.log('Status : 200')
    And karate.log("Response is : ",response)
    And match response.message == 'Record(s) Updated Successfully.'
    
    
  #REV2-16748
  Scenario: PUT - Verify new vendor alloc preference PUT  Rule for unsupported method with super admin
  
    * karate.log(requestPayloadUpdate)
    
    And request requestPayloadUpdate
    When method patch
    Then status 405
    And karate.log('Response is : ', response)
    And match response.errors[0].message == 'METHOD_NOT_ALLOWED'
    And karate.log('Test Completed !')
    

	#REV2-16684
  Scenario: DELETE - Verify Super Admin to delete New Vendor Allocation Preference Configuration for invalid endpoint url
    
    * def createNewVendor = call read('./new-vendor-alloc-preference-crud-superadmin-test.feature@createNewVendor')
    * def generatedId = createNewVendor.response.id
    
    Given path '/delete/' + generatedId + '/id1'
    When method delete
    Then status 404
    And match response.errors[0].message == "http.request.not.found"
    And karate.log('Status : 404')
    And karate.log('Test Completed !')
    
  
  #REV2-16682
  Scenario: DELETE - Verify Super Admin to delete New Vendor Allocation Preference Configuration with duplicate data/id
    
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
    
     
  #REV2-16681
  Scenario: DELETE - Verify Super Admin to delete New Vendor Allocation Preference Configuration with blank id
    
    Given path '/id/' + ""
    When method delete
    Then status 404
    And match response.errors[0].message == "http.request.not.found"
    And karate.log('Status : 404')
    And karate.log('Test Completed !')
    
      
  #REV2-16680
  Scenario: DELETE - Verify Super Admin to delete New Vendor Allocation Preference Configuration with invalid id
    
    Given path '/id/' + "123456789abcdef"
    When method delete
    Then status 404
    And match response.errors[0].message == "There is no such New Vendor Preference to delete"
    And karate.log('Status : 404')
    And karate.log('Test Completed !')
    
  
  #REV2-16679
  Scenario: DELETE - Verify Super Admin to delete New Vendor Allocation Preference Configuration with valid id
    
    * def createNewVendor = call read('./new-vendor-alloc-preference-crud-superadmin-test.feature@createNewVendor')
    * def generatedId = createNewVendor.response.id
    
    Given path '/id/' + generatedId
    When method delete
    Then status 200
    And match response.message == "Record(s) Deleted Successfully."
    And karate.log('Status : 200')
    And karate.log('Test Completed !')
    
  
  #REV2-16678
  Scenario: DELETE - Verify Super Admin to delete New Vendor Allocation Preference Configuration with Unsupported methods for endpoint
  
    * def createNewVendor = call read('./new-vendor-alloc-preference-crud-superadmin-test.feature@createNewVendor')
    * def generatedId = createNewVendor.response.id
    
    Given path '/id/' + generatedId
    And request ''
    When method patch
    Then status 405
    And match response.errors[0].message == 'METHOD_NOT_ALLOWED'
    
    * header Authorization = authToken
    
    Given path '/hendrix/v1/new-vendor-allocation-preferences/id/' + generatedId
    And request ''
    When method put
    Then status 405
    And match response.errors[0].message == 'METHOD_NOT_ALLOWED'
    And karate.log('Status : 405')
    And karate.log('Test Completed !')
	

  #REV2-16732 --rem
  Scenario: PUT - Verify new vendor alloc preference PUT Rule for only mandatory values with allocation executive user role
  
  #	* def postResult = call read('./new-vendor-alloc-preference-crud-superadmin-test.feature@createNewVendor')
    
   	* eval requestPayloadUpdate[0].fromDate = '12-09-2022'
	  * eval requestPayloadUpdate[0].id = '61cf073cb9b6da591c2369f7'
	  * eval requestPayloadUpdate[0].thruDate = '13-10-2022' 

	  * karate.log(requestPayloadUpdate)

    Given request requestPayloadUpdate
    When method put
    Then status 200
    And karate.log('Status : 200')
    And karate.log("Response is : ",response)
    And match response.message == 'Record(s) Updated Successfully.'
	
	
	