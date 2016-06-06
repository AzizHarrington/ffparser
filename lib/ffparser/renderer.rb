module FFParser
  module Renderer
    module_function

    def render(data, output_format)
      return to_text(data) if output_format == :text
      return to_hash_array(data) if output_format == :hash_array
    end

    def to_text(data)
      output = ["Here are the results of your query:"]
      data.each_with_index do |result, index|
        formatted = "#{index + 1}: " + result.to_s
        output << formatted
      end
      output.join("\n")
    end

    def to_hash_array(data)
      data.map { |d| d.to_h }
    end
  end
end
