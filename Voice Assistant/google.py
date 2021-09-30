from selenium import webdriver


class goo():
    def __init__(self):
        self.driver = webdriver.Chrome(executable_path="D:\chromedriver_win32\chromedriver.exe")

    def ser(self, query):
        self.query = query
        self.driver.get(url="https://www.google.com/")
        search = self.driver.find_element_by_xpath(
            '/html/body/div[1]/div[3]/form/div[1]/div[1]/div[1]/div/div[2]/input')
        search.click()
        search.send_keys(query)
        enter = self.driver.find_element_by_xpath('/html/body/div[1]/div[3]/form/div[1]/div[1]/div[2]/div[2]/div['
                                                  '2]/center/input[1]')
        enter.click()
        link_enter = self.driver.find_element_by_xpath('//*[@id="rso"]/div[1]/div/div/div/div/div/div[1]/a/h3')
        link_enter.click()
