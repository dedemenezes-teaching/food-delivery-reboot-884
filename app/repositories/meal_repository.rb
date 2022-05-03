require 'csv'
require_relative '../models/meal'

class MealRepository
  def initialize(csv_file)
    @csv_file = csv_file
    @meals = []
    load_csv if File.exist?(@csv_file)
  end

  def all
    @meals
  end

  def find(id)
    @meals.find { |meal| meal.id == id }
  end

  def create(meal)
    # @meals is [], meal has id 1
    # @meals has 10 meals, meal id is 11
    next_id = @meals.empty? ? 1 : @meals.last.id + 1
    meal.id = next_id
    @meals << meal
    save_csv
  end

  private

  def save_csv
    CSV.open(@csv_file, 'wb') do |csv|
      # FIRST PUSH CSV HEADERS
      csv << %w[id name price]
      # PUSH EACH MEAL INTO A CSV NEW LINE
      @meals.each do |meal|
        csv << [meal.id, meal.name, meal.price]
      end
    end
  end

  def load_csv
    CSV.foreach(@csv_file, headers: :first_row, header_converters: :symbol) do |row|
      # p row
      # PREPARE THE ROW
      row[:id] = row[:id].to_i
      row[:price] = row[:price].to_i
      # INSTANTIATE MY MEAL
      meal = Meal.new(row)
      @meals << meal
    end
  end
end
