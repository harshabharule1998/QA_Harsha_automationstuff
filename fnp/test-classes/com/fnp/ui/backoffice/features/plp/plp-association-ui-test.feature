Feature: Listing page Relationship Super Admin User feature

 	Background: 
		* def loginLocator = read('../../data/loginPage_locator.json')
    * def usersValue = read('../../data/users.json')
    * def dashBoardLocator = read('../../data//dashboard_locators.json')
    * def associationLocators = read('../../data/plp/associationLocators.json')
    * def associationConstants = read('../../data/plp/associationConstants.json')
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
    * delay(3000)
    And click(dashBoardLocator.switchMenu)
    * delay(1000)
    * highlight(dashBoardLocator.galleriaMenu)
    * delay(1000)  
    * click(dashBoardLocator.galleriaMenu)
    * delay(4000)
  	* match text(associationLocators.categorymngmntHeading) == (associationConstants.categorymngmntText)
    * delay(4000) 
	  * click(associationLocators.searchByCategoryId)
		* delay(3000)	
		* input(associationLocators.searchByCategoryId,associationConstants.categoryIdTxt)
    * delay(10000) 		
	  * def optionsOnCategoryId = locateAll(associationLocators.optionOnThreeDots)
    * delay(4000)
		* optionsOnCategoryId[0].click()
	  * delay(2000)
	  * click(associationLocators.productTab)
   	* delay(3000)
    
    
      * def isValidDateFormat =
    
							"""
							function(date) {
							var Status
								var date_regex = /^([1-9]|0[1-9]|1[0-2])\/(0[1-9]|1\d|2\d|3[01])\/(19|20)\d{2}$/;
								if (!(date_regex.test(date))) {
    							return false;
								} else {
									return true;
								}
							}					
           
							"""
   
	#REV2-23727 
  Scenario: Verify Product Listing Page Header Menu

    * delay(1000)  
    * highlight('{li/a}Menu')
   * mouse().move('{li/a}Menu').click()
        * delay(5000)  
    
  
	Scenario:
	
    #And match script('{^span}AUTO POPULATE ', '_.innerHTML') == 'AUTO POPULATE '  	
    #* match text('{^span}AUTO POPULATE ') contains "AUTO POPULATE 
  
	  * def fromDates = scriptAll("table tr td.column-fromDate", '_.textContent')
	  * def fromDates = locateAll("table tr td.column-fromDate")
    * print 'fromDates...', fromDates
  	* karate.log("*****Verifying from date format***** ")  
		* def doadate = fromDates[0]
		* karate.log(doadate)				
		* def isValid = isValidDateFormat(doadate)
		* karate.log(" from Date in DD/MM/YYYY format is : ", isValid)
  	* karate.log("*****Verifying through date format***** ")  
    * def thruDates = scriptAll("table tr td.column-thruDate", '_.textContent')	  
    * print 'thruDates...', thruDates
		* def dobdate = thruDates[0]
		* karate.log(dobdate)	
		* def isValid = isValidDateFormat(dobdate)
		* karate.log("through Date  DD/MM/YYYY format is : ", isValid)		
   	* delay(5000)	
   	
   	
	#REV2-23728/#REV2-23727 
	Scenario: Verify the Tabs present in product listing page of a category
		
	
	  * def productListPageTabs = scriptAll(associationLocators.productListPageTabs, '_.textContent')
    * print 'productListPageTabs...', productListPageTabs
    * delay(1000)
    * highlight(associationLocators.productTab)
    * delay(2000)  
    * click(associationLocators.productTab)
   	* delay(5000)
  	* match text(associationLocators.updateButton) == (associationConstants.updateButtonTxt)
    * delay(2000) 	
    * def productTabColumns = scriptAll(associationLocators.productTabColumns, '_.textContent')
    * print 'productTabColumns...', productTabColumns  
   	* productTabColumns[1] == "Product Name & ID"
    * productTabColumns[2] == "Sequence"
   	* productTabColumns[3] == "From Date"
    * productTabColumns[4] == "Through Date"
    * productTabColumns[5] == "Last Updated Stamp"
    * productTabColumns[6] == "Created By"
    * productTabColumns[7] == "Last Updated By"	
	  * delay(2000)
    * def allThreeDots = scriptAll(associationLocators.threeDots, '_.textContent')
    * print 'allThreeDots...', allThreeDots
    * delay(2000)  
    * mouse().move(associationLocators.autopopulateChkbox).click()
    * delay(2000)
    #* def autopopulateTxt = scriptAll("[class='ra-field ra-field-undefined'] div div span:nth-child(2)", '_.textContent')
    #* delay(1000)
