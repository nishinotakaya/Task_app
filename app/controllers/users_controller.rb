class UsersController < ApplicationController
  before_action :set_user, only: [:new, :edit, :update]
  before_action :logged_in_user, only: [:edit, :show, :edit, :update, :destroy]
  before_action :correct_user, only: [:update]
  before_action :admin_user, only: [:show, :index, :destroy]
  
  
  def top
  end  
    
  def index
    @users = User.paginate(page: params[:page])
  end  
  
  
  def show
   @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = '新規作成に成功しました。'
      redirect_to @user
    else
      render :new
    end
  end
  
  def edit
    @user = User.find(params[:id])
  end  
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "ユーザー情報を更新しました。"
      redirect_to user_url @user
    else
      render :edit      
    end
  end
  
  def destroy
   @user = User.find(params[:id])
   @user.destroy
    flash[:success] = "#{@user.name}のデータを削除しました。"
    redirect_to user_url @user
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
    
  def set_user
   @user = User.find(params[:id])
  end 
   
  def logged_in_user
     unless logged_in?
        flash[:danger] = "ログインしてください。"
        redirect_to login_url
     end
  end
   
  def correct_user
    redirect_to(root_url) unless current_user?(@user)
  end

    # システム管理権限所有かどうか判定します。
  def admin_user
    redirect_to root_url unless current_user.admin?
  end
   
  
    
end
    
 
 
  
 
  
