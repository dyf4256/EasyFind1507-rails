class RecommendationsController < ApplicationController
  before_action :set_attraction, only: %i[show]

  # GET /recommendations
  def index
    case params[:type]
    when 'attraction'
      @recommendation = Attraction.order("RANDOM()").first
      @type = 'attraction'
    when 'event'
      @recommendation = Event.order("RANDOM()").first
      @type = 'event'
    when 'restaurant'
      @recommendation = Restaurant.order("RANDOM()").first
      @type = 'restaurant'
    else
      @recommendation = nil
    end
  end

  def new
    @recommendation = Recommendation.new
  end

  def show
    @recommendation = Recommendation.find(params[:id])
    @recommendation.user = current_user
  end

  def create
    @recommendation = Recommendation.new
    @activity = Restaurant.all.sample
    @recommendation.activity = @activity
    @recommendation.user = current_user
    if @recommendation.save
      redirect_to recommendation_path(@recommendation)
    else
      raise
    end
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
