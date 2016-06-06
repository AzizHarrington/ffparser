require 'spec_helper'

describe FFParser::Renderer do
  describe ".render" do

    let(:record) { double('record') }
    let(:data) { [record, record, record] }

    before :each do
      allow(record).to receive(:to_s).and_return("one", "two", "three")
      allow(record).to receive(:to_h).and_return(
        {one: "one"},
        {two: "two"},
        {three: "three"}
      )
    end

    context "when text format" do
      it "returns a text string" do
        result = described_class.render(data, :text)
        expected = [
          "Here are the results of your query:",
          "1: one",
          "2: two",
          "3: three"
        ].join("\n")
        expect(result).to eq(expected)
      end
    end

    context "when hash_array format" do
      it "returns a hash array" do
        result = described_class.render(data, :hash_array)
        expected = [
          {one: "one"},
          {two: "two"},
          {three: "three"}
        ]
        expect(result).to eq(expected)
      end
    end
  end
end
