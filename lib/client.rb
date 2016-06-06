require_relative "ffparser/database"
require_relative "ffparser/parser"
require_relative "ffparser/record"
require_relative "ffparser/renderer"
require_relative "ffparser/writer"

module FFParser
  class Client
    def initialize(file_path, delimiter)
      @parser = Parser.new(file_path)
      @database = set_database(delimiter)
    end

    def self.save_record(file_path, record_string)
      Writer.new(file_path).write_record(record_string)
    end

    def sort(fields, order, output_format)
      raise ArgumentError unless [:asc, :desc].include?(order)
      raise ArgumentError unless [:text, :hash_array].include?(output_format)
      Renderer.render(
        @database.sort_by(fields, order),
        output_format
      )
    end

    private

    def set_database(delimiter)
      Database.new(@parser.parse(Record, delimiter))
    end
  end
end
