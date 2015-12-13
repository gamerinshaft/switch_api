class Log < ActiveRecord::Base
  belongs_to :user
  belongs_to :loggable, polymorphic: true, dependent: :destroy
  enum status: %i(receive_ir send_ir update_ir destroy_ir add_ir remove_ir robot_send_ir remove_schedule create_schedule activate_schedule update_schedule delete_schedule)
end
