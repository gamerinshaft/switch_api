class InfraredGroup < ActiveRecord::Base
  belongs_to :user
  has_many :task_infrareds
  has_many :infrareds, through: :task_infrareds
  belongs_to :log
end
