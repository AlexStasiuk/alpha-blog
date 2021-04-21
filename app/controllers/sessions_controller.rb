class SessionsController < ApplicationController

  def new

  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    isAuthenticated = user && user.authenticate(params[:session][:password])
    if !isAuthenticated
      flash.now[:alert] = "Something went wrong with login details"
      render 'new'
      return
    end
    session[:user_id] = user.id
    flash[:notice] = "You logged in successfuly"
    redirect_to user
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "You has been logged out"
    redirect_to root_path
  end
end
