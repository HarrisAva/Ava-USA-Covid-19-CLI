require 'bcrypt'
require 'json'

class User
  attr_accessor :username, :password

  @@users = []

  def initialize(username, password, existing_hash = false) 
    # if existing_hash is true, use the password in the hash by create new instance from exiting hash and using existing password that user entered before. 
    # Otherwise (existing_hash is false), 'create' a new hash and encrypt password.
    @username = username
    @password = existing_hash ? BCrypt::Password.new(password) : BCrypt::Password.create(password) 
     
    @@users << self
  end

  def self.all
    @@users
  end

  # authenticate user to login
  def self.authenticate(username, password)
    user = User.find_by_username(username) # finds user by username

    if user && user.password == password # checks if user exists and if password matches
      return user
    else
      return nil
    end
  end

  def self.find_by_username(username)
    user = all.find do |user| # return user
      user.username == username # returns the user if the username matches, if not return nil
    end
  end

  ### STORE USERS ###
  def self.store_credentials(user)
    # Step 1: Create a file if it does not exist
      file_path = "users.json"
      unless File.exist?(file_path)
        File.open(file_path, "w") { |file| file.write(JSON.generate([]))}         # create a file with empty array of Json object
      end
    
    # Step 2: Write the user credentials to the file     
    file = File.read(file_path) # read the file and grab its content (JSon object/array)
    users_data = JSON.parse(file) # parse the JSon array into a Ruby array so we can add the new user

    users_data << {username: user.username, password: user.password} # add the user that sign up to the array (hash ruby format), if 
    
    # now, we want to override the file_path (users.json) with the new user added (the updated 'users_data' file)
    # open the file_path Json file (users.json) and write the array of updated users (users_data) to this file 
    File.open(file_path, "w") {|file| file.write(JSON.generate(users_data))} 
       
  end

  def self.load_users_from_file
    file_path = "users.json"

    if File.exist? (file_path)
      # Step 1: parse data from file
      file = File.read(file_path)

      users_data = JSON.parse(file) # parse the JSon array into a Ruby array

      # Step 2: Iterate through each user and create a new instance from array of hashes
      users_data.each do |user_data|
        User.new(user_data["username"], user_data["password"], true)
      end
    end  
  end
end
### store_credential method summary ####
# Step 1: Create a users.json file if it does not exist
# Step 2: Write the user credentials to the file
    # Step 2.1: Read the file and grap the content in the file (Json format)
    # Step 2.2: Parse the JSon array into a Ruby array so we can add the new user who sign up
    # Step 2.3: Add the new user that sign up to the array (hash ruby format)
    # Step 2.4: Now, we want to override the Json file, the entire file, with the new added user (the updated users_data file)
    # => open the  file_path Json file and write the array of updated users to this file

## login ##
# load the data from the json file and use it to login
# load it before the authenticate
