class Donation_Location
  attr_reader :name

  def initialize(attributes)
    @name = attributes[:name]
  end

  def self.all
    donation_locations = []
  end

end
