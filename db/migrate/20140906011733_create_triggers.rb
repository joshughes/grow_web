class CreateTriggers < ActiveRecord::Migration
  def change
    create_table :triggers do |t|
      t.string  :condition
      t.string  :type
      t.decimal :value
      t.boolean :state
      t.integer :device_id
      t.timestamps
    end
  end
end
