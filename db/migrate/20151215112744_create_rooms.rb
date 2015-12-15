class CreateRooms < ActiveRecord::Migration
  def change
    create_table :rooms do |t|
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
