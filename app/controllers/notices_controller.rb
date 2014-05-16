class NoticesController < ApplicationController
  before_filter :require_on_team, except: :streamer

  def index
    @notices = Notice.for current_team, params[:since]

    @scoreboard = Team.for_scoreboard current_team

    finish = Time.at game_window.last
    now = Time.now
    remain = finish - now

    respond_to do |r|
      r.json { render json: {
        notices: @notices.to_a.as_json,
        remain: remain,
        scoreboard: @scoreboard
        } }
    end
  end

  def streamer
    @notices = Notice.where(team_id: nil).limit(25).order(created_at: :desc)
    @scoreboard = Team.anonymous_scoreboard

    finish = Time.at game_window.last
    now = Time.now
    remain = finish - now

    respond_to do |r|
      r.json do
        render json: { 
          notices: @notices.to_a.as_json,
          remain: remain,
          scoreboard: @scoreboard
        }
      end
    end
  end
end
