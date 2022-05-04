class Order
  attr_reader :meal, :customer, :employee
  attr_accessor :id
  # id, meal, customer, employee, delivered
  def initialize(attributes = {})
    @id        = attributes[:id]
    @meal      = attributes[:meal]
    @customer  = attributes[:customer]
    @employee  = attributes[:employee]
    @delivered = attributes[:delivered] || false
  end

  def delivered?
    @delivered
  end

  def deliver!
    @delivered = true
  end
end
