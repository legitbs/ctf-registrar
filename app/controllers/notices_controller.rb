class NoticesController < ApplicationController
  before_filter :require_on_team

  def index
    @notices = Notice.for current_team, params[:since]

    finish = Time.at 1371254400
    now = Time.now
    remain = finish - now

    respond_to do |r|
      r.json { render json: {
        notices: @notices,
        remain: remain
        } }
    end
  end
end
