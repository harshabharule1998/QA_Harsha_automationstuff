Feature: sample karate UI google search test script

	Background:
	* def homePage = read('../../data/homePage_locators.json')
	* def resultPage = read('../../data/resultPage_locators.json')
 	* configure driver = driverConfig
 	
 	# Browser Stack settings 
 	#* def BrowserStackTarget = Java.type('com.fnp.ui.common.BrowserStackTarget')
  #* configure driverTarget = new BrowserStackTarget({url: browserStackUrl, capabilityKey: browserStackCapability })
 	
	@smoke
	Scenario: Search for text
	 Given driver backOfficeWebUrl
	 And maximize()
	 * karate.log('***Enter keyword to search****')
	 And input(homePage.searchInput, 'karate framework')
	 When click(homePage.searchButton)
	 Then match value(resultPage.searchInput) contains 'karate framework'
	 