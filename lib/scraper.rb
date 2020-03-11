require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

# html = open("https://learn-co-curriculum.github.io/student-scraper-test-page/index.html")


  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open("https://learn-co-curriculum.github.io/student-scraper-test-page/index.html"))
    students = []
    
    doc.css("div.student-card").each do |student|
      name = student.css(".student-name").text
      location = student.css(".student-location").text
      # binding.pry
      profile = student.css("a").attribute("href").value
      info = {:name => name,
              :location => location,
              :profile_url => profile}
      students << info
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open("https://learn-co-curriculum.github.io/student-scraper-test-page/index.html"))
    student = {}
    socialmedia = doc.css(".social-icon-container a").collect{|icon| icon.attribute("href").value}
    socialmedia.each do |link|
      if link.include?("twitter")
        student[:twitter] = link
      elsif link.include?("linkedin")
        student[:linkedin] = link
      elsif link.include?("github")
        student[:github] = link
      elsif link.include?(".com")
        student[:blog] = link
      end
      
    end
    student[:profile_quote] = doc.css(".profile-quote").text
    student[:bio] = doc.css("div.description-holder p").text
      student
  end

end

