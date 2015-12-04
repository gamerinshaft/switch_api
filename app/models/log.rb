class Log < ActiveRecord::Base
  belongs_to :user
  has_one :infrared_group
  has_one :infrared
end
