module API
  module V1
    class Authorize < Grape::API
      helpers do
        params :attributes do
          requires :screen_name, type: String, desc: '表示名'
          requires :email, type: String, desc: 'メールアドレス'
          requires :password, type: String, desc: 'パスワード'
          requires :auth_token, type: String, desc: 'トークン'
          # optional :body, type: String, desc: "MessageBoard body."
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

        desc '確認用のテストAPI', notes: <<-NOTE
            <h1>signup</h1>
            <p>
            User登録をします。<br>
            </p>
          NOTE
        params do
          use :attributes
        end
        post '/signup', jbuilder: 'api/v1/auth/signup' do
          if (token = AuthToken.find_by(token: params[:auth_token]))
            if !user.info.nil?
              error!(json: {
                       errors: [
                         message: ('errors.messages.already_existing'),
                         code: ErrorCodes::ALREADY_EXISTING
                       ]
                     }, status: 400)
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
          end
        end
      end
    end
  end
end
