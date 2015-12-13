class User < ActiveRecord::Base
  soft_deletable

  has_many :auth_tokens, dependent: :destroy
  has_one :info, class_name: 'UserInfo', dependent: :destroy
  has_many :schedules, dependent: :destroy
  has_many :infrareds
  has_many :infrared_groups
  has_many :logs, dependent: :destroy
  has_many :log_infrareds, through: :logs, source: :loggable, source_type: 'Infrared'
  has_many :log_schedules, through: :logs, source: :loggable, source_type: 'Schedule'

  def self.schedule_logs
    self.logs.where(loggable_type: "Schedule")
  end

  def self.infrared_logs
    self.logs.where(loggable_type: "Infrared")
  end
end
