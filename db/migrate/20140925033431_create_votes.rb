class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.integer :user_id, null: false
      t.integer :content_id, null: false
      t.integer :value, null: false
      t.string :content_type, null: false

      t.timestamps
    end

    add_index :votes, :content_id
    add_index :votes, :user_id
  end
end
