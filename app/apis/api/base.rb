require 'error_codes'

module API
  class Base < Grape::API
    helpers do
      def save_object(object)
        if object.save
          object
        else
          errors = []
          object.errors.each do |key, value|
            errors << {
              message: "#{key} #{value}",
              code: ErrorCodes::FAIL_SAVE
            }
          end
          error!(meta: {
                   status: 400,
                   errors: errors
                 }, response: {})
        end
      end

      def check_password(user_info, raw_password)
        if BCrypt::Password.new(user_info.hashed_password) == raw_password
          true
        else
          error!(meta: {
                     status: 400,
                     errors: [
                       message: ('errors.messages.invalid_pin'),
                       code: ErrorCodes::INVALID_PIN
                     ]
                   }, response: {})
          false
        end
      end

      def user
        return @user if @user
        return nil unless (token = AuthToken.find_by(token: params[:auth_token]))
        update_auth_token token
        @user = token.user
      end

      def update_auth_token(token)
        token.touch
        token.save
      end

      def user_signed_in?
        user.present?
      end

      def authenticate_user!
        unless user_signed_in?
          error!(json: {
                   errors: [
                     {
                       message: t('errors.messages.invalid_auth_token'),
                       code: ErrorCodes::INVALID_TOKEN
                     }
                   ]
                 }, status: 400
                )
        end
      end
    end

    mount V1::Base
  end
end
