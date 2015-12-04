class CreateInfraredGroups < ActiveRecord::Migration
  def change
    create_table :infrared_groups do |t|
      t.string :name
      t.references :user, index: true, foreign_key: true
      t.references :log, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
