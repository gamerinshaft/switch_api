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
          # path = File.join(Rails.root.to_s + 'commands/blink.sh')
          # `sudo sh #{path}`
        end
      end
    end
  end
end
