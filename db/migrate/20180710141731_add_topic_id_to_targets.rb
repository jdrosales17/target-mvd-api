class AddTopicIdToTargets < ActiveRecord::Migration[5.2]
  def change
    add_reference :targets, :topic, foreign_key: true
  end
end
