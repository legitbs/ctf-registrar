class Jarmandy::NoticesController < Jarmandy::BaseController
  helper_method :team
  def index
    scope = Notice.order(created_at: :desc)
    if !params[:q].blank?
      @source = 'Search results'
      @notices = scope.search(params[:q])
    elsif params[:only] == 'everyone'
      @notices = scope.where(team_id: nil)
      @source = 'Global notices'
    elsif team
      @notices = scope.where(team_id: params[:team_id])
      @source = "Notices for #{team}"
    else
      @source = 'Notices for anyone and everyone'
      @notices = scope
    end
  end

  def new
    @notice = Notice.new team: team
  end

  def create
    notice_params = params[:notice].dup
    do_tweet = notice_params.delete :tweet
    do_post = notice_params.delete :post

    @notice = Notice.new notice_params

    if do_post
      saved = @notice.save
      unless saved
        return render view: 'new'
      end
    end

    if do_tweet && @notice.body.length <= 140
      resp = TwitterClient.update @notice.body
      if do_post && saved
        @notice.update_attribute :twitter, resp.uri.to_s
      end
    end

    redirect_to action: 'index'
  end

  private
  def team
    @team ||= Team.where(id: params[:team_id]).first
  end
end