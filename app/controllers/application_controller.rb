class ApplicationController < ActionController::Base
 include SessionsHelper
 private

  def require_user_logged_in
    unless logged_in?
      redirect_to login_url
    end
  end
  def counts(user)
    @count_challenging_rules = user.rules.where(master: 0).count
    @count_master_rules = user.rules.where(master: 1).count
  end

end
