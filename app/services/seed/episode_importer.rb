require_relative 'importer'

class EpisodeImporter < Importer
  def create(attributes)
    sp_episode = Episode.find_or_initialize_by title: attributes[:title]
    sp_episode.season = attributes[:season]
    sp_episode.episode_number = attributes[:episode]
    sp_episode.release_date = attributes[:release_date]

    sp_episode.save
  end

  private

  def default_options
    { header_converters: :symbol, headers: true, col_sep: ',' }
  end
end
