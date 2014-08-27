class DonationLocation
  attr_reader :name, :id

  def initialize(attributes)
    @name = attributes['name']
    @id = attributes['id'].to_i
  end

  def self.all
    donation_locations = []
    results = DB.exec("SELECT * FROM donation_locations")
    results.each do |result|
      new_donation_location = DonationLocation.new(result)
      donation_locations << new_donation_location
    end
    donation_locations
  end

  def save
    results = DB.exec("INSERT INTO donation_locations (name) VALUES ('#{@name}') RETURNING id;")
    @id = results.first['id'].to_i
  end

  def ==(another_donation_location)
    (self.name == another_donation_location.name)
  end

  def self.locate_blood(donation_location_id, blood_type_id)
    results = DB.exec("INSERT INTO blood_locations (donation_location_id, blood_type_id) VALUES (#{donation_location_id}, #{blood_type_id}) RETURNING id;")
    blood_location_id = results.first['id'].to_i
  end

  def self.list_locations_for_type(type_id)
    results = DB.exec("SELECT donation_locations. * FROM blood_types
      JOIN blood_locations ON (blood_types.id = blood_locations.blood_type_id)
      JOIN donation_locations ON (blood_locations.donation_location_id = donation_locations.id)
      WHERE blood_types.id = #{type_id};")
    donation_locations = []
    results.each do |result|
      current_donation_location = DonationLocation.new(result)
      donation_locations << current_donation_location
    end
    donation_locations
  end

end
