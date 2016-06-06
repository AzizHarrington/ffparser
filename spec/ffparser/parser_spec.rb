require 'spec_helper'

describe FFParser::Parser do
  describe '#parse' do
    let(:record_class) { double('record_class') }
    let(:record_instance) { double('record_instance') }
    let(:expected_rows) do
      [
        {:column_one => "a", :column_two => "a", :column_three => "a"},
        {:column_one => "b", :column_two => "b", :column_three => "b"},
        {:column_one => "c", :column_two => "c", :column_three => "c"}
      ]
    end

    it "raises a parse error on invalid csv" do
      allow(record_class).to receive(:valid?) { false }
      parser = described_class.new("spec/test_data/test_comma.txt", :comma, record_class)
      expect{parser.parse}.to raise_exception(FFParser::Parser::ParseError)
    end

    context "when comma delimited file" do
      it "parses data and returns array of record instances" do
        expected_rows.each do |row|
          expect(record_class).to receive(:valid?).with(row) { true }
          expect(record_class).to receive(:new).with(row) { record_instance }
        end
        parser = described_class.new("spec/test_data/test_comma.txt", :comma, record_class)
        expect(parser.parse).to match_array([
          record_instance, record_instance, record_instance
        ])
      end
    end

    context "when pipe delimited file" do
      it "parses data and returns array of record instances" do
        expected_rows.each do |row|
          expect(record_class).to receive(:valid?).with(row) { true }
          expect(record_class).to receive(:new).with(row) { record_instance }
        end
        parser = described_class.new("spec/test_data/test_pipe.txt", :pipe, record_class)
        expect(parser.parse).to match_array([
          record_instance, record_instance, record_instance
        ])
      end
    end
  end
end
