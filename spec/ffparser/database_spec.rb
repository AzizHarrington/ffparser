require 'spec_helper'
require 'time'


describe FFParser::Database do

  subject { described_class.new(data) }

  let(:data) { [bill, joyce, jim, alice, tom] }

  let(:bill) { record("bill", "m", "03/19/1990") }
  let(:jim) { record("jim", "m", "04/05/1976") }
  let(:alice) { record("alice", "f", "11/12/1981") }
  let(:tom) { record("tom", "m", "08/01/1967") }
  let(:joyce) { record("joyce", "f", "02/15/1982") }

  def record(name, gender, birthday)
    double(
      name,
      name: name,
      gender: gender,
      birthday: Time.strptime(birthday, "%m/%d/%Y")
    )
  end

  describe "#sort_by" do
    context "when one field" do
      it "sorts in ascending order" do
        result = subject.sort_by(["name"], :asc)
        expect(result).to eq([alice, bill, jim, joyce, tom])
      end

      it "sorts in descending order" do
        result = subject.sort_by(["name"], :desc)
        expect(result).to eq([tom, joyce, jim, bill, alice])
      end
    end

    context "when multiple fields" do
      it "sorts in ascending order" do
        result = subject.sort_by(["gender", "name"], :asc)
        expect(result).to eq([alice, joyce, bill, jim, tom])
      end

      it "sorts in descending order" do
        result = subject.sort_by(["gender", "birthday"], :desc)
        expect(result).to eq([bill, jim, tom, joyce, alice])
      end
    end
  end
end
