require 'pg'
require './lib/donation_location'
require './lib/blood_type'

DB = PG.connect(:dbname => "test_blood_tracker_db")


