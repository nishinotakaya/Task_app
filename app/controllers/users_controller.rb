class UsersController < ApplicationController
  def index
    @users = User.paginate(page: params[:page])
  end  
  
  
  def show
   @user = User.find_by(params[:id])
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
      redirect_to @user
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
    
  def correct_user
      redirect_to(root_url) unless current_user?(@user)
  end  
  
  def admin_user
      redirect_to root_url unless current_user.admin?
  end
    
end