#		* match autopopulateTxt[3] == "AUTO POPULATE "
	  * delay(2000)
    #* match text('{^span}AUTO POPULATE ') contains "AUTO POPULATE "
    * match text(associationLocators.frequency) == "Frequency"
    * delay(1000)
 		* highlight(associationLocators.frequency)  
    * delay(1000)		 
    * mouse().move(associationLocators.frequency).click()
    * delay(5000)
    * def frequencyOptions = scriptAll(associationLocators.paginationDropDownOption, '_.textContent')
    * print 'frequencyOptions...', frequencyOptions  
    * match frequencyOptions[0] == "Frequency" 
    * match frequencyOptions[1] == "Weekly" 
    * match frequencyOptions[2] == "Monthly" 
    * match frequencyOptions[3] == "Fortnight" 
    * match frequencyOptions[4] == "Daily" 
   
    * delay(1000)
    * def allButtonsOnProductTab = scriptAll(associationLocators.allButtonsOnProductTab, '_.textContent')
    * allButtonsOnProductTab[0] == "Populate" 
    * allButtonsOnProductTab[1] == "Hide Suppressed Products"    
    * allButtonsOnProductTab[2] == "Add Products To Category"
    * allButtonsOnProductTab[3] == "Auto Sequence Category" 
    * delay(5000)
     
  
	#REV2-23729
	Scenario: Verify pagination functionality of product list page
	
		  
    * scroll(associationLocators.paginationOnList)
    * delay(2000)
    * def paginationTxt = scriptAll(associationLocators.paginationTxtOnList, '_.textContent')
    * print 'Pagination txt', paginationTxt
    * match paginationTxt[0] contains 'Rows per page'
    * delay(1000)
    * mouse().move(associationLocators.paginationDropdownTxt).click()
    * delay(3000)
    * def optionOnPagin = locateAll(associationLocators.paginationDropDownOption)
    * delay(5000)
    * optionOnPagin[0].click()
    * delay(10000)
	
	
	#REV2-23730
	Scenario: Verify the checkboxes of the products associated with the category
		  
		* mouse().move(associationLocators.checkbox).click()
		* delay(5000)
		And match enabled(associationLocators.populate) == false
		And match enabled(associationLocators.addProductToCategory) == false
		And match enabled(associationLocators.hideSuppressedProduct) == false
		And match enabled(associationLocators.autoseqCategory) == false
