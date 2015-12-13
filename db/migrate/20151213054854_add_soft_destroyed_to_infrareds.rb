class AddSoftDestroyedToInfrareds < ActiveRecord::Migration
  def change
    add_column :infrareds, :soft_destroyed_at, :datetime
    add_index :infrareds, :soft_destroyed_at
  end
end
