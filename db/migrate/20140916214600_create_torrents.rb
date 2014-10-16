class CreateTorrents < ActiveRecord::Migration
  def change
    create_table :torrents do |t|
      t.string :title
      t.integer :uploader_id
      t.string :file_name
      t.integer :download_count
      t.integer :category_id
      t.text :description

      t.timestamps
    end
  end
end
