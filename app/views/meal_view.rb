class MealView
  def display(meals)
    meals.each_with_index do |meal, index|
      puts "#{index + 1} - #{meal.name} - $#{meal.price}"
    end
  end

  def ask_for(item)
    puts "#{item.capitalize}?"
    gets.chomp
  end
end
