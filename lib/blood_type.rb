class Blood_Type
  attr_reader :name

  def initialize(attributes)
    @name = attributes[:name]
  end

  def self.all
    blood_types = []
  end
end
