require_relative "ffparser/database"
require_relative "ffparser/parser"
require_relative "ffparser/record"
require_relative "ffparser/renderer"
require_relative "ffparser/writer"

module FFParser
  class Client
    # Client providing abstractions for parsing & sorting, and saving records
    # TODO: remove need for explicit delimiter declaration. Auto-detect.
    def initialize(file_path, delimiter)
      @parser = Parser.new(file_path, delimiter, Record)
      @writer = Writer.new(file_path, delimiter, Record)
    end

    def sort_by(fields, order, output_format)
      raise ArgumentError, "invalid order" unless valid_order?(order)
      raise ArgumentError, "invalid output_format" unless valid_output_format?(output_format)
      result = database.sort_by(fields, order)
      Renderer.render(result, output_format)
    end

    def save_record(record_string)
      @writer.write_record(record_string)
    end

    private

    def database
      @database ||= Database.new(@parser.parse)
    end

    def valid_order?(order)
      [:asc, :desc].include?(order)
    end

    def valid_output_format?(output_format)
      [:text, :hash_array].include?(output_format)
    end
  end
end
