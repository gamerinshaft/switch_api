class AddReferencesToTasks < ActiveRecord::Migration
  def change
    add_reference :tasks, :log, index: true, foreign_key: true
  end
end
