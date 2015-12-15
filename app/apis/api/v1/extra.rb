module API
  module V1
    class Extra < Grape::API
      resource :extra do
        desc 'ping', notes: <<-NOTE
            <h1>レスポンスの有無</h1>
            <p>
            このURLにリクエストすることによって、アクセストークンを取得すること\
ができます。<br>
            アクセストークンは基本的にどんなリクエストをする時でも必要なので、\\
値をキャッシュするようにしてください。
            </p>
          NOTE
        get '/ping', jbuilder: 'api/v1/extra/ping' do
          path = Rails.root.to_s
          command = File.join(path, 'commands/temperature.rb')
          `sudo ruby #{command} #{path}/data/extra/temperature.txt`
        end
      end
    end
  end
end