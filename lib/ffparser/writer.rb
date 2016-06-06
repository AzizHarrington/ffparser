module FFParser
  class Writer
    # Contains logic for initializing a flat file with appropriate headers
    # and writing a single record to the end of a file.
    # Record strings are automatically converted to match the set delimiter
    # before writing.
    def initialize(file_path, delimiter, record_class)
      @file_path = file_path
      @delimiter = delimiter
      @record_class = record_class
    end

    def write_record(record_string)
      ensure_file_present
      processed_string = match_delimiter(record_string)
      append_to_file(processed_string)
    end

    private

    def match_delimiter(record_string)
      if @delimiter == :comma
        record_string.gsub(/\|/, ",")
      elsif @delimiter == :pipe
        record_string.gsub(/,/, "|")
      end
    end

    def ensure_file_present
      return if File.exist?(@file_path)
      append_to_file(header_string)
    end

    def header_string
      @record_class.fields.map do |field|
        to_camel_case(field)
      end.join(get_delimiter)
    end

    def to_camel_case(header)
      header.to_s.split('_').map(&:capitalize).join
    end

    def get_delimiter
      if @delimiter == :comma
        ","
      elsif @delimiter == :pipe
        "|"
      end
    end

    def append_to_file(line)
      File.open(@file_path, "a") do |f|
        f << (line + "\n")
      end
    end
  end
end
