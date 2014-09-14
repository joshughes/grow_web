class CreatePowerConsumptions < ActiveRecord::Migration
  def change
    create_table :power_consumptions do |t|
      t.integer :device_id
      t.decimal  :power_consumed
      t.decimal  :cost, :precision => 8, :scale => 2
      t.timestamps
    end

    change_table :devices do |t|
      t.decimal  :wattage
      Device.find_each do |device|
        device.wattage = 0
        device.save!
      end
    end
    
  end
end
