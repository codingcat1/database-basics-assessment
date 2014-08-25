require 'spec_helper'
require 'pry'

describe Donation_Location do
  it "initializes a donation location with a name" do
    test_donation_location = Donation_Location.new ({'name' => 'Red Cross'})
    expect(test_donation_location).to be_an_instance_of Donation_Location
  end

  it "shows the user the donation location they initialized" do
    test_donation_location = Donation_Location.new ({'name' => 'Red Cross'})
    expect(test_donation_location.name).to eq 'Red Cross'
  end

  it "starts out with an empty array of donation locations" do
    test_donation_location = Donation_Location.new ({'name' => 'Red Cross'})
    expect(Donation_Location.all).to eq []
  end

  it "saves a location to the donation locations table" do
    test_donation_location = Donation_Location.new ({'name' => 'Red Cross'})
    test_donation_location.save
    expect(Donation_Location.all).to eq [test_donation_location]
  end

  it "recognizes two occurrences of a donation location as two separate objects" do
    test_donation_location = Donation_Location.new ({'name' => 'Red Cross'})
    test_donation_location2 = Donation_Location.new ({'name' => 'Red Cross'})
    expect(test_donation_location).to eq test_donation_location2
  end

  it "sets an ID to a donation location when it is saved" do
    test_donation_location = Donation_Location.new ({'name' => 'Red Cross'})
    test_donation_location.save
    expect(test_donation_location.id).to be_an_instance_of Fixnum
  end

  it "connects a blood type to a donation location and returns all donation locations connected to a blood type" do
    test_donation_location = Donation_Location.new({'name' => 'Red Cross'})
    test_donation_location.save
    test_donation_location2 = Donation_Location.new({'name' => 'Green Cross'})
    test_donation_location2.save
    test_blood_type = Blood_Type.new({'name' => 'B+'})
    test_blood_type.save
    Donation_Location.locate_blood(test_donation_location.id, test_blood_type.id)
    Donation_Location.locate_blood(test_donation_location2.id, test_blood_type.id)
    donation_locations = Donation_Location.list_locations_for_type(test_blood_type.id)
    expect(donation_locations).to eq [test_donation_location, test_donation_location2]
  end

  # it "adds a blood type to a donation location" do
  #   test_donation_location = Donation_Location.new({'name' => 'Red Cross'})
  #   test_donation_location.save
  #   test_blood_type = Blood_Type.new({'name' => 'B+'})
  #   test_blood_type.save
  #   Donation_Location.add_type(test_blood_type)
  #   results = DB.exec("SELECT * FROM blood_locations WHERE donation_location_id = #{test_donation_location.id}")
  #   expect(results.first['blood_type_id'].to_i).to eq test_blood_type.id
  # end



end
