class AddUniqueIndexToEpisodesSeasonAndEpisode < ActiveRecord::Migration
  def change
    add_index :episodes, [:season, :episode_number], unique: true
  end
end
