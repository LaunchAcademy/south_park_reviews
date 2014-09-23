class CreateEpisodes < ActiveRecord::Migration
  def change
    create_table :episodes do |t|
      t.string :title, null: false
      t.text :synopsis
      t.string :url, null: false
      t.integer :season, null: false
      t.integer :episode_number, null: false

      t.timestamps
    end
  end
end
