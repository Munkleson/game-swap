class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home

  def home
    @query = params.dig(:search, :query)
    if @query.present?
      normalized_query = @query.gsub(/[^a-z0-9]/i, '').downcase
      @listings = Listing.joins(:game).where('games.search_name LIKE ?', "%#{normalized_query}%")
    else
      @listings = Listing.all
    end
  end
end
