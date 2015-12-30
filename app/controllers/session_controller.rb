class SessionController < ApplicationController
  def new
  end

  def create
    redirect_to '/pages/user_home'
  end
end
