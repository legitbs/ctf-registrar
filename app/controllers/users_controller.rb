class UsersController < ApplicationController
  def create
    @user = User.new params[:user]
    if @user.save
      flash[:success] = "You've registered!"
      return redirect_to root_path
    end

    @password_stash = params[:user][:password]

    render action: 'new'
  end
end
