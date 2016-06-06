require "time"

module FFParser
  class Record
    # Holds data and logic for validation & display
    FIELDS = [:last_name, :first_name, :gender, :favorite_color, :date_of_birth]
    attr_reader(*FIELDS)

    def self.fields
      FIELDS
    end

    def self.valid?(args)
      fields.all? { |key| args.key?(key) }
    end

    def initialize(args)
      @last_name = args[:last_name]
      @first_name = args[:first_name]
      @gender = args[:gender]
      @favorite_color = args[:favorite_color]
      @date_of_birth = Time.strptime(args[:date_of_birth], "%m/%d/%Y")
    end

    def to_h
      {
        last_name: @last_name,
        first_name: @first_name,
        gender: @gender,
        favorite_color: @favorite_color,
        date_of_birth: formatted_birthdate
      }
    end

    def to_s
      [
        "Name: #{@first_name.capitalize} #{@last_name.capitalize}, ",
        "Gender: #{@gender}, ",
        "Favorite Color: #{@favorite_color}, ",
        "Birthday: #{formatted_birthdate}"
      ].join
    end

    private

    def formatted_birthdate
      "#{@date_of_birth.month}/#{@date_of_birth.day}/#{@date_of_birth.year}"
    end
  end
end
