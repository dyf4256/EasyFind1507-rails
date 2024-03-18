require "active_support/concern"

module PrepareRecommendation
  extend ActiveSupport::Concern

  def prepare_recommendation(session)
    @recommendation = Recommendation.new
    @recommendation.session = session
    case session.activity_type
    when 'Attraction'
      @recommendation.activity = Attraction.order("RANDOM()").first
    when 'Event'
      @recommendation.activity = Event.order("RANDOM()").first
    when 'Restaurant'
      @recommendation.activity = Restaurant.order("RANDOM()").first
    when 'Movie'
      @recommendation.activity = Movie.order("RANDOM()").first
    end
    @recommendation
  end
end
