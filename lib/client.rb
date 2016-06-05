require_relative "database"
require_relative "parser"
require_relative "record"
require_relative "renderer"

class Client
  def initialize(file_path, delimiter)
    @database = set_database(file_path, delimiter)
  end

  def sort(fields, order, output_format)
    Renderer.render(
      @database.sort_by(fields, order),
      output_format
    )
  end

  def set_database(file_path, delimiter)
    data = Parser.parse(Record, file_path, delimiter)
    Database.new(data)
  end
end
