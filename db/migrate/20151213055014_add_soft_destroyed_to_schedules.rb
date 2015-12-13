class AddSoftDestroyedToSchedules < ActiveRecord::Migration
  def change
    add_column :schedules, :soft_destroyed_at, :datetime
    add_index :schedules, :soft_destroyed_at
  end
end
