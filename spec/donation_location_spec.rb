require 'spec_helper'

describe Donation_Location do
  it "initializes a donation location with a name" do
    test_donation_location = Donation_Location.new ({:name => 'Red Cross'})
    expect(test_donation_location).to be_an_instance_of Donation_Location
  end

  it "shows the user the donation location they initialized" do
    test_donation_location = Donation_Location.new ({:name => 'Red Cross'})
    expect(test_donation_location.name).to eq 'Red Cross'
  end

  it "starts out with an empty array of donation locations" do
    test_donation_location = Donation_Location.new ({:name => 'Red Cross'})
    expect(Donation_Location.all).to eq []
  end

  it "saves a location to the donation locations table" do
    test_donation_location = Donation_Location.new ({:name => 'Red Cross'})
    test_donation_location.save
    expect(Donation_Location.all).to eq [test_donation_location]
  end

  it "recognizes two occurrences of a donation location as two separate objects" do
    test_donation_location = Donation_Location.new ({:name => 'Red Cross'})
    test_donation_location2 = Donation_Location.new ({:name => 'Red Cross'})
    expect(test_donation_location).to eq test_donation_location2
  end


end
