class DropTableTaskInfrareds < ActiveRecord::Migration
  def change
    drop_table :task_infrareds
  end
end
