Feature: sample karate UI google search test script

	Background:
		* def homePage = read('../../data/homePage_locators.json')
		* def resultPage = read('../../data/resultPage_locators.json')
		* def homePage_constant = read('../../data/homePage_constants.json')
		* def localeData = read('../../data/locale/' + locale + '.json')
		* configure driver = driverConfig
	  #* configure driver = { type: 'chrome' }
		* driver backOfficeUrl
	
	@smoke1
	Scenario: Search text1
		* karate.log('**********Enter one search string to test****************')
		And maximize()
		* delay(3000)
		* call read('classpath:com/fnp/ui/backoffice/features/pages/homePage.feature@searchText1') { searchText: '#(homePage_constant.inputString1)',timeToWait:'2000'}
		#Then match value(resultPage.searchInput) contains 'karate framework'
		Then match value(resultPage.searchInput) contains localeData.searchInputText1

	@smoke	
	Scenario: Search text2
	  * karate.log('****************Enter another search string to test********************')
	  And maximize()
	  * callonce read('classpath:com/fnp/ui/backoffice/features/pages/homePage.feature@searchText2') { searchText: '#(homePage_constant.inputString2)'}
	  Then match text(homePage.resultText) contains homePage_constant.expectedValue
	 
	#Scenario for reusable function 
	@smoke2
	Scenario: Search text3
	  * karate.log('****************Enter another search string to test********************')
	  And maximize()
	  * callonce read('classpath:com/fnp/ui/backoffice/features/pages/homePage.feature@searchText2') { searchText: '#(homePage_constant.inputString2)'}
	  * def data = call read('classpath:com/fnp/ui/common/common-functions.feature@getText') {elementLocator: '#(homePage.resultText)'}
	  Then match data.text contains homePage_constant.expectedValue
	 