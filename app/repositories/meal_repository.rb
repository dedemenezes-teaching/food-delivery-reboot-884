class MealRepository
  def initialize(csv_file)
    @csv_file = csv_file
    @meals = []
    load_csv if File.exist?(@csv_file)
  end

  private

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
