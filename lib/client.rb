require_relative "ffparser/database"
require_relative "ffparser/parser"
require_relative "ffparser/record"
require_relative "ffparser/renderer"

module FFParser
  class Client
    def initialize(file_path, delimiter)
      @database = set_database(file_path, delimiter)
    end

    def sort(fields, order, output_format)
      raise ArgumentError unless [:asc, :desc].include?(order)
      raise ArgumentError unless [:text, :hash_array].include?(output_format)
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
end
