Feature: Kitchen Module campaign CRUD scenarios with Super Admin

  Background: 
  
    Given url backOfficeAPIBaseUrl
    And header Accept = 'application/json'
    And path '/kitchen/v1/campaigns'
    
    * def loginResult = callonce read('classpath:com/fnp/api/utils/generate-token.feature') {userType:'kitchenAdmin'}
    * def authToken = loginResult.accessToken
    * header Authorization = authToken
    
    * def requestPayloadCreate = read('classpath:com/fnp/api/backoffice/data/kitchen/create-campaign.json')
    * def requestPayloadEdit = read('classpath:com/fnp/api/backoffice/data/kitchen/edit-campaign.json')
    
    * def today = new java.util.Date().time
    * def num = today + ""
    * def num = num.substring(8)
    
    * def validCampaignId = "U_04657"
    * def invalidCampaignId = "$#@&*^$$"
    

  #REV2-18987
  Scenario: POST - Verify Super admin to create campaign with all invalid data
    
    * eval requestPayloadCreate.campaign.name = "$%&&&%^#@"
    * eval requestPayloadCreate.campaign.campaignDomainId = num
    
    * karate.log(requestPayloadCreate)
    
    Given request requestPayloadCreate
    When method post
    Then status 400
    And karate.log('Response is : ', response)
    And karate.log('Status : 400')
    And match response.errors[*].message contains "Geo id is invalid"
    And match response.errors[*].message contains "Domain is invalid"
    And karate.log('Test Completed !')


  #REV2-18988
  Scenario: POST - Verify Super admin to create campaign with all blank data
    
    * eval requestPayloadCreate.campaign.name = ""
    * eval requestPayloadCreate.campaign.currencyId = ""
    * eval requestPayloadCreate.campaign.frequency = ""
    * eval requestPayloadCreate.campaign.geoId = ""
    * eval requestPayloadCreate.campaign.publisherId = ""
    * eval requestPayloadCreate.campaign.campaignDomainId = ""
    
    * karate.log(requestPayloadCreate)
    
    Given request requestPayloadCreate
    When method post
    Then status 400
    And karate.log('Response is : ', response)
    And karate.log('Status : 400')
    And match response.errors[0].message contains "Invalid input data"
    And karate.log('Test Completed !')

	
  #REV2-18989
  Scenario: POST - Verify Super admin to create campaign with invalid fieldId
    
    * eval requestPayloadCreate.andConditions[0].orConditions[0].fieldId = num
    
    * karate.log(requestPayloadCreate)
    
    Given request requestPayloadCreate
    When method post
    Then status 400
    And karate.log('Response is : ', response)
    And karate.log('Status : 400')
    And match response.errors[0].errorCode contains "INVALID_DATA"
    And karate.log('Test Completed !')
    

  #REV2-18990
  Scenario: POST - Verify Super admin to create campaign with blank fieldId
    
    * eval requestPayloadCreate.andConditions[0].orConditions[0].fieldId = ""
    
    * karate.log(requestPayloadCreate)
    
    Given request requestPayloadCreate
    When method post
    Then status 400
    And karate.log('Response is : ', response)
    And karate.log('Status : 400')
    And match response.errors[*].message contains "must not be blank"
    And karate.log('Test Completed !')
    
    
	#REV2-18994
  Scenario: POST - Verify Super admin to create campaign with invalid fieldOperand
    
    * eval requestPayloadCreate.andConditions[0].orConditions[0].fieldOperand = "$%&&&%^#@"
    
    * karate.log(requestPayloadCreate)
    
    Given request requestPayloadCreate
    When method post
    Then status 400
    And karate.log('Response is : ', response)
    And karate.log('Status : 400')
    And karate.log('Test Completed !')
    

  #REV2-18995
  Scenario: POST - Verify Super admin to create campaign with blank fieldOperand
    
    * eval requestPayloadCreate.andConditions[0].orConditions[0].fieldOperand = ""
    
    * karate.log(requestPayloadCreate)
    
    Given request requestPayloadCreate
    When method post
    Then status 400
    And karate.log('Response is : ', response)
    And karate.log('Status : 400')
    And match response.errors[*].message contains "must not be blank"
    And karate.log('Test Completed !')
    
	
	#REV2-18996
  Scenario: POST - Verify Super admin to create campaign with invalid fieldOperator
    
    * eval requestPayloadCreate.campaign.name = requestPayloadCreate.campaign.name + num
    * eval requestPayloadCreate.andConditions[0].orConditions[0].fieldOperator = "$%&&&%^#@"
    
    * karate.log(requestPayloadCreate)
    
    Given request requestPayloadCreate
    When method post
    Then status 400
    And karate.log('Response is : ', response)
    And karate.log('Status : 400')
    And match response.errors[0].message contains "Field Operator is invalid"
    And karate.log('Test Completed !')
    
	
  #REV2-18997
  Scenario: POST - Verify Super admin to create campaign with blank fieldOperator
    
    * eval requestPayloadCreate.campaign.name = requestPayloadCreate.campaign.name + num
    * eval requestPayloadCreate.andConditions[0].orConditions[0].fieldOperator = ""
    
    * karate.log(requestPayloadCreate)
    
    Given request requestPayloadCreate
    When method post
    Then status 400
    And karate.log('Response is : ', response)
    And karate.log('Status : 400')
    And match response.errors[0].message contains "Field Operator is invalid"
    And karate.log('Test Completed !')
    
	
  #REV2-19001
  Scenario: POST - Verify Super admin to create campaign with blank CampaignName
    
    * eval requestPayloadCreate.campaign.name = ""
    
    * karate.log(requestPayloadCreate)
    
    Given request requestPayloadCreate
    When method post
    Then status 400
    And karate.log('Response is : ', response)
    And karate.log('Status : 400')
    And match response.errors[0].message contains "must not be blank"
    And karate.log('Test Completed !')
    

  #REV2-19002
  Scenario: POST - Verify Super admin to create campaign with duplicate CampaignName
        
    * karate.log(requestPayloadCreate)
    
    Given request requestPayloadCreate
    When method post
    Then status 400
    And karate.log('Response is : ', response)
    And karate.log('Status : 400')
    And match response.errors[0].message contains "Campaign name already exist"
    And karate.log('Test Completed !')
	
	
  #REV2-19003
  Scenario: POST - Verify Super admin to create campaign with invalid CampaignName
    
    * eval requestPayloadCreate.campaign.name = null
    
    * karate.log(requestPayloadCreate)
    
    Given request requestPayloadCreate
    When method post
    Then status 400
    And karate.log('Response is : ', response)
    And karate.log('Status : 400')
    And match response.errors[0].errorCode contains "INVALID_DATA"
    And karate.log('Test Completed !')
    
	
	#REV2-19004
  Scenario: POST - Verify Super admin to create campaign with blank currencyId
    
    * eval requestPayloadCreate.campaign.currencyId = ""
    
    * karate.log(requestPayloadCreate)
    
    Given request requestPayloadCreate
    When method post
    Then status 400
    And karate.log('Response is : ', response)
    And karate.log('Status : 400')
    And match response.errors[0].message contains "kitchen.currency.invalid"
    And karate.log('Test Completed !')
    

  #REV2-19005
  Scenario: POST - Verify Super admin to create campaign with invalid currencyId
    
    * eval requestPayloadCreate.campaign.currencyId = "ABC123"    
    * karate.log(requestPayloadCreate)
    
    Given request requestPayloadCreate
    When method post
    Then status 400
    And karate.log('Response is : ', response)
    And karate.log('Status : 400')
    And match response.errors[0].message contains "kitchen.currency.invalid"
    And karate.log('Test Completed !')
	
	
  #REV2-19006
  Scenario: POST - Verify Super admin to create campaign with multiple currencyId
    
    * eval requestPayloadCreate.campaign.currencyId = "INR,USD"
    
    * karate.log(requestPayloadCreate)
    
    Given request requestPayloadCreate
    When method post
    Then status 400
    And karate.log('Response is : ', response)
    And karate.log('Status : 400')
    And match response.errors[0].errorCode contains "INVALID_DATA"
    And karate.log('Test Completed !')
    
		
  Scenario: POST - Verify currencyId length validation for Super admin 
    
    * eval requestPayloadCreate.campaign.currencyId = "USDR"
    
    * karate.log(requestPayloadCreate)
    
    Given request requestPayloadCreate
    When method post
    Then status 400
    And karate.log('Response is : ', response)
    And karate.log('Status : 400')
    And match response.errors[0].errorCode contains "INVALID_DATA"
    And karate.log('Test Completed !')
    
	
	#REV2-19007
  Scenario: POST - Verify Super admin to create campaign with blank campaignDomainId
    
    * eval requestPayloadCreate.campaign.campaignDomainId = ""
    
    * karate.log(requestPayloadCreate)
    
    Given request requestPayloadCreate
    When method post
    Then status 400
    And karate.log('Response is : ', response)
    And karate.log('Status : 400')
    And match response.errors[0].message contains "must not be blank"
    And karate.log('Test Completed !')
    
	
  #REV2-19008
  Scenario: POST - Verify Super admin to create campaign with invalid campaignDomainId
    
    * eval requestPayloadCreate.campaign.name = requestPayloadCreate.campaign.name + num
    * eval requestPayloadCreate.campaign.campaignDomainId = "ABC123"    
    * karate.log(requestPayloadCreate)
    
    Given request requestPayloadCreate
    When method post
    Then status 400
    And karate.log('Response is : ', response)
    And karate.log('Status : 400')
    And match response.errors[*].message contains "Domain is invalid"
    And karate.log('Test Completed !')
	
	
  #REV2-19009
  Scenario: POST - Verify Super admin to create campaign with multiple campaignDomainId
    
    * eval requestPayloadCreate.campaign.name = requestPayloadCreate.campaign.name + num
    * eval requestPayloadCreate.campaign.campaignDomainId = "fnp.com,fnp1.com"
    
    * karate.log(requestPayloadCreate)
    
    Given request requestPayloadCreate
    When method post
    Then status 400
    And karate.log('Response is : ', response)
    And karate.log('Status : 400')
    And match response.errors[*].message contains "Domain is invalid"
    And karate.log('Test Completed !')
    
	
	#REV2-19010
  Scenario: POST - Verify Super admin to create campaign with blank frequency
    
    * eval requestPayloadCreate.campaign.frequency = ""
    
    * karate.log(requestPayloadCreate)
    
    Given request requestPayloadCreate
    When method post
    Then status 400
    And karate.log('Response is : ', response)
    And karate.log('Status : 400')
    And match response.errors[0].message contains "Invalid input data"
    And karate.log('Test Completed !')
    
	
  #REV2-19011
  Scenario: POST - Verify Super admin to create campaign with invalid frequency
    
    * eval requestPayloadCreate.campaign.name = requestPayloadCreate.campaign.name + num
    * eval requestPayloadCreate.campaign.frequency = "ABC123"    
    * karate.log(requestPayloadCreate)
    
    Given request requestPayloadCreate
    When method post
    Then status 400
    And karate.log('Response is : ', response)
    And karate.log('Status : 400')
    And match response.errors[*].message contains "Invalid input data"
    And karate.log('Test Completed !')
    
	
	#REV2-19012
  Scenario: POST - Verify Super admin to create campaign with invalid geoId
    
    * eval requestPayloadCreate.campaign.name = requestPayloadCreate.campaign.name + num
    * eval requestPayloadCreate.campaign.geoId = "ABC123"    
    * karate.log(requestPayloadCreate)
    
    Given request requestPayloadCreate
    When method post
    Then status 400
    And karate.log('Response is : ', response)
    And karate.log('Status : 400')
    And match response.errors[*].message contains "Geo id is invalid"
    And karate.log('Test Completed !')
	
	
	#REV2-19013
  Scenario: POST - Verify Super admin to create campaign with blank geoId
    
    * eval requestPayloadCreate.campaign.geoId = ""
    
    * karate.log(requestPayloadCreate)
    
    Given request requestPayloadCreate
    When method post
    Then status 400
    And karate.log('Response is : ', response)
    And karate.log('Status : 400')
    And match response.errors[*].message contains "must not be blank"
    And karate.log('Test Completed !')
    

  #REV2-19014
  Scenario: POST - Verify Super admin to create campaign with multiple geoId
    
    * eval requestPayloadCreate.campaign.name = requestPayloadCreate.campaign.name + num
    * eval requestPayloadCreate.campaign.geoId = "india,japan"
    
    * karate.log(requestPayloadCreate)
    
    Given request requestPayloadCreate
    When method post
    Then status 400
    And karate.log('Response is : ', response)
    And karate.log('Status : 400')
    And match response.errors[*].message contains "Geo id is invalid"
    And karate.log('Test Completed !')
    
	
  #REV2-19015
  Scenario: POST - Verify Super admin to create campaign with select All geoId
    
    * eval requestPayloadCreate.campaign.name = requestPayloadCreate.campaign.name + num
    * eval requestPayloadCreate.campaign.geoId = "ALL"
    
    * karate.log(requestPayloadCreate)
    
    Given request requestPayloadCreate
    When method post
    Then status 201
    And karate.log('Response is : ', response)
    And karate.log('Status : 201')
    And karate.log('Test Completed !')
    
	
	#REV2-19016
  Scenario: POST - Verify Super admin to create campaign with invalid publisherId
    
    * eval requestPayloadCreate.campaign.name = requestPayloadCreate.campaign.name + num
    * eval requestPayloadCreate.campaign.publisherId = "ABC123"    
    * karate.log(requestPayloadCreate)
    
    Given request requestPayloadCreate
    When method post
    Then status 400
    And karate.log('Response is : ', response)
    And karate.log('Status : 400')
    And match response.errors[*].message contains "kitchen.publisherId.invalid"
    And karate.log('Test Completed !')
	
	
	#REV2-19017
  Scenario: POST - Verify Super admin to create campaign with blank publisherId
    
    * eval requestPayloadCreate.campaign.publisherId = ""
    
    * karate.log(requestPayloadCreate)
    
    Given request requestPayloadCreate
    When method post
    Then status 400
    And karate.log('Response is : ', response)
    And karate.log('Status : 400')
    And match response.errors[*].message contains "must not be blank"
    And karate.log('Test Completed !')
    
	
  #REV2-19018
  Scenario: POST - Verify Super admin to create campaign with multiple publisherId
    
    * eval requestPayloadCreate.campaign.name = requestPayloadCreate.campaign.name + num
    * eval requestPayloadCreate.campaign.publisherId = "P_01423,P_01424"
    
    * karate.log(requestPayloadCreate)
    
    Given request requestPayloadCreate
    When method post
    Then status 400
    And karate.log('Response is : ', response)
    And karate.log('Status : 400')
    And match response.errors[*].message contains "kitchen.publisherId.invalid"
    And karate.log('Test Completed !')
    
	
	#REV2-19019
  Scenario: POST - Verify Super admin to create campaign with invalid time
    
    * eval requestPayloadCreate.campaign.name = requestPayloadCreate.campaign.name + num
    * eval requestPayloadCreate.campaign.time = "@#@#"    
    * karate.log(requestPayloadCreate)
    
    Given request requestPayloadCreate
    When method post
    Then status 400
    And karate.log('Response is : ', response)
    And karate.log('Status : 400')
    And match response.errors[*].message contains "kitchen.time.format.invalid"
    And karate.log('Test Completed !')
	

	#REV2-19020
  Scenario: POST - Verify Super admin to create campaign with blank time
    
    * eval requestPayloadCreate.campaign.name = requestPayloadCreate.campaign.name + num
    * eval requestPayloadCreate.campaign.time = ""
    
    * karate.log(requestPayloadCreate)
    
    Given request requestPayloadCreate
    When method post
    Then status 201
    And karate.log('Response is : ', response)
    And karate.log('Status : 201')
    And karate.log('Test Completed !')
    
	
	#REV2-19021
  Scenario: POST - Verify Super admin to create campaign with invalid repeat
    
    * eval requestPayloadCreate.campaign.name = requestPayloadCreate.campaign.name + num
    * eval requestPayloadCreate.campaign.frequency = "WEEKLY"
    * eval requestPayloadCreate.campaign.repeat = "@#@#"    
    * karate.log(requestPayloadCreate)
    
    Given request requestPayloadCreate
    When method post
    Then status 400
    And karate.log('Response is : ', response)
    And karate.log('Status : 400')
    And match response.errors[*].message contains "Repeat is invalid"
    And karate.log('Test Completed !')
	
	
	#REV2-19022
  Scenario: POST - Verify Super admin to create campaign with blank repeat
    
    * eval requestPayloadCreate.campaign.name = requestPayloadCreate.campaign.name + num
    * eval requestPayloadCreate.campaign.frequency = "WEEKLY"
    * eval requestPayloadCreate.campaign.repeat = ""
    
    * karate.log(requestPayloadCreate)
    
    Given request requestPayloadCreate
    When method post
    Then status 400
    And karate.log('Response is : ', response)
    And karate.log('Status : 400')
    And match response.errors[*].message contains "Repeat is invalid"
    And karate.log('Test Completed !')
    
	
	#REV2-19023
  Scenario: POST - Verify Super admin to create campaign with frequency and repeat set correctly
    
    * eval requestPayloadCreate.campaign.name = requestPayloadCreate.campaign.name + num
    * eval requestPayloadCreate.campaign.frequency = "MONTHLY"
    * eval requestPayloadCreate.campaign.repeat = "15TH"
    * eval requestPayloadCreate.campaign.time = "11:00 AM"
    
    * karate.log(requestPayloadCreate)
    
    Given request requestPayloadCreate
    When method post
    Then status 201
    And karate.log('Response is : ', response)
    And karate.log('Status : 201')
    And karate.log('Test Completed !')
    

	#REV2-19024
  Scenario: POST - Verify repeat with frequency set to daily for Super admin to create campaign
    
    * eval requestPayloadCreate.campaign.name = requestPayloadCreate.campaign.name + num
    * eval requestPayloadCreate.campaign.frequency = "DAILY"
    * eval requestPayloadCreate.campaign.repeat = "15TH"
    
    * karate.log(requestPayloadCreate)
    
    Given request requestPayloadCreate
    When method post
    Then status 400
    And karate.log('Response is : ', response)
    And karate.log('Status : 400')
    And match response.errors[*].message contains "Repeat should be empty in case of Daily and Hourly"
    And karate.log('Test Completed !')
    

	#REV2-18717 and REV2-18720 
  Scenario: PUT - Verify Super admin to edit existing campaign with valid data
    
    * eval requestPayloadEdit.campaign.name = "Diwali" + num
    
    * karate.log(requestPayloadEdit)
    
    Given path '/' + validCampaignId
    And request requestPayloadEdit
    When method put
    Then status 202
    And karate.log('Response is : ', response)
    And karate.log('Status : 202')
    And match response.campaign.name == requestPayloadEdit.campaign.name
    And karate.log('Test Completed !')
	
	
	#REV2-18718
  Scenario: PUT - Verify Super admin to edit campaign with all invalid data
    
    * eval requestPayloadEdit.campaign.name = "$%&&&%^#@"
    * eval requestPayloadEdit.campaign.frequency = num
    
    * karate.log(requestPayloadEdit)
    
    Given path '/' + validCampaignId
    And request requestPayloadEdit
    When method put
    Then status 400
    And karate.log('Response is : ', response)
    And karate.log('Status : 400')
    And match response.errors[*].message contains "Invalid input data"
    And karate.log('Test Completed !')


  #REV2-18719
  Scenario: PUT - Verify Super admin to edit campaign with all blank data
    
    * eval requestPayloadEdit.campaign.name = ""
    * eval requestPayloadEdit.campaign.frequency = ""
    
    * karate.log(requestPayloadEdit)
    
    Given path '/' + validCampaignId
    And request requestPayloadEdit
    When method put
    Then status 400
    And karate.log('Response is : ', response)
    And karate.log('Status : 400')
    And match response.errors[0].message contains "Invalid input data"
    And karate.log('Test Completed !')


  #REV2-18721
  Scenario: PUT - Verify Super admin to edit campaign with invalid campaignId
    
    * eval requestPayloadEdit.campaign.name = "Diwali" + num
    
    * karate.log(requestPayloadEdit)
    
    Given path '/' + invalidCampaignId
    And request requestPayloadEdit
    When method put
    Then status 400
    And karate.log('Response is : ', response)
    And karate.log('Status : 400')
    And match response.errors[0].message contains "Campaign Id is not having proper format"
    And karate.log('Test Completed !')
    
	
  #REV2-18722
  Scenario: PUT - Verify Super admin to edit campaign with blank campaignId
    
    * def blankCampaignId = " "
    * eval requestPayloadEdit.campaign.name = "Diwali" + num
    
    * karate.log(requestPayloadEdit)
    
    Given path '/' + blankCampaignId
    And request requestPayloadEdit
    When method put
    Then status 400
    And karate.log('Response is : ', response)
    And karate.log('Status : 400')
    And match response.errors[*].message contains "Campaign Id is not having proper format"
    And karate.log('Test Completed !')


	#REV2-18723
  Scenario: PUT - Verify Super admin to edit campaign with non existing campaignId
    
    * def nonExistingCampaignId = "U_00000"
    * eval requestPayloadEdit.campaign.name = "Diwali" + num
    
    * karate.log(requestPayloadEdit)
    
    Given path '/' + nonExistingCampaignId
    And request requestPayloadEdit
    When method put
    Then status 404
    And karate.log('Response is : ', response)
    And karate.log('Status : 404')
    And match response.errors[0].message contains "Campaign Id doesn't exist"
    And karate.log('Test Completed !')  

    
	#REV2-18724
  Scenario: PUT - Verify Super admin to edit campaign with blank campaign name
    
    * eval requestPayloadEdit.campaign.name = " "
    
    * karate.log(requestPayloadEdit)
    
    Given path '/' + validCampaignId
    And request requestPayloadEdit
    When method put
    Then status 400
    And karate.log('Response is : ', response)
    And karate.log('Status : 400')
    And match response.errors[*].message contains "must not be blank"
    And karate.log('Test Completed !')
    
	    
	#REV2-18725
  Scenario: PUT - Verify Super admin to edit campaign with invalid campaign name
    
    * eval requestPayloadEdit.campaign.name = null
    
    * karate.log(requestPayloadEdit)
    
    Given path '/' + validCampaignId
    And request requestPayloadEdit
    When method put
    Then status 400
    And karate.log('Response is : ', response)
    And karate.log('Status : 400')
    And match response.errors[*].errorCode contains "INVALID_DATA"
    And karate.log('Test Completed !')
  
      
	#REV2-18726
  Scenario: PUT - Verify Super admin to edit campaign with duplicate campaign name
    
    * karate.log(requestPayloadEdit)
    
    Given path '/' + validCampaignId
    And request requestPayloadEdit
    When method put
    Then status 400
    And karate.log('Response is : ', response)
    And karate.log('Status : 400')
    And match response.errors[*].message contains "Campaign name already exist"
    And karate.log('Test Completed !')
  
    
  #REV2-18731
  Scenario: PUT - Verify Super admin to edit campaign with invalid fieldId
    
    * eval requestPayloadEdit.campaign.name = "Diwali" + num
    * eval requestPayloadEdit.andConditions[0].orConditions[0].fieldId = num
    
    * karate.log(requestPayloadEdit)
    
    Given path '/' + validCampaignId
    And request requestPayloadEdit
    When method put
    Then status 400
    And karate.log('Response is : ', response)
    And karate.log('Status : 400')
    And match response.errors[*].errorCode contains "INVALID_DATA"
    And karate.log('Test Completed !')    
  
    
  #REV2-18732
  Scenario: PUT - Verify Super admin to edit campaign with blank fieldId
    
    * eval requestPayloadEdit.campaign.name = "Diwali" + num
    * eval requestPayloadEdit.andConditions[0].orConditions[0].fieldId = " "
    
    * karate.log(requestPayloadEdit)
    
    Given path '/' + validCampaignId
    And request requestPayloadEdit
    When method put
    Then status 400
    And karate.log('Response is : ', response)
    And karate.log('Status : 400')
    And match response.errors[*].message contains "must not be blank"
    And karate.log('Test Completed !')    
  
  
  #REV2-18736
  Scenario: PUT - Verify Super admin to edit campaign with invalid fieldOperand
    
    * eval requestPayloadEdit.campaign.name = "Diwali" + num
    * eval requestPayloadEdit.andConditions[0].orConditions[0].fieldOperand = null
    
    * karate.log(requestPayloadEdit)
    
    Given path '/' + validCampaignId
    And request requestPayloadEdit
    When method put
    Then status 400
    And karate.log('Response is : ', response)
    And karate.log('Status : 400')
    And karate.log('Test Completed !')    
  
    
  #REV2-18737
  Scenario: PUT - Verify Super admin to edit campaign with blank fieldOperand
    
    * eval requestPayloadEdit.campaign.name = "Diwali" + num
    * eval requestPayloadEdit.andConditions[0].orConditions[0].fieldOperand = " "
    
    * karate.log(requestPayloadEdit)
    
    Given path '/' + validCampaignId
    And request requestPayloadEdit
    When method put
    Then status 400
    And karate.log('Response is : ', response)
    And karate.log('Status : 400')
    And match response.errors[*].message contains "must not be blank"
    And karate.log('Test Completed !')    
  
  
  #REV2-18738
  Scenario: PUT - Verify Super admin to edit campaign with invalid fieldOperator
    
    * eval requestPayloadEdit.campaign.name = "Diwali" + num
    * eval requestPayloadEdit.andConditions[0].orConditions[0].fieldOperator = "$%^&#@#$"
    
    * karate.log(requestPayloadEdit)
    
    Given path '/' + validCampaignId
    And request requestPayloadEdit
    When method put
    Then status 400
    And karate.log('Response is : ', response)
    And karate.log('Status : 400')
    And match response.errors[0].message contains "Field Operator is invalid"
    And karate.log('Test Completed !')    
  
    
  #REV2-18739
  Scenario: PUT - Verify Super admin to edit campaign with blank fieldOperator
    
    * eval requestPayloadEdit.campaign.name = "Diwali" + num
    * eval requestPayloadEdit.andConditions[0].orConditions[0].fieldOperator = " "
    
    * karate.log(requestPayloadEdit)
    
    Given path '/' + validCampaignId
    And request requestPayloadEdit
    When method put
    Then status 400
    And karate.log('Response is : ', response)
    And karate.log('Status : 400')
    And match response.errors[0].message contains "Field Operator is invalid"
    And karate.log('Test Completed !')
    
	
	#REV2-18743
  Scenario: PUT - Verify Super admin to edit campaign with blank frequency
    
    * eval requestPayloadEdit.campaign.frequency = " "
    
    * karate.log(requestPayloadEdit)
    
    Given path '/' + validCampaignId
    And request requestPayloadEdit
    When method put
    Then status 400
    And karate.log('Response is : ', response)
    And karate.log('Status : 400')
    And match response.errors[*].message contains "Invalid input data"
    And karate.log('Test Completed !')    
  
  
  
	#REV2-18744
  Scenario: PUT - Verify Super admin to edit campaign with invalid frequency
    
    * eval requestPayloadEdit.campaign.frequency = "ABC123"
    
    * karate.log(requestPayloadEdit)
    
    Given path '/' + validCampaignId
    And request requestPayloadEdit
    When method put
    Then status 400
    And karate.log('Response is : ', response)
    And karate.log('Status : 400')
    And match response.errors[*].message contains "Invalid input data"
    And karate.log('Test Completed !')
    
	
	#REV2-18745
  Scenario: PUT - Verify Super admin to edit campaign with invalid time
    
    * eval requestPayloadEdit.campaign.time = "ABC123"
    
    * karate.log(requestPayloadEdit)
    
    Given path '/' + validCampaignId
    And request requestPayloadEdit
    When method put
    Then status 400
    And karate.log('Response is : ', response)
    And karate.log('Status : 400')
    And match response.errors[*].message contains "kitchen.time.format.invalid"
    And karate.log('Test Completed !')
    
	
	#REV2-18746
  Scenario: PUT - Verify Super admin to edit campaign with blank time
    
    * eval requestPayloadEdit.campaign.time = " "
    
    * karate.log(requestPayloadEdit)
    
    Given path '/' + validCampaignId
    And request requestPayloadEdit
    When method put
    Then status 400
    And karate.log('Response is : ', response)
    And karate.log('Status : 400')
    And match response.errors[*].message contains "kitchen.time.format.invalid"
    And karate.log('Test Completed !')
    
	
	#REV2-18747
  Scenario: PUT - Verify Super admin to edit campaign with invalid repeat
    
    * eval requestPayloadEdit.campaign.name = "Diwali" + num
    * eval requestPayloadEdit.campaign.frequency = "WEEKLY"
    * eval requestPayloadEdit.campaign.repeat = "@#@#"
    
    * karate.log(requestPayloadEdit)
    
    Given path '/' + validCampaignId
    And request requestPayloadEdit
    When method put
    Then status 400
    And karate.log('Response is : ', response)
    And karate.log('Status : 400')
    And match response.errors[*].message contains "Repeat is invalid"
    And karate.log('Test Completed !')
    

	#REV2-18748
  Scenario: PUT - Verify Super admin to edit campaign with blank repeat
    
    * eval requestPayloadEdit.campaign.name = "Diwali" + num
    * eval requestPayloadEdit.campaign.frequency = "WEEKLY"
    * eval requestPayloadEdit.campaign.repeat = ""
    
    * karate.log(requestPayloadEdit)
    
    Given path '/' + validCampaignId
    And request requestPayloadEdit
    When method put
    Then status 400
    And karate.log('Response is : ', response)
    And karate.log('Status : 400')
    And match response.errors[*].message contains "Repeat is invalid"
    And karate.log('Test Completed !')
    
	
	#REV2-18749
  Scenario: PUT - Verify Super admin to edit campaign with frequency and repeat set correctly
    
    * eval requestPayloadEdit.campaign.name = "Diwali" + num
    * eval requestPayloadEdit.campaign.frequency = "MONTHLY"
    * eval requestPayloadEdit.campaign.repeat = "17TH"
    * eval requestPayloadEdit.campaign.time = "10:00 AM"
    
    * karate.log(requestPayloadEdit)
    
    Given path '/' + validCampaignId
    And request requestPayloadEdit
    When method put
    Then status 202
    And karate.log('Response is : ', response)
    And karate.log('Status : 202')
    And karate.log('Test Completed !')
    
	
	#REV2-18750
  Scenario: PUT - Verify repeat with frequency set to daily for Super admin to edit campaign
    
    * eval requestPayloadEdit.campaign.name = "Diwali" + num
    * eval requestPayloadEdit.campaign.frequency = "DAILY"
    * eval requestPayloadEdit.campaign.repeat = "15TH"
    
    * karate.log(requestPayloadEdit)
    
    Given path '/' + validCampaignId
    And request requestPayloadEdit
    When method put
    Then status 400
    And karate.log('Response is : ', response)
    And karate.log('Status : 400')
    And match response.errors[*].message contains "Repeat should be empty in case of Daily and Hourly"
    And karate.log('Test Completed !')
	