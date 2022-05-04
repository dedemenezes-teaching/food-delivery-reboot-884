class Employee
  attr_reader :username, :password, :role
  attr_accessor :id

  # STATE/PROPERTIES
  # id, username, password, role
  def initialize(attributes = {})
    @id       = attributes[:id]
    @username = attributes[:username]
    @password = attributes[:password]
    @role    = attributes[:role] # manager / rider
  end

  def rider?
    @role == 'rider'
  end

  def manager?
    @role == 'manager'
  end

  def self.insert_header
    %w[id username password role]
  end

  def insert_row
    [@id, @username, @password, @role]
  end

  def self.prepare_row(row)
    row[:id] = row[:id].to_i
    row
  end
end
