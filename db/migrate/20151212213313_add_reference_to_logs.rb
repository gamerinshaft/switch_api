class AddReferenceToLogs < ActiveRecord::Migration
  def change
    add_reference :logs, :loggable, index: true, foreign_key: true
  end
end
