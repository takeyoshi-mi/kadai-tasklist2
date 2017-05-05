class TasksController < ApplicationController
  before_action :set_tasks, only: [:show, :edit, :update, :destroy]
  before_action :require_user_logged_in
  before_action :current_user, only: [:destroy]

  def index
    @tasks = Task.order(created_at: :desc).page(params[:page]).per(3)
  end

  def show
  end

  def new
    @tasks = Task.new
  end

  def create
    
    @tasks = current_user.task.build(tasks_params)

    if @tasks.save
      flash[:success] = 'タスクが正常に投稿されました'
      redirect_to @tasks
    else
      flash.now[:danger] = 'タスクが投稿されませんでした'
      render :new
    end
    
    
  end

  def edit
  end

  def update
    if @tasks.update(tasks_params)
      flash[:success] = 'タスクは正常に更新されました'
      redirect_to @tasks
    else
      flash.now[:danger] = 'タスクは更新されませんでした'
      render :edit
    end
  end

  def destroy
    @tasks.destroy

    flash[:success] = 'タスクは正常に削除されました'
    redirect_to tasks_url
  end

  private

  def set_tasks
    @tasks = Task.find(params[:id])
  end

  def tasks_params
    params.require(:task).permit(:content, :status)
  end
end