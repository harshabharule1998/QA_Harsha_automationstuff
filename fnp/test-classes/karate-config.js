function fn() {
	
	var result;
	var env = karate.properties['karate.env'] || 'qaui'; // get system property 'karate.env'
	var brand = karate.properties['karate.brand'] || 'IND'; // default is india
	var locale = karate.properties['karate.locale'] || 'en_US'; // default is en_US
	var driverType = karate.properties['karate.browser'] || 'chrome'; // default is chrome
	var data = read('classpath:envdata.json')
	var envData = JSON.parse(data);
	// replace username:accesskey in below url with your credentials
	var browserStackUrl = "https://username:accesskey@hub-cloud.browserstack.com/wd/hub"
	var browserStackCapability = "win10Chrome86" 
	
	//karate.configure('ssl', { keyStore: 'classpath:keystore.jks', keyStorePassword: 'TBD', keyStoreType: 'jks',trustStore: 'classpath:trustStore.jks', trustStorePassword: 'TBD', trustStoreType: 'jks' });
	//we need to add this if needed else later delete it.
	var backOfficeUrl;
	var partnerPortalUrl;
	var corporateUrl;
	karate.log('karate.env system property was:', env);
	if (env =="qaui" || env == "stageui") {
		
		karate.log('******** SITE URL **************** : ', envData[0][env][brand].backOfficeUrl);
		karate.log('******** LOCALE **************** :', locale);
		karate.log('******** DRIVER TYPE **************** :', driverType);
		
		backOfficeUrl = envData[0][env][brand].backOfficeUrl;
		partnerPortalUrl = envData[0][env][brand].partnerPortalUrl;
		corporateUrl = envData[0][env][brand].corporateUrl;
	
	}
	
	
		
	switch(driverType) {
	 case "chrome":
		  	driverType = 'chrome';
		  	break;
	 case "firefox":
		  	driverType = 'geckodriver';
		  	break;
	};
	
	var config = {
			    apiHeader: {'Content-type': 'application/json'},
			    driverConfig: {type: driverType,addOptions: ['--incognito']},
			    locale: locale,
			    backOfficeUrl: "https://zeus-test-r2.fnp.com/",
			    backOfficeAPIBaseUrl: "https://api-test-zeus-r2.fnp.com",
			    partnerPortalUrl: partnerPortalUrl,
			    corporateUrl: corporateUrl,
			    browserStackUrl: browserStackUrl,
			    browserStackCapability: browserStackCapability
	};
 
	switch(env) {
	  
	  case "qaapi":
		 	result = karate.callSingle('classpath:com/fnp/api/utils/generatetoken.feature');
		  	config.apiBaseUrl = "qa_api_url";
		   	config.apiHeader.Authorization = result.accessToken;
		  	break;
	  case "stageapi":
		  	result = karate.callsingle('classpath:com/fnp/api/utils/generatetoken.feature');
		  	config.apiBaseUrl = "Stage_api_url";
		   	config.apiHeader.Authorization = result.accessToken;
		  	break;
	 }
	
	if(env == "qaui" || env == "stageui") {
		karate.log('********your env*************', env);
		karate.configure('afterScenario', read('screenshot.js'));
	}
	
	karate.configure('connectTimeout', 5000);
	karate.configure('readTimeout', 5000);
  
	return config;
}