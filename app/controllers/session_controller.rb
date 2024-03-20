class SessionController < ApplicationController
  include PrepareRecommendation

  def create
    if current_user.active_session_for?(params[:type])
      @session = current_user.active_session_for(params[:type])
    else
      @session = Session.new
      @session.user = current_user
      @session.activity_type = params[:type]
      raise "Something went wrong" unless @session.save
    end

    @recommendation = prepare_recommendation(@session)
    if @recommendation.activity.nil?
      redirect_to nomore_path
    elsif @recommendation.save
      redirect_to recommendation_path(@recommendation)
    else
      render session_index_path, status: :unprocessable_entity
    end
  end
end
