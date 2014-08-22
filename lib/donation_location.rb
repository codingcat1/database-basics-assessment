class Location
  attr_reader :name

  def initialize(attributes)
    @name = attributes[:name]
  end

  def self.all
    locations = []
  end

end
