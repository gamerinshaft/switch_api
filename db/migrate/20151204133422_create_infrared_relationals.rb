class CreateInfraredRelationals < ActiveRecord::Migration
  def change
    create_table :infrared_relationals do |t|
      t.references :infrared, index: true, foreign_key: true
      t.references :infrared_group, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
