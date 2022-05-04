class OrderView
  def ask_for(item)
    puts "#{item.capitalize}?"
    gets.chomp
  end

  def display_riders(riders)
    riders.each_with_index do |rider, index|
      puts "#{index + 1} - #{rider.username} - #{rider.role}"
    end
  end

  def display_undelivered(orders)
    orders.each_with_index do |order, index|
      puts "#{index + 1} - #{order.meal.name} - #{order.customer.name} - #{order.employee.username}"
    end
  end
end
