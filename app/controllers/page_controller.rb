class PageController < ApplicationController
  def index
  end

  def user_home
    @user = current_user
  end
end
