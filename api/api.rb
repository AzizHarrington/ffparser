require 'grape'

class API < Grape::API
  format :json

  helpers do
    def client
      FFParser::Client.new("data/records.txt", :csv)
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
  end
end
