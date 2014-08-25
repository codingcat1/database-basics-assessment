require 'pg'
require './lib/donation_location'
require './lib/blood_type'
require 'pry'

DB = PG.connect(:dbname => "test_blood_tracker_db")

def main_menu
  loop do
    system 'clear'
    puts "*** WELCOME TO BLOOD TRACKER ***\n\n"
    puts "Press 'l' to add a Donation Location"
    puts "Press 'b' to add a Blood Type"
    puts "Press 's' to search for all Blood Types at a Location or search for all Locations holding a Blood Type"
    puts "Press 'x' to EXIT\n\n"
    main_choice = gets.chomp
    if main_choice == 'l'
      add_location
    elsif main_choice == 'b'
      add_type
    elsif main_choice == 's'
      search
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

def add_type
  puts "*** NEW BLOOD TYPE ***"
  puts "Please enter a new Blood Type:\n\n"
  type_input = gets.chomp
  new_type = Blood_Type.new('name' => type_input)
  new_type.save
  puts "* #{new_type.name.upcase} * has been added to the list of Blood Types.\n\n"
  sleep(1.5)
end

def search
  puts "*** SEARCH FOR BLOOD TYPE OR DONATION LOCATION *** \n\n"
  puts "Type 'l' to search for any participating Donation Locations holding a specific Blood Type."
  puts "Type 'b' to see a list of all Blood Types at a specific Donation Location."
  puts "Press 'x' to return to the main menu"
  search_choice = gets.chomp
  if search_choice == 'l'
    puts "*** CURRENT BLOOD TYPES ***"
    Blood_Type.all.each do |type|
      puts "#{type.id}. #{type.name}\n\n"
    end
    puts "Enter the ID of a Blood Type:"
    id_input = gets.chomp.to_i
    puts "Here are the participating Donation Locations:"
    Donation_Location.list_locations_for_type(id_input).each do |location|
      puts "#{location.id}. #{location.name}\n\n"
    end
    sleep(1.5)
    search
  elsif search_choice == 'b'
    puts "*** CURRENT DONATION LOCATIONS ***\n\n"
    Donation_Location.all.each do |location|
      puts "#{location.id}. #{location.name}\n\n"
    end
    puts "Enter the ID of the Location you would like to list available Blood Types for:"
    id_input = gets.chomp.to_i
    Blood_Type.list_types_at_location(id_input).each do |type|
      puts "#{type.id}. #{type.name}\n\n"
    end
    sleep(1.5)
    search
  elsif search_choice == 'x'
    main_menu
  else
    puts "WHOOPS, PLEASE TRY AGAIN."
    sleep(1)
    system 'clear'
  end
end


main_menu
