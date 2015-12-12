class Infrared < ActiveRecord::Base
  belongs_to :user
  has_many :infrared_relationals
  has_many :infrared_groups, through: :infrared_relationals
  has_many :logs, as: :loggable
  has_one :schedule
end
