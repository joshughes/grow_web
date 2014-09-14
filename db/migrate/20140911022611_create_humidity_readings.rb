class CreateHumidityReadings < ActiveRecord::Migration
  def change
    create_table :humidity_readings do |t|
      t.decimal  :humidity
      t.timestamps
    end
  end
end
