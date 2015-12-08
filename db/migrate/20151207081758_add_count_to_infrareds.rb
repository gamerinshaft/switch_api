class AddCountToInfrareds < ActiveRecord::Migration
  def change
    add_column :infrareds, :count, :integer, default: 0
  end
end
