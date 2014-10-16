class AddIsModeratorAndIsAdminToUsers < ActiveRecord::Migration
  def change
    add_column :users, :is_moderator, :boolean, :default => false
    add_column :users, :is_admin, :boolean, :default => false
  end
end
