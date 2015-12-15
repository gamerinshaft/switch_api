
module API
  module V1
    class Base < Grape::API
      format :json
      default_format :json

      # for Grape::Jbuilder
      formatter :json, Grape::Formatter::Jbuilder

      prefix :api # /apiというパスになる
      version 'v1', using: :path # /api/v1というパスになる

      # 例外ハンドル 404
      rescue_from ActiveRecord::RecordNotFound do |e|
        rack_response({ message: e.message, status: 404 }.to_json, 404)
      end

      # 例外ハンドル 400
      rescue_from Grape::Exceptions::ValidationErrors do |e|
        rack_response e.to_json, 400
      end

      # 例外ハンドル 500
      rescue_from :all do |e|
        if Rails.env.development?
          fail e
        else
          error_response(message: 'Internal server error', status: 500)
        end
      end

      mount V1::Users
      mount V1::Authorize
      mount V1::IR
      mount V1::InfraredGroup
      mount V1::Schedules
      mount V1::Logs
      mount V1::Extra
      add_swagger_documentation format: :json, api_version: 'v1', hide_documentation_path: true
    end
  end
end
