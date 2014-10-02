class CreateFollowers < ActiveRecord::Migration
  def change
    create_table :followers do |t|
      t.integer :follower
      t.integer :user_id

      t.timestamps
    end
  end
end
