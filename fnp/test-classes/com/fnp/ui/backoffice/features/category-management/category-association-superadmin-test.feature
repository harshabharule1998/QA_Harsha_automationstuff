Feature: Category Association Super Admin CRUD feature

  Background: 
    
    * def loginLocator = read('../../data/loginPage_locator.json')
    * def usersValue = read('../../data/users.json')
    * def dashBoardLocator = read('../../data//dashboard_locators.json')
    * def categoryLocator = read('../../data/categoryPage_locators.json')
    * def categoryConstant = read('../../data/categoryPage_constants.json')
    * def today = new java.util.Date().time
    * def num = today + ""
    * def num = num.substring(8)
    * def date = "25"
    * def month = "07"
    * def year = "2022"
    * configure driver = driverConfig
    * driver backOfficeUrl
    * print '***backofficeurl***' backOfficeUrl
    * maximize()
    * karate.log('***Logging into the application****')
    * input(loginLocator.usernameTextArea, usersValue.users.superAdmin.email)
    * delay(3000)
    * input(loginLocator.passwordTextArea, usersValue.users.superAdmin.password)
    * delay(3000)
    * click(loginLocator.loginButton)
    * karate.log('***Logging into the application****')
    * delay(3000)
    * click(dashBoardLocator.switchMenu)
    * delay(3000)
    * click(dashBoardLocator.galleriaMenu)
    * delay(4000)
    * def categoryName = scriptAll(categoryLocator.categoryNameList, '_.textContent')
    * delay(3000)
    * def options = scriptAll(categoryLocator.optionOnThreeDots, '_.textContent')
    * def elements = locateAll(categoryLocator.optionOnThreeDots)   
    * click(categoryLocator.dots)
    * delay(2000)
    * elements[0].click()
    * delay(2000)
    * karate.log('*** Open Category View Page ****')
    * def allLabelName = scriptAll(categoryLocator.tabDetails, '_.textContent')
    * match allLabelName[5] == categoryConstant.relationTabTxt
    * click(categoryLocator.relationshipTabLink)
    * delay(1000)


	#REV2-9104 and REV2-9112
  Scenario: Verify Super Admin can create category association

    * karate.log('*** Open Category Relationship Tab ****')
    * click(categoryLocator.newRelationButton)
		* delay(1000)
		* karate.log('*** Create New Relation ****')
		* mouse().move(categoryLocator.relationCategoryNameDropdown).click()
		* delay(1000)
		* def optionsList = locateAll(categoryLocator.categoryNameOptionList)
		* optionsList[0].click()
		* delay(1000)
		* mouse().move(categoryLocator.relationTypeDropdown).click()
		* delay(1000)
		* click(categoryLocator.relationTypeChildOption)
		* delay(1000)
		* input(categoryLocator.sequenceInput, 2)
		* delay(1000)
		* input(categoryLocator.fromDateInput, "01/22/2022")
		* delay(1000)
		* input(categoryLocator.toDateInput, "05/22/2022")
		* delay(1000)
		* karate.log('*** Enter Relation Details ****')
		* click(categoryLocator.createRelationButton)
		* delay(1000)
		* click(categoryLocator.continueCreateButton)
		* delay(1000)
		* waitForText('body', 'Category association created successfully')
		* delay(5000)
		* karate.log('*** Category association created successfully ****')
		
	
	#REV2-9113
  Scenario: Verify Super Admin can cancel create category association

    * karate.log('*** Open Category Relationship Tab ****')
    * click(categoryLocator.newRelationButton)
		* delay(1000)
		* karate.log('*** Create New Relation ****')
		* mouse().move(categoryLocator.relationCategoryNameDropdown).click()
		* delay(1000)
		* def optionsList = locateAll(categoryLocator.categoryNameOptionList)
		* optionsList[0].click()
		* delay(1000)
		* mouse().move(categoryLocator.relationTypeDropdown).click()
		* delay(1000)
		* click(categoryLocator.relationTypeChildOption)
		* delay(1000)
		* input(categoryLocator.sequenceInput, 2)
		* delay(1000)
		* input(categoryLocator.fromDateInput, "01/22/2022")
		* delay(1000)
		* input(categoryLocator.toDateInput, "05/22/2022")
		* delay(1000)
		* karate.log('*** Enter Relation Details ****')
		* click(categoryLocator.createRelationButton)
		* delay(1000)
		* click(categoryLocator.cancelCreateButton)
		* delay(1000)
		* click(categoryLocator.cancelRelationButton)
		* delay(1000)
		* karate.log('*** Cancel Create Relation ****')
		* waitForText('body', 'Category Relationship Management')
		* delay(5000)
		

	#REV2-9114
  Scenario: Verify Super Admin cannot create category association with blank mandatory fields
 
    * delay(1000)
    * karate.log('*** Open Category Relationship Tab ****')
    * click(categoryLocator.newRelationButton)
		* delay(1000)
		* karate.log('*** Create New Relation ****')
		* input(categoryLocator.sequenceInput, 2)
		* delay(1000)
		* input(categoryLocator.fromDateInput, "01/22/2022")
		* delay(1000)
		* input(categoryLocator.toDateInput, "05/22/2022")
		* delay(1000)
		* karate.log('*** Enter Relation Details with blank mandatory fields****')
		* click(categoryLocator.createRelationButton)
		* delay(1000)
		* karate.log('*** Create Relation ****')
		* waitForText('body', 'The form is not valid. Please check for errors')
		* delay(5000)
		
	
	#REV2-9115		
	Scenario: Verify Super Admin cannot create existing category association

    * karate.log('*** Open Category Relationship Tab ****')
    * click(categoryLocator.newRelationButton)
		* delay(1000)
		* karate.log('*** Create New Relation ****')
		* mouse().move(categoryLocator.relationCategoryNameDropdown).click()
		* delay(1000)
		* def optionsList = locateAll(categoryLocator.categoryNameOptionList)
		* optionsList[0].click()
		* delay(1000)
		* mouse().move(categoryLocator.relationTypeDropdown).click()
		* delay(1000)
		* click(categoryLocator.relationTypeChildOption)
		* delay(1000)
		* input(categoryLocator.sequenceInput, 2)
		* delay(1000)
		* input(categoryLocator.fromDateInput, "01/22/2022")
		* delay(1000)
		* input(categoryLocator.toDateInput, "05/22/2022")
		* delay(1000)
		* karate.log('*** Enter Relation Details ****')
		* click(categoryLocator.createRelationButton)
		* delay(1000)
		* click(categoryLocator.continueCreateButton)
		* delay(1000)
		* waitForText('body', 'Category association already exists')
		* delay(5000)

	
	#REV2-9119, REV2-9120, REV2-9121, REV2-9122, REV2-9123, REV2-9137 and REV2-9138
  Scenario: Verify Super Admin can view edit category association page

    * karate.log('*** Open Category Relationship Tab ****')
    * click(categoryLocator.nextAssociationPageButton)
		* delay(1000)
		* click(categoryLocator.latestAssociation)
		* delay(1000)
		* karate.log('*** Open Edit Category Relation Page ****')
		* def elements = locateAll(categoryLocator.editAssociationOption)
		* eval lastIndex = karate.sizeOf(elements) - 1
		* elements[lastIndex].click()
		* delay(1000)
		* waitFor(categoryLocator.updateAssociationButton)
		* karate.log('*** Verify Pre-populated Category Relation data ****')
		* match value(categoryLocator.relationCategoryNameInput) contains 'Send Rakhi Best Seller Gifts'
		* match script(categoryLocator.relationTypeDiv, '_.innerHTML') == 'Child'
		* match value(categoryLocator.sequenceInput) == '2'
		* match value(categoryLocator.fromDateInput) == '2022-01-22'
		* match value(categoryLocator.toDateInput) == '2022-05-22'
		* delay(5000)
		

	#REV2-9125, REV2-9130 and REV2-9131
  Scenario: Verify Super Admin can edit category association

		* karate.log('*** Open Edit Category Relation Page ****')
		* def elements = locateAll(categoryLocator.editAssociationOption)
		* eval lastIndex = karate.sizeOf(elements) - 1
		* elements[lastIndex].click()
		* delay(1000)
		* waitFor(categoryLocator.updateAssociationButton)
		* karate.log('*** Edit Category Relation data ****')
		* value(categoryLocator.relationCategoryNameInput, '')
		* delay(1000)
		* mouse().move(categoryLocator.relationCategoryNameDropdown).click()
		* delay(1000)
		* def optionsList = locateAll(categoryLocator.categoryNameOptionList)
		* optionsList[2].click()
		* delay(1000)
		* mouse().move(categoryLocator.relationTypeDiv).click()
		* delay(1000)
		* def optionsList = locateAll(categoryLocator.relationTypeOptionList)
		* optionsList[0].click()
		* delay(1000)
		* clear(categoryLocator.sequenceInput)
		* delay(1000)
		* value(categoryLocator.sequenceInput, '3')
		* delay(1000)
		* input(categoryLocator.fromDateInput, "01/11/2022")
		* delay(1000)
		* input(categoryLocator.toDateInput, "05/11/2022")
		* delay(1000)
		* karate.log('*** Update category association ****')
		* click(categoryLocator.updateAssociationButton)
		* delay(1000)
		* click(categoryLocator.continueCreateButton)
		* delay(1000)
		* waitForText('body', 'Category association updated successfully')
		* delay(5000)
		* karate.log('*** Category association updated successfully ****')
		
	
	#REV2-9126 and REV2-9128
  Scenario: Verify Super Admin can cancel edit category association after entering data
 
    * karate.log('*** Open Category Relationship Tab ****')
    * click(categoryLocator.nextAssociationPageButton)
		* delay(1000)
		* click(categoryLocator.latestAssociation)
		* delay(1000)
		* karate.log('*** Open Edit Category Relation Page ****')
		* def elements = locateAll(categoryLocator.editAssociationOption)
		* eval lastIndex = karate.sizeOf(elements) - 1
		* elements[lastIndex].click()
		* delay(1000)
		* waitFor(categoryLocator.updateAssociationButton)
		* karate.log('*** Edit Category Relation data ****')
		* value(categoryLocator.relationCategoryNameInput, '')
		* delay(1000)
		* mouse().move(categoryLocator.relationCategoryNameDropdown).click()
		* delay(1000)
		* def optionsList = locateAll(categoryLocator.categoryNameOptionList)
		* optionsList[2].click()
		* delay(1000)
		* mouse().move(categoryLocator.relationTypeDiv).click()
		* delay(1000)
		* def optionsList = locateAll(categoryLocator.relationTypeOptionList)
		* optionsList[0].click()
		* delay(1000)
		* clear(categoryLocator.sequenceInput)
		* delay(1000)
		* value(categoryLocator.sequenceInput, '3')
		* delay(1000)
		* input(categoryLocator.fromDateInput, "01/11/2022")
		* delay(1000)
		* input(categoryLocator.toDateInput, "05/11/2022")
		* delay(1000)
		* karate.log('*** Update category association ****')
		* click(categoryLocator.updateAssociationButton)
		* delay(1000)
		* click(categoryLocator.cancelCreateButton)
		* delay(1000)
		* click(categoryLocator.cancelRelationButton)
		* delay(1000)
		* karate.log('*** Cancel Update Relation ****')
		* waitForText('body', 'Category Relationship Management')
		* delay(5000)
		
	
	#REV2-9127
  Scenario: Verify Super Admin can cancel edit category association without entering data

    * karate.log('*** Open Category Relationship Tab ****')
    * click(categoryLocator.nextAssociationPageButton)
		* delay(1000)
		* click(categoryLocator.latestAssociation)
		* delay(1000)
		* karate.log('*** Open Edit Category Relation Page ****')
		* def elements = locateAll(categoryLocator.editAssociationOption)
		* eval lastIndex = karate.sizeOf(elements) - 1
		* elements[lastIndex].click()
		* delay(1000)
		* waitFor(categoryLocator.updateAssociationButton)
		* click(categoryLocator.cancelRelationButton)
		* delay(1000)
		* karate.log('*** Cancel Update Relation ****')
		* waitForText('body', 'Category Relationship Management')
		* delay(5000)
		
	
	#REV2-9129
  Scenario: Verify Super Admin can edit category association without entering data

    * karate.log('*** Open Category Relationship Tab ****')
    * click(categoryLocator.nextAssociationPageButton)
		* delay(1000)
		* click(categoryLocator.latestAssociation)
		* delay(1000)
		* karate.log('*** Open Edit Category Relation Page ****')
		* def elements = locateAll(categoryLocator.editAssociationOption)
		* eval lastIndex = karate.sizeOf(elements) - 1
		* elements[lastIndex].click()
		* delay(1000)
		* waitFor(categoryLocator.updateAssociationButton)
		* karate.log('*** Update category association ****')
		* click(categoryLocator.updateAssociationButton)
		* delay(1000)
		* click(categoryLocator.continueCreateButton)
		* delay(1000)
		* waitForText('body', 'There is nothing to update')
		* delay(5000)
		

	#REV2-9132
  Scenario: Verify Super Admin can edit category association with only mandatory data

    * karate.log('*** Open Category Relationship Tab ****')
    * click(categoryLocator.nextAssociationPageButton)
		* delay(1000)
		* click(categoryLocator.latestAssociation)
		* delay(1000)
		* karate.log('*** Open Edit Category Relation Page ****')
		* def elements = locateAll(categoryLocator.editAssociationOption)
		* eval lastIndex = karate.sizeOf(elements) - 1
		* elements[lastIndex].click()
		* delay(1000)
		* waitFor(categoryLocator.updateAssociationButton)
		* karate.log('*** Edit Category Relation data ****')
		* value(categoryLocator.relationCategoryNameInput, '')
		* delay(1000)
		* mouse().move(categoryLocator.relationCategoryNameDropdown).click()
		* delay(1000)
		* def optionsList = locateAll(categoryLocator.categoryNameOptionList)
		* optionsList[2].click()
		* delay(1000)
		* mouse().move(categoryLocator.relationTypeDiv).click()
		* delay(1000)
		* def optionsList = locateAll(categoryLocator.relationTypeOptionList)
		* optionsList[4].click()
		* delay(1000)
		* karate.log('*** Update category association with only mandatory data ****')
		* click(categoryLocator.updateAssociationButton)
		* delay(1000)
		* click(categoryLocator.continueCreateButton)
		* delay(1000)
		* waitForText('body', 'Category association updated successfully')
		* delay(5000)
		* karate.log('*** Category association updated successfully ****')
		

	#REV2-9134
  Scenario: Verify Super Admin cannot edit category association with invalid data

    * karate.log('*** Open Category Relationship Tab ****')
    * click(categoryLocator.nextAssociationPageButton)
		* delay(1000)
		* click(categoryLocator.latestAssociation)
		* delay(1000)
		* karate.log('*** Open Edit Category Relation Page ****')
		* def elements = locateAll(categoryLocator.editAssociationOption)
		* eval lastIndex = karate.sizeOf(elements) - 1
		* elements[lastIndex].click()
		* delay(1000)
		* waitFor(categoryLocator.updateAssociationButton)
		* karate.log('*** Edit Category Relation data ****')
		* value(categoryLocator.relationCategoryNameInput, '')
		* delay(1000)
		* mouse().move(categoryLocator.relationCategoryNameDropdown).click()
		* delay(1000)
		* def optionsList = locateAll(categoryLocator.categoryNameOptionList)
		* optionsList[2].click()
		* delay(1000)
		* mouse().move(categoryLocator.relationTypeDiv).click()
		* delay(1000)
		* def optionsList = locateAll(categoryLocator.relationTypeOptionList)
		* optionsList[0].click()
		* delay(1000)
		* clear(categoryLocator.sequenceInput)
		* delay(1000)
		* value(categoryLocator.sequenceInput, '3')
		* delay(1000)
		* input(categoryLocator.fromDateInput, "aa/bb/2022")
		* delay(1000)
		* input(categoryLocator.toDateInput, "aa/bb/2022")
		* delay(1000)
		* karate.log('*** Update category association with invalid data ****')
		* click(categoryLocator.updateAssociationButton)
		* delay(1000)
		* click(categoryLocator.continueCreateButton)
		* delay(1000)
		* waitForText('body', 'Invalid from date')
		* delay(5000)
		
		
	#REV2-9135
  Scenario: Verify Super Admin can edit category association with only optional data

    * delay(1000)
    * karate.log('*** Open Category Relationship Tab ****')
    * click(categoryLocator.nextAssociationPageButton)
		* delay(1000)
		* click(categoryLocator.latestAssociation)
		* delay(1000)
		* karate.log('*** Open Edit Category Relation Page ****')
		* def elements = locateAll(categoryLocator.editAssociationOption)
		* eval lastIndex = karate.sizeOf(elements) - 1
		* elements[lastIndex].click()
		* delay(1000)
		* waitFor(categoryLocator.updateAssociationButton)
		* clear(categoryLocator.sequenceInput)
		* delay(1000)
		* value(categoryLocator.sequenceInput, '3')
		* delay(1000)
		* input(categoryLocator.fromDateInput, "01/13/2022")
		* delay(1000)
		* input(categoryLocator.toDateInput, "05/15/2022")
		* delay(1000)
		* karate.log('*** Update category association with optional data ****')
		* click(categoryLocator.updateAssociationButton)
		* delay(1000)
		* click(categoryLocator.continueCreateButton)
		* delay(1000)
		* waitForText('body', 'Category association updated successfully')
		* delay(5000)
	

	#REV2-9081 and REV2-9082
  Scenario: Verify Super Admin can delete category association from list screen
    
 
    * karate.log('*** Open Category Relationship Tab ****')
    * click(categoryLocator.relationshipTabLink)
    * delay(1000)
    * karate.log('*** Open Category Association options ****')
  	* click(categoryLocator.dots)
  	* karate.log('*** Select Delete Category Relation option ****')
		* def elements = locateAll(categoryLocator.deleteAssociationOption)
		* elements[0].click()
		* delay(1000)
		* click(categoryLocator.continueDeleteButton)
		* delay(1000)
		* waitForText('body', 'Category association deleted successfully')
		* delay(5000)
		* karate.log('*** Category association deleted successfully ****')
		

	#REV2-9083
  Scenario: Verify Super Admin can cancel delete category association from list screen
 
    * karate.log('*** Open Category Relationship Tab ****')
    * click(categoryLocator.relationshipTabLink)
    * delay(1000)
    * karate.log('*** Open Category Association options ****')
  	* click(categoryLocator.dots)
  	* karate.log('*** Select Delete Category Relation option ****')
		* def elements = locateAll(categoryLocator.deleteAssociationOption)
		* elements[0].click()
		* delay(1000)
		* match enabled(categoryLocator.cancelDeleteButton) == true
		* click(categoryLocator.cancelDeleteButton)
		* delay(2000)
		* def elements = locateAll(categoryLocator.cancelDeleteButton)
		* match karate.sizeOf(elements) == 0
		* delay(3000)
		* karate.log('*** Category association delete cancelled ****')
		
	
	#REV2-9084 and REV2-9085
  Scenario: Verify Super Admin can delete category association from view screen
 
    * karate.log('*** Open Category Association options ****')
  	* click(categoryLocator.dots)
  	* karate.log('*** Select View Category Relation option ****')
		* def elements = locateAll(categoryLocator.viewAssociationOption)
		* elements[0].click()
		* delay(3000)
		* karate.log('*** Click Category Relation delete icon ****')
		* def elements = locateAll(categoryLocator.associationViewPageDeleteIcon)
		* elements[1].click()
		* delay(1000)
		* click(categoryLocator.continueDeleteButton)
		* delay(1000)
		* waitForText('body', 'Category association deleted successfully')
		* delay(5000)
		* karate.log('*** Category association deleted successfully ****')
		
		
	#REV2-9086
  Scenario: Verify Super Admin can cancel delete category association from view screen

    * karate.log('*** Open Category Association options ****')
  	* click(categoryLocator.dots)
  	* karate.log('*** Select View Category Relation option ****')
		* def elements = locateAll(categoryLocator.viewAssociationOption)
		* elements[0].click()
		* delay(3000)
		* karate.log('*** Click Category Relation delete icon ****')
		* def elements = locateAll(categoryLocator.associationViewPageDeleteIcon)
		* elements[1].click()
		* delay(1000)
		* match enabled(categoryLocator.cancelDeleteButton) == true
		* click(categoryLocator.cancelDeleteButton)
		* delay(2000)
		* def elements = locateAll(categoryLocator.cancelDeleteButton)
		* match karate.sizeOf(elements) == 0
		* delay(3000)
		* karate.log('*** Category association delete cancelled ****')
		

	#REV2-9056, REV2-9057 and REV2-9058
  Scenario: Verify Super Admin can view category association view page
 
    * karate.log('*** Open Category Association options ****')
  	* click(categoryLocator.dots)
  	* karate.log('*** Select View Category Relation option ****')
		* def elements = locateAll(categoryLocator.viewAssociationOption)
		* elements[0].click()
		* delay(3000)
		* karate.log('*** Verify Edit and Delete icon ****')
		* def elements = locateAll(categoryLocator.associationViewPageDeleteIcon)
		* match karate.sizeOf(elements) == 2
		* delay(3000)
		

	#REV2-9060
  Scenario: Verify details for Super Admin on category association view page
 
    * karate.log('*** Open Category Relationship Tab ****')
    * click(categoryLocator.relationshipTabLink)
    * delay(1000)
    * karate.log('*** Open Category Association options ****')
  	* click(categoryLocator.dots)
  	* karate.log('*** Select View Category Relation option ****')
		* def elements = locateAll(categoryLocator.viewAssociationOption)
		* elements[0].click()
		* delay(3000)
		* karate.log('*** Verify details on view page ****')
		* def data = scriptAll(categoryLocator.viewAssociationData, '_.textContent')
		* karate.log('DATA : ', data)
		* match each data[*] == '#notnull'
		* delay(3000)