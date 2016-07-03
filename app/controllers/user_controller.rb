class UsersController < ApplicationController
skip_before_action :require_login, only: [:new, :create]
before_action :find_user, only: [:edit, :update]
before_filter :authenticate_user!

def new
  @user = User.new
end

def show
  @user = User.find(params[:id])
end

def create
  @user ||= User.new(user_params)
  if @user.save
    session[:user_id] = @user.id
    flash[:success] = 'Signed Up'
    redirect_to @user
  else
    render 'new'
  end
end

def edit
  @user = User.find(params[:id])
end

def update
  if @user.update_attributes(user_params)
    flash[:success] = 'Successfully Updated'
    redirect_to user_path
  else
    render 'edit'
  end
end

private

  def find_user
    @user = User.find(params[:id])
    redirect_to root_path unless @user == current_user
  end

  def user_params
    params.require(:user).permit(:name, :username, :email, :password,
                                 :password_confirmation, :image, :album)
  end
end
