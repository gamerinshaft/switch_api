class User < ActiveRecord::Base
  has_many :auth_tokens, dependent: :destroy
  has_one :info, class_name: 'UserInfo', dependent: :destroy
  has_many :schedules, dependent: :destroy
  has_many :infrareds
  has_many :infrared_groups
  has_many :logs, dependent: :destroy
  has_many :infrared_logs, through: :logs, source: :loggable, source_type: 'Infrared'
  has_many :schedule_logs, through: :logs, source: :loggable, source_type: 'Schedule'
end
