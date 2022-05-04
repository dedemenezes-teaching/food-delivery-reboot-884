class Router
  def initialize(meals_controller, customers_controller, sessions_controller)
    @meals_controller = meals_controller
    @customers_controller = customers_controller
    @sessions_controller = sessions_controller
    @running = true
  end

  def run
    welcome
    while @running
      @employee = @sessions_controller.sign_in
      while @employee #=> needs to be nil or false to exit the loop
        if @employee.manager?
          display_manager_menu
          user_action = gets.chomp.to_i
          route_manager_to(user_action)
        else
          display_rider_menu
          user_action = gets.chomp.to_i
          route_rider_to(user_action)
        end
      end
    end
    puts "Bye bye\nzo/"
  end

  def display_rider_menu
    puts "1. List my undelivered orders"
    puts "2. Mark an order as delivered"
  end

  def route_rider_to(action)
    case action
    when 1 then puts "TODO: LIST UNDELIVERED ORDERS"
    when 2 then puts "TODO: MARK AN ORDER AS DELIVERED"
    else
      puts "Press 1, 2, 3, 4 or 5"
    end
  end

  def welcome
    puts "*" * 31
    puts "Welcome to LW Food Delivery App"
    puts "*" * 31
  end

  def route_manager_to(action)
    case action
    when 1 then @meals_controller.add
    when 2 then @meals_controller.list
    when 3 then @customers_controller.add
    when 4 then @customers_controller.list
    when 5 then @employee = nil
    when 6 then @running = false
    else
      puts "Press 1, 2, 3, 4 , 5 or 6"
    end
  end

  def display_manager_menu
    puts '1. Add a new meal'
    puts '2. List all the meals'
    puts '3. Add a new customer'
    puts '4. List all the customers'
    puts "5. Logout"
    puts '6. Quit'
  end
end
