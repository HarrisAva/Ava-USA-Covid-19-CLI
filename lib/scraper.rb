require 'nokogiri'
require 'open-uri'
require 'byebug'
require_relative 'country.rb'
require_relative 'state.rb'

module Scraper
  # extract USA info from page
  # extract states info from page
  # scrape Data
  # -------------------------

  URL = "https://www.worldometers.info/coronavirus/country/us/"
  
  # extract USA info from page
  def self.extract_usa_data(doc) 
    country_main = doc.css("div.maincounter-number")
    usa_confirmed = country_main[0].text.strip
    usa_deaths = country_main[1].text.strip
    usa_recovered = country_main[2].text.strip
    # use the data extracted above in the Country class, to format it in one place
    # call the country class
  debugger;
    usa = Country.new("USA", usa_confirmed, usa_deaths, usa_recovered)
    
  end
    
  # extract states info from page
  def self.extract_states_data(doc)
    state_table = doc.css("tbody tr")
    
    state_table[1..51].each do |row|
      name = row.css("td")[1].text.strip
      confirmed_cases = row.css('td')[2].text.strip
      deaths = row.css('td')[4].text.strip
      recovered = row.css('td')[6].text.strip
      # use the data extracted above in the State class, to format it in one place
      if (name != 'District Of Columbia')
        State.new(name, confirmed_cases, deaths, recovered)
      end
    end
  end

  
  # scrape Data -> parsing the data extracted into a hash that we can use
  def self.scrape_data  
    puts "Scraping data..."
    unparsed_page = URI.open(URL)
    doc = Nokogiri::HTML(unparsed_page) # raw data - too much info, only need class 'maincounter-number'
    extract_usa_data(doc)
    extract_states_data(doc)

  end
end



