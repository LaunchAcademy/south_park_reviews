class Episode < ActiveRecord::Base


  def self.paginate(query, page = 1, results_per_page = 20, order = {season: :asc, episode_number: :asc})
    order(order).limit(results_per_page)
        .offset((page - 1) * results_per_page)
  end

  def self.paginate_search(page = 1, results_per_page = 20, order = [:season, :episode_number])
    order(order).where("title ILIKE ?", query)
        .limit(results_per_page)
        .offset((page - 1) * results_per_page)
  end
end
