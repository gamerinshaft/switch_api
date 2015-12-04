class Log < ActiveRecord::Base
  belongs_to :user
  has_many :infrared_groups
  has_many :infrareds
end
