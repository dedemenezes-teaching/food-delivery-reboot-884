require 'csv'

class OrderRepository
  def initialize(csv_file_path, meal_repository, customer_repository, employee_repository)
    @csv_file_path = csv_file_path
    @meal_repository = meal_repository
    @customer_repository = customer_repository
    @employee_repository = employee_repository
    @orders = []
    load_csv if File.exist? @csv_file_path
  end

  def create(order)
    next_id = @orders.empty? ? 1 : @orders.last.id + 1
    order.id = next_id
    @orders << order
    save_csv
  end

  def undelivered_orders
    @orders.select { |order| order.delivered? == false }
  end

  def mark_as_delivered(order)
    order.deliver!
    save_csv
  end

  private

  def save_csv
    CSV.open(@csv_file_path, 'wb') do |csv|
      csv << %w[id meal_id customer_id employee_id delivered]
      @orders.each do |order|
        csv << [order.id, order.meal.id, order.customer.id, order.employee.id, order.delivered?]
      end
    end
  end

  def load_csv
    CSV.foreach(@csv_file_path, headers: :first_row, header_converters: :symbol) do |row|
      # CONVERT FROM STRING TO DATA TYPE USED IN YOUR APP
      row[:id] = row[:id].to_i
      row[:delivered] = row[:delivered] == "true"
      # RETRIVE THE INSTANCE THAT HAS THE ID PROVIDED
      row[:meal] = @meal_repository.find(row[:meal_id].to_i)
      row[:customer] = @customer_repository.find(row[:customer_id].to_i)
      row[:employee] = @employee_repository.find(row[:employee_id].to_i)
      @orders << Order.new(row)
    end
  end
end
