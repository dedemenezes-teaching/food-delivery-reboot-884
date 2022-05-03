require_relative '../views/meal_view'

class MealsController
  def initialize(meal_repository)
    @meal_repository = meal_repository
    @meal_view = MealView.new
  end

  def add
    # ASK FOR THE NAME
    name = @meal_view.ask_for("name")
    # ASK FOR THE PRICE
    price = @meal_view.ask_for(:price).to_i
    # INSTANTIATE MY MEAL
    meal = Meal.new({ name: name, price: price })
    # ASK THE REPO TO SAVE/PERSIST/CREATE THE MEAL
    @meal_repository.create(meal)
    list
  end

  def list
    # ask the repo for all the meals
    meals = @meal_repository.all
    # display all the meals
    @meal_view.display(meals)
  end
end
