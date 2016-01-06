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
      flash[:notice] = "Invite sent."
      redirect_to user_path(@user)
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit


    @headline = "Please save your password and user handle"
    @user = User.find(params[:id])

    authorize! :update, @user, :message => "my exception message"

  end

  def update
    can? :update, @user
    @user = User.find_by(params[:id])

    unless params[:password] == params[:password_confirmation]
      render :edit
      return
    end

    if @user.update!(user_params)
      redirect_to page_user_home_path
    else
      render :edit
    end
  end


  def confirm
    @token = params[:token]
    my_user = User.confirm(@token)

    if my_user
      flash[:notice] = "Account confirmed."
      set_session_for_confirmed_user(my_user)
      redirect_to edit_user_path(my_user)
    else
      flash[:notice] = "Token invalid."
      redirect_to root_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:handle,:password)
  end

  def invite_params
    params.require('user').permit('email')
  end
end
