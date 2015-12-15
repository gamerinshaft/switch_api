class CreateTemperatures < ActiveRecord::Migration
  def change
    create_table :temperatures do |t|
      t.references :room, index: true, foreign_key: true
      t.string :centigrade

      t.timestamps null: false
    end
  end
end
