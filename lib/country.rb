class Country # this class is to store country instances

  attr_accessor :name, :confirmed_cases, :deaths, :recovered

  @@countries = [] # to store all instances of country

  def initialize(name, confirmed_cases, deaths, recovered)
    @name = name
    @confirmed_cases = confirmed_cases
    @deaths = deaths
    @recovered = recovered
    @@countries << self  # push/add the instance above to the 'countries' class's array variable
  end

  def self.all # return the array of all instances of country
    @@countries
  end

  def self.first
    @@countries[0] # return the first instance of country which is USA
  end
end
