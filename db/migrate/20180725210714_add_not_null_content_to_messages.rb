class AddNotNullContentToMessages < ActiveRecord::Migration[5.2]
  def change
    change_column :messages, :content, :string, null: false
  end
end
