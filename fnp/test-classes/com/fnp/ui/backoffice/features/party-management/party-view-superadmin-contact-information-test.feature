Feature: Party - Super Admin UI scenarios for View Contact Information

  Background: 
  
    * def loginLocator = read('../../data/loginPage_locator.json')
    * def usersValue = read('../../data/users.json')
    * def dashBoardLocator = read('../../data//dashboard_locators.json')
    * def contactLocator = read('../../data/party/contactPage_locators.json')
    * def contactConstant = read('../../data/party/contactPage_constants.json')
    
    * configure driver = driverConfig
    * driver backOfficeUrl
    * print '***backofficeurl***' backOfficeUrl
    And maximize()  
    * karate.log('***Logging into the application****')
    And input(loginLocator.usernameTextArea, usersValue.users.superAdmin.email)
    * delay(1000)
    And input(loginLocator.passwordTextArea, usersValue.users.superAdmin.password)
    * delay(1000)  
    When click(loginLocator.loginButton)
    * karate.log('***Logging into the application****')
    * delay(1000)
    And click(dashBoardLocator.switchMenu)
    * delay(1000)
    * karate.log('***Click on party menu****')
    And click(dashBoardLocator.partyMenu)
    * delay(1000)
    * karate.log('***Click on dropdown to select party type****')  
		* mouse().move(contactLocator.partyTypeDropdownTxt).click()
    * delay(2000)
    * def dropdownTxt = scriptAll(contactLocator.partyTypeDropdownMenu, '_.textContent')
    * print 'Dropdown', dropdownTxt
    * delay(2000)
    * match dropdownTxt[0] contains 'Individual'
    * match dropdownTxt[1] contains 'Organization'
    * delay(1000) 
    * def optionOnDropDown = locateAll(contactLocator.partyTypeDropdownMenu)
    * delay(1000)
    * match karate.sizeOf(optionOnDropDown) == 2
    * optionOnDropDown[0].click()
    * delay(1000)    
    * karate.log('***Enter the party ID****')     
    * input(contactLocator.typePartyId,contactConstant.partyId)
    * delay(1000)
    * click(contactLocator.clickOnApply)
    * delay(1000)
    * click(contactLocator.clickOnPartyId)
    * delay(1000)
    * karate.log('***Personal information tab will get open by default****')   
    * match text(contactLocator.personalInfoColLoadByDefault) == contactConstant.personalInfoTabText
    * delay(1000)
  	* karate.log('***Click on contact information tab****')   
 		* click(contactLocator.contactInfoTab)
    * delay(3000)   
    
  
	#REV2-22227 and REV2-22226 and REV2-22225 
  Scenario: Verify all the information present is according to the Postal Address contact type for super admin.
      
    * karate.log('************Search for postal address on contact information list***********')
    * click(contactLocator.searchInput)
    * delay(1000)
    * input(contactLocator.searchInput,'Postal Address')
    * delay(2000)
    * karate.log("***********************Contact types fields label***************************")      
    * def contactTypeList = scriptAll(contactLocator.contactTypeList, '_.textContent')
		* print "Contact information column list..." , contactTypeList  
		* delay(1000)	
    * click(contactLocator.dots)
    * delay(1000)
    * def viewOption = locateAll(contactLocator.viewOptions)
    * viewOption[0].click()
    * delay(1000)
    * karate.log("*****************Verifying postal address page label************************")
    * match text(contactLocator.postalAddLabel) == contactConstant.postalAddPageLabelTxt
    * karate.log("*********Verifying  url after click on three dots of postal address***************") 
    * waitForUrl(contactConstant.contactInfoViewPageUrl)
    * karate.log("*********Verifying postal address fields on contact information**************")
    * def postalAddAllFields = scriptAll(contactLocator.contactTypeFieldsFormsLabels, '_.textContent')
    * print 'postalAddAllFieldsLable--' , postalAddAllFields
    * delay(1000)
    * match postalAddAllFields[0] == contactConstant.contactTypeText
    * match postalAddAllFields[2] == contactConstant.contactPurposeColText
    * match postalAddAllFields[4] == contactConstant.statusColText
		* match postalAddAllFields[6] == contactConstant.toName
    * match postalAddAllFields[8] == contactConstant.attentionName
    * match postalAddAllFields[10] == contactConstant.doorbell
    * match postalAddAllFields[12] == contactConstant.addressLine1    
    * match postalAddAllFields[14] == contactConstant.addressLine2           
    * match postalAddAllFields[16] == contactConstant.country
    * match postalAddAllFields[18] == contactConstant.state
    * match postalAddAllFields[20] == contactConstant.city
    * match postalAddAllFields[22] == contactConstant.pincode
    * match postalAddAllFields[23] == contactConstant.fromDate  
    * match postalAddAllFields[24] == contactConstant.throghDate
    * match postalAddAllFields[25] == contactConstant.createdByColText
    * match postalAddAllFields[26] == contactConstant.createdOn
    * match postalAddAllFields[27] == contactConstant.modifiedByColText
    * match postalAddAllFields[28] == contactConstant.modifiedDateColText
		* delay(1000)
		
    * karate.log('***Check weather value is present for postal address on contact information****') 		
		* def postalAddAllFieldsPresent = scriptAll(contactLocator.postalAddAllFieldsPresent, '_.textContent')
    * print 'postalAddAllFieldsPresent--' , postalAddAllFieldsPresent
    * delay(1000)
	 	* match postalAddAllFieldsPresent[0] == "#present"
		* match postalAddAllFieldsPresent[1] == "#present"
	 	* match postalAddAllFieldsPresent[2] == "#present"
	 	* match postalAddAllFieldsPresent[3] == "#present"
	 	* match postalAddAllFieldsPresent[4] == "#present"
	 	* match postalAddAllFieldsPresent[5] == "#present"
	 	* match postalAddAllFieldsPresent[6] == "#present"
	 	* match postalAddAllFieldsPresent[7] == "#present"
	 	* def postalAddAllFields = scriptAll(contactLocator.postalAddAllFields, '_.textContent')
    * print 'postalAddAllFields--' , postalAddAllFields
    * delay(1000)
	  * match postalAddAllFields[0] == "#present"
		* match postalAddAllFields[1] == "#present"
	 	* match postalAddAllFields[2] == "#present"
	 	* match postalAddAllFields[3] == "#present"
	 	* match postalAddAllFields[5] == "#present"
	 	* match postalAddAllFields[7] == "#present"
	 	* match postalAddAllFields[8] == "#present"
	 	* delay(1000)
	 
	 
	#REV2-22228
	Scenario: Check whether all the information present is according to the phone number contact type for super admin.
	 
    * karate.log('*********Search for phone number on contact information list*****************')
    * click(contactLocator.searchInput)
    * delay(1000)
    * input(contactLocator.searchInput,'Phone Number')
    * delay(2000)
    * def contactTypeList = scriptAll(contactLocator.contactTypeList, '_.textContent')
		* print "Contact information column list..." , contactTypeList  
		* delay(1000)		
		* karate.log('***********Click on three dots left side of phone number ********************')
    * click(contactLocator.dots) 
    * delay(1000)
    * karate.log('******Click on view option on three dots left side of phone number **********')
    * def viewOption = locateAll(contactLocator.viewOptions)
    * viewOption[0].click() 
    * delay(5000)
    * karate.log("*********Verifying phone number fields on contact information****************")
    * def phoneNoAllFields = scriptAll(contactLocator.contactTypeFieldsFormsLabels, '_.textContent')
    * print 'phoneNoAllFields--' , phoneNoAllFields
    * delay(1000) 
    * match phoneNoAllFields[0] == contactConstant.contactTypeText
    * match phoneNoAllFields[2] == contactConstant.contactPurposeColText
    * match phoneNoAllFields[4] == contactConstant.code  
    * match phoneNoAllFields[6] == contactConstant.contactPhoneNo  
    * match phoneNoAllFields[8] == contactConstant.statusColText  
    * match phoneNoAllFields[10] == contactConstant.primary  
	  * match phoneNoAllFields[11] == contactConstant.fromDate  
    * match phoneNoAllFields[12] == contactConstant.throghDate
    * match phoneNoAllFields[13] == contactConstant.createdByColText
    * match phoneNoAllFields[14] == contactConstant.createdOn
    * match phoneNoAllFields[15] == contactConstant.modifiedByColText
    * match phoneNoAllFields[16] == contactConstant.modifiedDateColText
		* delay(10000)
	
	
	#REV2-22218/REV2-22219/REV2-22220/REV2-22221/REV2-22224
	Scenario: Verify the Label and Navigation Link after the back office user select the party in 
						which user wants to view contact information
		
		* karate.log("*********Verifying contact information page url************************************")				
	  * waitForUrl('show/contact-info')  
	  * delay(100)
	  * karate.log("*********Verifying new contact button is enable and match the label on it***********")
		* match enabled(contactLocator.newContactButton) == true
		And match text(contactLocator.newContactLabel) == contactConstant.newContactLabelTxt
    * delay(3000)
    * karate.log("*********Verifying partyId as page label********************************************")
    * match text(contactLocator.lableOfPartyId) == contactConstant.partyId
    * delay(5000)
    * karate.log("*********Verifying navigation link after click on partyId **************************") 
    And match driver.url contains contactConstant.navigationLinkOfPartyId
    * def navBarTab = scriptAll(contactLocator.navBarTab, '_.textContent')
    * print ' navBar tabs---' , navBarTab
    * delay(100)
  
    * karate.log("*********Verifying tabs on Navigation bar*******************************************")  
    * match karate.sizeOf(navBarTab) == 5
   	* match navBarTab[0] == contactConstant.personalInfoTabText
    * match navBarTab[1] == contactConstant.usernamesTabText
    * match navBarTab[2] == contactConstant.contactInfoTabText
    * match navBarTab[3] == contactConstant.relationshipTabText
    * match navBarTab[4] == contactConstant.rolesTabText  
    * delay(3000)
    
    * karate.log("*********Contact information tab  fields ********************************************")    
    * def columnNameOnGrid = scriptAll(contactLocator.contactInfoColList, '_.textContent')
    * delay(300)
    * print "Contact information column list..." , columnNameOnGrid    
    * delay(3000)    
 
 		* karate.log("*********Contact information fields listing ********************************************")       
    * def ContactTypeList = scriptAll(contactLocator.clickOnContactType, '_.textContent')
    * print ' ContactTypeList---' , ContactTypeList
    * delay(100) 
    * def contactPurposeList = scriptAll(contactLocator.contactPurposeList, '_.textContent')
    * print ' contactPurposeList---' , contactPurposeList  
    * delay(100)
    * def contactInfoList = scriptAll(contactLocator.contactInfoList, '_.textContent')
    * print ' contactInfoList---' , contactInfoList  
    * delay(100) 
    * def statusList = scriptAll(contactLocator.statusList, '_.textContent')
    * print ' statusList---' , statusList  
    * delay(100) 
    * def createdByList = scriptAll(contactLocator.createdByList, '_.textContent')
    * print ' contactInfoList---' , createdByList  
    * delay(100) 
    * def createdAtList = scriptAll(contactLocator.createdAtList , '_.textContent')
    * print ' createdAtList ---' , createdAtList   
    * delay(100)
    * def modifiedBy = scriptAll(contactLocator.updateByList , '_.textContent')
    * print ' modifiedBy ---' , modifiedBy   
    * delay(100)  
    * def modifiedDate = scriptAll(contactLocator.updatedAt , '_.textContent')
    * print ' modifiedDate ---' , modifiedDate   
    * delay(100)    
 		* click(contactLocator.dots)
    * delay(100)
    * def options = scriptAll(contactLocator.optionOnThreeDots, '_.textContent')
    * delay(100)    
    
    * karate.log('****************************** Match the labels **************************************')  
    And match options[0] contains 'View'
 		And match options[1] contains 'Edit'  
    * delay(10000)
    
    
  #REV2-22229  
 	Scenario: Verify all the information present is according to the Email Address contact type for super admin.
      
    * karate.log('************Search for Email address on contact information list***********')
    * click(contactLocator.searchInput)
    * delay(1000)
    * input(contactLocator.searchInput,'Email Address')
    * delay(2000)
    * karate.log("***********************Contact types fields label***************************")      
    * def contactTypeList = scriptAll(contactLocator.contactTypeList, '_.textContent')
		* print "Contact information column list..." , contactTypeList  
		* delay(1000)	
    * click(contactLocator.dots)
    * delay(1000)
    * def viewOption = locateAll(contactLocator.viewOptions)
    * viewOption[0].click()
    * delay(1000)
    * karate.log("*****************Verifying email address page label************************")
    * karate.log("*********Verifying  url after click on three dots of email address***************") 
    * waitForUrl(contactConstant.contactInfoViewPageUrl)
    * karate.log("*********Verifying email address fields on contact information**************")
    * def emailAddAllFields = scriptAll(contactLocator.contactTypeFieldsFormsLabels, '_.textContent')
    * print 'emailAddAllFields--' , emailAddAllFields
    * delay(1000)   
    * emailAddAllFields[0] == contactConstant.contactTypeText
    * emailAddAllFields[2] == contactConstant.contactPurposeColumn   
    * emailAddAllFields[4] == contactConstant.newContactEmailAddTxt
    * emailAddAllFields[6] == contactConstant.statusColText
    * emailAddAllFields[8] == contactConstant.primary   
    * emailAddAllFields[9] == contactConstant.fromDate
    * emailAddAllFields[10] == contactConstant.throghDate
    * emailAddAllFields[11] == contactConstant.createdByColText   
    * emailAddAllFields[12] == contactConstant.createdDateColText
    * emailAddAllFields[13] == contactConstant.modifiedByColText
    * emailAddAllFields[14] == contactConstant.modifiedDateColText   
		* delay(10000)
    