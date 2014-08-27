require 'spec_helper'

describe BloodType do
  it "initializes a blood type with a name" do
    test_blood_type = BloodType.new ({'name' => 'B+'})
    expect(test_blood_type).to be_an_instance_of BloodType
  end

  it "shows the user the blood type they initialized" do
    test_blood_type = BloodType.new ({'name' => 'B+'})
    expect(test_blood_type.name).to eq 'B+'
  end

  it "starts out with an empty array of blood types" do
    test_blood_type = BloodType.new ({'name' => 'B+'})
    expect(BloodType.all).to eq []
  end

  it "saves a blood type to the blood types table" do
    test_blood_type = BloodType.new ({'name' => 'B+'})
    test_blood_type.save
    expect(BloodType.all).to eq [test_blood_type]
  end

  it "recognizes two occurrences of a blood type as two separate objects" do
    test_blood_type = BloodType.new ({'name' => 'B+'})
    test_blood_type2 = BloodType.new ({'name' => 'B+'})
    expect(test_blood_type).to eq test_blood_type2
  end

  it "sets an ID to a blood type when it is saved" do
    test_blood_type = BloodType.new ({'name' => 'B+'})
    test_blood_type.save
    expect(test_blood_type.id).to be_an_instance_of Fixnum
  end

  it "connects a donation location to a blood type and returns all blood types connected to a location" do
    test_donation_location = DonationLocation.new({'name' => 'Red Cross'})
    test_donation_location.save
    test_blood_type = BloodType.new({'name' => 'B-'})
    test_blood_type.save
    test_blood_type2 = BloodType.new({'name' => 'B+'})
    test_blood_type2.save
    DonationLocation.locate_blood(test_donation_location.id, test_blood_type.id)
    DonationLocation.locate_blood(test_donation_location.id, test_blood_type2.id)
    blood_types = BloodType.list_types_at_location(test_donation_location.id)
    expect(blood_types).to eq [test_blood_type, test_blood_type2]
  end
end
