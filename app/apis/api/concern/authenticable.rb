module Authenticable
  extend ActiveSupport::Concern

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
      render json: {
                 errors: [
                     {
                         message: t('errors.messages.invalid_auth_token'),
                         code: ErrorCodes::INVALID_TOKEN
                     }
                 ]
             }, status: 400
    end
  end

end

