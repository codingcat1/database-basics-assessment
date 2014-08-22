class Blood_Type
  attr_reader :name

  def initialize(attributes)
    @name = attributes[:name]
  end

  def self.all
    blood_types = []
    results = DB.exec("SELECT * FROM blood_types")
    results.each do |result|
      attributes = {:name => result['name']}
      current_blood_type = Blood_Type.new(attributes)
      blood_types << current_blood_type
    end
    blood_types
  end

  def save
    results = DB.exec("INSERT INTO blood_types (name) VALUES ('#{@name}');")
  end

  def ==(another_blood_type)
    (self.name == another_blood_type.name)
  end

end
