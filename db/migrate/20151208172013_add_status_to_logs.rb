class AddStatusToLogs < ActiveRecord::Migration
  def change
    add_column :logs, :status, :integer
  end
end
