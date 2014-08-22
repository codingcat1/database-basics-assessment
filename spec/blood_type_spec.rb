require 'spec_helper'

describe Blood_Type do
  it "initializes a blood type with a name" do
    test_blood_type = Blood_Type.new ({:name => 'B+'})
    expect(test_blood_type).to be_an_instance_of Blood_Type
  end

  it "shows the user the blood type they initialized" do
    test_blood_type = Blood_Type.new ({:name => 'B+'})
    expect(test_blood_type.name).to eq 'B+'
  end

  it "starts out with an empty array of blood types" do
    test_blood_type = Blood_Type.new ({:name => 'B+'})
    expect(Blood_Type.all).to eq []
  end

  it "saves a blood type to the blood types table" do
    test_blood_type = Blood_Type.new ({:name => 'B+'})
    test_blood_type.save
    expect(Blood_Type.all).to eq [test_blood_type]
  end

  it "recognizes two occurrences of a donation location as two separate objects" do
    test_blood_type = Blood_Type.new ({:name => 'B+'})
    test_blood_type2 = Blood_Type.new ({:name => 'B+'})
    expect(test_blood_type).to eq test_blood_type2
  end


end
