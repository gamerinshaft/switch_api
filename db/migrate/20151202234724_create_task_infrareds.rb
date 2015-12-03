class CreateTaskInfrareds < ActiveRecord::Migration
  def change
    create_table :task_infrareds do |t|
      t.references :task, index: true, foreign_key: true
      t.references :infrared, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
