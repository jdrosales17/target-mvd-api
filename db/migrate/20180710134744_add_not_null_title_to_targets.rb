class AddNotNullTitleToTargets < ActiveRecord::Migration[5.2]
  def change
    change_column :targets, :title, :string, null: false
  end
end
