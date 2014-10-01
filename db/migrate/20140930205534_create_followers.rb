class CreateFollowers < ActiveRecord::Migration
  def change
    create_table :followers do |t|
      t.integer :follower, null: false
      t.integer :user_id, null: false

      t.timestamps
    end
  end
end
