class AddUserIdToTargets < ActiveRecord::Migration[5.2]
  def change
    add_reference :targets, :user, foreign_key: true
  end
end