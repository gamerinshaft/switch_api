# app/apis/api/v1/ir.rb

module API
  module V1
    class InfraredGroup < Grape::API
      resource :group do
        desc 'グループ内の赤外線一覧の表示', notes: <<-NOTE
            <h1>グループ内の赤外線を表示</h1>
            <p>
              グループ内の赤外線を表示します
            </p>
          NOTE
        get '/ping', jbuilder: 'api/v1/group/ping' do
        end

        desc 'グループの作成', notes: <<-NOTE
            <h1>グループを作成する</h1>
            <p>
              グループを作成します。
            </p>
          NOTE
        params do
          requires :auth_token, type: String, desc: 'Auth token.'
          requires :name, type: String, desc: 'Group name.'
        end
        post '/', jbuilder: 'api/v1/group/create' do
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
              @group = user.infrared_groups.create(name: params[:name])
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
