require 'grape'
require_relative '../lib/client'

class RecordAPI < Grape::API
  format :json

  PATH = "data/records.txt"

  helpers do
    def client
      @client ||= FFParser::Client.new(PATH, :csv)
    end
  end

  resource :records do
    desc 'Returns records sorted by gender.'
    get :gender do
      client.sort(["gender"], :asc, :hash_array)
    end

    desc 'Returns records sorted by birthdate.'
    get :birthdate do
      client.sort(["date_of_birth"], :asc, :hash_array)
    end

    desc 'Returns records sorted by name.'
    get :name do
      client.sort(["last_name", "first_name"], :asc, :hash_array)
    end

    desc 'Create a new record.'
    params do
      requires :record, type: String
    end
    post do
      FFParser::Client.save_record(PATH, params[:record])
    end
  end
end
