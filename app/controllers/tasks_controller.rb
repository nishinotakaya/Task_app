class TasksController < ApplicationController
  before_action :set_user
  before_action :logged_in_user, only: [:update, :show, :index, :edit]
  before_action :admin_or_correct_user, only: [:update, :show]
  
  def index
   @tasks = Task.all
   
  end

  def show
   @task = Task.find(params[:id])   
  end
  
  def new
   @task = Task.new
  end
  
  def create
    @task = @user.tasks.build(task_params)
    if @task.save
      flash[:success] = "タスクを新規作成しました。"
      redirect_to user_tasks_url @user
    else
      render :new
    end
  end
  
  def update
   @task = Task.find(params[:id])
    if @task.update_attributes(task_params)
     flash[:success] = '更新に成功しました。'
      redirect_to user_tasks_url @user
    else
      render :edit
    end
  end
  
  
  def destroy
   @task = Task.find(params[:id])
   @task.destroy
    flash[:success] = "#{@task.name}のデータを削除しました。"
    redirect_to user_tasks_url @user
  end
  
  def logged_in_user
     unless logged_in?
        flash[:danger] = "ログインしてください。"
        redirect_to login_url
     end
  end
  
  
  def edit
    @task = Task.find(params[:id])
  end  
  
    
 
 private
 
 def task_params
   params.require(:task).permit(:name, :description,)
 end  
 
 def set_user
   @user = User.find(params[:user_id])
 end 
 
 def correct_task
    redirect_to(root_url) unless current_task?(@task)
 end 
 
 def admin_or_correct_user
      @user = User.find(params[:user_id]) if @user.blank?
      unless current_user?(@user) || current_user.admin?
        flash[:danger] = "編集権限がありません。"
        redirect_to(root_url)
      end  
 end
    
end
 
 
  
 
     
