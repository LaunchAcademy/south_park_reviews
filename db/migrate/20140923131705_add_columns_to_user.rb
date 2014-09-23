class AddColumnsToUser < ActiveRecord::Migration
  def change
    add_column :users, :name, :string
    add_column :users, :avatar_url, :string
    add_column :users, :role, :string, default: "Member"
  end
end
