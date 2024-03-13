class RecommendationsController < ApplicationController
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

  def recommendation_params
    params.require(:recommendation).permit(:status)
  end
end
