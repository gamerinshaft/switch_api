class AddColumnToLogs < ActiveRecord::Migration
  def change
    add_column :logs, :loggable_type, :string
  end
end
