class CreateDevices < ActiveRecord::Migration[6.1]
  def change
    create_table :devices do |t|
      t.string :device_name
      t.string :device_information

      t.timestamps
    end
  end
end
