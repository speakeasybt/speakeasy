class AddAvailableToPackages < ActiveRecord::Migration
  def change
    add_column :packages, :avaliable, :boolean, :default => false
  end
end
