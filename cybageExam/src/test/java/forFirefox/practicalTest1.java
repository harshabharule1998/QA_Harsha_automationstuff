package forFirefox;

import java.io.IOException;
import java.util.concurrent.TimeUnit;

import org.openqa.selenium.WebDriver;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeOptions;
import org.openqa.selenium.firefox.FirefoxDriver;
import org.testng.annotations.BeforeClass;
import org.testng.annotations.Test;


public class practicalTest1 {
	WebDriver driver;
	@BeforeClass
	public void mysetup() throws IOException
	{

		System.out.println("in firefox browser");
		System.setProperty("webdriver.gecko.driver", "C:\\Users\\HP\\Desktop\\automation-training-stuff\\geckodriver.exe");
		driver = new FirefoxDriver();
		driver.manage().window().maximize();
		driver.manage().timeouts().implicitlyWait(10, TimeUnit.SECONDS);
	

	}
	@Test
	public void practicalT() {
		practical1 p1=new practical1(driver);
		p1.openCybageSite();
		p1.checkIndustries();
		p1.checkJobOpening();
		p1.verifySearchPage();
		p1.goToHomePage();
		p1.clickOnCareerLink();
		p1.selectIndiaJava();
		p1.verifyIndiaJava();
		p1.goToCybageAlumini();
		p1.contactUs();
		p1.verifyHeadqurterText();
		p1.verifyPhone();
		p1.closeBrowser();
		
		
		
	}
}
