# app/apis/api/v1/users.rb

module API
  module V1
    class Logs < Grape::API
      resource :log do
        desc 'logを取得する', notes: <<-NOTE
            <h1>ログを取得します</h1>
            <h3>size - 取得数</h3>
            <p>
              null ・・・ すべてのログの取得<br>
              num  ・・・ 最新num件のログを取得
            </p>
            <h3>type - ログのタイプ</h3>
            <p>
              null ・・・ すべてのログの取得<br>
              0    ・・・ 赤外線にまつわるログの取得<br>
              1    ・・・ スケジューラーにまつわるログの取得
            </p>
          NOTE
        params do
          requires :auth_token, type: String, desc: 'Auth token.'
          optional :size, type: Integer, desc: 'Array size'
          optional :type, type: Integer, desc: 'Log type'
        end
        get '/', jbuilder: 'api/v1/log/index' do
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
              if params[:type].nil?
                if params[:size].nil?
                  @logs = user.logs.sort { |a, b| b <=> a }
                else
                  @logs = user.logs.last(params[:size].to_i).sort { |a, b| b <=> a }
                end
              elsif params[:type].to_s =~ /^[0-1]$/
                if params[:type] == 0
                  if params[:size].nil?
                    @logs = user.infrared_logs.sort { |a, b| b <=> a }
                  else
                    @logs = user.infrared_logs.last(params[:size].to_i).sort { |a, b| b <=> a }
                  end
                elsif params[:type] == 1
                  if params[:size].nil?
                    @logs = user.schedule_logs.sort { |a, b| b <=> a }
                  else
                    @logs = user.schedule_logs.last(params[:size].to_i).sort { |a, b| b <=> a }
                  end
                end
              else
                error!(meta: {
                         status: 400,
                         errors: [
                           message: ('errors.messages.invalid_params'),
                           code: ErrorCodes::INVALID_PARAMS
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
