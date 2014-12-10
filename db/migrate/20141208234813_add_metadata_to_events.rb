class AddMetadataToEvents < ActiveRecord::Migration
  def change
    add_column :events, :metadata, :text
  end
end
