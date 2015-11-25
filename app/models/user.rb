class User < ActiveRecord::Base
  has_many :auth_tokens, dependent: :destroy
end
