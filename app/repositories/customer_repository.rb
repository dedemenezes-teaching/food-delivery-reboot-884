require 'csv'
require_relative '../models/customer'
require_relative 'base_repository'

class CustomerRepository < BaseRepository
  def initialize(csv_file)
    @klass = Customer
    super(csv_file)
  end
end
