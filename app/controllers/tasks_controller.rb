class TasksController < ApplicationController
  before_action :set_user
  
  def index
   @tasks = Task.all
   
  end

  def show
   @task = Task.find_by(params[:name])   
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
end
 
 
  
 
     
