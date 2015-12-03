class Infrared < ActiveRecord::Base
  belongs_to :user
  has_many :task_infrareds
  has_many :tasks, through: :task_infrareds
end
