class CreateUsersRiddles < ActiveRecord::Migration
  def change
    create_table :users_riddles do |t|
      t.integer :user_id
      t.integer :riddle_id

      t.timestamps null: false
    end
  end
end
