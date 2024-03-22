class SessionController < ApplicationController
  include PrepareRecommendation
  before_action :set_session, except: %i[create past_bookmarks]

  def create
    if current_user.active_session_for?(params[:type])
      @session = current_user.active_session_for(params[:type])
    else
      @last_completed_session = current_user.last_completed_session_for(params[:type])
      if params[:import_from_previous_session].nil? && @last_completed_session&.bookmarked_recommendations&.any?
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
    @previous_session = Session.find(params[:previous_session_id])
  end

  def update
    @recommendation = @session.pending_recommendation
    respond_to do |format|
      if @session.update(session_params)
        format.html { redirect_to recommendation_path(@recommendation) }
        format.json { head :no_content }
      else
        format.html { render 'recommendations/show', status: :unprocessable_entity }
        format.json { render json: { error: 'Invalid setting' }, status: :unprocessable_entity }
      end
    end
  end

  def bookmarks
    @session = Session.find(params[:id])
  end

  def end
    @session = Session.find(params[:id])
    @activity = @session.accepted_recommendation.activity

    @markers = [{
      lat: @activity.latitude,
      lng: @activity.longitude,
      info_window_html: render_to_string(partial: "recommendations/details/info_window", locals: { recommendation: @session.accepted_recommendation }),
      marker_html: render_to_string(partial: "recommendations/details/marker", locals: { recommendation: @session.accepted_recommendation })
    }]
  end

  private

  def set_session
    @session = Session.find(params[:id])
  end

  def session_params
    params.require(:session).permit(:distance_filter)
  end
end
