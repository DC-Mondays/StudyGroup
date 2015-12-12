class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    if current_user.nil?
      flash[:notice] = "You don't have authority to access this page"
      redirect_to root_path
      return
    end

    @user = User.invite(invite_params, current_user)

    if @user.nil?
      render :new
    else
      redirect_to user_path(@user)
    end
  end

  def show
    @user = User.find(params[:id])
  end

  private

  def user_params
    require(:user).permit(:handle, :email)
  end

  def invite_params
    #binding.pry
    params.require('user').permit('email')
  end
end
