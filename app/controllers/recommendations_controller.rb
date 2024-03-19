class RecommendationsController < ApplicationController
  include PrepareRecommendation
  before_action :set_recommendation, only: %i[show details update]
  def index
    if params[:status] == 'favorited'
      @recommendations = current_user.favorited_activities
      @restaurants = @recommendations.select { |e| e.instance_of?(Restaurant) }
      @movies = @recommendations.select { |e| e.instance_of?(Movie) }
      @events = @recommendations.select { |e| e.instance_of?(Event) }
      @attractions = @recommendations.select { |e| e.instance_of?(Attraction) }
    else
      case params[:status]
      when 'accepted'
        @recommendations = current_user.accepted_recommendations
      when 'bookmarked'
        @recommendations = current_user.bookmarked_recommendations
      end
      # @movies = @recommendations.where(activity_type: 'Movie')
      # @restaurants = @recommendations.where(activity_type: 'Restaurant')
      # @events = @recommendations.where(activity_type: 'Event')
      # @attractions = @recommendations.where(activity_type: 'Attraction')
    end
  end

  def new
    @recommendation = Recommendation.new
  end

  def show
    redirect_to categories_path, alert: 'Session is expired!' if @recommendation.session.inactive?
  end

  def details
  end

  def create
    prepare_recommendation(Session.find(params[:session_id]))

    if @recommendation.save
      redirect_to recommendation_path(@recommendation)
    else
      render root_path, status: :unprocessable_entity
    end
  end

  def update
    @recommendation.status = params[:status]
    if @recommendation.save
      if @recommendation.accepted?
        @recommendation.session.end!
        redirect_to details_path(@recommendation)
      else
        create
      end
    else
      render root_path, status: :unprocessable_entity
    end
  end

  def favorite
    case params[:type]
    when 'Restaurant'
      @activity = Restaurant.find(params[:id])
    when 'Movie'
      @activity = Movie.find(params[:id])
    when 'Event'
      @activity = Event.find(params[:id])
    when 'Attraction'
      @activity = Attraction.find(params[:id])
    end
    @activity.favorited_by?(current_user) ? current_user.unfavorite(@activity) : current_user.favorite(@activity)
    redirect_to recommendations_path(status: params[:from])
  end

  private

  def set_recommendation
    @recommendation = Recommendation.find(params[:id])
  end
end
