class SessionController < ApplicationController
  def new
  end

  def create
    set_user(params['email'], params['password'])
    redirect_to page_user_home_path
  end
end
