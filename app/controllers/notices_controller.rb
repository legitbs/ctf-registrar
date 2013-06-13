class NoticesController < ApplicationController
  before_filter :require_on_team

  def index
    @notices = Notice.for current_team, params[:since]

    @scoreboard = Team.for_scoreboard current_team

    finish = Time.at 1371427200
    now = Time.now
    remain = finish - now

    respond_to do |r|
      r.json { render json: {
        notices: @notices,
        remain: remain,
        scoreboard: @scoreboard
        } }
    end
  end
end
