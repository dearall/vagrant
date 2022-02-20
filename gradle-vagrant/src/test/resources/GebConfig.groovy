import org.openqa.selenium.chrome.ChromeOptions
import org.openqa.selenium.firefox.FirefoxDriver
import org.openqa.selenium.chrome.ChromeDriver
import org.openqa.selenium.remote.DesiredCapabilities

waiting {
    timeout = 3
}

environments {
    firefox {
        driver = { new FirefoxDriver() }
    }
    chrome {
        driver = {
            new ChromeDriver(options)
        }
    }
    chromeHeadless {
        driver = {
            ChromeOptions options = new ChromeOptions()
            options.addArguments("--headless", "--disable-gpu")

            new ChromeDriver(options)
        }
    }
}
