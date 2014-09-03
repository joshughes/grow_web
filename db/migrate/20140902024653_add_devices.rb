class AddDevices < ActiveRecord::Migration
  def change
    create_table :devices do |t|
      t.string  :name
      t.string  :address
      t.boolean :state
      t.timestamps
    end
  end
end
