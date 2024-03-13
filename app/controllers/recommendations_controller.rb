class RecommendationsController < ApplicationController
  before_action :set_attraction, only: %i[show]

  # GET /recommendations
  def index
    @attraction = Attraction.order("RANDOM()").first
  end

  def new
    @recommendation = Recommendation.new
  end

  def show
    @recommendation = Recommendation.find(params[:id])
    @recommendation.user = current_user
  end

  def create
    @recommendation = Recommendation.new(recommendation_params)
  end

  def update
  end

  private

  def set_attraction
    @attraction = Attraction.find(params[:id])
  end

  def recommendation_params
    params.require(:recommendation).permit(:status)
  end
end
