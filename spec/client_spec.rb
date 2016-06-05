require "spec_helper"

describe Client do

  subject { described_class.new("spec/files/record.txt", :comma) }

  describe "#sort" do
    it "sorts data and returns result rendered as text" do
      expected = [
        "Here are the results of your query:",
        "1: Name: Bob Smith, Gender: male, Favorite Color: yellow, Birthday: 3/30/1980",
        "2: Name: Dan Daniels, Gender: male, Favorite Color: red, Birthday: 10/15/1972",
        "3: Name: Joseph Williams, Gender: male, Favorite Color: blue, Birthday: 9/3/1988",
        "4: Name: Mary Evans, Gender: female, Favorite Color: green, Birthday: 6/24/1980",
        "5: Name: Sarah Jones, Gender: female, Favorite Color: red, Birthday: 5/31/1978",
      ].join("\n")
      result = subject.sort(["first_name"], :asc, :text)
      expect(result).to eq(expected)
    end
  end
end
