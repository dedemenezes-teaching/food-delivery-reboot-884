class Meal
  attr_reader :name, :price
  attr_accessor :id #=> attr_reader + attr_writer
  # id, name, price
  def initialize(attributes = {})
    @id = attributes[:id]
    @name = attributes[:name]
    @price = attributes[:price]
  end
end
