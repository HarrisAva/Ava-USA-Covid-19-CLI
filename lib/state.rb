class State

  attr_accessor :name, :confirmed_cases, :deaths, :recovered

  @@states = [] # to store all instances of states

  def initialize(name, confirmed_cases, deaths, recovered)
    @name = name
    @confirmed_cases = confirmed_cases
    @deaths = deaths
    @recovered = recovered
    @@states << self  # push/add the instance above to the 'states' class's array variable
  end

  def self.all # return the array of all instances of country
    @@states
  end

  def self.first
    @@states[0] # return the first instance of country which is USA
  end
end
