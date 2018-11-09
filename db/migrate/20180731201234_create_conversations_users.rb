class CreateConversationsUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :conversations_users do |t|
      t.integer :unread_messages, null: false, default: 0
      t.references :user, foreign_key: true
      t.references :conversation, foreign_key: true
    end
  end
end
