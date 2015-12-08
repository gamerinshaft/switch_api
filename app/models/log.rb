class Log < ActiveRecord::Base
  belongs_to :user
  has_one :infrared_group, dependent: :destroy
  has_one :infrared, dependent: :destroy
end
