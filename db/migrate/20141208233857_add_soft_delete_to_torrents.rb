class AddSoftDeleteToTorrents < ActiveRecord::Migration
  def change
    add_column :torrents, :soft_delete, :boolean, :default => false
  end
end
