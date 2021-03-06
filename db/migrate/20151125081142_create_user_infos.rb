class CreateUserInfos < ActiveRecord::Migration
  def change
    create_table :user_infos do |t|
      t.string :screen_name
      t.string :hashed_password
      t.string :email
      t.string :email_for_index

      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
