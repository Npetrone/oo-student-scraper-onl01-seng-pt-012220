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

  # def self.scrape_profile_page(profile_url)
  #   doc = Nokogiri::HTML(open("https://learn-co-curriculum.github.io/student-scraper-test-page/index.html"))
  #   student = {}
  #   socialmedia = doc.css(".social-icon-container a").collect{|icon| icon.attribute("href").value}
  #   socialmedia.each do |link|
  #     if element.attr('href').include?("twitter")
  #       student[:twitter] = element.attr('href')
  #     elsif element.attr('href').include?("linkedin")
  #       student[:linkedin] = element.attr('href')
  #     elsif element.attr('href').include?("github")
  #       student[:github] = element.attr('href')
  #     elsif element.attr('href').include?(".com")
  #       student[:blog] = element.attr('href')
  #     end
  #     student[:profile_quote] = doc.css(".vitals-container .vitals-text-container .profile-quote").text
  #     student[:bio] = doc.css(".bio-block.details-block .bio-content.content-holder .description-holder p").text
  #   end
  #   # student_sm = {:twitter => :twitter,
  #   # :linkedin => :linkedin,
  #   # :github => :github,
  #   # :blog => :blog,
  #   # :profile_quote => :profile_quote,
  #   # :bio => :bio}
  #   # student << student_sm
  #   # binding.pry
  #   student
  # end
def self.scrape_profile_page(profile_url)
    html = open(profile_url)
    doc = Nokogiri::HTML(html)
    return_hash = {}

      social = doc.css(".vitals-container .social-icon-container a")
      social.each do |element| #iterate through each of the social elements and assign the keys if the item exists
        if element.attr('href').include?("twitter")
          return_hash[:twitter] = element.attr('href')
        elsif element.attr('href').include?("linkedin")
          return_hash[:linkedin] = element.attr('href')
        elsif element.attr('href').include?("github")
          return_hash[:github] = element.attr('href')
        elsif element.attr('href').end_with?("com/")
          return_hash[:blog] = element.attr('href')
        end
      end
      return_hash[:profile_quote] = doc.css(".vitals-container .vitals-text-container .profile-quote").text
      return_hash[:bio] = doc.css(".bio-block.details-block .bio-content.content-holder .description-holder p").text

  return_hash
  end

end

