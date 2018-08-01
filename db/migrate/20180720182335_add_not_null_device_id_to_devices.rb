class AddNotNullDeviceIdToDevices < ActiveRecord::Migration[5.2]
  def change
    change_column :devices, :device_id, :string, null: false
  end
end
