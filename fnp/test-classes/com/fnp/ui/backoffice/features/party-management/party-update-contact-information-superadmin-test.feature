Feature:  Update Contact Information UI scenarios for super admin

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
    
    * input(contactLocator.typePartyId,contactConstant.lablePartyIdText)
    * delay(1000)
    * click(contactLocator.clickOnApply)
    * delay(1000)
    * click(contactLocator.clickOnPartyId)
    * delay(100)
		* karate.log('***Personal information tab will get open by default****')   
    * match text(contactLocator.personalInfoColLoadByDefault) == contactConstant.personalInfoTabText
    * delay(1000)
   * karate.log('***Click on contact information tab****')    
	  * click(contactLocator.contactInfoTab)
    * delay(1000)  	
	
	
	#REV2-22972/REV2-22974/REV2-22975
	Scenario: On clicking edit option from three dots button, verify whether the contact information of the party 
						opening in an editable form or not for super admin
 			
	  * karate.log("*********Verifying  url after click edit on three dots of postal address***************") 
    * waitForUrl(contactConstant.contactInfoViewPageUrl)  	
		* delay(1000)
	  * karate.log('************Search for postal address on contact information list***********')
    * click(contactLocator.searchInput)
    * delay(1000)
    * input(contactLocator.searchInput,'Postal Address')
    * delay(2000)	
		* click(contactLocator.dots)
    * delay(1000)
		* def options = locateAll(contactLocator.optionOnThreeDots)
    * delay(1000)
		* options[1].click()
	  * delay(1000)
		* karate.log("*****************Verifying postal address page label************************")
    * match text(contactLocator.postalAddLabel) == contactConstant.postalAddPageLabelTxt
	  * karate.log('******* Verify Update and cancel button is exist *************')    
  	* def updateButtonExists = exists(contactLocator.updateButton)
    * if (updateButtonExists) karate.log("Update button is present")       
    * def cancelButtonExists = exists(contactLocator.cancelButton)
    * if (cancelButtonExists) karate.log("Cancel button is present") 
    * delay(1000)  
    And match text(contactLocator.updateButton) == contactConstant.updateButtonLabelTxt
    And match text(contactLocator.cancelButtonlabel) == contactConstant.cancelButtonTLabelTxt
	 	* delay(1000)
	 
	 	
	#REV2-22976/REV2-22977/REV2-22978	 
	Scenario: After clicking update button, verify whether update verification window will appear or not for super admin
	
		* click(contactLocator.searchInput)
    * delay(1000)
    * input(contactLocator.searchInput,'Postal Address')
    * delay(2000)	
		* click(contactLocator.dots)
    * delay(1000)
		* def options = locateAll(contactLocator.optionOnThreeDots)
    * delay(1000)
		* options[1].click()
	  * delay(1000)
	  * click(contactLocator.updateButton)
		* delay(1000)
	  And match text(contactLocator.updateDilogBox) == contactConstant.updateDilogBoxText
	  * delay(1000)
		* def createNewContactConfirmationBoxOptions = scriptAll(contactLocator.confirmationboxOptions, '_.textContent')
		* createNewContactConfirmationBoxOptions[0] == 'CANCEL'
		* createNewContactConfirmationBoxOptions[1] == 'CONTINUE'	
    * delay(1000)	  
    * click(contactLocator.continueButton)
    * karate.log('******* Verify label on continue button and confirmation message after click on it  *************')    
 		And match text(contactLocator.continueButton) == contactConstant.continueButtonLabelTxt
    And match text(contactLocator.confirmationMessage) == contactConstant.updateConfirmationMessageTxt   
    * karate.log('***** Verify after click on continue button it should redirect tocontactInfo page url  ****')    
    And waitForUrl(contactConstant.contactInfoPageUrl)
    * delay(10000)   
     
	 
	#REV2-22979   
	Scenario: After clicking 'Cancel' button on update verification window verify whether user will remain
	 			     on the same page or not for super admin
 
  	* click(contactLocator.searchInput)
	  * delay(1000)
	  * input(contactLocator.searchInput,'Postal Address')
	  * delay(2000)	
	  * click(contactLocator.dots)
	  * delay(1000)
	  * def options = locateAll(contactLocator.optionOnThreeDots)
	  * delay(1000)
		* options[1].click()
		* delay(1000)		
		* click(contactLocator.updateButton)
		* delay(1000)
		And match text(contactLocator.updateDilogBox) == contactConstant.updateDilogBoxText
		* delay(1000)
		* def createNewContactConfirmationBoxOptions = scriptAll(contactLocator.confirmationboxOptions, '_.textContent')
		* createNewContactConfirmationBoxOptions[0] == 'CANCEL'
		* createNewContactConfirmationBoxOptions[1] == 'CONTINUE'	
	  * delay(1000)	  
	  * karate.log('******* Verify label on cancel button and match url after click it *************')    
	  * click(contactLocator.cancelButton)
	  * delay(1000)	     
	  * waitForUrl(contactConstant.contactInfoViewPageUrl)  	
	  * delay(3000)	  
	   
	  
	#REV2-22980
	Scenario: After clicking cancel button at the bottom of the page, verify whether user will be redirected to previous
	 page or not for super admin
	
  	* click(contactLocator.searchInput)
	  * delay(1000)
	  * input(contactLocator.searchInput,'Postal Address')
	  * delay(2000)	
	  * click(contactLocator.dots)
	  * delay(1000)
	  * def options = locateAll(contactLocator.optionOnThreeDots)
	  * delay(1000)
		* options[1].click()
		* delay(1000)		
	  * karate.log('******* Verify cancel button redirect to same page *************')    
	  * click(contactLocator.cancelButton)
	  * delay(1000)	  
	  * waitForUrl(contactConstant.contactInfoViewPageUrl)  	
	  * delay(3000)	
	
	
	#REV2-22981
  Scenario: Verify the functionality of the edit icon present on the contact information page for super admin
  
  	* click(contactLocator.searchInput)
	  * delay(1000)
	  * input(contactLocator.searchInput,'Postal Address')
	  * delay(2000)	
	  * click(contactLocator.dots)
	  * delay(1000)
	  * def options = locateAll(contactLocator.optionOnThreeDots)
	  * delay(1000)
		* options[0].click()
		* delay(1000)
	  * waitForUrl('/view')  		
	  * karate.log('******* Verify functionality of edit Icon*************')        	   
		* def editIconExists = exists(contactLocator.editIcon)
    * if (editIconExists) karate.log("Edit Icon is present")  
		* delay(1000)
    * mouse().move(contactLocator.editIcon).click()	
		* waitForUrl(contactConstant.contactInfoViewPageUrl)  	
		* delay(1000)
	
	
	#REV2-22982		
  Scenario: Verify the field validation for different fields present in 'Postal address' edit form for super admin
	
		* click(contactLocator.searchInput)
	  * delay(1000)
	  * input(contactLocator.searchInput,'Postal Address')
	  * delay(1000)	
	  * click(contactLocator.dots)
	  * delay(1000)
	 	* def options = scriptAll(contactLocator.viewOptions, '_.textContent')
	  * print 'options...',options 
	  * def options = locateAll(contactLocator.viewOptions)
	  * delay(1000)
		* options[1].click()
	  * delay(3000)	
	  * karate.log('******* Verify contactType field is not editable*************')        	    
    * match contactLocator.contactTypeField == "#present"
    And match enabled(contactLocator.contactTypeField) == false  
  	* delay(2000)	
  	* karate.log('******* Verify toName field should be editable*************')        	   
    * click(contactLocator.toName)	
	  * delay(1000)	
    * clear(contactLocator.toName)	
	  * delay(1000)	
	  * value(contactLocator.toName,'harsh')	
	  * delay(2000)	
	 	* karate.log('******* Verify attention name field should be editable*************')        	   
	  * click(contactLocator.attentionNameTextBox)	
	  * delay(2000)	
    * clear(contactLocator.attentionNameTextBox)	
	  * delay(2000)	
	  * input(contactLocator.attentionNameTextBox,'pqr')	
	  * delay(1000)		 	
	  * karate.log('******* Verify doorbell field should be editable*************')        	   
	  * click(contactLocator.doorbell)	
	  * delay(1000)	
    * clear(contactLocator.doorbell)	
	  * delay(1000)	
	  * value(contactLocator.doorbell,'123')	
	  * delay(2000)	
	  * karate.log('******* Verify addressline1 field should be editable*************')        	   
	  * click(contactLocator.addressLine1)	
	  * delay(200)	
    * clear(contactLocator.addressLine1)	
	  * delay(1000)	
	  * value(contactLocator.addressLine1,'jalgaon')	
	  * delay(1000)	
	  * karate.log('******* Verify addressline2 field should be editable*************')        	   
	  * click(contactLocator.addressLine2)	
	  * delay(1000)	
	  * value(contactLocator.addressLine2,'pune')	
	  * delay(3000)
		* karate.log('******* Verify country field should be editable*************')        	   
	  * scroll(contactLocator.pincode)
	  * delay(1000)	
	  * mouse().move(contactLocator.country).click()			
	  * delay(1000)	
    * clear(contactLocator.country)	
	  * delay(3000)	
	  * def countryEditCheckbox = scriptAll(contactLocator.countryEditCheckbox, '_.textContent')
	  * print 'countryEditCheckbox',countryEditCheckbox
	  * input(contactLocator.country, ['Cana', Key.DOWN, Key.ENTER])
	  * delay(3000)	
	  * refresh()
	  * delay(1000)	 
	 	* karate.log('******* Verify state field should be editable*************')        	   
	  * scroll(contactLocator.pincode)
	  * delay(1000)	 			 
	  * mouse().move(contactLocator.state).click()
	  * delay(1000)	 			 
    * clear(contactLocator.state)	
	  * delay(1000)	 
	  * def stateChkBox = scriptAll(contactLocator.stateChkBox, '_.textContent')
	  * print 'stateChkBox',stateChkBox
	  * delay(1000)
	  * input(contactLocator.state, ['BI', Key.DOWN, Key.ENTER])
	  * delay(1000)		  
	 	* refresh()
	  * delay(5000)	 	  
	  * karate.log('******* Verify city field should be editable*************')        	   	  
	  * scroll(contactLocator.pincode)
	  * delay(1000)	 			  	  
	  * mouse().move(contactLocator.cityTextBox).click()
	 	* delay(1000)	  			 
	  * clear(contactLocator.cityTextBox)	
	 	* delay(1000)	  			 
	  * def cityCheckbox = scriptAll(contactLocator.listBox, '_.textContent')
	  * print 'cityCheckbox',cityCheckbox
	  * delay(5000)
    * input(contactLocator.cityTextBox, ['Nas', Key.UP, Key.ENTER])
  	* delay(2000)       
    * karate.log('******* Verify through date field should be editable*************')        	    	
    * input(contactLocator.date , "01/11/2021")
    * delay(1000)	  			 
    * karate.log('******* Verify pincode field should be editable*************')        	   
    * click(contactLocator.pincode)
   	* delay(1000)	  			 
    * clear(contactLocator.pincode)
    * delay(1000)	  			   
    * input(contactLocator.pincode,'425002')
	  * delay(10000)
	  

	#REV2-22983	
  Scenario: Verify the field validation for different fields present in 'Contact Email' edit form for super admin
	
		* click(contactLocator.searchInput)
	  * delay(1000)
	  * input(contactLocator.searchInput,'Email Address')
	  * delay(1000)	
	  * click(contactLocator.dots)
	  * delay(1000)
	  * highlight(contactLocator.editOption) 
    * click(contactLocator.editOption)
    * delay(1000)	 	
 	  * karate.log('******* Verify contact type field is not editable *************')       
    * match contactLocator.contactTypeField == "#present"
     And match enabled(contactLocator.contactTypeField) == false
  	* delay(2000)
  	* karate.log('******* click on contactpurposeId field*************')        	
    * mouse().move(contactLocator.contactPurposeId).click()			
		* delay(1000)    
	  * clear(contactLocator.contactPurposeId)
		* delay(1000)   	
	  * def optionsContactPurposeId = scriptAll(contactLocator.listBox, '_.textContent')
	  * print 'options...',optionsContactPurposeId 
	  * delay(1000)
		* karate.log('******* Verify contactpurposeId should be editable*************')        	  
    * input(contactLocator.contactPurposeId, ['Rec', Key.DOWN, Key.ENTER])
	  * delay(3000)
		* clear(contactLocator.contactPurposeId)
		* delay(3000)   			
    * input(contactLocator.contactPurposeId, ['Sen', Key.DOWN, Key.ENTER])
   	* delay(5000)       
 		* karate.log('******* Verify email field should be editable*************')        	  
    * click(contactLocator.email)	
	  * delay(1000)	
    * clear(contactLocator.email)	
	  * delay(3000)	
	  * value(contactLocator.email,'harsh@fnp.com')	
	  * delay(5000)	
	  * karate.log('******* Verify through date field should be editable*************')        	 
	  * click(contactLocator.date) 	
	  * delay(3000)  
    * input(contactLocator.date , "01/11/2021")
	  * delay(10000)
 
 
	#REV2-22984
	Scenario: Verify the field validation for different fields present in 'Contact Phone' edit form for super admin
	
		* click(contactLocator.searchInput)
	  * delay(1000)
	  * input(contactLocator.searchInput,'Phone Number')
	  * delay(1000)	
	  * click(contactLocator.dots)
	  * delay(1000)	   
	 	* def options = scriptAll(contactLocator.viewOptions, '_.textContent')
	  * print 'options...',options 
	  * def options = locateAll(contactLocator.viewOptions)
	  * delay(1000)
		* options[1].click()
	  * delay(3000)	
	  * karate.log('******* Verify contactType field should be editable*************')        	   
    * match contactLocator.contactTypeField == "#present"
    And match enabled(contactLocator.contactTypeField) == false  
  	* delay(2000)	
  	* karate.log('******* Verify contactpurposeId field should be editable*************')        	   
	  * mouse().move(contactLocator.contactPurposeId).click()			
		* delay(1000)    
	  * clear(contactLocator.contactPurposeId)
		* delay(1000)   	
	  * def optionsContactPurposeId = scriptAll(contactLocator.listBox, '_.textContent')
	  * print 'options...',optionsContactPurposeId 
	  * delay(1000)
    * input(contactLocator.contactPurposeId, ['Rec', Key.DOWN, Key.ENTER])
	  * delay(5000)
		* clear(contactLocator.contactPurposeId)
   	* delay(2000)      		
    * input(contactLocator.contactPurposeId, ['Sen', Key.DOWN, Key.ENTER])
   	* delay(2000)       
    * karate.log('******* Verify country field should be editable*************')        	   
    * mouse().move(contactLocator.countryCode).click()			
		* delay(1000) 
    * clear(contactLocator.countryCode)
		* delay(2000)
    * input(contactLocator.countryCode, ['21', Key.DOWN, Key.ENTER])	 
	  * delay(5000)
	  * karate.log('******* Verify phoneNo field should be editable*************')        	   
	  * click(contactLocator.phoneNo)
		* delay(3000) 
    * clear(contactLocator.phoneNo)
		* delay(5000)
    * value(contactLocator.phoneNo,'9876345678')	 
	  * delay(5000)
	  * karate.log('******* Verify through date field should be editable*************')        	   
	  * input(contactLocator.date , "01/11/2021")
	  * delay(10000)
 
 