class SessionsController < ApplicationController
  def create
    @user = User.find_by username: params[:username]
    return fail_login unless @user && @user.authenticate(params[:password])

    if @user.auth_secret
      session[:otp_user_id] = @user.id
      return render
    end

    session[:user_id] = @user.id

    analytics_flash '_trackEvent', 'Users', 'login'
    return redirect_to dashboard_path
  end

  def token
    return fail_login unless @user = User.find(session[:otp_user_id])

    code = params[:code]

    if code =~ /^\d+$/
      verifier = ROTP::TOTP.new @user.auth_secret

      return fail_login unless verifier.verify(code)
    elsif code =~ /-/
      fallback = @user.fallback_tokens.find_by_token_string code

      return fail_login unless fallback

      fallback.destroy
    end

    session[:user_id] = @user.id
    session[:otp_user_id] = nil
    redirect_to dashboard_path
  end

  def destroy
    reset_session
    redirect_to root_path
  end

  private
  def fail_login
    reset_session
    flash[:alert] = "Login failed."
    redirect_to root_path
  end
end
