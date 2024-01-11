Feature: sample karate UI google search test script

	Background:
		* def homePage = read('../../data/homePage_locators.json')
		* def resultPage = read('../../data/resultPage_locators.json')
		* def homePage_constant = read('../../data/homePage_constants.json')
		* def localeData = read('../../data/locale/' + locale + '.json')
		* configure driver = driverConfig
	  		
	@locale
	Scenario: Search text1
	Given driver backOfficeWebUrl
		* karate.log('**********Enter one search string to test****************')
		And maximize()
		* call read('classpath:com/fnp/ui/backoffice/features/pages/homePage.feature@searchText1') { searchText: '#(homePage_constant.inputString_ar)'}
		Then match value(resultPage.searchInput) contains 'karate framework'
		Then match value(resultPage.searchInput) contains localeData.searchInputText1
		And print locale
		