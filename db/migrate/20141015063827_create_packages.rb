class CreatePackages < ActiveRecord::Migration
  def change
    create_table :packages do |t|
      t.integer :torrent_id
      t.integer :user_id
      t.string :file_token

      t.timestamps
    end
  end
end
