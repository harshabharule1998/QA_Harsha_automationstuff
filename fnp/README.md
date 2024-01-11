# QA Automation

This repository contains BackOffice API and Zeus UI automation codebase.

Required Softwares:

	Eclipse
	Apache-Maven-3.6.1
	Java - 1.8.*

Setup steps :

	1) clone repository
	2) build project with 'mvn clean install'

Steps for running scenarios :

	1) Add tag to scenario, and update the same tag in following file :

	/src/test/java/com/fnp/api/backoffice/features/SmokeTestRunner.java

	2) Run above file as a JUnit test

	3) Command for running test suite through command line - 
		
	mvn test -Dtest=SmokeTestRunner
	

Reports :

	Reports are generated in html format at following location : 
	
	target/cucumber-html-reports