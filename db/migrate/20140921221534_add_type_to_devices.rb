class AddTypeToDevices < ActiveRecord::Migration
  def change
    change_table :devices do |t|
      t.boolean :digital
    end
  end
end
