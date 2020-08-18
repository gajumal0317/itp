class ApplicationController < ActionController::Base
 include SessionsHelper
 before_action :set_search
 
def set_search
  @search = Rule.ransack(params[:q])
  @search_rules = @search.result(distinct: true).order(created_at: "DESC").includes(:user).page(params[:page]).per(5)
end
 
 
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
