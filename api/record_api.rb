require 'grape'
require_relative '../lib/client'

class RecordAPI < Grape::API
  # A simple API exposing records sorted by gender, name, and birthdate.
  # Also allows posting a new record as a string
  format :json

  PATH = "data/records.txt"
  DELIMITER = :comma

  helpers do
    def client
      @client ||= FFParser::Client.new(PATH, DELIMITER)
    end
  end

  resource :records do
    desc 'Returns records sorted by gender.'
    get :gender do
      client.sort_by(["gender"], :asc, :hash_array)
    end

    desc 'Returns records sorted by birthdate.'
    get :birthdate do
      client.sort_by(["date_of_birth"], :asc, :hash_array)
    end

    desc 'Returns records sorted by name.'
    get :name do
      client.sort_by(["last_name", "first_name"], :asc, :hash_array)
    end

    desc 'Create a new record.'
    params do
      requires :record, type: String
    end
    post do
      client.save_record(params[:record])
      {status: "ok"}
    end
  end
end
