class User < ActiveRecord::Base
  has_many :auth_tokens, dependent: :destroy
  has_one :info, class_name: 'UserInfo', dependent: :destroy

end
