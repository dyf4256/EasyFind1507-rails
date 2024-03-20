class RecommendationsController < ApplicationController
  include PrepareRecommendation
  before_action :set_recommendation, only: %i[show details update]

  def index
    @type = params[:type]
    case @type
    when 'accepted'
      @recommendations = current_user.accepted_recommendations
    when 'bookmarked'
      @recommendations = current_user.bookmarked_recommendations.only_unique
    when 'favorited'
      @recommendations = current_user.favorited_recommendations
    else
      raise ActionController::RoutingError.new('Not Found')
    end
  end

  def new
    @recommendation = Recommendation.new
  end

  def show
    redirect_to categories_path, alert: 'Session is expired!' if @recommendation.session.completed?
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

  def create
    prepare_recommendation(Session.find(params[:session_id]))
    if @recommendation.activity.nil?
      redirect_to nomore_path
    elsif @recommendation.save
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
        if params[:from] == 'bookmarks'
          redirect_to session_bookmarks_path(@recommendation.session)
        else
          create
        end
      end
    else
      render root_path, status: :unprocessable_entity
    end
  end

  def favorite
    # Capitalize the first letter of the type to ensure it matches the class name convention
    activity_class = params[:type].capitalize.constantize

    # Use find_by to gracefully handle nil if no record is found
    @activity = activity_class.find_by(id: params[:id])

    if @activity
      if @activity.favorited_by?(current_user)
        current_user.unfavorite(@activity)
        favorited = false
      else
        current_user.favorite(@activity)
        favorited = true
      end
      render json: { favorited: @activity.favorited_by?(current_user) }
    else
      render json: { error: 'Activity not found.' }, status: :not_found
    end

  end

  private

  def set_recommendation
    @recommendation = Recommendation.find(params[:id])
  end
end
