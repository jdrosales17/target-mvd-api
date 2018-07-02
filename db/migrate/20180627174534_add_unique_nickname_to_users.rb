class AddUniqueNicknameToUsers < ActiveRecord::Migration[5.2]
  def change
    change_column :users, :nickname, :string, null: false
    add_index :users, :nickname, unique: true
  end
end
