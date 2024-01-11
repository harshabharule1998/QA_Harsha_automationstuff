Feature: Homepage common features 

	Background:
	* def homePage = read('../../data/homePage_locators.json')
	* def homePage_constant = read('../../data/homePage_constants.json')

	@searchText1
	Scenario: Search text karate framework
	 And input(homePage.searchInput, __arg.searchText)
	 * call read('classpath:com/fnp/ui/backoffice/features/pages/homePage.feature@submit')
	 * delay(2000)
 
	@searchText2
	Scenario: Search text fnp
	 #OR And input(homePage.searchInput, homePage_constant.inputString)
	 And input(homePage.searchInput, __arg.searchText)
	 * call read('classpath:com/fnp/ui/backoffice/features/pages/homePage.feature@submit')
	 #OR When click(homePage.searchButton)
 
 
	@submit
	Scenario: Submit Search
	 When click(homePage.searchButton)
 
 