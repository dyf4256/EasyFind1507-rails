class SessionController < ApplicationController
  include PrepareRecommendation

  def create
    if current_user.active_session_for?(params[:type])
      @session = current_user.active_session_for(params[:type])
    else
      @last_completed_session = current_user.last_completed_session_for(params[:type])
      if params[:import_from_previous_session] != 'true' && @last_completed_session&.bookmarked_recommendations&.any?
        redirect_to past_session_bookmarks_path(@last_completed_session)
        return
      else
        @session = Session.new
        @session.user = current_user
        @session.activity_type = params[:type]
        raise "Something went wrong" unless @session.save

        if params[:import_from_previous_session] == 'true'
          @last_completed_session.bookmarked_recommendations.each do |recommendation|
            @session.recommendations.create!(
              activity: recommendation.activity,
              status: 'bookmarked'
            )
          end
        end
      end
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

  def past_bookmarks
    @previous_session = Session.find(params[:id])
  end

end
