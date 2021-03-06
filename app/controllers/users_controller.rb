class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:index, :show, :master]
  def index
    @users = User.order(id: :desc).page(params[:page]).per(20)
  end

  def show
    @user = User.find(params[:id])
    @rules = @user.rules.order(id: :desc).page(params[:page]).per(5)
    counts(@user)
  end
  
  def master
    @user = User.find(params[:id])
    @rules = @user.rules.order(id: :desc).page(params[:page]).per(5)
    counts(@user)  
  end
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = 'ユーザを登録しました。'
      redirect_to @user
    else
      flash.now[:danger] = 'ユーザの登録に失敗しました。'
      render :new
    end
  end
   
  
  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end