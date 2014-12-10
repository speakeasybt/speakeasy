class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.integer :user_id
      t.integer :torrent_id
      t.string :action

      t.timestamps
    end
  end
end
