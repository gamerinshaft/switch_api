# app/apis/api/v1/ir.rb

module API
  module V1
    class IR < Grape::API
      resource :ir do
        desc '赤外線一覧の表示', notes: <<-NOTE
            <h1>赤外線一覧の表示</h1>
            <p>
              赤外線一覧を表示します
            </p>
          NOTE
        params do
          requires :auth_token, type: String, desc: 'Auth token.'
        end
        get '/', jbuilder: 'api/v1/ir/index' do
          if (token = AuthToken.find_by(token: params[:auth_token]))
            if user.info.nil?
              error!(meta: {
                       status: 400,
                       errors: [
                         message: ('errors.messages.user_not_found'),
                         code: ErrorCodes::NOT_FOUND_USER
                       ]
                     }, response: {})
            else
              @infrareds = user.infrareds.without_soft_destroyed.all
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

        desc '赤外線の受信', notes: <<-NOTE
            <h1>赤外線を受信します</h1>
            <p>
              赤外線を受信します。
              任意でグループIDを渡すと、そのグループに紐付けてくれます。
            </p>
          NOTE
        params do
          requires :auth_token, type: String, desc: 'Auth token.'
          optional :group_id, type: Integer, desc: 'Group ID.'
        end
        post '/receive', jbuilder: 'api/v1/ir/receive' do
          if (token = AuthToken.find_by(token: params[:auth_token]))
            if user.info.nil?
              error!(meta: {
                       status: 400,
                       errors: [
                         message: ('errors.messages.user_not_found'),
                         code: ErrorCodes::NOT_FOUND_USER
                       ]
                     }, response: {})
            else
              infrared = user.infrareds.create(name: '名無しの赤外線', data: '')
              path = Rails.root.to_s
              command = File.join(path, 'commands/receive')
              fname = "user_#{user.id}_ir_#{infrared.id}.txt"
              `#{command} #{path}/data/#{fname}`
              if File.read("#{path}/data/#{fname}").size == 0
                infrared.soft_destroy
                error!(meta: {
                         status: 400,
                         errors: [
                           message: ('errors.messages.fail_scanir'),
                           code: ErrorCodes::FAIL_SCANIR
                         ]
                       }, response: {})
              end
              infrared.update(data: "#{fname}")
              log = user.logs.create(name: '赤外線を受信しました', status: :receive_ir)
              infrared.logs << log
              unless params[:group_id].nil?
                if group = user.infrared_groups.find_by(id: params[:group_id])
                  group.infrareds << infrared
                  log = user.logs.create(name: "「#{infrared.name}」を「#{group.name}」に追加しました", status: :add_ir)
                  log.infrared = infrared
                else
                  error!(meta: {
                           status: 400,
                           errors: [
                             message: ('errors.messages.ir_accept_but_group_not_found'),
                             code: ErrorCodes::NOT_FOUND
                           ]
                         }, response: {})
                end
              end
              @infrared = infrared
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
        desc '赤外線の送信', notes: <<-NOTE
            <h1>赤外線を送信します</h1>
            <p>
              赤外線を照射します
            </p>
          NOTE
        params do
          requires :auth_token, type: String, desc: 'Auth token.'
          requires :ir_id, type: Integer, desc: 'IR Id.'
        end
        post '/send', jbuilder: 'api/v1/ir/send' do
          if (token = AuthToken.find_by(token: params[:auth_token]))
            if user.info.nil?
              error!(meta: {
                       status: 400,
                       errors: [
                         message: ('errors.messages.user_not_found'),
                         code: ErrorCodes::NOT_FOUND_USER
                       ]
                     }, response: {})
            else
              if infrared = user.infrareds.without_soft_destroyed.find_by(id: params[:ir_id])
                fname = infrared.data
                path = Rails.root.to_s
                command = File.join(path, 'commands/send')
                `#{command} #{path}/data/#{fname}`
                count = infrared.count + 1
                infrared.update(count: count)
                log = user.logs.create(name: "「#{infrared.name}」を実行しました", status: :send_ir)
                infrared.logs << log
                @infrared = infrared
              else
                error!(meta: {
                         status: 400,
                         errors: [
                           message: ('errors.messages.ir_not_found'),
                           code: ErrorCodes::NOT_FOUND
                         ]
                       }, response: {})
              end
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
        desc '赤外線の名前変更', notes: <<-NOTE
            <h1>赤外線の名前を変更します</h1>
            <p>
              赤外線名を変更します
            </p>
          NOTE
        params do
          requires :auth_token, type: String, desc: 'Auth token.'
          requires :name, type: String, desc: 'IR name.'
          requires :ir_id, type: Integer, desc: 'IR Id.'
        end
        put '/rename', jbuilder: 'api/v1/ir/rename' do
          if (token = AuthToken.find_by(token: params[:auth_token]))
            if user.info.nil?
              error!(meta: {
                       status: 400,
                       errors: [
                         message: ('errors.messages.user_not_found'),
                         code: ErrorCodes::NOT_FOUND_USER
                       ]
                     }, response: {})
            else
              if infrared = user.infrareds.without_soft_destroyed.find_by(id: params[:ir_id])
                infrared.update(name: params[:name])
                log = user.logs.create(name: "「#{infrared.name}」に名前を変更しました", status: :update_ir)
                infrared.logs << log
                @infrared = infrared
              else
                error!(meta: {
                         status: 400,
                         errors: [
                           message: ('errors.messages.ir_not_found'),
                           code: ErrorCodes::NOT_FOUND
                         ]
                       }, response: {})
              end
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
        desc '赤外線の削除', notes: <<-NOTE
            <h1>赤外線を削除します</h1>
            <p>
              赤外線をデータベースから削除します
            </p>
          NOTE
        params do
          requires :auth_token, type: String, desc: 'Auth token.'
          requires :ir_id, type: Integer, desc: 'IR Id.'
        end
        delete '/', jbuilder: 'api/v1/ir/destroy' do
          if (token = AuthToken.find_by(token: params[:auth_token]))
            if user.info.nil?
              error!(meta: {
                       status: 400,
                       errors: [
                         message: ('errors.messages.user_not_found'),
                         code: ErrorCodes::NOT_FOUND_USER
                       ]
                     }, response: {})
            else
              if infrared = user.infrareds.without_soft_destroyed.find_by(id: params[:ir_id])
                name = infrared.data
                file = Rails.root.to_s + '/data/' + name
                File.delete file
                log = user.logs.create(name: "「#{infrared.name}」を削除しました", status: :destroy_ir)
                infrared.logs << log
                infrared.soft_destroy
              else
                error!(meta: {
                         status: 400,
                         errors: [
                           message: ('errors.messages.ir_not_found'),
                           code: ErrorCodes::NOT_FOUND
                         ]
                       }, response: {})
              end
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
