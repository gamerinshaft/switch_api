module API
  module V1
    class Extra < Grape::API
      resource :extra do
        desc '気温を取得する', notes: <<-NOTE
            <h1>ログを取得します</h1>
            <h3>size - 取得数</h3>
            <p>
              null ・・・ すべての気温の取得<br>
              num  ・・・ 最新num件の気温を取得
            </p>
          NOTE
        params do
          requires :auth_token, type: String, desc: 'Auth token.'
          optional :size, type: Integer, desc: 'Array size'
        end
        get '/temperatures', jbuilder: 'api/v1/extra/temperatures' do
          if (token = AuthToken.find_by(token: params[:auth_token]))
            if user.info.nil?
              error!(meta: {
                       status: 400,
                       errors: [
                         message: ('errors.messages.user_not_found'),
                         code: ErrorCodes::NOT_FOUND_USER
                       ]
                     }, response: {})
            else
              @user = user
              if user.room.nil?
                if params[:size].nil?
                  @logs = user.room.temperatures.sort { |a, b| b <=> a }
                else
                  @logs = user.room.temperatures.last(params[:size].to_i).sort { |a, b| b <=> a }
                end
              else
                error!(meta: {
                         status: 400,
                         errors: [
                           message: ('errors.messages.room_not_found'),
                           code: ErrorCodes::NOT_FOUND_ROOM
                         ]
                       }, response: {})
              end
            end
          else
            error!(meta: {
                     status: 400,
                     errors: [
                       message: ('errors.messages.invalid_token'),
                       code: ErrorCodes::INVALID_TOKEN
                     ]
                   }, response: {})
          end
        end
      end
    end
  end
end