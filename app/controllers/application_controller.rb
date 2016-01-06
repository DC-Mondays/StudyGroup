class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  include CanCan::ControllerAdditions


  before_action :is_admin?

  rescue_from CanCan::AccessDenied do |exception|

      redirect_to root_url, :alert => "You don't have authorization for this resource"
    end

  def current_user
    @current_user = User.find_by(id: session[:current_user]) || nil
  end

  def is_admin?
    @admin = current_user.admin? unless current_user.nil?
  end

  def set_session_for_confirmed_user(user)
    session[:current_user] = user.id
  end

  def set_user(email_address, password)
    my_user = User.authenticate(email_address, password)
    if my_user != nil
      session[:current_user] = my_user.id
      flash[:notice] = "You have successfully logged in #{my_user.handle}"
    else
      flash[:error] = "Not a valid email/password combination"
    end
  end
end