#		And match enabled("[aria-label='Populate']") == false
	* delay(5000)
	

 #REV2-23731	
	Scenario: Verify the Edit option and Edit Page Screen
		
   	* click(associationLocators.dots)
    * delay(10000) 	
   #	* def productNameOptions = scriptAll(associationLocators.productNameOptions, '_.textContent')
    #* print 'productNameOptions....', productNameOptions
   	* match text(associationLocators.editOption) contains "Edit"
   	* match text(associationLocators.deleteOption) contains "Delete"
    * delay(1000) 
    * delay(1000)
	  * def productTabColumns = scriptAll(associationLocators.productTabColumns, '_.textContent')
    * print 'productTabColumns...', productTabColumns  
   	* productTabColumns[0] == "Product Name & ID"
    * productTabColumns[1] == "Sequence"
    * productTabColumns[2] == "Last Updated Stamp"
    * productTabColumns[3] == "Created By"
    * productTabColumns[4] == "Last Updated By"	
	  * delay(2000)
	  
	 
	#REV2-23732
	Scenario: Verify From & Through Date of Edit page screen
				
	
    * click(associationLocators.dots)  
    * delay(2000) 
    * def threedotOptionsOnProductTab = locateAll("#long-menu div ul a")  
    * delay(1000) 
	  * threedotOptionsOnProductTab[0].click()
    * delay(4000)
	  * def productTabColumns = scriptAll(associationLocators.productTabColumns, '_.textContent')
    * print 'productTabColumns...', productTabColumns  
   	* productTabColumns[0] == "Product Name & ID"
    * productTabColumns[1] == "Sequence"
    * productTabColumns[2] == "Last Updated Stamp"
    * productTabColumns[3] == "Created By"
    * productTabColumns[4] == "Last Updated By"	
	  * delay(3000)
	  * def productTabColumnsValues = scriptAll(associationLocators.productTabValues, '_.textContent')
    * print 'productTabColumnsValues...', productTabColumnsValues  
   	* match productTabColumnsValues[0] == "#present"
	  * match productTabColumnsValues[1] == "#present"
	  * match productTabColumnsValues[2] == "#present"
	  * match productTabColumnsValues[3] == "#present"
	  * delay(4000)
	  * karate.log('**** Verify throgh date always greater than form date ***')  
    * mouse().move("[placeholder='DD/MM/YYYY']").click()
		* delay(1000)
		* click('{span/p}20')
		* delay(3000)
		* click('{^span}OK')
	  * delay(3000)
		* mouse().move(associationLocators.throughDate).click()
	  * delay(4000)  
    * click('{span/p}19')
	  * delay(4000)	
		* click('{^span}OK')
	  * delay(3000)
    * click(associationLocators.saveButton)
    * delay(1000)   
    * def validationThroghDate = scriptAll(associationLocators.validationTxtFromThroughDate, '_.textContent') 
    * validationThroghDate[1] == "ThroughDate and Time is not greater than FromDate and Time"
    * delay(3000)
    * karate.log('**** Verify after giving from and through date click on save button***')    
    * refresh()
    * delay(2000)
    * mouse().move("[placeholder='DD/MM/YYYY']").click()
		* delay(1000)
    * delay(4000) 
	  * click('{span/p}20')
	  * delay(3000)   
		* mouse().move('{^span}OK').click()
	  * delay(3000)
	  * mouse().move(associationLocators.throughDate).click()
		* delay(4000)  
#		* def clickOnRighArrow = locateAll("[aria-hidden='true']:last-child")  
    #* delay(1000) 
