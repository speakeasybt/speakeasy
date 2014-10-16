class AddTransmissionHashToTorrents < ActiveRecord::Migration
  def change
    add_column :torrents, :transmission_hash, :string
  end
end
