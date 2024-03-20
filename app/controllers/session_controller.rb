class SessionController < ApplicationController
  include PrepareRecommendation

  def create
    if exist_active_session?(params[:type])
      @session = current_user.sessions.where(activity_type: params[:type]).where(active: true).last
    else
      @session = Session.new
      @session.user = current_user
      @session.activity_type = params[:type]
      render session_index_path, status: :unprocessable_entity unless @session.save
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

  private

  def exist_active_session?(activity_type)
    !current_user.sessions.where(activity_type: activity_type).where(active: true).empty?
  end
end
