class AddHasAnsweredColumnToUsers < ActiveRecord::Migration
  def change
    add_column :users, :has_answered, :boolean, default: false
  end
end
