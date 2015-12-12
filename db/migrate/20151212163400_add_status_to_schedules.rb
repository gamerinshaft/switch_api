class AddStatusToSchedules < ActiveRecord::Migration
  def change
    add_column :schedules, :status, :integer
  end
end
