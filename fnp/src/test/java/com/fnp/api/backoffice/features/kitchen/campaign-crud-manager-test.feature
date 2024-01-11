Feature: Kitchen Module campaign CRUD scenarios with Manager role

  Background: 
  
    Given url backOfficeAPIBaseUrl
    And header Accept = 'application/json'
    And path '/kitchen/v1/campaigns'
    
    * def loginResult = callonce read('classpath:com/fnp/api/utils/generate-token.feature') {userType:'kitchenManager'}
    * def authToken = loginResult.accessToken
    * header Authorization = authToken
    
    * def requestPayloadCreate = read('classpath:com/fnp/api/backoffice/data/kitchen/create-campaign.json')
    * def requestPayloadEdit = read('classpath:com/fnp/api/backoffice/data/kitchen/edit-campaign.json')
    
    * def today = new java.util.Date().time
    * def num = today + ""
    * def num = num.substring(8)
    
    * def validCampaignId = "U_04657"
    * def invalidCampaignId = "$#@&*^$$"


  #REV2-19025
  Scenario: POST - Verify Kitchen Manager to create campaign with all invalid data
    
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


  #REV2-19026
  Scenario: POST - Verify Kitchen Manager to create campaign with all blank data
    
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

	
  #REV2-19027
  Scenario: POST - Verify Kitchen Manager to create campaign with invalid fieldId
    
    * eval requestPayloadCreate.andConditions[0].orConditions[0].fieldId = num
    
    * karate.log(requestPayloadCreate)
    
    Given request requestPayloadCreate
    When method post
    Then status 400
    And karate.log('Response is : ', response)
    And karate.log('Status : 400')
    And match response.errors[0].errorCode contains "INVALID_DATA"
    And karate.log('Test Completed !')
    

  #REV2-19028
  Scenario: POST - Verify Kitchen Manager to create campaign with blank fieldId
    
    * eval requestPayloadCreate.andConditions[0].orConditions[0].fieldId = ""
    
    * karate.log(requestPayloadCreate)
    
    Given request requestPayloadCreate
    When method post
    Then status 400
    And karate.log('Response is : ', response)
    And karate.log('Status : 400')
    And match response.errors[*].message contains "must not be blank"
    And karate.log('Test Completed !')
    
    
	#REV2-19032
  Scenario: POST - Verify Kitchen Manager to create campaign with invalid fieldOperand
    
    * eval requestPayloadCreate.andConditions[0].orConditions[0].fieldOperand = "$%&&&%^#@"
    
    * karate.log(requestPayloadCreate)
    
    Given request requestPayloadCreate
    When method post
    Then status 400
    And karate.log('Response is : ', response)
    And karate.log('Status : 400')
    And karate.log('Test Completed !')
    

  #REV2-19033
  Scenario: POST - Verify Kitchen Manager to create campaign with blank fieldOperand
    
    * eval requestPayloadCreate.andConditions[0].orConditions[0].fieldOperand = ""
    
    * karate.log(requestPayloadCreate)
    
    Given request requestPayloadCreate
    When method post
    Then status 400
    And karate.log('Response is : ', response)
    And karate.log('Status : 400')
    And match response.errors[*].message contains "must not be blank"
    And karate.log('Test Completed !')
    
	
	#REV2-19034
  Scenario: POST - Verify Kitchen Manager to create campaign with invalid fieldOperator
    
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
    
	
  #REV2-19035
  Scenario: POST - Verify Kitchen Manager to create campaign with blank fieldOperator
    
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
    
    
	#REV2-19038
  Scenario: POST - Verify Kitchen Manager to create campaign with correct fieldOperator
    
    * eval requestPayloadCreate.campaign.name = requestPayloadCreate.campaign.name + num
    * eval requestPayloadCreate.andConditions[0].orConditions[0].fieldOperator = "CONTAINS"
    
    * karate.log(requestPayloadCreate)
    
    Given request requestPayloadCreate
    When method post
    Then status 201
    And karate.log('Response is : ', response)
    And karate.log('Status : 201')
    And karate.log('Test Completed !')
    
    
  #REV2-19039
  Scenario: POST - Verify Kitchen Manager to create campaign with blank CampaignName
    
    * eval requestPayloadCreate.campaign.name = ""
    
    * karate.log(requestPayloadCreate)
    
    Given request requestPayloadCreate
    When method post
    Then status 400
    And karate.log('Response is : ', response)
    And karate.log('Status : 400')
    And match response.errors[0].message contains "must not be blank"
    And karate.log('Test Completed !')
    

  #REV2-19040
  Scenario: POST - Verify Kitchen Manager to create campaign with duplicate CampaignName
        
    * karate.log(requestPayloadCreate)
    
    Given request requestPayloadCreate
    When method post
    Then status 400
    And karate.log('Response is : ', response)
    And karate.log('Status : 400')
    And match response.errors[0].message contains "Campaign name already exist"
    And karate.log('Test Completed !')
	
	
  #REV2-19041
  Scenario: POST - Verify Kitchen Manager to create campaign with invalid CampaignName
    
    * eval requestPayloadCreate.campaign.name = null
    
    * karate.log(requestPayloadCreate)
    
    Given request requestPayloadCreate
    When method post
    Then status 400
    And karate.log('Response is : ', response)
    And karate.log('Status : 400')
    And match response.errors[0].errorCode contains "INVALID_DATA"
    And karate.log('Test Completed !')
    
	
	#REV2-19042
  Scenario: POST - Verify Kitchen Manager to create campaign with blank currencyId
    
    * eval requestPayloadCreate.campaign.currencyId = ""
    
    * karate.log(requestPayloadCreate)
    
    Given request requestPayloadCreate
    When method post
    Then status 400
    And karate.log('Response is : ', response)
    And karate.log('Status : 400')
    And match response.errors[0].message contains "kitchen.currency.invalid"
    And karate.log('Test Completed !')
    

  #REV2-19043
  Scenario: POST - Verify Kitchen Manager to create campaign with invalid currencyId
    
    * eval requestPayloadCreate.campaign.currencyId = "ABC123"    
    * karate.log(requestPayloadCreate)
    
    Given request requestPayloadCreate
    When method post
    Then status 400
    And karate.log('Response is : ', response)
    And karate.log('Status : 400')
    And match response.errors[0].message contains "kitchen.currency.invalid"
    And karate.log('Test Completed !')
	
	
  #REV2-19044
  Scenario: POST - Verify Kitchen Manager to create campaign with multiple currencyId
    
    * eval requestPayloadCreate.campaign.currencyId = "INR,USD"
    
    * karate.log(requestPayloadCreate)
    
    Given request requestPayloadCreate
    When method post
    Then status 400
    And karate.log('Response is : ', response)
    And karate.log('Status : 400')
    And match response.errors[0].errorCode contains "INVALID_DATA"
    And karate.log('Test Completed !')
    
		
  Scenario: POST - Verify currencyId length validation for Kitchen Manager 
    
    * eval requestPayloadCreate.campaign.currencyId = "USDR"
    
    * karate.log(requestPayloadCreate)
    
    Given request requestPayloadCreate
    When method post
    Then status 400
    And karate.log('Response is : ', response)
    And karate.log('Status : 400')
    And match response.errors[0].errorCode contains "INVALID_DATA"
    And karate.log('Test Completed !')
    
	
	#REV2-19045
  Scenario: POST - Verify Kitchen Manager to create campaign with blank campaignDomainId
    
    * eval requestPayloadCreate.campaign.campaignDomainId = ""
    
    * karate.log(requestPayloadCreate)
    
    Given request requestPayloadCreate
    When method post
    Then status 400
    And karate.log('Response is : ', response)
    And karate.log('Status : 400')
    And match response.errors[0].message contains "must not be blank"
    And karate.log('Test Completed !')
    
	
  #REV2-19046
  Scenario: POST - Verify Kitchen Manager to create campaign with invalid campaignDomainId
    
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
	
	
  #REV2-19047
  Scenario: POST - Verify Kitchen Manager to create campaign with multiple campaignDomainId
    
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
    
	
	#REV2-19048
  Scenario: POST - Verify Kitchen Manager to create campaign with blank frequency
    
    * eval requestPayloadCreate.campaign.frequency = ""
    
    * karate.log(requestPayloadCreate)
    
    Given request requestPayloadCreate
    When method post
    Then status 400
    And karate.log('Response is : ', response)
    And karate.log('Status : 400')
    And match response.errors[0].message contains "Invalid input data"
    And karate.log('Test Completed !')
    
	
  #REV2-19049
  Scenario: POST - Verify Kitchen Manager to create campaign with invalid frequency
    
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
    
	
	#REV2-19050
  Scenario: POST - Verify Kitchen Manager to create campaign with invalid geoId
    
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
	
	
	#REV2-19051
  Scenario: POST - Verify Kitchen Manager to create campaign with blank geoId
    
    * eval requestPayloadCreate.campaign.geoId = ""
    
    * karate.log(requestPayloadCreate)
    
    Given request requestPayloadCreate
    When method post
    Then status 400
    And karate.log('Response is : ', response)
    And karate.log('Status : 400')
    And match response.errors[*].message contains "must not be blank"
    And karate.log('Test Completed !')
    

  #REV2-19052
  Scenario: POST - Verify Kitchen Manager to create campaign with multiple geoId
    
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
    
	
  #REV2-19053
  Scenario: POST - Verify Kitchen Manager to create campaign with select All geoId
    
    * eval requestPayloadCreate.campaign.name = requestPayloadCreate.campaign.name + num
    * eval requestPayloadCreate.campaign.geoId = "ALL"
    
    * karate.log(requestPayloadCreate)
    
    Given request requestPayloadCreate
    When method post
    Then status 201
    And karate.log('Response is : ', response)
    And karate.log('Status : 201')
    And karate.log('Test Completed !')
    
	
	#REV2-19054
  Scenario: POST - Verify Kitchen Manager to create campaign with invalid publisherId
    
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
	
	
	#REV2-19055
  Scenario: POST - Verify Kitchen Manager to create campaign with blank publisherId
    
    * eval requestPayloadCreate.campaign.publisherId = ""
    
    * karate.log(requestPayloadCreate)
    
    Given request requestPayloadCreate
    When method post
    Then status 400
    And karate.log('Response is : ', response)
    And karate.log('Status : 400')
    And match response.errors[*].message contains "must not be blank"
    And karate.log('Test Completed !')
    
	
  #REV2-19056
  Scenario: POST - Verify Kitchen Manager to create campaign with multiple publisherId
    
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
    
	
	#REV2-19057
  Scenario: POST - Verify Kitchen Manager to create campaign with invalid time
    
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
		

	#REV2-19058
  Scenario: POST - Verify Kitchen Manager to create campaign with blank time
    
    * eval requestPayloadCreate.campaign.name = requestPayloadCreate.campaign.name + num
    * eval requestPayloadCreate.campaign.time = ""
    
    * karate.log(requestPayloadCreate)
    
    Given request requestPayloadCreate
    When method post
    Then status 201
    And karate.log('Response is : ', response)
    And karate.log('Status : 201')
    And karate.log('Test Completed !')
    
	
	#REV2-19059
  Scenario: POST - Verify Kitchen Manager to create campaign with invalid repeat
    
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
	
	
	#REV2-19060
  Scenario: POST - Verify Kitchen Manager to create campaign with blank repeat
    
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
    
	
	#REV2-19061
  Scenario: POST - Verify Kitchen Manager to create campaign with frequency and repeat set correctly
    
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
    

	#REV2-19062
  Scenario: POST - Verify repeat with frequency set to daily for Kitchen Manager to create campaign
    
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

	
	#REV2-18754 and REV2-18757 
  Scenario: PUT - Verify Kitchen Manager to edit existing campaign with valid data
    
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
	
	
	#REV2-18755
  Scenario: PUT - Verify Kitchen Manager to edit campaign with all invalid data
    
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


  #REV2-18756
  Scenario: PUT - Verify Kitchen Manager to edit campaign with all blank data
    
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


  #REV2-18758
  Scenario: PUT - Verify Kitchen Manager to edit campaign with invalid campaignId
    
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
    
	
  #REV2-18759
  Scenario: PUT - Verify Kitchen Manager to edit campaign with blank campaignId
    
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


	#REV2-18760
  Scenario: PUT - Verify Kitchen Manager to edit campaign with non existing campaignId
    
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

    
	#REV2-18761
  Scenario: PUT - Verify Kitchen Manager to edit campaign with blank campaign name
    
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
    
	    
	#REV2-18762
  Scenario: PUT - Verify Kitchen Manager to edit campaign with invalid campaign name
    
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
  
      
	#REV2-18763
  Scenario: PUT - Verify Kitchen Manager to edit campaign with duplicate campaign name
    
    * karate.log(requestPayloadEdit)
    
    Given path '/' + validCampaignId
    And request requestPayloadEdit
    When method put
    Then status 400
    And karate.log('Response is : ', response)
    And karate.log('Status : 400')
    And match response.errors[*].message contains "Campaign name already exist"
    And karate.log('Test Completed !')
  
    
  #REV2-18768
  Scenario: PUT - Verify Kitchen Manager to edit campaign with invalid fieldId
    
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
  
    
  #REV2-18769
  Scenario: PUT - Verify Kitchen Manager to edit campaign with blank fieldId
    
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
  
  
  #REV2-18773
  Scenario: PUT - Verify Kitchen Manager to edit campaign with invalid fieldOperand
    
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
  
    
  #REV2-18774
  Scenario: PUT - Verify Kitchen Manager to edit campaign with blank fieldOperand
    
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
  
  
  #REV2-18775
  Scenario: PUT - Verify Kitchen Manager to edit campaign with invalid fieldOperator
    
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
  
    
  #REV2-18776
  Scenario: PUT - Verify Kitchen Manager to edit campaign with blank fieldOperator
    
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
    
	
	#REV2-18780
  Scenario: PUT - Verify Kitchen Manager to edit campaign with blank frequency
    
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
  
   
	#REV2-18781
  Scenario: PUT - Verify Kitchen Manager to edit campaign with invalid frequency
    
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
    
	
	#REV2-18782
  Scenario: PUT - Verify Kitchen Manager to edit campaign with invalid time
    
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
    
	
	#REV2-18783
  Scenario: PUT - Verify Kitchen Manager to edit campaign with blank time
    
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
    
	
	#REV2-18784
  Scenario: PUT - Verify Kitchen Manager to edit campaign with invalid repeat
    
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
    

	#REV2-18785
  Scenario: PUT - Verify Kitchen Manager to edit campaign with blank repeat
    
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
    

	#REV2-18786
  Scenario: PUT - Verify Kitchen Manager to edit campaign with frequency and repeat set correctly
    
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
    
	
	#REV2-18787
  Scenario: PUT - Verify repeat with frequency set to daily for Kitchen Manager to edit campaign
    
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
	