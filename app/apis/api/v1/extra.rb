module API
  module V1
    class Extra < Grape::API
      resource :extra do
        desc 'ping', notes: <<-NOTE
            <h1>レスポンスの有無</h1>
            <p>
            このURLにリクエストすることによって、アクセストークンを取得することができます。<br>
            アクセストークンは基本的にどんなリクエストをする時でも必要なので、値をキャッシュするようにしてください。
            </p>
          NOTE
        get '/ping', jbuilder: 'api/v1/extra/ping' do

        end
      end
    end
  end
end
