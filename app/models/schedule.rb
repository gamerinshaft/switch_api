class Schedule < ActiveRecord::Base
  belongs_to :user
  belongs_to :infrared
  has_many :logs, as: :loggable
  enum status: %i(inactive_schedule active_schedule)
end
