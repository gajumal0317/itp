class RulesController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:edit, :update, :destroy]
  
  def index
    @rules = Rule.order(id: :desc).page(params[:page]).per(10)
    @rules_sort = Rule.sort()
  end
  
  def search
    selection = params[:rule][:keyword]
    @rules_sort = Rule.sort(selection)
  end
  
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

  def update
    if @rule.update(rule_params)
      flash[:success] = 'ルールは正常に更新されました'
      redirect_to user_path(current_user.id)
    else
      flash.now[:danger] = 'ルールは更新されませんでした'
      render :edit
    end
  end

  def destroy
    @rule.destroy
    flash[:success] = 'ルールを削除しました。'
    redirect_back(fallback_location: root_path)
  end
  
  private

  def rule_params
    params.require(:rule).permit(:if_rule, :then_rule, :master)
  end
  
  def correct_user
    @rule = current_user.rules.find_by(id: params[:id])
    unless @rule
      redirect_to user_path(current_user.id)
    end
  end
  
end
