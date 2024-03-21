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
      @recommendation.activity = @activities.first
    when 'Event'
      @activities = Event.where.not(id: exclude_ids)
      @recommendation.activity = @activities.first
    when 'Restaurant'
      @activities = Restaurant.where.not(id: exclude_ids)
      @recommendation.activity = @activities.first
    when 'Movie'
      @activities = Movie.where.not(id: exclude_ids)
      @recommendation.activity = @activities.first
    end
  end

  # randomly generate recommendtaion
  # def new_recommendations(session)
  #   @recommendation = Recommendation.new
  #   @recommendation.session = session
  #   exclude_ids = get_exclude_ids(session)
  #   case session.activity_type
  #   when 'Attraction'
  #     @activities = Attraction.where.not(id: exclude_ids)
  #     @recommendation.activity = @activities.order("RANDOM()").first
  #   when 'Event'
  #     @activities = Event.where.not(id: exclude_ids)
  #     @recommendation.activity = @activities.order("RANDOM()").first
  #   when 'Restaurant'
  #     @activities = Restaurant.where.not(id: exclude_ids)
  #     @recommendation.activity = @activities.order("RANDOM()").first
  #   when 'Movie'
  #     @activities = Movie.where.not(id: exclude_ids)
  #     @recommendation.activity = @activities.order("RANDOM()").first
  #   end
  # end
end
