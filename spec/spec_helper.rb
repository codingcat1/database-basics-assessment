require 'pq'
require 'blood_type'
require 'donation_location'
require 'blood_location'

DB = PG.connect ({:dbname => "test_blood_tracker_db"})

RSpec.configure do |config|
  config.before(:each) do
    DB.exec("DELETE FROM blood_types *;")
    DB.exec("DELETE FROM donation_locations *;")
    DB.exec("DELETE FROM blood_locations *;")
  end
end
