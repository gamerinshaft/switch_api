# app/apis/api/v1/ir.rb

module API
  module V1
    class InfraredGroup < Grape::API
      resource :group do
        desc 'グループ内の赤外線一覧の表示', notes: <<-NOTE
            <h1>グループ内の赤外線を表示</h1>
            <p>
              グループ内の赤外線を表示します
            </p>
          NOTE
        get '/ping', jbuilder: 'api/v1/group/ping' do
        end
      end
    end
  end
end
