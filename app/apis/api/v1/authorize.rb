module API
  module V1
    class Authorize < Grape::API
      helpers do
        params :signup_params do
          requires :screen_name, type: String, desc: '表示名'
          requires :email, type: String, desc: 'メールアドレス'
          requires :password, type: String, desc: 'パスワード'
          requires :auth_token, type: String, desc: 'トークン'
          # optional :body, type: String, desc: "MessageBoard body."
        end
        params :login_params do
          requires :email_or_screen_name, type: String, desc: 'メールアドレスまたは名前'
          requires :password, type: String, desc: 'パスワード'
        end
        def find_user_by_identifier(identifier)
          if (user_info = UserInfo.find_by(screen_name: identifier) || UserInfo.find_by(email: identifier))
            user_info.user
          else
            error!(meta: {
                     status: 400,
                     errors: [
                       message: ('errors.messages.user_not_found'),
                       code: ErrorCodes::NOT_FOUND_USER
                     ]
                   }, response: {})
          end
        end
      end
      resource :auth do
        desc 'トークンの取得', notes: <<-NOTE
            <h1>アクセストークンを作成する</h1>
            <p>
            このURLにリクエストすることによって、アクセストークンを取得することができます。<br>
            アクセストークンは基本的にどんなリクエストをする時でも必要なので、値をキャッシュするようにしてください。
            </p>
          NOTE
        get '/token', jbuilder: 'api/v1/auth/token' do
          user = save_object(User.new)
          @token = user.auth_tokens.new_token
        end

        desc 'User登録用API', notes: <<-NOTE
            <h1>signup</h1>
            <p>
            User登録をします。<br>
            </p>
          NOTE
        params do
          use :signup_params
        end
        post '/signup', jbuilder: 'api/v1/auth/signup' do
          if (token = AuthToken.find_by(token: params[:auth_token]))
            if !user.info.nil?
              error!(meta: {
                       status: 400,
                       errors: [
                         message: ('errors.messages.already_existing'),
                         code: ErrorCodes::ALREADY_EXISTING
                       ]
                     }, response: {})
            else
              user_info = user.build_info(
                email:           params[:email],
                screen_name:     params[:screen_name],
                password:        params[:password]
              )
              obj = save_object(user_info)
              @screen_name = obj.screen_name
              @token = token.token
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

        desc 'ログイン用API', notes: <<-NOTE
            <h1>signup</h1>
            <p>
            emailまたはスクリーンネームを用いてログインします。<br>
            </p>
          NOTE
        params do
          use :login_params
        end
        post '/login', jbuilder: 'api/v1/auth/login' do
          user = find_user_by_identifier(params[:email_or_screen_name])
          if check_password(user.info, params[:password])
            @token = user.auth_tokens.new_token
          end
        end

        desc 'ログアウト用API', notes: <<-NOTE
            <h1>logout</h1>
            <p>
            トークンを削除してログアウトします。ユーザー情報がまだ作成されてないトークンは削除できません。
            </p>
          NOTE
        params do
          requires :auth_token, type: String, desc: 'トークン'
        end
        delete '/logout', jbuilder: 'api/v1/auth/logout' do
          if (token = AuthToken.find_by(token: params[:auth_token]))
            if token.user.info
              token.destroy
            else
              error!(meta: {
                       status: 400,
                       errors: [
                         message: ('errors.messages.info_not_found'),
                         code: ErrorCodes::NOT_FOUND_INFO
                       ]
                     }, response: {})
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
