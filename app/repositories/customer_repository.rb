require 'csv'
require_relative '../models/customer'

class CustomerRepository
  def initialize(csv_file)
    @csv_file = csv_file
    @customers = []
    load_csv if File.exist?(@csv_file)
  end

  def all
    @customers
  end

  def find(id)
    @customers.find { |customer| customer.id == id }
  end

  def create(customer)
    # @customers is [], customer has id 1
    # @customers has 10 customers, customer id is 11
    next_id = @customers.empty? ? 1 : @customers.last.id + 1
    customer.id = next_id
    @customers << customer
    save_csv
  end

  private

  def save_csv
    CSV.open(@csv_file, 'wb') do |csv|
      # FIRST PUSH CSV HEADERS
      csv << %w[id name address]
      # PUSH EACH customer INTO A CSV NEW LINE
      @customers.each do |customer|
        csv << [customer.id, customer.name, customer.address]
      end
    end
  end

  def load_csv
    CSV.foreach(@csv_file, headers: :first_row, header_converters: :symbol) do |row|
      # p row
      # PREPARE THE ROW
      row[:id] = row[:id].to_i
      # INSTANTIATE MY customer
      customer = Customer.new(row)
      @customers << customer
    end
  end
end
