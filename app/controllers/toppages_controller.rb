class ToppagesController < ApplicationController
  def index
    if logged_in?
      @user = current_user
      @task = current_user.task.build  # form_for 用
      @tasks = current_user.task.order('created_at DESC').page(params[:page])
    end
  end
end