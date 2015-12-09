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

        desc 'グループの一覧表示', notes: <<-NOTE
            <h1>グループを一覧表示する</h1>
            <p>
              グループを一覧表示します。
            </p>
          NOTE
        params do
          requires :auth_token, type: String, desc: 'Auth token.'
        end
        get '/', jbuilder: 'api/v1/group/index' do
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
              @groups = user.infrared_groups
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

        desc 'グループの作成', notes: <<-NOTE
            <h1>グループを作成する</h1>
            <p>
              グループを作成します。
            </p>
          NOTE
        params do
          requires :auth_token, type: String, desc: 'Auth token.'
          requires :name, type: String, desc: 'Group name.'
        end
        post '/', jbuilder: 'api/v1/group/create' do
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
              @group = user.infrared_groups.create(name: params[:name])
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

        desc 'グループのアップデート', notes: <<-NOTE
            <h1>グループをアップデートする</h1>
            <p>
              グループをアップデートします。
            </p>
          NOTE
        params do
          requires :auth_token, type: String, desc: 'Auth token.'
          requires :name, type: String, desc: 'Name.'
          requires :group_id, type: Integer, desc: 'Group_id.'
        end
        put '/', jbuilder: 'api/v1/group/update' do
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
              if group = user.infrared_groups.find_by(id: params[:group_id])
                group.update(name: params[:name])
                @group = group
              else
                error!(meta: {
                       status: 400,
                       errors: [
                         message: ('errors.messages.group_not_found'),
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

        desc 'グループの削除', notes: <<-NOTE
            <h1>グループを削除する</h1>
            <p>
              グループを削除します。
            </p>
          NOTE
        params do
          requires :auth_token, type: String, desc: 'Auth token.'
          requires :group_id, type: Integer, desc: 'Group_id.'
        end
        delete '/', jbuilder: 'api/v1/group/destroy' do
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
              if group = user.infrared_groups.find_by(id: params[:group_id])
                @group = group
                group.destroy
              else
                error!(meta: {
                       status: 400,
                       errors: [
                         message: ('errors.messages.group_not_found'),
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

        resource :ir do
          desc '赤外線の追加', notes: <<-NOTE
              <h1>グループに赤外線を追加する</h1>
              <p>
                グループに赤外線を追加します。
              </p>
            NOTE
          params do
            requires :auth_token, type: String, desc: 'Auth token.'
            requires :group_id, type: Integer, desc: 'Group_id.'
            requires :ir_id, type: Integer, desc: 'IR_id.'
          end
          post '/', jbuilder: 'api/v1/group/ir/add' do
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
                if group = user.infrared_groups.find_by(id: params[:group_id])
                  if ir = user.infrareds.find_by(id: params[:ir_id])
                    if !group.infrareds.find_by(id: params[:ir_id])
                      group.infrareds << ir
                      @group = group
                      @ir = ir
                    else
                      error!(meta: {
                           status: 400,
                           errors: [
                             message: ('errors.messages.ir_already_existing'),
                             code: ErrorCodes::ALREADY_EXISTING
                           ]
                         }, response: {})
                    end
                  else
                    error!(meta: {
                           status: 400,
                           errors: [
                             message: ('errors.messages.ir_not_found'),
                             code: ErrorCodes::NOT_FOUND
                           ]
                         }, response: {})
                  end
                else
                  error!(meta: {
                         status: 400,
                         errors: [
                           message: ('errors.messages.group_not_found'),
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
              <h1>グループに赤外線情報を削除する</h1>
              <p>
                グループに赤外線情報を削除します。
              </p>
            NOTE
          params do
            requires :auth_token, type: String, desc: 'Auth token.'
            requires :group_id, type: Integer, desc: 'Group_id.'
            requires :ir_id, type: Integer, desc: 'IR_id.'
          end
          delete '/', jbuilder: 'api/v1/group/ir/remove' do
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
                if group = user.infrared_groups.find_by(id: params[:group_id])
                  if ir = user.infrareds.find_by(id: params[:ir_id])
                    if relational = group.infrared_relationals.find_by(infrared_id: params[:ir_id])
                      @group = group
                      @ir = ir
                      relational.destroy
                    else
                      error!(meta: {
                           status: 400,
                           errors: [
                             message: ('errors.messages.ir_not_found_in_group'),
                             code: ErrorCodes::NOT_FOUND
                           ]
                         }, response: {})
                    end
                  else
                    error!(meta: {
                           status: 400,
                           errors: [
                             message: ('errors.messages.ir_not_found'),
                             code: ErrorCodes::NOT_FOUND
                           ]
                         }, response: {})
                  end
                else
                  error!(meta: {
                         status: 400,
                         errors: [
                           message: ('errors.messages.group_not_found'),
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

          desc 'グループの赤外線一覧表示', notes: <<-NOTE
              <h1>グループの赤外線を一覧表示する</h1>
              <p>
                グループの赤外線を一覧表示します。
              </p>
            NOTE
          params do
            requires :auth_token, type: String, desc: 'Auth token.'
            requires :group_id, type: Integer, desc: 'Group_id.'
          end
          get '/', jbuilder: 'api/v1/group/ir/index' do
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
                if group = user.infrared_groups.find_by(id: params[:group_id])
                    @group = group
                    @infrareds = group.infrareds
                else
                  error!(meta: {
                         status: 400,
                         errors: [
                           message: ('errors.messages.group_not_found'),
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
end
