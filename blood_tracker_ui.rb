require 'pg'
require './lib/donation_location'
require './lib/blood_type'
require 'pry'

DB = PG.connect(:dbname => "test_blood_tracker_db")

def main_menu
  loop do
    system 'clear'
    puts "*** WELCOME TO BLOOD TRACKER ***\n\n"
    puts "Press 'l1' to add a Donation Location"
    puts "Press 'l2' to list Donation Locations"
    puts "Press 'b1' to add a Blood Type"
    puts "Press 'b2' to list all Blood Types"
    puts "Press 'bl' to add a Blood type to a specific Donation Location"
    puts "Press '1' to show all Blood Types that exist at a specific Donation Location"
    puts "Press '2' to show all Donation Locations with a specfic Blood Type"
    puts "Press 'x' to EXIT\n\n"
    main_choice = gets.chomp
    if main_choice == 'l1'
      add_location
    elsif main_choice == 'l2'
      list_locations
    elsif main_choice == 'b1'
      add_type
    elsif main_choice == 'b2'
      list_types
    elsif main_choice == '1'
      all_available_types
    elsif main_choice == '2'
      all_possessing_locations
    elsif main_choice == 'x'
      puts "*** THANK YOU, COME AGAIN LATER ***\n\n"
      sleep(1)
      system 'clear'
      exit
    else
      puts "WHOOPS, PLEASE TRY AGAIN."
      sleep(1)
      system 'clear'
    end
  end
end

def add_location
  puts "*** NEW LOCATION ***"
  puts "Please enter the name of a Donation Location:\n\n"
  location_input = gets.chomp
  new_location = Donation_Location.new('name' => location_input)
  new_location.save
  puts "* #{new_location.name.upcase} * has been added to the list of Donation Locations.\n\n"
  sleep(1.5)
end

def list_locations
  puts "*** CURRENT DONATION LOCATIONS ***\n\n"
  Donation_Location.all.each do |location|
    puts "#{location.id}. #{location.name}\n\n"
  end
  puts "Press 'b' to show all Blood Types available at a specific Donation Location"
  puts "Press 'x' to return to the Main Menu\n\n"
  choice = gets.chomp
end

def add_type
  puts "*** NEW BLOOD TYPE ***"
  puts "Please enter a new Blood Type:\n\n"
  type_input = gets.chomp
  new_type = Blood_Type.new('name' => type_input)
  new_type.save
  puts "* #{new_type.name.upcase} * has been added to the list of Blood Types.\n\n"
  sleep(1.5)
end


main_menu
