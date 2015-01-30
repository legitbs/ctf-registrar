class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user, :current_team 
  helper_method :during_game?, :before_game?, :game_window

  def require_logged_in
    return true if current_user
    reset_session
    flash[:error] = "You're not logged in."
    redirect_to root_path
  end

  def require_logged_out
    return true unless current_user
    flash[:error] = "You're already logged in."
    redirect_to dashboard_path
  end

  def require_on_team
    return true if current_user && current_team

    flash[:error] = "You're not a member of a team."
    redirect_to dashboard_path
  end

  def require_hot_team
    return true if current_user && current_team && current_team.hot

    redirect_to dashboard_path
    return false
  end

  def game_window
    Time.at(1431734400)..Time.at(1431907200)
  end

  def during_game?
	true	
#    game_window.cover? Time.now
  end

  def before_game?
    game_window.first > Time.now
  end

  def require_during_game
    return true if legitbs_cookie?
    return true if during_game?

    redirect_to dashboard_path
    return false
  end

  def require_during_or_after_game
    return true if legitbs_cookie?
    return false if before_game?

    redirect_to dashboard_path
    return false
  end

  def require_before_game
    return true if legitbs_cookie?
    return true if before_game?

    redirect_to dashboard_path
    return false
  end

  def require_before_or_during_game
    return true if legitbs_cookie?
    return true if before_game? or during_game?

    redirect_to dashboard_path
    return false
  end

  def require_legitbs
    return true if legitbs_cookie?

    raise ActionController::RoutingError.new('Not Found')
  end

  def lbs_cookie
    return unless params[:butts] == 'CleodhewpAbNidcimthIvLyfsOiwibEitkoydsyi'
    cookies[:legitbs] = params[:legitbs]
  end

  def legitbs_cookie?
    (current_team.try(:id) == 1) &&
      (cookies[:legitbs] == 'EbHacyenibtisEkyourWenyeOdnifennEcgeawUb')
  end

  def current_user
    @current_user ||= User.find session[:user_id] rescue nil
  end

  def current_team
    @current_team ||= current_user.team rescue nil
  end

  def current_user=(user)
    @current_user = user
    session[:user_id] = @current_user.id
  end

  def analytics_flash(*args)
    flash[:analytics] ||= []
    flash[:analytics] << args
  end

  def cheevo(name)
    achievement = Achievement.where(name: name).first
    return unless achievement
    award = current_team.awards.create(
                                       achievement: achievement,
                                       comment: "Unlocked by",
                                       user: current_user
                                       )

    
    if award.persisted?
      flash[:cheevo] ||= []
      flash[:cheevo] << award.id
    end
  rescue => e
    Rails.logger.warn "Lost cheevo #{name.inspect} for user #{current_user.id} on team #{current_team.id} :( #{e.inspect}"
    return
  end
end
