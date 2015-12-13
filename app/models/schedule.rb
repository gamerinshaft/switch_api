class Schedule < ActiveRecord::Base
  soft_deletable

  belongs_to :user
  belongs_to :infrared
  has_many :logs, as: :loggable
  enum status: %i(inactive_schedule active_schedule)
  soft_deletable dependent_associations: [:user]
  soft_deletable dependent_associations: [:infrared]
end
