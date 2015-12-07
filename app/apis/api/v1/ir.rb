# app/apis/api/v1/ir.rb

module API
  module V1
    class IR < Grape::API
      resource :ir do
        desc '赤外線の受信', notes: <<-NOTE
            <h1>赤外線を受信します</h1>
            <p>
              赤外線を受信します
            </p>
          NOTE
        params do
          requires :auth_token, type: String, desc: 'Auth token.'
        end
        post '/recieve', jbuilder: 'api/v1/ir/recieve' do
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
              infrared = user.infrareds.create(name: "名無しの赤外線", data: "")
              path = Rails.root.to_s
              command = File.join(path, "commands/recieve")
              fname = "user_#{user.id}_ir_#{infrared.id}.txt"
              `#{command} #{path}/data/#{fname}`
              status = `echo %ERRORLEVEL%`
              if(status != 0){
                error!(meta: {
                       status: 400,
                       errors: [
                         message: ('errors.messages.fail_shell_sclipt'),
                         code: ErrorCodes::FAIL_SHELLSCRIPT
                       ]
                     }, response: {})
              }
              infrared.update(data: "#{fname}")
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
      end
    end
  end
end
