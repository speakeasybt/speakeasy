class FixPackageAvailable < ActiveRecord::Migration
  def change
    rename_column :packages, :avaliable, :is_available
  end
end
