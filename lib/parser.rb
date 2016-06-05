require 'csv'

class Parser
  class ParseError < StandardError
    @message = "File invalid! must have headers and be '|' or ',' delimited."
    def initialize(msg=message)
      super
    end
  end

  def self.parse(record_class, file_path, delimiter)
    csv = read_csv(file_path, delimiter)
    csv.map { |line| handle_line(record_class, line) }
  end

  def self.read_csv(file_path, delimiter)
    CSV.read(file_path, headers: true, col_sep: set_col_sep(delimiter))
  end

  def self.set_col_sep(delimiter)
    return "|" if delimiter == :pipe
    ","
  end

  def self.handle_line(record_class, line)
    line_hash = parse_line(line)
    raise ParseError unless record_class.valid?(line_hash)
    record_class.new(line_hash)
  end

  def self.parse_line(line)
    line.to_h.map { |k, v| [snake_case(k).to_sym, v.strip] }.to_h
  end

  def self.snake_case(header)
    header.strip.gsub(/([^A-Z])([A-Z]+)/,'\1_\2').downcase
  end
end
