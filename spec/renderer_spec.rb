require 'spec_helper'

describe Renderer do
  describe ".render" do

    let(:record) { double('record') }
    let(:data) { [record, record, record] }
    let(:text) do
      [
        "Here are the results of your query:",
        "1: one",
        "2: two",
        "3: three"
      ].join("\n")
    end

    before :each do
      allow(record).to receive(:to_s).and_return("one", "two", "three")
    end

    context "when text format" do
      it "returns a text string" do
        result = described_class.render(data, :text)
        expect(result).to eq(text)
      end
    end
  end
end
