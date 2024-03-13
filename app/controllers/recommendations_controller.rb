class RecommendationsController < ApplicationController

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

  def recommendation_params
    params.require(:recommendation).permit(:status)
  end
end
