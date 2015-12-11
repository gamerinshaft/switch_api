class CreateSchedules < ActiveRecord::Migration
  def change
    create_table :schedules do |t|
      t.string :name
      t.text :description
      t.string :cron
      t.string :job_name
      t.references :user, index: true, foreign_key: true
      t.references :infrared, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
