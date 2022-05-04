require_relative '../models/order'
require_relative '../views/meal_view'
require_relative '../views/customer_view'
require_relative '../views/order_view'

class OrdersController
  def initialize(meal_repository, customer_repository, employee_repository, order_repository)
    @meal_repository     = meal_repository
    @customer_repository = customer_repository
    @employee_repository = employee_repository
    @order_repository    = order_repository
    @meal_view = MealView.new
    @customer_view = CustomerView.new
    @order_view = OrderView.new
  end

  def add
    # DISPLAY MEALS OPTIONS
    meals = @meal_repository.all
    @meal_view.display(meals)
    # ASK THE MANAGER WHICH MEAL INDEX
    meal_index = @order_view.ask_for("index").to_i - 1
    # ASK THE MANAGER WHICH CUSTOMER
    customers = @customer_repository.all
    @customer_view.display(customers)
    customer_index = @order_view.ask_for(:index).to_i - 1
    # ASK THE MANAGER WHICH RIDER
    riders = @employee_repository.all_riders
    @order_view.display_riders(riders)
    rider_index = @order_view.ask_for(:index).to_i - 1
    order = Order.new(meal: meals[meal_index], customer: customers[customer_index], employee: riders[rider_index])
    @order_repository.create(order)
  end

  def list_undelivered_orders
    orders = @order_repository.undelivered_orders
    @order_view.display_undelivered(orders)
  end

  def list_my_orders(current_user)
    # NEED THE LOGGED IN USER
    orders = @order_repository.undelivered_orders
    my_undelivered_orders = orders.select { |order| order.employee == current_user }
    # DISPLAY THE RIDER THAT IS USING YOUR APP
    @order_view.display_undelivered(my_undelivered_orders)
    # UNDELIVERED ORDERS
    my_undelivered_orders
  end

  def mark_as_delivered(current_user)
    my_undelivered_orders = list_my_orders(current_user)
    index = @order_view.ask_for(:index).to_i - 1
    @order_repository.mark_as_delivered(my_undelivered_orders[index])
  end
end
