class AuthToken < ActiveRecord::Base
  soft_deletable dependent_associations: [:user]
  belongs_to :user

  validates :user, presence: true
  validates :token, presence: true, uniqueness: true

  def self.generate_token
    create!(token: SecureRandom.urlsafe_base64)
  end

  def self.new_token
    generate_token.token
  end
end
