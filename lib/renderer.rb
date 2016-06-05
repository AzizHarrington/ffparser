class Renderer
  def self.render(data, output_format)
    to_text(data)
  end

  def self.to_text(data)
    output = ["Here are the results of your query:"]
    data.each_with_index do |result, index|
      formatted = "#{index + 1}: " + result.to_s
      output << formatted
    end
    output.join("\n")
  end
end
