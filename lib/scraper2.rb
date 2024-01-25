require "nokogiri"
require "open-uri"
require 'byebug'
require_relative "teams.rb"

module Scraper
URL = 'https://www.scrapethissite.com/pages/forms/'

  def self.extract_data(doc)
    table = doc.css("tbody tr")
    table.each do |row|
      team = row.css("td")[0].text.strip
      year = row.css("td")[1].text.strip
      win = row.css("td")[2].text.strip
      Teams.new(team, year, win)
     end     
  end

  def self.scrape_data
    puts "Scraping data.."
    unparsed_data = URI.open(URL)
    doc = Nokogiri::HTML(unparsed_data)
    extract_data(doc)
    debugger
  end

end