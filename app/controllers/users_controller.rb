class UsersController < ApplicationController
  def new 
    @user = User.new()
  end

  def create
    #byebug
    @user = User.new(user_params)
    if @user.save
        flash[:notice] = "Welcome #{@user.username}!"
        redirect_to @user
    else
        render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def show
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
        flash[:notice] = "You successfuly updated information about your account"
        redirect_to @user
    else
        render 'edit'
    end
  end

  def index
    @users = User.paginate(page: params[:page], per_page: 5)

  end
  private
  def user_params
    params.require(:user).permit(:username,:email,:password)
  end
end