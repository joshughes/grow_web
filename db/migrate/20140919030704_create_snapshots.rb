class CreateSnapshots < ActiveRecord::Migration
  def change
    create_table :snapshots do |t|
      t.attachment :shot
      t.timestamps
    end
  end
end
