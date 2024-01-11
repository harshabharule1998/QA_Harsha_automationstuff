package forFirefox;

import java.util.Iterator;
import java.util.List;
import java.util.Set;

import org.openqa.selenium.By;
import org.openqa.selenium.Keys;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.interactions.Actions;
import org.openqa.selenium.support.ui.Select;
import org.testng.asserts.SoftAssert;

import junit.framework.Assert;

public class practical1 {

	WebDriver driver;
	Actions act;
	
	By industries=By.linkText("INDUSTRIES");
	By searchIcon=By.cssSelector("img[alt=\"Icon_search.png\"]");
	By enterText=By.cssSelector("input[placeholder=\"Search\"]");
	By travel= By.linkText("Travel & Hospitality");
	By media=By.linkText("MEDIA & ADVERTISING");
	By searchPageVerify=By.className("pageTitle");
	By home =By.linkText("Home");
	By career=By.linkText("CAREERS");
	By location=By.id("edit-location-id");
	By java=By.cssSelector("input[data-drupal-selector=\"edit-key\"]");
	By go=By.id("edit-submit-general-pages-and-blocks");
	By india=By.className("h-22x");
	By javaVerify=By.className("js-views-accodion-group-header");
	By cybageAluminiNw=By.linkText("Cybage Alumni Network");
	By contact=By.className("title");
	By headQuarter=By.cssSelector(".loc_add");
	By contact1=By.cssSelector(".loc_add span");


//	By headQuarter=By.cssSelector("div[class=\"loc_add\"]span");
	By phone=By.cssSelector("div[class=\"loc_add\"]");
	
	
	public practical1(WebDriver d)
	{
		this.driver=d;
		act=new Actions(d);
		
	}
	public void openCybageSite() {
		driver.get("http://www.Cybage.com");
			}
	public void checkIndustries() {
		WebElement w=driver.findElement(industries);
		act.moveToElement(w).build().perform();
		SoftAssert srt = new SoftAssert();
		String act="Travel & Hospitality";
		String exp=driver.findElement(travel).getText();
		srt.assertEquals(act, exp);
		System.out.println("Travel & Hospitality verified suceessfully!!");
		String act1=" MEDIA & ADVERTISING";
		String exp1=driver.findElement(media).getText();
		srt.assertEquals(act1, exp1);
		System.out.println(" MEDIA & ADVERTISING verified suceessfully!!");
	
	}
	public void checkJobOpening() {
		driver.findElement(searchIcon).click();
		driver.findElement(enterText).sendKeys("job Opening",Keys.ENTER);
	

	}
	public void verifySearchPage() {
		
		String act="Search Results";
		String exp=driver.findElement(searchPageVerify).getText();
		Assert.assertEquals(act, exp);
		System.out.println("search Result, verified suceessfully!!");
		
		
	}
	public void goToHomePage() {
		act.moveToElement(driver.findElement(home)).click().build().perform();
		
	}
	public void clickOnCareerLink() {
		act.moveToElement(driver.findElement(career)).click().build().perform();
	}
	public void selectIndiaJava() {
		Select loc= new Select(driver.findElement(location));
		loc.selectByVisibleText("India");
		driver.findElement(java).sendKeys("java");
		act.moveToElement(driver.findElement(go)).click().build().perform();

		
		
	}
	public void verifyIndiaJava() {
		
		String act="India";
		String exp=driver.findElement(india).getText();
		Assert.assertEquals(act, exp);
		System.out.println("India, verified suceessfully!!");
		String act1="Java";
		String exp1=driver.findElement(javaVerify).getText();
		Assert.assertEquals(act1, exp1);
		System.out.println("Java, verified suceessfully!!");
	}
	public void goToCybageAlumini() {
		driver.findElement(cybageAluminiNw).click();
	}
	public void contactUs() {
		

		Set<String> s=driver.getWindowHandles();
		Iterator<String>itr=s.iterator();

		String a=itr.next();
		String b=itr.next();
		driver.switchTo().window(b);
		driver.findElement(contact).click();

	}
	public void verifyHeadqurterText() {
	
//		String h=driver.findElement(headQuarter).getText();
//		Assert.assertTrue(h.equals("Cybage Head Quarter"));
		List<WebElement> contacts=driver.findElements(headQuarter);
		
		Assert.assertEquals(contacts.get(0).getText(),"Cybage Head Quarters");
		System.out.println("headQuarter, verified suceessfully!!");
	}
	public void verifyPhone() {
		String ph=driver.findElement(phone).getText();
		Assert.assertTrue(ph.contains("91 20 6604 4700"));
		System.out.println("phone number, verified suceessfully!!");
		
	}
	public void closeBrowser() {
		driver.quit();
		
	}
}
