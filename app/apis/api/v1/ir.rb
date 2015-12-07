# app/apis/api/v1/ir.rb

module API
  module V1
    class IR < Grape::API
      resource :ir do
        desc 'LEDの点滅', notes: <<-NOTE
            <h1>LEDを点滅させる</h1>
            <p>
               LEDがつくよ
            </p>
          NOTE
        params do
          requires :auth_token, type: String, desc: 'Auth token.'
        end
        get '/recieve', jbuilder: 'api/v1/ir/recieve' do
          path = Rails.root.to_s
          command = File.join(path, "commands/recieve")
          `#{command} #{path}/data/`
        end
      end
    end
  end
end
