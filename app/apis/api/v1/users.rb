# app/apis/api/v1/users.rb

module API
  module V1
    class Users < Grape::API
      helpers do
        # パラメータのチェック
        # パラメーターの必須、任意を指定することができる。
        # use :attributesという形で使うことができる。
        params :attributes do
          requires :password, type: String, desc: 'User Password.'
          # optional :body, type: String, desc: "MessageBoard body."
        end

        # パラメータのチェック
        params :id do
          requires :id, type: Integer, desc: 'id.'
        end

        params :token do
          requires :auth_token, type: String, desc: 'auth_token'
        end
      end
      resource :user do
        desc 'ユーザー削除', notes: <<-NOTE
            <h1>Userを削除します</h1>
            <p>
            このURLにアクセスするとUserを削除します
            </p>
          NOTE
        params do
          use :token
          optional :password, type: String, desc: 'サインアップしている場合'
        end
        delete '/', jbuilder: 'api/v1/user/destroy' do
          unless token = AuthToken.find_by(token: params[:auth_token])
            error!(meta: {
                     status: 400,
                     errors: [
                       message: ('errors.messages.cant_find_token'),
                       code: ErrorCodes::INVALID_TOKEN
                     ]
                   }, response: {})
            false
          end
          if info = token.user.info
            if params[:password]
              if check_password(info, params[:password])
                name = user.info.screen_name
                user.destroy
                @message = "#{name}さんは退会しました。"
              end
            else
              error!(meta: {
                       status: 400,
                       errors: [
                         message: ('errors.messages.need_a_password'),
                         code: ErrorCodes::NEED_A_PASSWORD
                       ]
                     }, response: {})
              false
            end
          else
            user.destroy
            @message = '退会しました。'
          end
        end
        resource :info do
          desc 'ユーザー情報の表示', notes: <<-NOTE
              <h1>ユーザー情報を表示する</h1>
              <p>
                ユーザーのプロフィール情報がかえってきます。
              </p>
            NOTE
          params do
            use :token
          end
          get '/', jbuilder: 'api/v1/user/info/show' do
            if user.info.nil?
              error!(meta: {
                       status: 400,
                       errors: [
                         message: ('errors.messages.not_create_info'),
                         code: ErrorCodes::NOT_FOUND
                       ]
                     }, response: {})
              false
            end
            @info = user.info
          end
        end
      end
    end
  end
end
