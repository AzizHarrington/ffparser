require "spec_helper"
require "rack/test"

describe RecordAPI do
  include Rack::Test::Methods

  def app
    RecordAPI
  end

  let(:client) { double("client") }

  before :each do
    allow(FFParser::Client)
      .to receive(:new)
      .with("data/records.txt", :csv) { client }
  end

  context "GET /records/gender" do
    it "returns a json array of records sorted by gender" do
      expect(client)
        .to receive(:sort)
        .with(["gender"], :asc, :hash_array) { [{record: 1}, {record: 2}] }

      get "/records/gender"

      expect(last_response.status).to eq(200)
      expect(JSON.parse(last_response.body)).to eq(
        [{"record"=>1}, {"record"=>2}]
      )
    end
  end

  context "GET /records/birthdate" do
    it "returns a json array of records sorted by birthdate" do
      expect(client)
        .to receive(:sort)
        .with(["date_of_birth"], :asc, :hash_array) { [{record: 1}, {record: 2}] }

      get "/records/birthdate"

      expect(last_response.status).to eq(200)
      expect(JSON.parse(last_response.body)).to eq(
        [{"record"=>1}, {"record"=>2}]
      )
    end
  end

  context "GET /records/name" do
    it "returns a json array of records sorted by name" do
      expect(client)
        .to receive(:sort)
        .with(["last_name", "first_name"], :asc, :hash_array) { [{record: 1}, {record: 2}] }

      get "/records/name"

      expect(last_response.status).to eq(200)
      expect(JSON.parse(last_response.body)).to eq(
        [{"record"=>1}, {"record"=>2}]
      )
    end
  end

  context "POST /records" do
    it "creates a new record" do
      expect(FFParser::Client).to_not receive(:new)
      record = "foo, bar, baz, green, 08/21/1986"
      expect(FFParser::Client)
        .to receive(:save_record).with("data/records.txt", record)
      post "/records", "record=#{record}"
      expect(last_response.status).to eq 201
    end
  end
end
