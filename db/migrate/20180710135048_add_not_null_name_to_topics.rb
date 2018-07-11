class AddNotNullNameToTopics < ActiveRecord::Migration[5.2]
  def change
    change_column :topics, :name, :string, null: false
  end
end
