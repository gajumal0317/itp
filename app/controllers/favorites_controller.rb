class FavoritesController < ApplicationController
  before_action :require_user_logged_in

  def create
    rule = Rule.find(params[:rule_id])
    current_user.favorite(rule)
    flash[:success] = 'お気に入り登録しました。'
    redirect_back(fallback_location: root_path)
  end

  def destroy
    rule = Rule.find(params[:rule_id])
    @user = User.find_by(id: rule.user_id)
    current_user.unfavorite(rule)
    flash[:success] = 'お気に入りから解除しました。'
    redirect_back(fallback_location: root_path)
  end
end
