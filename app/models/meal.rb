class Meal
  attr_reader :name, :price
  attr_accessor :id #=> attr_reader + attr_writer

  # id, name, price
  def initialize(attributes = {})
    @id = attributes[:id]
    @name = attributes[:name]
    @price = attributes[:price]
  end

  def self.insert_header
    %w[id name price]
  end

  def insert_row
    [@id, @name, @price]
  end

  def self.prepare_row(row)
    row[:id] = row[:id].to_i
    row[:price] = row[:price].to_i
    row
  end
end
