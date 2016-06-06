require 'spec_helper'

describe FFParser::Writer do

  subject { described_class.new("filename", :comma, "record") }

  describe "#write_record" do

    let(:file) { double('file') }

    before :each do
      allow(File).to receive(:exist?).with("filename") { true }
      allow(File).to receive(:open).with("filename", "a").and_yield(file)
    end

    it "should append record to end of file" do
      expect(file).to receive(:<<).with("record\n")
      subject.write_record("record")
    end

    context "when comma delimiter" do
      it "should convert delimiter to match file" do
        expect(file).to receive(:<<).with("a,b,c\n")
        subject.write_record("a|b|c")
      end
    end

    context "when pipe delimiter" do
      it "should convert delimiter to match file" do
        expect(file).to receive(:<<).with("a|b|c\n")
        described_class.new("filename", :pipe, "record").write_record("a,b,c")
      end
    end

    it "should create file if missing and add headers" do
      expect(File).to receive(:exist?).with("filename") { false }
      record_class = double('record_class')
      expect(record_class).to receive(:fields) { [:field_a, :field_b] }
      expect(file).to receive(:<<).with("FieldA,FieldB\n")
      expect(file).to receive(:<<).with("a,b\n")
      described_class.new("filename", :comma, record_class).write_record("a,b")
    end
  end
end
