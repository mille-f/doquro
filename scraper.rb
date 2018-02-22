require 'selenium-webdriver'

driver = Selenium::WebDriver.for :chrome # ブラウザ起動
driver.navigate.to 'https://cardlibrary.dqrivals.com/cards/search?leader=all,terry,zeshika,arena,kukule,torneco,minea,pissarro&cardpack=all&cost=0,1,2,3,4,5,6,7&type=unit,skill,weapon&rarity=normal,rare,super-rare,legend&keyword=&atk=&atkType=&hp=&hpType=' # 初期URL

wait = Selenium::WebDriver::Wait.new(:timeout => 30) # タイムアウト30秒
wait.until {driver.find_element(:xpath, "//*[@id='app']/div[1]/div[2]/div[2]/div[2]/ul")} #読み込むまで待機

### カードパック選択 ###
def select_cardpack(driver)
  pack = {}
  pack_n = driver.find_elements(:xpath, "//*[@id='app']/div[1]/div[2]/div[1]/div/fieldset[2]/div[2]/select/option").size
  for n in 1..pack_n do
    value = driver.find_element(:xpath, "//*[@id='app']/div[1]/div[2]/div[1]/div/fieldset[2]/div[2]/select/option[#{n}]").attribute("value")
    name = driver.find_element(:xpath, "//*[@id='app']/div[1]/div[2]/div[1]/div/fieldset[2]/div[2]/select/option[#{n}]").text
    pack.store(value, name)
  end

  puts "Select cardpack number\n\n"
  pack.each_with_index do |(_,v), i|
    puts "#{i}: #{v}"
  end

  while true
    printf("\n=> ")
    sel = gets.chomp!
    if sel =~ /\d+/ && sel.to_i.between?(0, pack_n-1)
      break
    else
      puts "Try again"
    end
  end

  puts "<#{pack.values[sel.to_i]}>"
  get_card_name(driver, pack.keys[sel.to_i])
end

### カード名取得 ###
def get_card_name(driver, pack)
  driver.navigate.to "https://cardlibrary.dqrivals.com/cards/search?leader=all,terry,zeshika,arena,kukule,torneco,minea,pissarro&cardpack=#{pack}&cost=0,1,2,3,4,5,6,7&type=unit,skill,weapon&rarity=normal,rare,super-rare,legend&keyword=&atk=&atkType=&hp=&hpType=" # URL遷移
  wait = Selenium::WebDriver::Wait.new(:timeout => 30) # タイムアウト30秒
  wait.until {driver.find_element(:xpath, "//*[@id='app']/div[1]/div[2]/div[2]/div[2]/ul")} #読み込むまで待機

  puts
  1.step do |i|
    if driver.find_elements(:xpath, "//*[@id='app']/div[1]/div[2]/div[2]/div[2]/ul/li[#{i}]/img").size > 0
      img = driver.find_element(:xpath, "//*[@id='app']/div[1]/div[2]/div[2]/div[2]/ul/li[#{i}]/img")
      puts img.attribute("alt")
    else
      break
    end
  end
end

select_cardpack(driver)

# driver.quit # ブラウザ終了
