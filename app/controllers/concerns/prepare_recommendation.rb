require "active_support/concern"

module PrepareRecommendation
  extend ActiveSupport::Concern
  def prepare_recommendation(session)
    if session.pending_recommendation?
      @recommendation = session.pending_recommendation
    else
      new_recommendations(session)
    end
    @recommendation
  end

  private

  def get_exclude_ids(session)
    ids = []
    unless session.recommendations.empty?
      session.recommendations.each do |recommendation|
        ids << recommendation.activity.id
      end
    end
    return ids
  end

  def new_recommendations(session)
    @recommendation = Recommendation.new
    @recommendation.session = session
    exclude_ids = get_exclude_ids(session)
    case session.activity_type
    when 'Attraction'
      @activities = Attraction.where.not(id: exclude_ids)
    when 'Event'
      @activities = Event.where.not(id: exclude_ids)
    when 'Restaurant'
      @activities = Restaurant.where.not(id: exclude_ids)
    when 'Movie'
      @activities = Movie.where.not(id: exclude_ids)
    end
    distance_radius = Session::DISTANCE_FILTERS[session.distance_filter]

    @activities = @activities.near(current_user.to_coordinates, distance_radius) unless distance_radius.nil?

    @recommendation.activity = @activities.order("RANDOM()").first
  end
end
