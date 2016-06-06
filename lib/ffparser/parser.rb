require 'csv'

module FFParser
  class Parser
    class ParseError < StandardError
      @message = "File invalid! must have headers and be '|' or ',' delimited."
      def initialize(msg=message)
        super
      end
    end

    def initialize(file_path, delimiter, record_class)
      @file_path = file_path
      @delimiter = delimiter
      @record_class = record_class
    end

    def parse
      read_csv.map { |line| handle_line(line) }
    end

    private

    def read_csv
      CSV.read(@file_path, headers: true, col_sep: column_seperator)
    end

    def column_seperator
      return "|" if @delimiter == :pipe
      ","
    end

    def handle_line(line)
      line_hash = parse_line(line)
      raise ParseError unless @record_class.valid?(line_hash)
      @record_class.new(line_hash)
    end

    def parse_line(line)
      line.to_h.map { |k, v| [snake_case(k).to_sym, v.strip] }.to_h
    end

    def snake_case(header)
      header.strip.gsub(/([^A-Z])([A-Z]+)/,'\1_\2').downcase
    end
  end
end
