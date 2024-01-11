Feature: UI scenarios for List Contact Information with Grid functionality for super admin

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
    And click(dashBoardLocator.partyMenu)
    * delay(1000)
		* mouse().move(contactLocator.partyTypeDropdownTxt).click()

    * delay(1000)
    * def dropdownTxt = scriptAll(contactLocator.partyTypeDropdownMenu, '_.textContent')
    * print 'Dropdown', dropdownTxt
    * delay(1000)
    * match dropdownTxt[0] contains 'Individual'
    * match dropdownTxt[1] contains 'Organization'
    * delay(1000)
    
    * def optionOnDropDown = locateAll(contactLocator.partyTypeDropdownMenu)
    * delay(1000)
    * match karate.sizeOf(optionOnDropDown) == 2
    * optionOnDropDown[0].click()
    * delay(1000) 
    
    * input(contactLocator.typePartyId,contactConstant.lablePartyIdText)
    * delay(1000)
    * click(contactLocator.clickOnApply)
    * delay(1000)
    * click(contactLocator.clickOnPartyId)
    * delay(1000)
		* karate.log('***Personal information tab will get open by default****')   
    * match text(contactLocator.personalInfoColLoadByDefault) == contactConstant.personalInfoTabText
    * delay(1000)
    
    
	#REV2-22568/REV2-22567						
	Scenario: Verify various fields present in 'Postal address' form for super admin
		
		* click(contactLocator.contactInfoTab)   				
 		* delay(1000)
	  * click(contactLocator.newContactButton)
    * delay(1000)
	  * mouse().move(contactLocator.clickOnContactType).click()
	  * delay(1000)   
	  * def contactTypeCheckBoxValue = scriptAll(contactLocator.contactTypeCheckBox, '_.textContent')
	  * print 'contactTypeCheckBox', contactTypeCheckBoxValue
	  * delay(1000)     
	  * def contactTypeValue = locateAll(contactLocator.contactTypeCheckBox)  
	  * contactTypeValue[0].click()
	  * delay(1000) 
	  
	  * karate.log('***Verify fields in postal address****')   
    * def postalAddFields = scriptAll(contactLocator.contactTypeFieldsFormsLabels, '_.textContent')
    * print 'postalAddFields', postalAddFields
   	* def postalAddFields = locateAll(contactLocator.contactTypeFieldsFormsLabels)
    * postalAddFields[0] == contactConstant.contactTypeText
    * postalAddFields[2] == contactConstant.contactPurposeColumn
    * postalAddFields[5] == contactConstant.toName
    * postalAddFields[7] == contactConstant.attentionName   
    * postalAddFields[9] == contactConstant.doorbell
    * postalAddFields[11] == contactConstant.addressLine1
    * postalAddFields[13] == contactConstant.addressLine2
    * postalAddFields[14] == contactConstant.attentionName   
    * postalAddFields[16] == contactConstant.attentionName   
    * postalAddFields[19] == contactConstant.attentionName   
	  * delay(1000) 				 
  	* def fromAndThroghDateVerify = scriptAll(contactLocator.newContactEmailFromAndThroughDate, '_.textContent')
  	* fromAndThroghDateVerify[0] == contactConstant.newContactEmailFromDate
    * fromAndThroghDateVerify[1] == contactConstant.throghDate
  	* delay(1000)   
	  
		* click(contactLocator.createButton)
	  * delay(1000)		
	  
	  * karate.log('************** Verify basic validations for mandatory fields *************')   
    * match text(contactLocator.contactPurposeIdValidationMsg) == contactConstant.contactPurposeValidationMsgTxt
    * delay(1000)
    * match text(contactLocator.toNameNewContactValidationMsg) == contactConstant.toNameValidationMsgTxt
    * delay(1000)
    * match text(contactLocator.addressLine1ValidationMsg) == contactConstant.addressLine1ValidationMsgTxt
    * delay(1000)
    * def fromDateValidationMsg = scriptAll(contactLocator.fromAndThroughDateValidationMsg, '_.textContent')
    * delay(200)
    * fromDateValidationMsg[0] = contactConstant.fromDateValidationMsgTxt 
    * delay(1000)
    * match text(contactLocator.stateValidationMsg) == contactConstant.stateValidationMsgTxt
    * delay(1000)
    * match text(contactLocator.cityValidationMsg) == contactConstant.cityValidationMsgTxt
    * delay(1000)
 
    * karate.log('**** Verify To Name field with numbers***')   
    * click(contactLocator.toNameTxtBox)
    * delay(1000)
    * input(contactLocator.toNameTxtBox ,"1234")
    * delay(2000)					
    * match text(contactLocator.toNameInvalidMsg) == contactConstant.toNameInvalidMsgTxt
    * delay(1000) 
    
    * karate.log('**** Verify To Name field with maximum character limit upto fifty ***') 
    * clear(contactLocator.toNameTxtBox)
    * delay(1000) 
    * input(contactLocator.toNameTxtBox ,"abcdefghijabcdefghijabcdefghijabcdefghijabcdefghija")
    * delay(1000)					
    * match text(contactLocator.toNameCharacterLimitValidationMsg) == contactConstant.characterLimitValidationMsgTxt
    * delay(1000) 
    
    * karate.log('**** Verify Attention Name field with numbers ***')
    * click(contactLocator.attentionNameTextBox)
    * delay(1000)    
    * input(contactLocator.attentionNameTextBox ,"1234")
    * delay(3000)					
    * match text(contactLocator.attentionNameInvalidMsg) == contactConstant.attentionNameInvalidMsgTxt
    * delay(1000)
    
    * karate.log('**** Verify Attention Name field with maximum character limit upto fifty ***')
    * clear(contactLocator.attentionNameTextBox)
    * input(contactLocator.attentionNameTextBox ,"abcdefghijabcdefghijabcdefghijabcdefghijabcdefghija")
    * delay(2000)					
    * match text(contactLocator.attentionNameCharacterLimitValidationMsg) == contactConstant.attentionNameValidationMsgTxt
    * delay(1000) 
    
    * karate.log('**** Verify the the system will check Pincode validation for the invalid State and City***')
    * mouse().move(contactLocator.country).click()
    * delay(1000)
    * def countryCheckBox = scriptAll(contactLocator.countryCheckBoxList, '_.textContent')
    * print 'countryCheckBox',countryCheckBox
    * delay(1000)
	  * def countryCheckBoxList = locateAll(contactLocator.countryCheckBoxList)  
	  * delay(1000)  
	  * countryCheckBoxList[105].click()
	  * delay(10000) 	     	    		
	  * mouse().move(contactLocator.state).click()	 
	  * delay(1000)  	
	  * def stateCheckboxList = scriptAll(contactLocator.stateCheckboxList, '_.textContent') 
	  * print 'stateCheckbox',stateCheckboxList
    * delay(1000)
	  * def stateCheckboxList = locateAll(contactLocator.stateCheckboxList)  
	  * stateCheckboxList[2].click()   
	  * delay(1000)
	  * mouse().move(contactLocator.cityTextBox).click()	   	 
	  * delay(1000) 
    * def cityDropdownCheckbox = scriptAll(contactLocator.cityDropdownCheckboxList, '_.textContent')
	  * print 'cityDropdownCheckbox', cityDropdownCheckbox
	  * delay(1000)     
	  * def cityDropdownCheckboxList = locateAll(contactLocator.cityDropdownCheckboxList)  
	  * cityDropdownCheckboxList[2].click()
	 	* delay(1000)     	  

    * karate.log('**** Verify validation as invalid pincode for particular state and city ***')  	 	 
    * click(contactLocator.pincode)
    * delay(1000)
    * input(contactLocator.pincode ,"425001")
    * delay(1000)
    * match text(contactLocator.pincodeForInvalidStateCityValidationMsg) == contactConstant.pincodeForInvalidStateCityValidationMsgTxt
    * delay(1000) 
  
    * karate.log('**** Verify validation msg for throgh date always greater than form date ***')   
		* mouse().move(contactLocator.fromDate).click()
    * delay(1000)    
    * input(contactLocator.date , "04/11/2021")
		* delay(2000) 
    * def thruDate = locateAll(contactLocator.throughDatePostalAdd)  
  	* delay(1000) 	  
	  * thruDate[0].click()
	 	* delay(10000) 	 
	  * input(contactLocator.throughDatePostalAdd , "01/11/2021")
		* delay(2000)     
    * click(contactLocator.createButton)
	  * delay(1000)
	  * def throughDateValidationMsg = scriptAll(contactLocator.fromAndThroughDateValidationMsg, '_.textContent')
   * delay(1000)
   * throughDateValidationMsg[1] == contactConstant.throughDateValidationMsgTxt 
   * print "throughDateValidationMsg[1]-------------" ,throughDateValidationMsg[1]
   * delay(5000)  
     
	  
   		
	#REV2-22575/REV2-22576/REV2-22569  
	Scenario: Verify if super admin clicks on 'CANCEL' button present on create confirmation window, it will remain on the same page or not
		  
  	* click(contactLocator.contactInfoTab)   				
 		* delay(100)
	  * click(contactLocator.newContactButton)
	  * delay(300)	
	  * mouse().move(contactLocator.clickOnContactType).click()
	  * delay(300)   
	  * def contactTypeCheckBoxValue = scriptAll(contactLocator.contactTypeCheckBox, '_.textContent')
	  * print 'contactTypeCheckBox', contactTypeCheckBoxValue
	  * delay(1000)     
	  * def contactTypeValue = locateAll(contactLocator.contactTypeCheckBox)  
	  * contactTypeValue[2].click()
	  * delay(1000) 
	  * mouse().move(contactLocator.clickOnContactPurpose).click()
	  * delay(1000) 
    * def clickOnContactPurposeDropDownValue = scriptAll(contactLocator.clickOnContactPurposeCheckbox, '_.textContent')
    * print 'clickOnContactPurposeCheckbox', clickOnContactPurposeDropDownValue
    * delay(1000)
    
    * karate.log('**** Verify label on fields ***')    
    * def phoneNumberFields = scriptAll(contactLocator.contactTypeFieldsFormsLabels, '_.textContent')
    * print 'phoneNumberFields', phoneNumberFields  
    * delay(1000)

    * match phoneNumberFields[0] == contactConstant.contactTypeText
    * match phoneNumberFields[2] == contactConstant.contactPurposeColInNewContactText
    * match phoneNumberFields[5] == contactConstant.code
		* match phoneNumberFields[7] == contactConstant.contactPhoneNo
	  * def fromAndThroghDateVerify = scriptAll(contactLocator.newContactEmailFromAndThroughDate, '_.textContent')
  	* print 'fromAndThroghDateVerify', fromAndThroghDateVerify
  	* match fromAndThroghDateVerify[0] == contactConstant.newContactEmailFromDate
    * match fromAndThroghDateVerify[1] == contactConstant.throghDateForNewContactPhoneNo				
    * delay(1000)
    
	  * def clickOnContactPurposevalue = locateAll(contactLocator.clickOnContactPurposeCheckbox)  
	  * clickOnContactPurposevalue[1].click()  
	  * delay(1000)
	  * click(contactLocator.phoneNo)
	  * delay(1000)
	  * input(contactLocator.phoneNo ,"9127267815")
	  * delay(1000)
	  * mouse().move(contactLocator.fromDate).click()
	  * delay(1000) 
	  * input(contactLocator.date , "15011998")
	  * input(contactLocator.time , "112233")
		* delay(1000)     
	  * click(contactLocator.createButton)
	  * delay(1000)

	  * karate.log('** Verify on clicking CANCEL button after click on CONTINUE button it should redirect to same page**')    					
		* mouse().move(contactLocator.cancelButton).click()
	  * delay(1000) 
		* waitForUrl(contactConstant.newContactInfoPageUrl)	 
    * delay(1000)
  
    * karate.log('*** Verify on clicking CANCEL button for empty form it should redirect to contact-info page url **')    	  
		* click(contactLocator.cancelButton)
		* delay(1000)
		* waitForUrl('/show/contact-info')
	  * delay(5000)
			
			
	#REV2-22577/REV2-22573/REV2-22564/REV2-22565
  Scenario: Verify if super admin clicks on CONTINUE button present on create confirmation window, it will redirect to
   'Contact Information' list or not.
    
  	* click(contactLocator.contactInfoTab)
    * delay(100)
    * click(contactLocator.newContactButton)
    * delay(300)
  	
  	* mouse().move(contactLocator.clickOnContactType).click()
    * delay(300)
    
    * def contactTypeCheckBoxValue = scriptAll(contactLocator.contactTypeCheckBox, '_.textContent')
    * print 'contactTypeCheckBox', contactTypeCheckBoxValue
    * delay(200)
    * match contactTypeCheckBoxValue[0] contains 'Postal Address'
    * match contactTypeCheckBoxValue[1] contains 'Email Address'
    * match contactTypeCheckBoxValue[2] contains 'Phone Number'
    * delay(100)
       
    * def contactTypeValue = locateAll(contactLocator.contactTypeCheckBox)  
    * contactTypeValue[2].click()
    * delay(1000) 
    
    * mouse().move(contactLocator.clickOnContactPurpose).click()
    * delay(200)
    
    * def clickOnContactPurposeDropDownValue = scriptAll(contactLocator.clickOnContactPurposeCheckbox, '_.textContent')
    * print 'clickOnContactPurposeCheckbox', clickOnContactPurposeDropDownValue
    * delay(200)
  
    * def clickOnContactPurposevalue = locateAll(contactLocator.clickOnContactPurposeCheckbox)  
    * clickOnContactPurposevalue[1].click()
   
    * delay(200)
    * click(contactLocator.phoneNo)
    * delay(1000)
    * input(contactLocator.phoneNo ,"9127267815")
    * delay(200)
    * mouse().move(contactLocator.fromDate).click()
    * delay(200)
    
    * input(contactLocator.date , "15011998")
    * input(contactLocator.time , "112233")
		* delay(2000) 
		
     * karate.log('******* Verify create and cancel button is exist *************')    
  	* def createButtonExists = exists(contactLocator.createButton)
    * if (createButtonExists) karate.log("Create button is present")       
    * def cancelButtonExists = exists(contactLocator.cancelButton)
    * if (cancelButtonExists) karate.log("Cancel button is present") 
     And match text(contactLocator.createButton) == contactConstant.createButtonLabelTxt
     And match text(contactLocator.cancelButtonlabel) == contactConstant.cancelButtonTLabelTxt

    * karate.log('** Verify label on CREATE button and after click on it verify label on CANCEL and CONTINUE button**')        
    * click(contactLocator.createButton)
    * delay(1000)
    And match text(contactLocator.createDilogBox) == contactConstant.createDilogBoxText
    * delay(1000) 
    * def createNewContactConfirmationBoxOptions = scriptAll(contactLocator.confirmationboxOptions, '_.textContent')
		* createNewContactConfirmationBoxOptions[0] == 'CANCEL'
		* createNewContactConfirmationBoxOptions[1] == 'CONTINUE'	
    * delay(1000)
     
    * karate.log('******* Verify label on continue button and confirmation message after click on it  *************')    
 		* click(contactLocator.continueButton)
 		And match text(contactLocator.continueButton) == contactConstant.continueButtonLabelTxt
    * delay(1000) 
    And match text(contactLocator.confirmationMessage) == contactConstant.confirmationMessageTxt   
    * delay(100) 
    * karate.log('***** Verify after click on continue button it should redirect tocontactInfo page url  ****')    
    And waitForUrl(contactConstant.contactInfoPageUrl)
    * delay(10000)  
     
    
 
	#REV2-22571/REV2-22572	  
  Scenario: Verify whether all the required fields on 'New contact information' form is present or not,
  				 if super admin clicks on 'Email address' option from 'Contact type' drop-down.  
  				 
  	* click(contactLocator.contactInfoTab)
    * delay(1000)
    * click(contactLocator.newContactButton)
    * delay(1000)	
  	* mouse().move(contactLocator.clickOnContactType).click()
    * delay(1000)
    
    * def contactTypeCheckBoxValue = scriptAll(contactLocator.contactTypeCheckBox, '_.textContent')
    * print 'contactTypeCheckBox', contactTypeCheckBoxValue
    * delay(1000)
    * def contactTypeValue = locateAll(contactLocator.contactTypeCheckBox)  
	  * contactTypeValue[1].click()
    * delay(1000)

    * karate.log('******* Verify fields in email address *************')    
    * def emailAddFields = scriptAll(contactLocator.contactTypeFieldsFormsLabels, '_.textContent')
    * print 'emailAddFields', emailAddFields  
    * delay(1000)
  	* def emailAddFields = locateAll(contactLocator.contactTypeFieldsFormsLabels)
    * emailAddFields[0] == contactConstant.contactTypeText
    * emailAddFields[2] == contactConstant.contactPurposeColumn   
    * emailAddFields[5] == contactConstant.newContactEmailAddTxt
    * delay(1000) 				 
  	* def fromAndThroghDateVerify = scriptAll(contactLocator.newContactEmailFromAndThroughDate, '_.textContent')
  	* def fromAndThroghDateVerify = locateAll(contactLocator.newContactEmailFromAndThroughDate)
    * print 'fromAndThroghDateVerify', fromAndThroghDateVerify    	
  	* fromAndThroghDateVerify[0] == contactConstant.newContactEmailFromDate
    * fromAndThroghDateVerify[1] == contactConstant.throghDate
  	* delay(1000)   
    And match text(contactLocator.createButton) == contactConstant.createButtonLabelTxt
    And match text(contactLocator.cancelButtonlabel) == contactConstant.cancelButtonTLabelTxt			
   	* delay(1000)
   	* click(contactLocator.createButton) 
    * delay(1000)
   	
   	* karate.log('************** Verify basic validations for mandatory fields *************')   
   	* match text(contactLocator.contactPurposeIdValidationMsg) == contactConstant.contactPurposeIdValidationMsgTxt
    * match text(contactLocator.emailValidationMsg) == contactConstant.emailValidationMsgTxt
    * def fromDateValidationMsg = scriptAll(contactLocator.fromAndThroughDateValidationMsg, '_.textContent')
    * fromDateValidationMsg[0] = contactConstant.fromDateValidationMsgTxt 
    * delay(1000)	
    * click(contactLocator.email)
    * delay(1000)
    
    * karate.log('**** Verify email address field with invalid email ***')      
    * input(contactLocator.email ,"aa@kb")
    * delay(1000) 
    * match text(contactLocator.emailValidationMsg) == contactConstant.invalidEmailValidationMsgTxt
    * delay(1000)
     
    * karate.log('**** Verify throgh date always greater than form date ***')
   	* mouse().move(contactLocator.fromDate).click()
    * delay(1000)    
    * input(contactLocator.date , "04/11/2021")
		* delay(2000) 
    * def thruDate = locateAll(contactLocator.throughDate)  
  	* delay(1000) 	  
	  * thruDate[0].click()
	 	* delay(10000) 	 
	  * input(contactLocator.throughDate , "01/11/2021")
		* delay(2000)     
    * click(contactLocator.createButton)
	  * delay(1000)
			
	 * karate.log('************ Verify through date validation **********')       
	 * def throughDateValidationMsg = scriptAll(contactLocator.fromAndThroughDateValidationMsg, '_.textContent')
   * delay(1000)
   * throughDateValidationMsg[1] == contactConstant.throughDateValidationMsgTxt 
   * print "throughDateValidationMsg[1]-------------" ,throughDateValidationMsg[1]
   * delay(5000)  
    
   	
	#REV2-22570/REV2-22560/REV2-22566/REV2-22562//REV2-22563
	Scenario: Verify various fields present in 'Phone number' form for super admin
	
  	* click(contactLocator.contactInfoTab)
    * delay(1000)
    * karate.log("*********Verifying new contact button is enable and visible***********")
		* match enabled(contactLocator.newContactButton) == true
		And match text(contactLocator.newContactLabel) == contactConstant.newContactLabelTxt   
		* delay(1000)
    * karate.log("*********Verifying new contact button is exist*************")
  	* def buttonExists = exists(contactLocator.newContactButton)
    * if (buttonExists) karate.log("New Contact Button button is present") 	
  	* delay(1000)
    * karate.log("*********Verifying new contact button clickable and match the url after click it*************")
    * click(contactLocator.newContactButton)
    * delay(1000)
    * karate.log("*********Verifying new contact page navigation URL*************")   
    * waitForUrl(contactConstant.newContactInfoPageUrl)	 
    * delay(1000)  	
    
    * mouse().move(contactLocator.clickOnContactType).click()
    * delay(1000)   
    * def contactTypeCheckBoxValue = scriptAll(contactLocator.contactTypeCheckBox, '_.textContent')
    * print 'contactTypeCheckBox', contactTypeCheckBoxValue
    * delay(1000)
    * def contactTypeValue = locateAll(contactLocator.contactTypeCheckBox)  
    * contactTypeValue[2].click()
    * delay(1000)
    
    * karate.log('**** Verify phone number fields label***')     
    * def phoneNumFields = scriptAll(contactLocator.contactTypeFieldsFormsLabels, '_.textContent')
    * print 'phoneNumFields', phoneNumFields
   	* def phoneNumFields = locateAll(contactLocator.contactTypeFieldsFormsLabels)
    * delay(1000)
    * phoneNumFields[0] == contactConstant.contactTypeText 
    * phoneNumFields[2] == contactConstant.contactPurposeColum 
    * phoneNumFields[5] == contactConstant.code 
    * phoneNumFields[7] == contactConstant.contactPhoneNo 
    * phoneNumFields[11] == contactConstant.cancelButtonTLabelTxt 
    * phoneNumFields[13] == contactConstant.createButtonLabelTxt 
    * delay(1000)
    * def fromAndThroghDateVerify = scriptAll(contactLocator.newContactEmailFromAndThroughDate, '_.textContent')
    * def fromAndThroghDateVerify = locateAll(contactLocator.newContactEmailFromAndThroughDate)
  	* fromAndThroghDateVerify[0] == contactConstant.newContactEmailFromDate
    * fromAndThroghDateVerify[1] == contactConstant.throghDate
  	* delay(1000) 
  
    * mouse().move(contactLocator.countryCode).click()
    * def countryCodeCheckBox = scriptAll(contactLocator.countryCodeCheckBox, '_.textContent')
    * print 'countryCodeCheckBox' , countryCodeCheckBox
    * delay(1000) 
    * def countryCodeCheckBoxValues = locateAll(contactLocator.countryCodeCheckBox)
    * delay(1000)

    * karate.log('**** Verify phone number fields with character ***')   
    * mouse().move(contactLocator.countryCodeCheckBoxValue).click()
    * click(contactLocator.phoneNo)
    * delay(1000)
    * input(contactLocator.phoneNo ,"Avbnshsfg")
    * delay(2000)
    
    * karate.log('**** Validation msg for contact purpose***')      
    * click(contactLocator.createButton)
    * delay(1000) 
    * match text(contactLocator.contactPurposeIdValidationMsg) == contactConstant.contactPurposeIdValidationMsgTxt
    * delay(1000)
     
    * karate.log('********* Verify from date validation **********')     
    * def fromDateValidationMsg = scriptAll(contactLocator.fromAndThroughDateValidationMsg, '_.textContent')
    * delay(1000)
    * fromDateValidationMsg[0] = contactConstant.fromDateValidationMsgTxt 
    * delay(1000)
     
    * karate.log('**** Verify throgh date always greater than form date ***')  
	  * mouse().move(contactLocator.fromDate).click()
    * delay(1000)    
    * input(contactLocator.date , "04/11/2021")
		* delay(2000) 
    * def thruDate = locateAll(contactLocator.throughDate)  
  	* delay(1000) 	  
	  * thruDate[0].click()
	 	* delay(10000) 	 
	  * input(contactLocator.throughDate , "01/11/2021")
		* delay(2000)     
    * click(contactLocator.createButton)
	  * delay(1000)
	
		* karate.log('************ Verify through date validation **********')      
	  * def throughDateValidationMsg = scriptAll(contactLocator.fromAndThroughDateValidationMsg, '_.textContent')
    * delay(1000)
    * throughDateValidationMsg[1] == contactConstant.throughDateValidationMsgTxt 
    * print "throughDateValidationMsg[1]-------------" ,throughDateValidationMsg[1]
    * delay(5000)  
   
   
  