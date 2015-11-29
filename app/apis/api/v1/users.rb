# app/apis/api/v1/users.rb

module API
  module V1
    class Users < Grape::API
      helpers do
        # Strong Parametersの設定
        def message_board_params
          ActionController::Parameters.new(params).permit(:title, :body)
        end

        def set_message_board
          @message_board = MessageBoard.find(params[:id])
        end

        # パラメータのチェック
        # パラメーターの必須、任意を指定することができる。
        # use :attributesという形で使うことができる。
        params :attributes do
          requires :password, type: String, desc: 'User Password.'
          # optional :body, type: String, desc: "MessageBoard body."
        end

        # パラメータのチェック
        params :id do
          requires :id, type: Integer, desc: 'MessageBoard id.'
        end

        params :token do
          requires :auth_token, type: String, desc: 'auth_token'
        end
      end
      resource :users do
        desc '確認用のテストAPI', notes: <<-NOTE
            <h1>helloと返すAPI</h1>
            <p>
            このURLにアクセスするとHelloを返してくれます。<br>
            実際にリクエストできてるか確認するためのAPIです。
            </p>
          NOTE
        get '/hello', jbuilder: 'api/v1/users/hello' do
          @hoge = 'hello'
        end
        desc 'ユーザー作成', notes: <<-NOTE
            <h1>Userを作成するAPI</h1>
            <p>
            このURLにアクセスするとUserを作るよ。
            </p>
          NOTE
        post '/', jbuilder: 'api/v1/users/create' do
          user = save_object(User.new)
          @token = user.auth_tokens.new_token
        end

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
        delete '/', jbuilder: 'api/v1/users/destroy' do
          unless token = AuthToken.find_by(token: params[:auth_token])
            error!(json: {
                     errors: [
                       {
                         message: 'errors.messages.cant_find_token',
                         code: ErrorCodes::INVALID_TOKEN
                       }
                     ]
                   }, status: 400
                  )
            false
          end

          if info = token.user.info
            if params[:password]
              if check_password(info, params[:password])
                user.destroy
                @message = '退会しました。'
              end
            else
              error!(json: {
                       errors: [
                         {
                           message: 'errors.messages.need_a_password',
                           code: ErrorCodes::NEED_A_PASSWORD
                         }
                       ]
                     }, status: 400
                    )
              false
            end
          else
            user.destroy
            @message = '退会しました。'
          end
        end

        resource :info do
          desc 'ユーザー情報の表示', notes: <<-NOTE
              <h1>helloと返すAPI</h1>
              <p>
              このURLにアクセスするとHelloを返してくれます。<br>
              実際にリクエストできてるか確認するためのAPIです。
              </p>
            NOTE
          params do
            use :token
          end
          get '/', jbuilder: 'api/v1/users/info/show' do
            if user.info.nil?
              error!(json: {
                       errors: [
                         message: ('info did not create'),
                         code: ErrorCodes::NOT_FOUND
                       ]
                     }, status: 400)
            end
            @info = user.info
          end
        end
      end

      #   resource :message_boards do
      #     desc 'GET /api/v1/message_boards'
      #     get '/', jbuilder: 'api/v1/message_boards/index' do
      #       @message_boards = MessageBoard.all
      #     end

      #     desc 'POST /api/v1/message_boards'
      #     params do
      #       use :attributes
      #     end
      #     post '/' do
      #       message_board = MessageBoard.new(message_board_params)
      #       message_board.save
      #     end

      #     desc 'GET /api/v1/message_boards/:id'
      #     params do
      #       use :id
      #     end
      #     get '/:id', jbuilder: 'api/v1/message_boards/show' do
      #       set_message_board
      #     end

      #     desc 'PUT /api/v1/message_boards/:id'
      #     params do
      #       use :id
      #       use :attributes
      #     end
      #     put '/:id' do
      #       set_message_board
      #       @message_board.update(message_board_params)
      #     end

      #     desc 'DELETE /api/v1/message_boards/:id'
      #     params do
      #       use :id
      #     end
      #     delete '/:id' do
      #       set_message_board
      #       @message_board.destroy
      #     end
      #   end
    end
  end
end
