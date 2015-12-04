# app/apis/api/v1/raspberry.rb
require 'wiringpi'

module API
  module V1
    class Raspberry < Grape::API
      resource :raspberry do
        desc 'LEDの点滅', notes: <<-NOTE
            <h1>LEDを点滅させる</h1>
            <p>
               LEDがつくよ
            </p>
          NOTE
        params do
          requires :auth_token, type: String, desc: 'Auth token.'
        end
        get '/commands/blink', jbuilder: 'api/v1/raspberry/commands/blink' do
          if (token = AuthToken.find_by(token: params[:auth_token]))
            if token.user.info
              # path = File.join(Rails.root.to_s + 'commands/blink.sh')
              # `sudo sh #{path}`
              io = WiringPi::GPIO.new do |gpio|
                gpio.pin_mode(0, WiringPi::OUTPUT)
                # gpio.pin_mode(1, WiringPi::INPUT)
              end

              # pin_state = io.digital_read(1) # Read from pin 1
              # puts pin_state

              io.digital_write(0, WiringPi::HIGH) # Turn pin 0 on
              io.delay(100)                       # Wait
              io.digital_write(0, WiringPi::LOW)  # Turn pin 0 off
            else
              error!(meta: {
                       status: 400,
                       errors: [
                         message: ('errors.messages.info_not_found'),
                         code: ErrorCodes::NOT_FOUND_INFO
                       ]
                     }, response: {})
              false
            end
          else
            error!(meta: {
                     status: 400,
                     errors: [
                       message: ('errors.messages.invalid_token'),
                       code: ErrorCodes::INVALID_TOKEN
                     ]
                   }, response: {})
            false
          end
        end
      end
    end
  end
end
