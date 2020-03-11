require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

# html = open("https://learn-co-curriculum.github.io/student-scraper-test-page/index.html")


  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open("https://learn-co-curriculum.github.io/student-scraper-test-page/index.html"))
    students = []
    
    doc.css(div.student-card).each do |student|
      name = student.css(".student")
      location = 
      profile = 
    
    
    
    
  end

  def self.scrape_profile_page(profile_url)
    
  end

end

