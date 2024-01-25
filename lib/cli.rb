require_relative 'scraper.rb'
require_relative 'country.rb'
require_relative 'state.rb'
require_relative 'user.rb'

class CLI # CLI class is used to run the program
  
  # run
  # greeting
  # end program
  # menu
  # list of options
  # end
  #===============
  # run
    def run # run method is used to run the program
      User.load_users_from_file # load users from json file for login
      
      authenticate # authenticate user before using app
     
      Scraper.scrape_data # the first thing is to get the data
      greeting
      #menu
      while menu != "exit" # keep on executing the menu, end the program when user enters 'exit'
      end
      end_program
    end
  
  # greeting
    def greeting
      puts "Welcome to the USA Covid 19 Tracker!"
    end
  
  # end program
    def end_program
      puts "Thank you for using the USA Covid 19 Tracker!"
    end
  
  # menu - to excute the program for each option listed
    def menu
      list_options
      input = gets.chomp.downcase
      choose_option(input)
      input
    end
  
  # list of options - for user to choose from the list
    def list_options
      puts "Please choose from the following options:"
      puts "1. List all states"
      puts "2. List top ten states with the most confirmed cases"
      puts "3. List top ten states with the most deaths"
      puts "4. Print USA information"
      puts "Exit the program by entering 'exit'"
    end

    def  choose_option(option)
      case option
        when "1"
          puts "Listing all states.."
          State.all.each do |state|
            puts "------------------------------"
            puts "Name: #{state.name}"
            puts "Confirmed Cases: #{state.confirmed_cases}"
            puts "Deaths: #{state.deaths}"
            puts "Recovered: #{state.recovered}"
          end
        
        when "2"
          puts "Listing top ten confirmed cases states.."
        # [0..9] is used to get the first 10 states]
          State.all[0..9].each_with_index do |state, i| 
            puts "#{i+1} #{state.name} - #{state.confirmed_cases}"
          end
        
        when "3"
          puts "Listing top ten deaths states.."
          # use gsub to replace the /,/ with nil '' then convert to integer
          sort_states = State.all.sort_by {|state| state.deaths.gsub(/,/, '').to_i}
          sort_states.reverse! # reverse for the high to low
          sort_states[0..9].each_with_index do |state, i|
            puts "#{i+1} #{state.name} - #{state.deaths}"
          end 
        
        when "4"
          puts "Printing USA information"
          usa = Country.first
          puts "USA Total Confirmed Cases: #{usa.confirmed_cases}"
          puts "USA Total Deaths: #{usa.deaths}"
          puts "USA Total Recovered Cases: #{usa.recovered}"
        
      end
    end

    def authenticate
      authenticated = false
  
      until authenticated
        puts "Please login or Sign up"
        puts "Which do you choose? (login/signup)"
        get_input = gets.chomp
        
        if get_input == "login"
          #authenticate user
          authenticated = login
        elsif get_input == "signup"
          #create new user
          create_account
        else
          puts "Invalid input"
        end
      end
    end

    def login
      puts "Please enter your username"
      username = gets.chomp
      puts "Please enter your password"
      password = gets.chomp
      
      # call authenticate method from user class
      result = User.authenticate(username, password)
  
      if result
        puts "Welcome back #{username}"
      else
        puts "Invalid username or password"
      end
      result # return result to pass to 'login' option selected
    end

    def create_account
      # get user info
      puts "Please enter your username"
      username = gets.chomp
      puts "Please enter your password"
      password = gets.chomp

      user = User.new(username, password)
      # add the user to an external file
      User.store_credentials(user)
      
      puts "Account Created"
    end 



end


