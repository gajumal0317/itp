class ToppagesController < ApplicationController
  def index
    if current_user
      redirect_to user_path(current_user)
      return
    end
  end
  
  def explain
  end
end
