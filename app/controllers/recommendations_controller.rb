class RecommendationsController < ApplicationController
  before_action :set_attraction, only: %i[show]

  # GET /recommendations
  def index
    @attraction = Attraction.order("RANDOM()").first
  end

  # GET /recommendations/:id
  def show
  end

  private

  def set_attraction
    @attraction = Attraction.find(params[:id])
  end
end
