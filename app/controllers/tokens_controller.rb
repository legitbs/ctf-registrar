class TokensController < ApplicationController  
  before_filter :require_logged_in
  before_filter :require_no_token, only: %i{new create}

  def new
    @temporary_secret = ROTP::Base32.random_base32
    session[:temporary_secret] = @temporary_secret
  end

  def create
    unless params['i-promise']
      flash[:alert] = "Seriously, you have to promise to turn this on."
      return redirect_to action: 'new'
    end
    
    if session[:temporary_secret] != params[:temporary_secret]
      flash[:alert] = "Something got wonky."
      return redirect_to action: 'new' 
    end
    @temporary_secret = session[:temporary_secret]

    @candidate = params['first-code']
    
    verifier = ROTP::TOTP.new(@temporary_secret)
    unless verifier.verify(@candidate.to_i)
      flash[:alert] = "Failed the secret check, let's try again with a new secret."
      return redirect_to action: 'new'
    end

    current_user.auth_secret = @temporary_secret
    current_user.transaction do
      @fallback_tokens = 10.times.map do 
        current_user.fallback_tokens.create.as_token_string
      end
      current_user.save
    end
  end

  def show
    respond_to do |fmt|
      fmt.png do
        secret = params[:id]
        unless secret =~ /^[a-zA-Z0-9]{16}$/
          return render qrcode: 'lol', status: 400
        end
        payload = "otpauth://totp/legitbs%202014?secret=#{secret}"
        send_data Pngqr.encode(payload, scale: 9), disposition: :inline, type: 'image/png'
      end
    end
  end

  private
  def require_no_token
    return true unless current_user.auth_secret
    
    redirect_to dashboard_path
    return false
  end
end
