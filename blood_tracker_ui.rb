require 'pg'
require './lib/donation_location'
require './lib/blood_type'
require 'pry'

DB = PG.connect(:dbname => "blood_tracker_db")

def main_menu
  loop do
    system 'clear'
    puts "*** WELCOME TO BLOOD TRACKER ***\n\n"
    puts "Press 'l' to add a Donation Location"
    puts "Press 'b' to add a Blood Type"
    puts "Press 'a' to assign Blood Types to Donation Locations"
    puts "Press 's' to search for all Blood Types at a Location or search for all Locations holding a Blood Type"
    puts "Press 'x' to EXIT\n\n"
    main_choice = gets.chomp
    if main_choice == 'l'
      add_location
    elsif main_choice == 'b'
      add_type
    elsif main_choice == 'a'
      assign
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
  new_location = DonationLocation.new('name' => location_input)
  new_location.save
  puts "* #{new_location.name.upcase} * has been added to the list of Donation Locations.\n\n"
  sleep(1.5)
end

def add_type
  puts "*** NEW BLOOD TYPE ***"
  puts "Please enter a new Blood Type:\n\n"
  type_input = gets.chomp
  new_type = BloodType.new('name' => type_input)
  new_type.save
  puts "* #{new_type.name.upcase} * has been added to the list of Blood Types.\n\n"
  sleep(1.5)
end

def assign
  puts "*** ASSIGN BLOOD TYPES HERE ***"
  puts "Press 'a' to add Blood Types to Donation Locations"
  puts "Press 'x' to return to the main menu"
  choice = gets.chomp
  if choice == 'a'
    puts "*** CURRENT DONATION LOCATIONS ***"
    DonationLocation.all.each do |location|
      puts "#{location.id}. #{location.name}"
    end
    puts "\n\n"
    puts "*** CURRENT BLOOD TYPES ***"
    BloodType.all.each do |type|
      puts "#{type.id}. #{type.name}"
    end
    puts "Please enter the number of a Donation Location you would like to add a Blood Type to:\n"
    donation_location_id = gets.chomp.to_i
    puts "\nEnter the number of Blood Type to add to #{donation_location_id}:\n"
    blood_type_id = gets.chomp.to_i
    DonationLocation.locate_blood(donation_location_id, blood_type_id)
    puts "Location #: #{donation_location_id} is now carrying Blood Type #:#{blood_type_id}.\n\n"
    assign
  elsif choice == 'x'
    main_menu
  else
    puts "WHOOPS, PLEASE TRY AGAIN."
    sleep(1)
    system 'clear'
  end
end

def search
  puts "*** SEARCH FOR BLOOD TYPE OR DONATION LOCATION *** \n\n"
  puts "Type 'l' to search for any participating Donation Locations holding a specific Blood Type."
  puts "Type 'b' to see a list of all Blood Types at a specific Donation Location."
  puts "Press 'x' to return to the main menu"
  search_choice = gets.chomp
  if search_choice == 'l'
    puts "*** CURRENT BLOOD TYPES ***"
    BloodType.all.each do |type|
      puts "#{type.id}. #{type.name}\n\n"
    end
    puts "Enter the ID of a Blood Type:"
    id_input = gets.chomp.to_i
    puts "Here are the participating Donation Locations:"
    DonationLocation.list_locations_for_type(id_input).each do |location|
      puts "#{location.id}. #{location.name}\n\n"
    end
    sleep(1.5)
    search
  elsif search_choice == 'b'
    puts "*** CURRENT DONATION LOCATIONS ***\n\n"
    DonationLocation.all.each do |location|
      puts "#{location.id}. #{location.name}\n\n"
    end
    puts "Enter the ID of the Location you would like to list available Blood Types for:"
    id_input = gets.chomp.to_i
    BloodType.list_types_at_location(id_input).each do |type|
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
