# app/api/api.rb
class API < Grape::API
  format :json
  formatter :json, Grape::Formatter::Jbuilder

  content_type :xml, "text/xml"
  content_type :json, "application/json"

  prefix "v1"
  resource :items do
    get '/', jbuilder:'items' do

    end
  end
end