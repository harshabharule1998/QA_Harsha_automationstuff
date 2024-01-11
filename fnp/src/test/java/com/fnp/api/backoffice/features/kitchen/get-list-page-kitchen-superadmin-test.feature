Feature: Kitchen Get list page campaign scenarios with super admin user role 

  Background: 
    Given url backOfficeAPIBaseUrl
    And header Accept = 'application/json'
    And path '/kitchen/v1'
    * def loginResult = callonce read('classpath:com/fnp/api/utils/generate-token.feature') {userType:'superAdminQA'}
    * def authToken = loginResult.accessToken
    * def campaignId = 'U_04616'
    * def invalidcampaignId = 'aabc@!&'
    * def id = 'U_00446'
    * header Authorization = authToken
    
    
  #REV2-15820
  Scenario: GET - Verify super admin user can fetch request for campaign with valid values
  
    Given path '/campaigns'
    And param page = 0
    And param simplesearchvalue = 'testing'
    And param size = 10
    And param sortparam = 'updatedAt:desc'
    When method get
    Then status 200
    And karate.log('Status : 200')
    And karate.log('Test Completed !')
    
 
  #REV2-15821
  Scenario: GET - Verify super admin user can fetch request for campaign with invalid values
  
    Given path '/campaigns'
    And param page = 0
    And param simplesearchvalue = '@123'
    And param size = 10
    And param sortparam = 'campaign.updatedAt:DESC'
    When method get
    Then status 200
    And karate.log('Status : 200')
    And karate.log('Test Completed !')
    
   
  #REV2-15822
  Scenario: GET - Verify super admin user can fetch request for campaign with non existing keyword
  
    Given path '/campaigns'
    And param page = 0
    And param simplesearchvalue = 'CMP_1'
    And param size = 10
    And param sortparam = 'campaign.updatedAt:DESC'
    When method get
    Then status 200
    And karate.log('Status : 200')
    And karate.log('Test Completed !')
    
  
  #REV2-15823
  Scenario: GET - Verify super admin user can fetch request for campaign with blank values
  
    Given path '/campaigns'
    And param page = 0
    And param simplesearchvalue = ''
    And param size = ''
    And param sortparam = 'campaign.updatedAt:DESC'
    When method get
    Then status 200
    And karate.log('Status : 200')
    And karate.log('Test Completed !')
    
    
  #REV2-15824
  Scenario: GET - Verify super admin user can fetch request for campaign with invalid page
  
    Given path '/campaigns'
    And param page = 0
    And param simplesearchvalue = 'CMP_0002'
    And param size = 10
    And param sortparam = 'campaign.updatedAt:DESC'
    When method get
    Then status 200
    And karate.log('Status : 200')
    And karate.log('Test Completed !')
    
  
  #REV2-15825
  Scenario: GET - Verify super admin user can fetch request for campaign with blank page
  
    Given path '/campaigns'
    And param page = ''
    And param simplesearchvalue = '@123'
    And param size = 10
    And param sortparam = 'campaign.updatedAt:DESC'
    When method get
    Then status 200
    And karate.log('Status : 200')
    And karate.log('Test Completed !')
    
    
  #REV2-15826
  Scenario: GET - Verify super admin user can fetch request for campaign with blank size
  
    Given path '/campaigns'
    And param page = 0
    And param simplesearchvalue = 'testing'
    And param size = ''
    And param sortparam = 'campaign.updatedAt:DESC'
    When method get
    Then status 200
    And karate.log('Status : 200')
    And karate.log('Test Completed !')
    
  
  #REV2-15827
  Scenario: GET - Verify super admin user can fetch request for campaign with invalid size
  
    Given path '/campaigns'
    And param page = 0
    And param simplesearchvalue = 'testing'
    And param size = 'a'
    And param sortparam = 'campaign.updatedAt:DESC'
    When method get
    Then status 400
    And karate.log('Status : 400')
    And karate.log('Test Completed !')
    
  
  #REV2-15828
  Scenario: GET - Verify super admin user can fetch request for campaign with blank sortparam 
  
    Given path '/campaigns'
    And param page = 0
    And param simplesearchvalue = 'testing'
    And param size = 10
    And param sortparam = ''
    When method get
    Then status 200
    And karate.log('Status : 200')
    And karate.log('Test Completed !')
    
 
  #REV2-15829
  Scenario: GET - Verify super admin user can fetch request for campaign with invalid sortparam 
  
    Given path '/campaigns'
    And param page = 0
    And param simplesearchvalue = 'testing'
    And param size = 10
    And param sortparam = 'lastUpdatedDate*%5C%3Adesc'
    When method get
    Then status 200
    And karate.log('Status : 200')
    And karate.log('Test Completed !')
    
  
  #REV2-17791
  Scenario: GET - Verify super admin user can fetch request for campaign with valid values
  
    Given path '/campaigns'
    And param page = 0
    And param simplesearchvalue = 'emailtest'
    And param size = 10
    And param sortparam = 'updatedAt:desc'
    When method get
    Then status 200
    And karate.log('Status : 200')
    And karate.log('Test Completed !')
    
   
  #REV2-17792
  Scenario: GET - Verify super admin user fetch request for campaign with invalid data
  
    Given path '/campaigns'
    And param page = 'ffh'
    And param simplesearchvalue = 'testing@123'
    And param size = 'ssd'
    And param sortparam = 'campaign.updatedAt:DESC%%%$'
    When method get
    Then status 400
    And karate.log('Status : 400')
    And karate.log('Test Completed !')
  
 	
  #REV2-17793
  Scenario: GET - Verify super admin user can fetch request for campaign with blank values
  
    Given path '/campaigns'
    And param page = ' '
    And param simplesearchvalue = ' '
    And param size = ' '
    And param sortparam = ' '
    When method get
    Then status 400
    And karate.log('Status : 400')
    And karate.log('Test Completed !')
    
 
  #REV2-17794
  Scenario: GET - Verify super admin user can fetch request for campaign with valid value in search parameter
  
    Given path '/campaigns'
    And param page = 0
    And param simplesearchvalue = 'test'
    And param size = 10
    And param sortparam = 'campaign.updatedAt:DESC'
    When method get
    Then status 200
    And karate.log('Status : 200')
    And karate.log('Test Completed !')
    
  
  #REV2-17795
  Scenario: GET - Verify super admin user can fetch request for campaign with invalid value in search parameter
  
    Given path '/campaigns'
    And param page = 0
    And param simplesearchvalue = 'test@123%26**('
    And param size = 10
    And param sortparam = 'campaign.updatedAt:DESC'
    When method get
    Then status 200
    And karate.log('Status : 200')
    And karate.log('Test Completed !')
    
   
  #REV2-17796
  Scenario: GET - Verify super admin user can fetch request for campaign with blank value in search parameter
  
    Given path '/campaigns'
    And param page = 0
    And param simplesearchvalue = ''
    And param size = 10
    And param sortparam = 'campaign.updatedAt:DESC'
    When method get
    Then status 200
    And karate.log('Status : 200')
    And karate.log('Test Completed !')
    
    
  #REV2-17797
  Scenario: GET - Verify super admin user can fetch request for campaign with special character in search parameter
  
    Given path '/campaigns'
    And param page = 0
    And param simplesearchvalue = '%23%23$%^%26**('
    And param size = 10
    And param sortparam = 'campaign.updatedAt:DESC'
    When method get
    Then status 200
    And karate.log('Status : 200')
    And karate.log('Test Completed !')
    
	  
  #REV2-17798
  Scenario: GET - Verify super admin user can fetch request for campaign with valid integer page value
  
    Given path '/campaigns'
    And param page = 10
    And param simplesearchvalue = 'emailtest'
    And param size = 20
    And param sortparam = 'updatedAt:desc'
    When method get
    Then status 200
    And karate.log('Status : 200')
    And karate.log('Test Completed !')
    
  
  #REV2-17799
  Scenario: GET - Verify super admin user can fetch request for campaign with invalid integer page value
  
    Given path '/campaigns'
    And param page = '7777'
    And param simplesearchvalue = 'emailtest'
    And param size = 10
    And param sortparam = 'updatedAt:desc'
    When method get
    Then status 200
    And karate.log('Status : 200')
    And karate.log('Test Completed !')
    

  #REV2-17800
  Scenario: GET - Verify super admin user can fetch request for campaign with blank page value
  
    Given path '/campaigns'
    And param page = ' '
    And param simplesearchvalue = 'emailtest'
    And param size = 10
    And param sortparam = 'updatedAt:desc'
    When method get
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message contains "invalid.value.forpage"
    And karate.log('Test Completed !')
    
   
  #REV2-17801
  Scenario: GET - Verify super admin user can fetch request for campaign with special characters in page value
  
    Given path '/campaigns'
    And param page = '@%23$%^^%26%26'
    And param simplesearchvalue = 'emailtest'
    And param size = 20
    And param sortparam = 'updatedAt:desc'
    When method get
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message contains "invalid.value.forpage"
    And karate.log('Test Completed !')
    
  
	#REV2-17802
  Scenario: GET - Verify super admin user can fetch request for campaign with valid value in sortparam
  
    Given path '/campaigns'
    And param page = 0
    And param simplesearchvalue = 'emailtest'
    And param size = 10
    And param sortparam = 'updatedAt:desc'
    When method get
    Then status 200
    And karate.log('Status : 200')
    And karate.log('Test Completed !')
    
  
	#REV2-17803
  Scenario: GET - Verify super admin user can fetch request for campaign with blank value in sortparam
  
    Given path '/campaigns'
    And param page = 0
    And param simplesearchvalue = 'emailtest'
    And param size = 10
    And param sortparam = ' '
    When method get
    Then status 200
    And karate.log('Status : 200')
    And karate.log('Test Completed !')
    
    
  #REV2-17804
  Scenario: GET - Verify super admin user can fetch request for campaign with invalid value in sortparam
  
    Given path '/campaigns'
    And param page = 0
    And param simplesearchvalue = 'emailtest'
    And param size = 10
    And param sortparam = 'FDFDGDGH@%23$%%'
    When method get
    Then status 200
    And karate.log('Status : 200')
    And karate.log('Test Completed !')
    
  
  #REV2-17805
  Scenario: GET - Verify super admin user can fetch request for campaign with valid value in sortparam using last updated stamp
  
    Given path '/campaigns'
    And param page = 0
    And param simplesearchvalue = 'emailtest'
    And param size = 10
    And param sortparam = 'updatedAt:desc'
    When method get
    Then status 200
    And karate.log('Status : 200')
    And karate.log('Test Completed !')
    
  
  #REV2-17806
  Scenario: GET - Verify super admin user can fetch request for campaign with blank size
  
    Given path '/campaigns'
    And param page = 0
    And param simplesearchvalue = 'emailtest'
    And param size = ' '
    And param sortparam = 'updatedAt:desc'
    When method get
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message contains "invalid.value.forsize"
    And karate.log('Test Completed !')
    
 
  #REV2-17807
  Scenario: GET - Verify super admin user can fetch request for campaign with invalid size
  
    Given path '/campaigns'
    And param page = 0
    And param simplesearchvalue = 'emailtest'
    And param size = 1233444
    And param sortparam = 'updatedAt:desc'
    When method get
    Then status 200
    And karate.log('Status : 200')
    And karate.log('Test Completed !')
    
   
  #REV2-17808
  Scenario: GET - Verify super admin user can fetch request for campaign with valid size
  
    Given path '/campaigns'
    And param page = 0
    And param simplesearchvalue = 'emailtest'
    And param size = 10
    And param sortparam = 'updatedAt:desc'
    When method get
    Then status 200
    And karate.log('Status : 200')
    And karate.log('Test Completed !')
    
   
  #REV2-17809
  Scenario: GET - Verify super admin user can fetch request for campaign with string value in size
  
    Given path '/campaigns'
    And param page = 0
    And param simplesearchvalue = 'emailtest'
    And param size = 'aaavvc'
    And param sortparam = 'updatedAt:desc'
    When method get
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message contains "invalid.value.forsize"
    And karate.log('Test Completed !')
    
  
  #REV2-17810
  Scenario: GET - Verify super admin user cannot fetch request for campaign with special character in size
  
    Given path '/campaigns'
    And param page = 0
    And param simplesearchvalue = 'emailtest'
    And param size = '@#$%^^&&' 
    And param sortparam = 'updatedAt:desc'
    When method get
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message contains "invalid.value.forsize"
    And karate.log('Test Completed !')
    
	
  #REV2-17811
  Scenario: GET - Verify super admin user can fetch request for campaign with valid campaignid
    
    Given path '/campaigns/' + campaignId
    When method get
    Then status 200
    And karate.log('Status : 200')
    And karate.log('Test Completed !')
    
	
  #REV2-17812/REV2-17814
  Scenario: GET - Verify super admin user can fetch request for campaign with invalid campaignid
  
    Given path  '/campaigns/' + invalidcampaignId
    When method get
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message contains "Campaign Id is not having proper format"
    And karate.log('Test Completed !')
    
  
  #REV2-17813
  Scenario: GET - Verify super admin user can fetch request for campaign with blank campaignid
  
  	Given param campaignId = ''
    And path '/campaigns/' + campaignId 
    And param page = 0
    And param simplesearchvalue = 'emailtest'
    And param size = 10
    And param sortparam = 'updatedAt:desc'
    When method get
    Then status 200
    And karate.log('Status : 200')
    And karate.log('Test Completed !')
    
    
    
  
    
   
    
    
    