module FFParser
  class Writer
    def initialize(file_path, delimiter, record_class)
      @file_path = file_path
      @delimiter = delimiter
      @record_class = record_class
    end

    def write_record(record_string)
      File.open(@file_path, "a") do |f|
        f << record_string + "\n"
      end
    end
  end
end
