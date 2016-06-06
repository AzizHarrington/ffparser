require "spec_helper"

describe FFParser::Client do

  subject { described_class.new("spec/test_data/records.txt", :comma) }

  describe "#sort_by" do
    it "sorts data and returns result rendered as text" do
      expected = [
        "Here are the results of your query:",
        "1: Name: Bob Smith, Gender: male, Favorite Color: yellow, Birthday: 3/30/1980",
        "2: Name: Dan Daniels, Gender: male, Favorite Color: red, Birthday: 10/15/1972",
        "3: Name: Joseph Williams, Gender: male, Favorite Color: blue, Birthday: 9/3/1988",
        "4: Name: Mary Evans, Gender: female, Favorite Color: green, Birthday: 6/24/1980",
        "5: Name: Sarah Jones, Gender: female, Favorite Color: red, Birthday: 5/31/1978",
      ].join("\n")
      result = subject.sort_by(["first_name"], :asc, :text)
      expect(result).to eq(expected)
    end

    it "sorts data and returns as hash_array" do
      result = subject.sort_by(["first_name"], :asc, :hash_array)
      expect(result.first).to eq({
        :last_name=>"smith",
        :first_name=>"bob",
        :gender=>"male",
        :favorite_color=>"yellow",
        :date_of_birth=>"3/30/1980"
      })
    end

    it "raises exception for invalid order" do
      expect{subject.sort_by(["first_name"], :any, :text)}.to raise_error(ArgumentError)
    end

    it "raises exception for invalid output_format" do
      expect{subject.sort_by(["first_name"], :asc, :html)}.to raise_error(ArgumentError)
    end
  end

  describe "#save_record" do
    it "writes record and updates database" do
      writer = double('writer')
      allow(FFParser::Writer).to receive(:new) { writer }
      expect(writer).to receive(:write_record).with("record string")
      subject.save_record("record string")
    end
  end
end
