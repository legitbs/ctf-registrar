class ApiController < ApplicationController
  before_filter :require_auth_param

  def hot
    challenges = Challenge.for_picker(Team.find(1))

    respond_to do |fmt|
      fmt.json { render json: challenges }
    end
  end

  private

  def require_auth_param
    password = BCrypt::Password.new(ENV['AUTH_PARAM_B'])
    return true if password == params[:auth]
    return true if Rails.env.development?

    raise ActionController::RoutingError.new('Not Found')
  end
end
