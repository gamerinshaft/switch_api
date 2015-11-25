class UserInfo < ActiveRecord::Base
  belongs_to :user

  before_validation do
    self.email_for_index = email.downcase if email
  end

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  VALID_SCREEN_NAME_REGEX = /\A[a-zA-Z]+[a-zA-Z0-9]+\z/
  VALID_PASSWORD_REGEX = /\A[a-zA-Z0-9!#$%&~@<>?]+\z/

  validates :email, presence: true
  validates :email_for_index,
            presence: true,
            uniqueness: true,
            format: { with: VALID_EMAIL_REGEX }
  validates :screen_name,
            presence: true,
            uniqueness: true,
            format: { with: VALID_SCREEN_NAME_REGEX }
  validates :hashed_password, presence: true

  def password=(raw_password)
    unless VALID_PASSWORD_REGEX.match(raw_password)
      self.hashed_password = nil
      return
    end

    if raw_password.kind_of?(String)
      self.hashed_password = BCrypt::Password.create(raw_password)
    elsif raw_password.nil?
      self.hashed_password = nil
    end
  end
end
