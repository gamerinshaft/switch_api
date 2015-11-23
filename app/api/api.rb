# app/api/api.rb
class API < Grape::API
  format :json
  prefix "v1"
  resource :items do
    get '/hello' do
      {hello: "world"}
    end
  end
end