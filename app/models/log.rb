class Log < ActiveRecord::Base
  belongs_to :user
  belongs_to :infrared, dependent: :destroy
  enum status: %i(recieve_ir send_ir update_ir destroy_ir add_ir remove_ir robot_send_ir)
end
