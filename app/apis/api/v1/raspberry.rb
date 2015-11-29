# app/apis/api/v1/raspberry.rb

module API
  module V1
    class Raspberry < Grape::API
      resource :raspberry do
        desc 'LEDの点滅', notes: <<-NOTE
            <h1>LEDを点滅させる</h1>
            <p>
               LEDがつくよ
            </p>
          NOTE
        params do
          requires :auth_token, type: String, desc: 'Auth token.'
        end
        get '/commands/blink', jbuilder: 'api/v1/raspberry/commands/blink' do
          if(token = AuthToken.find_by(token: params[:auth_token]))
            if token.user.info

            else
              error!(meta: {
                     status: 400,
                     errors: [
                       message: ('errors.messages.info_not_found'),
                       code: ErrorCodes::NOT_FOUND_INFO
                     ]
                   }, response: {})
              false
            end
          else
            error!(meta: {
                     status: 400,
                     errors: [
                       message: ('errors.messages.invalid_token'),
                       code: ErrorCodes::INVALID_TOKEN
                     ]
                   }, response: {})
            false
          end
        end
      end
    end
  end
end
