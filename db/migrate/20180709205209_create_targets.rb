class CreateTargets < ActiveRecord::Migration[5.2]
  def change
    create_table :targets do |t|
      t.string :title
      t.integer :area_length

      t.timestamps
    end
    add_index :targets, :title, unique: true
  end
end
