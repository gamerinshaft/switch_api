class CreateTaskInfrareds < ActiveRecord::Migration
  def change
    create_table :task_infrareds do |t|

      t.timestamps null: false
    end
  end
end
