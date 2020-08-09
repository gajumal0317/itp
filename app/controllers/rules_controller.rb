class RulesController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy]
  
  def new
    @rule = current_user.rules.build
  end

  def create
    @rule = current_user.rules.build(rule_params)
    if @rule.save
      flash[:success] = 'ルールを作成しました。'
      redirect_to user_path(current_user.id)
    else
      @rules = current_user.rules.order(id: :desc).page(params[:page])
      flash.now[:danger] = 'ルールの作成に失敗しました。'
      render :new
    end
  end

  def edit
  end

  def destroy
    @rule.destroy
    flash[:success] = 'ルールを削除しました。'
    redirect_back(fallback_location: root_path)
  end
  
  private

  def rule_params
    params.require(:rule).permit(:if_rule,:then_rule)
  end
  
  def correct_user
    @rule = current_user.rules.find_by(id: params[:id])
    unless @rule
      redirect_to user_path(current_user.id)
    end
  end
  
end
