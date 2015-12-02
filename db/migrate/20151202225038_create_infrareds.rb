class CreateInfrareds < ActiveRecord::Migration
  def change
    create_table :infrareds do |t|
      t.string :name
      t.string :data
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
