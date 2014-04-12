class Jarmandy::NoticesController < Jarmandy::BaseController
  def index
    if !params[:q].blank?
      @source = 'Search results'
      @notices = Notice.search(params[:q]).order(created_at: :desc)
    elsif params[:only] == 'everyone'
      @source = 'Notices for anyone and everyone'
      @notices = Notice.order(created_at: :desc)
    elsif params[:team_id].to_i > 0
      @notices = Notice.where(team_id: params[:team_id])
      @team = Team.where(id: params[:team_id]).first
      @source = "Notices for #{@team.name}"
    else
      @notices = Notice.where(team_id: nil)
      @source = 'Global notices'
    end
  end

  def new
  end
end