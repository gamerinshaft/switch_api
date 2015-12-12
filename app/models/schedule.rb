class Schedule < ActiveRecord::Base
  belongs_to :user
  belongs_to :infrared
  enum status: %i(inactive_schedule active_schedule)
end
