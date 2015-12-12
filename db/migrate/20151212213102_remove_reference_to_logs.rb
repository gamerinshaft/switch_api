class RemoveReferenceToLogs < ActiveRecord::Migration
  def change
    remove_reference :logs, :infrared, index: true, foreign_key: true
  end
end
