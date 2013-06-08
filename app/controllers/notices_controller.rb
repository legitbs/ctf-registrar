class NoticesController < ApplicationController
  before_filter :require_on_team

  def index
    @notices = Notice.for current_team, params[:since]
    respond_to do |r|
      r.json { render json: {notices: @notices} }
    end
  end
end
