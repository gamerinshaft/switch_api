class Task < ActiveRecord::Base
  belongs_to :user
  has_many :task_infrareds
  has_many :infrareds, through: :task_infrareds
end
