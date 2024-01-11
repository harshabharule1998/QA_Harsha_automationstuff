Feature: Get Weightage for New Order Prference Vendor allocation by pg scenarios for allocation manager

  Background: 
    Given url backOfficeAPIBaseUrl
    And path '/hendrix/v1/new-vendor-allocation-preferences'
    * header Accept = 'application/json'
    * def loginResult = callonce read('classpath:com/fnp/api/utils/generate-token.feature') {userType:"allocMgr"}
    * def token = loginResult.accessToken
    * header Authorization = token

  
	#REV2-20515
	Scenario: GET - Verify allocation manager can fetch New Vendor Allocation Preference Quota Configuration by pg with all Valid values 
    
		Given path '/vendor-allocation-by-pg'
    And param baseGeoId = '411007'
    And param deliveryMode = 'hd'
    And param fieldName = 'vendorName'
    And param fieldValues = ['FC_Name101','FC_102']
    And param geoGroupId = 'mumbai'
    And param geoId = 'India'
    And param operator = 'EQUAL_TO'
    And param page = '0'  
    And param pgId = '2'
    And param size = '10'     
    When method get
    Then status 200
    And karate.log('Status : 200')
    And karate.log('Response is:', response)
    And karate.log('Test Completed !')    
    
    