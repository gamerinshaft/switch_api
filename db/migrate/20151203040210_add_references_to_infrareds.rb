class AddReferencesToInfrareds < ActiveRecord::Migration
  def change
    add_reference :infrareds, :log, index: true, foreign_key: true
  end
end
