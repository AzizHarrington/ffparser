require "optparse"
require_relative "lib/client"

options = {}
OptionParser.new do |opts|
  opts.on("-f", "--file_name=FILENAME", "(REQUIRED) path to local record csv") do |opt|
    options[:file_name] = opt
  end
  opts.on("-s", "--sort_by=FIELDS", Array, "(REQUIRED) comma seperated list of fields to sort on") do |opt|
    options[:sort_by] = opt
  end
  opts.on("-o", "--order=ORDER", "(OPTIONAL) choose 'asc' or 'desc'. defaults to 'asc'") do |opt|
    options[:order] = opt
  end
  opts.on("-d", "--delimiter=DELIMITER", "(OPTIONAL) choose 'comma' or 'pipe'. defaults to 'comma'") do |opt|
    options[:delimiter] = opt
  end
  opts.on("-h", "--help") do
    puts "Sort and view records from the command line"
    puts "\n"
    puts opts
    puts "\n"
    puts "example usage:"
    puts "    ruby ffparser_cli -f path_to_file.txt -s fielda,fieldb -o desc, -d pipe"
    puts "\n"
    exit
  end
end.parse!

file_name = options[:file_name]
sort_by = options[:sort_by]
order = options[:order] == "desc" ? :desc : :asc
delimiter = options[:delimeter] == "pipe" ? :pipe : :comma

client = FFParser::Client.new(file_name, delimiter)
puts "\n"
puts client.sort(sort_by, order, :text)
puts "\n"
