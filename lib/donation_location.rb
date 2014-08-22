class Donation_Location
  attr_reader :name

  def initialize(attributes)
    @name = attributes[:name]
  end

  def self.all
    donation_locations = []
    results = DB.exec("SELECT * FROM donation_locations")
    results.each do |result|
      attributes = {:name => result['name']}
      current_donation_location = Donation_Location.new(attributes)
      donation_locations << current_donation_location
    end
    donation_locations
  end

  def save
    results = DB.exec("INSERT INTO donation_locations (name) VALUES ('#{@name}');")
  end

  def ==(another_donation_location)
    (self.name == another_donation_location.name)
  end


end
