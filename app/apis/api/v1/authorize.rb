module API
  module V1
    class Authorize < Grape::API
      helpers do
        params :attributes do
          requires :name, type: String, desc: "User name."
          requires :email, type: String, desc: "User email."
          requires :password, type: String, desc: "User Password."
          # optional :body, type: String, desc: "MessageBoard body."
        end
      end
      resource :auth do
        desc '<input value="/api/v1/auth/signup"><span>確認用のテストAPI</span>', {
          notes: <<-NOTE
            <h1>signup</h1>
            <p>
            User登録をします。<br>
            </p>
          NOTE
        }
        params do
          use :attributes
        end
        post '/signup', jbuilder: 'api/v1/auth/signup' do
          @hoge = params[:name]
        end
      end
    end
  end
end