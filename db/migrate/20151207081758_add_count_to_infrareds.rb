class AddCountToInfrareds < ActiveRecord::Migration
  def change
    add_column :infrareds, :count, :integer
  end
end
