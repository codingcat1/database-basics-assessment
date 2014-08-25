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
  if choice == 'b'
    puts "Enter the ID of the Location you would like to list available Blood Types for:"
    id_input = gets.chomp.to_i
    Blood_Type.list_types_at_location(id_input).each do |type|
      puts "#{type.id}. #{type.name}\n\n"
    end
    sleep(1)
    list_locations
  elsif choice == 'x'
    main_menu
  else
    puts "WHOOPS, PLEASE TRY AGAIN."
    sleep(1)
    list_locations
  end
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

def list_types
  puts "*** CURRENT BLOOD TYPES ***\n\n"
  Blood_Type.all.each do |type|
    puts "#{type.id}. #{type.name}\n\n"
  end
  puts "Press 'l' to show all Donation Locations that carry a specific Blood Type."
  puts "Press 'x' to return to the Main Menu\n\n"
  choice = gets.chomp
  if choice == 'l'
    puts "Enter the ID of a Blood Type:"
    id_input = gets.chomp.to_i
    puts "Here are the participating Donation Locations:"
    Donation_Location.list_locations_for_type(id_input).each do |location|
      puts "#{location.id}. #{location.name}\n\n"
    end
    sleep(1)
    list_types
  elsif choice == 'x'
    main_menu
  else
    puts "WHOOPS, PLEASE TRY AGAIN."
    sleep(1)
    list_types
  end
end


main_menu
