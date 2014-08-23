class Blood_Type
  attr_reader :name, :id

  def initialize(attributes)
    @name = attributes['name']
    @id = attributes['id'].to_i
  end

  def self.all
    blood_types = []
    results = DB.exec("SELECT * FROM blood_types")
    results.each do |result|
      current_blood_type = Blood_Type.new(result)
      blood_types << current_blood_type
    end
    blood_types
  end

  def save
    results = DB.exec("INSERT INTO blood_types (name) VALUES ('#{@name}') RETURNING id;")
    @id = results.first['id'].to_i
  end

  def ==(another_blood_type)
    (self.name == another_blood_type.name)
  end


end
