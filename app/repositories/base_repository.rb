require 'csv'
class BaseRepository
  def initialize(csv_file_path)
    @csv_file = csv_file_path
    @elements = []
    load_csv if File.exist?(@csv_file)
  end

  def all
    @elements
  end

  def find(id)
    @elements.find { |element| element.id == id }
  end

  def create(element)
    next_id = @elements.empty? ? 1 : @elements.last.id + 1
    element.id = next_id
    @elements << element
    save_csv
  end

  private

  def save_csv
    CSV.open(@csv_file, 'wb') do |csv|
      csv << @klass.insert_header
      @elements.each do |element|
        csv << element.insert_row
      end
    end
  end

  def load_csv
    CSV.foreach(@csv_file, headers: :first_row, header_converters: :symbol) do |row|
      row = @klass.prepare_row(row)
      element = @klass.new(row)
      @elements << element
    end
  end
end
