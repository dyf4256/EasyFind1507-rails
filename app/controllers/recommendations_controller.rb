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

  def details
    @recommendation = Recommendation.find(params[:id])
  end

  def create
    @recommendation = Recommendation.new
    @recommendation.user = current_user
    case params[:type]
    when 'Attraction'
      @recommendation.activity = Attraction.order("RANDOM()").first
    when 'Event'
      @recommendation.activity = Event.order("RANDOM()").first
    when 'Restaurant'
      @recommendation.activity = Restaurant.order("RANDOM()").first
    when 'Movie'
      @recommendation.activity = Movie.order("RANDOM()").first
    end

    if @recommendation.save
      redirect_to recommendation_path(@recommendation)
    else
      render root_path, status: :unprocessable_entity
    end
  end

  def update
    @recommendation = Recommendation.find(params[:id])
    @recommendation.status = params[:status]
    if @recommendation.save
      if @recommendation.rejected?
        create
      else
        redirect_to details_path(@recommendation)
      end
    else
      render root_path, status: :unprocessable_entity
    end
  end

  private

  def recommendation_params
    params.require(:recommendation).permit(:status)
  end
end
