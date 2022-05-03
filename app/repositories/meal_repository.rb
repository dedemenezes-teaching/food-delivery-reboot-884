require 'csv'
require_relative '../models/meal'
require_relative 'base_repository'

class MealRepository < BaseRepository
  def initialize(csv_file)
    @klass = Meal
    super(csv_file)
  end
end
