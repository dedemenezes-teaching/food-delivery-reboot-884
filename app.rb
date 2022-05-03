# TODO: require relevant files to bootstrap the app.
# Then you can test your program with:
#   ruby app.rb
require_relative 'app/repositories/meal_repository'
require_relative 'app/controllers/meals_controller'

require_relative 'router'

meal_csv = 'data/meals.csv'
meal_repo = MealRepository.new(meal_csv)
meals_controller = MealsController.new(meal_repo)

router = Router.new(meals_controller)
router.run
