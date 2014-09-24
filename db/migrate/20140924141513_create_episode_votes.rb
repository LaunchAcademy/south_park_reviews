class CreateEpisodeVotes < ActiveRecord::Migration
  def change
    create_table :episode_votes do |t|
      t.integer :user_id, null: false
      t.integer :episode_id, null: false
      t.boolean :upvote?, null: false
    end
  end
end
