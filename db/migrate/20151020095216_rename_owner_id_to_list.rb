class RenameOwnerIdToList < ActiveRecord::Migration
  def change
    rename_column :lists ,:owner_id, :user_id
  end
end
