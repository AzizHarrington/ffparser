require 'spec_helper'

describe FFParser::Writer do
  describe "#write_record" do
    it "should append record to end of file" do
      file = double('file')
      expect(File).to receive(:open).with("filename", "a").and_yield(file)
      expect(file).to receive(:<<).with("record\n")
      described_class.new("filename").write_record("record")
    end

    it "should convert delimiter to match file" do
      
    end

    it "should create file if missing" do

    end

    it "should add headers to new file" do

    end
  end
end