#	  * mouse().move(clickOnRighArrow[6]).click()
    * click('{span/h6}2022')
    * delay(4000) 
    * click('{div}2023')
    * delay(4000) 
    * click('{span/p}22')
	  * delay(4000)	
		* click('{^span}OK')
	  * delay(3000)  
    * click(associationLocators.saveButton)
    * delay(1000)   
    * def dialogBox = scriptAll(associationLocators.dilogBox, '_.textContent')
    * print 'dilogBox...', dilogBox
    * delay(2000)         
    * def yesButtonOnDilogbox = locateAll(associationLocators.buttonsOnDilogbox)  
    * yesButtonOnDilogbox[1].click()
   	* match text(associationLocators.alertMsg) == (associationConstants.popupMsgOnUpdateProduct)
	  * delay(10000)
	  
	  
	   
	Scenario:	  
	  * karate.log("*****Verifying cancel button after open product edit page***** ")  
	  * click(associationLocators.dots)  
    * delay(2000) 
    * def threedotOptionsOnProductTab = locateAll("#long-menu div ul a")  
    * delay(1000) 
	  * threedotOptionsOnProductTab[0].click()
    * delay(2000)
	  * click(associationLocators.cancelButton)  
    * delay(2000) 
    * waitForUrl('/show/products')
	  * delay(5000)
	 * karate.log("*****Verifying click on No button on confirmation dilog box after click on save ***** ")  
    * click(associationLocators.dots)  
    * delay(2000) 
    * def threedotOptionsOnProductTab = locateAll("#long-menu div ul a")  
    * delay(1000) 
	  * threedotOptionsOnProductTab[0].click()
    * delay(2000)
    * mouse().move("[placeholder='DD/MM/YYYY']").click()
		* delay(1000)
	  * click('{span/p}20')
	  * delay(3000)   
		* click('{^span}OK')
	  * delay(3000)
	  * mouse().move(associationLocators.throughDate).click()
		* delay(4000)  
    * click('{span/p}22')
	  * delay(4000)	
	     
		* click('{^span}OK')
	  * delay(3000)  
    * click(associationLocators.saveButton)
    * delay(1000)   
    * match text(associationLocators.dilogBoxConfirmationTxt) == 'Are you sure you want to save?'
    * delay(2000)        
    * highlight(associationLocators.cancelButtonOnDeleteProductConfirmationbox) 
    * click(associationLocators.cancelButtonOnDeleteProductConfirmationbox)
    * delay(1000)   
   	* waitForUrl('/categories/products/')
	  * delay(10000)
	  
	 
	#REV2-23735/REV2-23736
	Scenario: Verify UI of Product listing page to category  
	  
	  * match associationLocators.thinLineUnderNineTabs == "#present"
	  * delay(1000)  
	  * click(associationLocators.dots)  
    * delay(2000) 
    
    * def threedotOptionsOnProductTab = locateAll("#long-menu div ul a")  
    * delay(1000) 
	  * threedotOptionsOnProductTab[0].click()
    * delay(4000)
   	* match text(associationLocators.editProductPageLabel) == "Edit Products"
    * delay(3000)  	
	  
	
	#REV2-23737  
	Scenario: Verify UI of Delete products for Category page
	  
	  * delay(4000)
		* click(associationLocators.dots)  
    * delay(1000) 
	  * def threedotOptionsOnProductTab = locateAll(associationLocators.productNameOptions)  
    * delay(1000) 
	  * threedotOptionsOnProductTab[1].click()
    * delay(4000)
    * def deleteProductConfirmationBox = scriptAll(associationLocators.deleteProductConfirmationBox, '_.textContent')
    * print 'deleteProductConfirmationBox...', deleteProductConfirmationBox
    * delay(1000)  
    * delay(2000)         
    * mouse().move(associationLocators.deleteCommentBox).click()
    * delay(1000)   
    * input(associationLocators.deleteCommentBox,"automation test")
    * delay(3000)
    And match enabled(associationLocators.saveOnDeleteProductConfirmationBox) == true 
    * delay(1000)
    * click(associationLocators.saveOnDeleteProductConfirmationBox)
    * match text(associationLocators.alertMsg) == "1 Records Deleted"
    * delay(5000) 
    
    
   
 	Scenario: Verify UI of Delete products for Category page click on cancel button   
    * delay(4000)
		* click(associationLocators.dots)  
    * delay(1000) 
	  * def threedotOptionsOnProductTab = locateAll(associationLocators.productNameOptions)  
	  * threedotOptionsOnProductTab[1].click()
    * delay(4000)
    * match text(associationLocators.ConfirmationboxMsg) == "Delete  1 selected product"
    * click(associationLocators.cancelButtonOnDeleteProductConfirmationbox)
    * delay(1000)   
    * waitForUrl('/show/products')
    * delay(5000) 
    
    
	#REV2-23739
	Scenario: Verify the Show Suppressed products
	
	  * click(associationLocators.hideSuppressedProduct)
    * delay(3000)	
   	* match text(associationLocators.hideSuppressedProduct) == 'Hide Suppressed Products'
    * delay(1000) 	
    * click('{^span}Yes')
	  * delay(3000)
		* click(associationLocators.showSuppressedProduct)
	  * delay(1000) 	
		* match text(associationLocators.dilogBoxConfirmationTxt) == 'Show Suppressed Products?'
		* delay(1000) 
		* click('{^span}Yes')
	  * delay(3000)
	  * click(associationLocators.hideSuppressedProduct)
    * delay(3000)	
    * click('{^span}No')
	  * delay(3000)
		
	
	#REV2-23740
	Scenario: Verify the Add Product Page
	
		* click(associationLocators.addProductToCategory)
	  * delay(3000)
		* waitForUrl('/AddProduct/add-product-category')
	  * delay(2000)
		* waitForText(associationLocators.pageTitle,'Add Products')
	  * delay(2000)
	  * match text(associationLocators.heading) contains 'Add Products to '
	  * delay(2000)
	  * def addProductToCategoryCol = scriptAll("table tr", '_.textContent')
    * print 'addProductToCategoryCol...', addProductToCategoryCol
    * delay(2000)
    * match text(associationLocators.productIdLabel) == 'Product ID *'
    * match text(associationLocators.sequenceLabel) == 'Sequence *'

   * def fromThroghDateLabel = locateAll(associationLocators.fromThroghDateLabel)
   * fromThroghDateLabel[0] == 'From Date *'
   * fromThroghDateLabel[1] ==	'Through Date '
    * delay(2000)
    

	#REV2-23741/REV2-23742/REV2-23747
  Scenario:  Verify list of added products on Add Products to category page
  	
  	* click(associationLocators.addProductToCategory)
	  * delay(3000)
  	* mouse().move(associationLocators.productIdTextBox).click()
  	* delay(3000)
    * input(associationLocators.productIdTextBox,"EXP2765")
  	* delay(3000)
    * mouse().move(associationLocators.sequenceTextbox).click()
  	* delay(1000)
  	* input(associationLocators.sequenceTextbox,1)
  	* delay(1000)
  	* mouse().move("[placeholder='DD/MM/YYYY']").click()
		* delay(1000)
	  * click('{span/p}20')
	  * delay(3000)   
		* click('{^span}OK')
	  * delay(3000)
  	* click(associationLocators.addToListButton) 
    * delay(3000)
    * def productTabColumnsValues = scriptAll(associationLocators.productTabValues, '_.textContent')
    * print 'productTabColumnsValues...', productTabColumnsValues  
	  * delay(4000)
    * click('{^span}ADD')
    * delay(1000)  
    * match text(associationLocators.ConfirmationboxMsg) == "Add products to category?"
    * delay(3000)
		* click('{^span}Yes')
	 	* match text(associationLocators.alertMsg) == "1 Product(s) Successfully Added"
	  * delay(3000)
   

  #REV2-23743
  Scenario: Verify the error when user tries to add product without providing inputs to mandatory fields
  
 		* click(associationLocators.addProductToCategory)
	  * delay(3000)
  	* click(associationLocators.addToListButton) 
    * delay(3000)
    * match text(associationLocators.alertMsg) == 'Required Fields cannot be empty'
	  * delay(3000)
  	
	
  #REV2-23744 
  Scenario: Verify the error when user tries to add product with invalid ProductID
  
  	* click(associationLocators.addProductToCategory)
	  * delay(3000)
  	* mouse().move(associationLocators.productIdTextBox).click()
  	* delay(3000)
    * input(associationLocators.productIdTextBox,"EXP2765")
  	* delay(3000)
  	* mouse().move("[placeholder='DD/MM/YYYY']").click()
	  * delay(3000)   
		* click('{^span}OK')
	  * delay(3000)
  	* click(associationLocators.addToListButton) 
  	* match text(associationLocators.alertMsg) == 'Required Fields cannot be empty'
    * delay(3000)
    * mouse().move(associationLocators.sequenceTextbox).click()
  	* delay(1000)
  	* input(associationLocators.sequenceTextbox,"a")
  	* delay(3000)
    * click(associationLocators.addToListButton)  	
  	* match text(associationLocators.alertMsg) == 'Invalid input data'
  	* delay(3000)
  
  
 
  #REV2-23746
  Scenario: Verify the error when user tries to add product with invalid From Date
    
    * click(associationLocators.addProductToCategory)
	  * delay(3000)
  	* mouse().move(associationLocators.productIdTextBox).click()
  	* delay(2000)
    * input(associationLocators.productIdTextBox,"EXP2765")
  	* delay(3000)
  	* mouse().move(associationLocators.sequenceTextbox).click()
  	* delay(1000)
  	* input(associationLocators.sequenceTextbox,1)
  	* delay(2000)
    * click(associationLocators.addToListButton) 	
    * match text(associationLocators.alertMsg) == 'From Date : Invalid date format'
	  * delay(3000)
	  * karate.log('**** Verify throgh date always greater than form date ***')  
    * mouse().move("[placeholder='DD/MM/YYYY']").click()
		* delay(1000)
		* click('{span/p}20')
		* delay(3000)
		* click('{^span}OK')
	  * delay(3000)
		* mouse().move(associationLocators.throughDate).click()
	  * delay(4000)  
    * click('{span/p}19')
	  * delay(4000)	
		* click('{^span}OK')
	  * delay(3000)
    * click(associationLocators.addToListButton) 	   
    * match text(associationLocators.alertMsg) == 'FROM DATE cannot be larger than THROUGH DATE'
    * delay(3000)
   
   
	@smoke123 
	#REV2-23749/REV2-23750
	Scenario: Verify the Populate category Page Breadcrumb and Heading
		
		* click('{^span}Populate')
		* delay(2000)
		* waitForUrl('/category/populate-category')
		* delay(2000)
		* match text(associationLocators.pageTitle) == 'Populate'
	  * delay(2000)
	  * match text(associationLocators.heading) contains 'Populate Category: '
		* delay(2000)
		* def populateCategoryMainOpt = locateAll(associationLocators.populateCategoryMainOpt)
    * print 'populateCategoryMainOpt...', populateCategoryMainOpt
    * populateCategoryMainOpt[0] == 'Consideration:'
    * populateCategoryMainOpt[1] == 'Look Back Period:'
    * populateCategoryMainOpt[2] == 'Shipping Method Distribution:'
    * populateCategoryMainOpt[3] == 'Total:'
    * def populateCategorySubOpt = scriptAll('.simple-form span', '_.textContent')
    * print 'populateCategorySubOpt...', populateCategorySubOpt
    * match populateCategorySubOpt[3] == 'Geo'
    * match populateCategorySubOpt[7] == 'Category'
    * match populateCategorySubOpt[11] == 'Number of Days'
    * match populateCategorySubOpt[16] == 'Date Range'
    * match populateCategorySubOpt[19] == 'Hand Delivery'
    * match populateCategorySubOpt[21] == 'Courier'
    * match populateCategorySubOpt[23] == 'Digital'
    * match populateCategorySubOpt[25] == 'International'
    * match populateCategorySubOpt[27] == 'Cancel'
    #* match populateCategorySubOpt[30] == 'Apply'
    * delay(2000)
		* click('{span}Date Range')
		* delay(2000)
		* def fromThroghDateLabel = locateAll(associationLocators.fromThroghDateLabel)
   * fromThroghDateLabel[0] == 'From Date '
   * fromThroghDateLabel[1] ==	'To Date  '
    * delay(2000)
    
 @smoke123 
 #REV2-23751
 Scenario: Verify Populate category functionality by selecting Geo
 	
 	
    