class AddColumnsToUser < ActiveRecord::Migration
  def change
    add_column :users, :username, :string, null: false
    add_column :users, :name, :string, null: false
    add_column :users, :avatar_url, :string, default: "https://lucylaituenchausheen.files.wordpress.com/2014/07/facebook_blank_face3.jpeg"
    add_column :users, :admin, :boolean, default: false
  end
end
