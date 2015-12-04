class Log < ActiveRecord::Base
  belongs_to :user
  has_one :infrared_groups
  has_one :infrareds
end
