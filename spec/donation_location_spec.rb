require 'spec_helper'

describe Location do
  it "initializes a donation location with a name" do
    test_location = Location.new ({:name => 'Red Cross'})
    expect(test_location).to be_an_instance_of Location
  end
end
