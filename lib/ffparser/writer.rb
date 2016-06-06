module FFParser
  class Writer
    def initialize(file_path)
      @file_path = file_path
    end

    def write_record(record_string)
      File.open(@file_path, "a") do |f|
        f << record_string + "\n"
      end
    end
  end
end
