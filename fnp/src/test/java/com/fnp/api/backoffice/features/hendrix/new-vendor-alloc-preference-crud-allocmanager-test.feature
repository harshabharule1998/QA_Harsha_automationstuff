Feature: New vendor alloc preference CRUD rule  with Allocation Manager user role

  Background: 
  
    Given url backOfficeAPIBaseUrl
    And header Accept = 'application/json'
    And path '/hendrix/v1/new-vendor-allocation-preferences'
    * def loginResult = callonce read('classpath:com/fnp/api/utils/generate-token.feature') {userType:'allocMgr'}
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
		
    
  #REV2-15790
  Scenario: POST - Verify new vendor alloc preference POST Rule for Allocation Manager user 
    
   	* def Id = "FC_12" + randomVendorId
    * eval requestPayloadCreate[0].vendorId = Id
    
    Given request requestPayloadCreate
    When method post
    Then status 201
    And match $[*].id == "#notnull"
    And karate.log('Response is : ', response)
    And karate.log('Status : 201')
    And karate.log('Test Completed !')    
    
	
	#REV2-16753
  Scenario: PUT - Verify new vendor alloc preference PUT Rule for valid values with Allocation Manager user

	  * eval requestPayloadUpdate[0].fromDate = '18-11-2022'
	  * eval requestPayloadUpdate[0].id = '61d2be63b9b6da591c2369f8'
	  * eval requestPayloadUpdate[0].thruDate = '19-12-2022' 
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
    And karate.log('Response is : ', response)
    And karate.log('Status : 200')
    And karate.log('Test Completed !')
    
    
	#REV2-16676
  Scenario: DELETE - Verify New Vendor Allocation Preference delete rule for 403 error with Allocation Manager user
    
    * def createNewVendor = call read('./new-vendor-alloc-preference-crud-superadmin-test.feature@createNewVendor')
    * def generatedId = createNewVendor.response.id
    
    Given path '/id/' + generatedId
    When method delete
    Then status 403
    And karate.log('Response is : ', response)
    And match response.errors[0].message == "Access_Denied"
    And karate.log('Status : 403')
    And karate.log('Test Completed !')      

    