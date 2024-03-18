class SessionController < ApplicationController
  include PrepareRecommendation

  def create
    @session = Session.new
    @session.user = current_user
    @session.activity_type = params[:type]
    render session_index_path, status: :unprocessable_entity unless @session.save

    @recommendation = prepare_recommendation(@session)
    if @recommendation.save
      redirect_to recommendation_path(@recommendation)
    else
      render session_index_path, status: :unprocessable_entity
    end
  end
end
