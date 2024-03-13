class RecommendationsController < ApplicationController

  # GET /recommendations
  def index

  end

  def new
    @recommendation = Recommendation.new
  end

  def show
    @recommendation = Recommendation.find(params[:id])
  end

  def create
    @recommendation = Recommendation.new
    @recommendation.user = current_user
    case params[:type]
    when 'attraction'
      @recommendation.activity = Attraction.order("RANDOM()").first
      @type = 'attraction'
    when 'event'
      @recommendation.activity = Event.order("RANDOM()").first
      @type = 'event'
    when 'restaurant'
      @recommendation.activity = Restaurant.order("RANDOM()").first
      @type = 'restaurant'
    when 'movie'
      @recommendation.activity = Movie.order("RANDOM()").first
    end

    if @recommendation.save
      redirect_to recommendation_path(@recommendation)
    else
      raise
    end
  end

  def update
  end

  private

  def recommendation_params
    params.require(:recommendation).permit(:status)
  end
end
