require_relative 'base_repository'
require_relative '../models/employee'

class EmployeeRepository < BaseRepository
  def initialize(csv_file)
    @klass = Employee
    super(csv_file)
  end

  undef_method :create

  def all_riders
    @elements.select { |employee| employee.rider? }
  end

  def find_by_username(username)
    @elements.find { |employee| employee.username == username }
  end
end
