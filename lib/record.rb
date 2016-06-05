require "time"

class Record
  attr_reader :last_name, :first_name, :gender, :favorite_color, :date_of_birth

  @required = [:last_name, :first_name, :gender, :favorite_color, :date_of_birth]

  def self.valid?(args)
    @required.all? { |key| args.key?(key) }
  end

  def initialize(args)
    @last_name = args[:last_name]
    @first_name = args[:first_name]
    @gender = args[:gender]
    @favorite_color = args[:favorite_color]
    @date_of_birth = Time.strptime(args[:date_of_birth], "%m/%d/%Y")
  end

  def to_s
    [
      "Name: #{@first_name.capitalize} #{@last_name.capitalize}, ",
      "Gender: #{@gender}, ",
      "Favorite Color: #{@favorite_color}, ",
      "Birthday: #{@date_of_birth.month}/#{@date_of_birth.day}/#{@date_of_birth.year}"
    ].join("")
  end
end
