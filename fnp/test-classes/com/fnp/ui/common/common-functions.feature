Feature: Reusable functions

	Background: Create reusable functions

	@getText
	Scenario: Function to take parameter as locator and return text
	* waitForEnabled(__arg.elementLocator)
	* def text = text(__arg.elementLocator)
		
	@WaitAndClick
	Scenario: Function to wait for element and click
	* retry(2).waitFor(__arg.elementLocator)
	* click(__arg.elementLocator)
	
	#To be used only in specific case
	@ClickAndWait
	Scenario: Function used click on element and wait for specific time
	* click(__arg.elementLocator)
	* delay(__arg.timeToWait)
			
	@waitForElementVisible
	Scenario: Function to wait until element gets visible
	* waitFor(__arg.elementLocator)
