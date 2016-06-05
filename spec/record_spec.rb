require "spec_helper"
require "time"

describe Record do
  describe ".valid?" do
    context "when param hash keys are missing" do
      it "returns false" do
        params = {
          first_name: "bar",
          gender: "m",
          date_of_birth: "01/01/2016"
        }
        expect(described_class.valid?(params)).to be(false)
      end
    end

    context "when all param hash keys are present" do
      it "returns true" do
        params = {
          last_name: "bar",
          first_name: "bar",
          gender: "m",
          favorite_color: "red",
          date_of_birth: "01/01/2016"
        }
        expect(described_class.valid?(params)).to be(true)
      end
    end
  end

  subject do
    described_class.new(
      last_name: "foo",
      first_name: "bar",
      gender: "baz",
      favorite_color: "grey",
      date_of_birth: "10/21/1990"
    )
  end

  describe "#new" do
    it "sets instance variables correctly" do
      expect(subject.last_name).to eq("foo")
      expect(subject.first_name).to eq("bar")
      expect(subject.gender).to eq("baz")
      expect(subject.favorite_color).to eq("grey")
      expect(subject.date_of_birth).to eq(Time.strptime("10/21/1990", "%m/%d/%Y"))
    end
  end

  describe "#to_s" do
    it "it renders self to string" do
      expected = "Name: Bar Foo, Gender: baz, Favorite Color: grey, Birthday: 10/21/1990"
      expect(subject.to_s).to eq(expected)
    end
  end
end
