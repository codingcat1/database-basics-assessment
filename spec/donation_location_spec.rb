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


end
