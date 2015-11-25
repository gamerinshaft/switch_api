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
          requires :password, type: String, desc: "User Password."
          # optional :body, type: String, desc: "MessageBoard body."
        end

        # パラメータのチェック
        params :id do
          requires :id, type: Integer, desc: "MessageBoard id."
        end
      end
      resource :users do
        desc '<input value="/api/v1/users/hello"><span>確認用のテストAPI</span>', {
          notes: <<-NOTE
            <h1>helloと返すAPI</h1>
            <p>
            このURLにアクセスするとHelloを返してくれます。<br>
            実際にリクエストできてるか確認するためのAPIです。
            </p>
          NOTE
        }
        get '/hello', jbuilder: 'api/v1/users/hello' do
          @hoge = 'hello'
        end
        desc '<input value="/api/v1/users"><span>ユーザー作成</span>', {
          notes: <<-NOTE
            <h1>Userを作成するAPI</h1>
            <p>
            このURLにアクセスするとUserを作るよ。
            </p>
          NOTE
        }
        post '/', jbuilder: 'api/v1/users/create' do
          user = save_object(User.new())
          @token = user.auth_tokens.new_token
        end
      end

      resource :devices do
        desc 'GET /api/v1/users/hello', {
          notes: <<-NOTE
            <h1>helloと返すAPI</h1>
            <hr>
            <p>
            このURLにアクセスするとHelloを返してくれます。<br>
            実際にリクエストできてるか確認するためのAPIです。
            </p>
          NOTE
        }
        get '/hello', jbuilder: 'api/v1/users/hello' do
          @hoge = 'hello'
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
