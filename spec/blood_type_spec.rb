require 'spec_helper'

describe Blood_Type do
  it "initializes a blood type with a name" do
    test_blood_type = Blood_Type.new ({:name => 'B+'})
    expect(test_blood_type).to be_an_instance_of Blood_Type
  end
end
