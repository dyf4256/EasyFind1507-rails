class RecommendationsController < ApplicationController
  include PrepareRecommendation
  before_action :set_recommendation, only: %i[show details update]
  def index
    case params[:status]
    when 'accepted'
      @recommendations = current_user.accepted_recommendations
    when 'bookmarked'
      @recommendations = current_user.bookmarked_recommendations
    end
    @movies = @recommendations.where(activity_type: 'Movie')
    @restaurants = @recommendations.where(activity_type: 'Restaurant')
    @events = @recommendations.where(activity_type: 'Event')
    @attractions = @recommendations.where(activity_type: 'Attraction')
  end

  def new
    @recommendation = Recommendation.new
  end

  def show
    redirect_to categories_path, alert: 'Session is expired!' if @recommendation.session.inactive?
  end

  def details
    activity = @recommendation.activity

    @markers = [{
      lat: activity.latitude,
      lng: activity.longitude,
      info_window_html: render_to_string(partial: "recommendations/details/info_window", locals: { recommendation: @recommendation }),
      marker_html: render_to_string(partial: "recommendations/details/marker", locals: { recommendation: @recommendation })
    }]
  end

  # def details
  #   activity = @recommendation.activity
  #   geocoded_activity = Geocoder.search(activity.address).first
  #   if geocoded_activity
  #     @markers = [{
  #       lat: geocoded_activity.latitude,
  #       lng: geocoded_activity.longitude,
  #       info_window: render_to_string(partial: "info_window", locals: { recommendation: @recommendation }),
  #     }]
  #   else
  #     @markers = []
  #   end
  # end

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

  private

  def set_recommendation
    @recommendation = Recommendation.find(params[:id])
  end
end
