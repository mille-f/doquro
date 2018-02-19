require 'selenium-webdriver'

driver = Selenium::WebDriver.for :chrome # ブラウザ起動
driver.navigate.to 'https://cardlibrary.dqrivals.com/cards/search?leader=all,terry,zeshika,arena,kukule,torneco,minea,pissarro&cardpack=all&cost=0,1,2,3,4,5,6,7&type=unit,skill,weapon&rarity=normal,rare,super-rare,legend&keyword=&atk=&atkType=&hp=&hpType=' # 初期URL

wait = Selenium::WebDriver::Wait.new(:timeout => 30) # タイムアウト30秒
wait.until {driver.find_element(:xpath, "//*[@id='app']/div[1]/div[2]/div[2]/div[2]/ul")} #読み込むまで待機
# driver.find_element(:id, "sqexFooter").location_once_scrolled_into_view

### カード名取得 ###
def get_card_name(driver)
  1.step do |i|
    if driver.find_elements(:xpath, "//*[@id='app']/div[1]/div[2]/div[2]/div[2]/ul/li[#{i}]/img").size > 0
      img = driver.find_element(:xpath, "//*[@id='app']/div[1]/div[2]/div[2]/div[2]/ul/li[#{i}]/img")
      puts img.attribute("alt")
    else
      break
    end
  end
end

get_card_name(driver)

# driver.quit # ブラウザ終了
