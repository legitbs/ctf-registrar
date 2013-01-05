class UsersController < ApplicationController
  def create
    @user = User.new params[:user]
    if @user.save
      flash[:success] = "You've registered!"
      self.current_user = @user
      return redirect_to dashboard_path
    end

    @password_stash = params[:user][:password]

    render action: 'new'
  end
end
