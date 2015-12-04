class AddNameToLogs < ActiveRecord::Migration
  def change
    add_column :logs, :name, :string
  end
end
