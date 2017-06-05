class TasksController < ApplicationController
  include Users::AdminsHelper
  def create
    @task = Task.new
    @task.title = params[:title]
    @task.details = params[:details]
    @task.deadline = params[:deadline]
    @task.user_id = params[:mentee_id]
    if @task.save
      flash.now[:success] = "Task Assigned"
      @mentee = get_user(@task.user_id)
      @previous_tasks = @mentee.tasks
      respond_to do |format|
        format.html { redirect_to "associate?type=tasks" }
        format.js
      end 
    else
      flash[:error] = "Error assigning task"
    end 
  end

  def get_tasks
    search_term = params[:searchterm]
    user_id = params[:user_id]
    tasks = Task.where(["user_id = ?",user_id])
    @result = tasks.select { |task| task.title.start_with?("#{search_term}") }
    # @returnhtml = render_to_string(partial: 'task_title_suggestion')
    respond_to do |format|
      format.html { render partial: 'task_title_suggestion' }
      format.json { render :json => @result }
    end
  end

  def get_updates
    task_id = params[:task_id]
    task = Task.find(task_id)
    @result = task.updates
    respond_to do |format|
      format.json { render :json => @result }
    end
  end

  def update
    task = Task.find(params[:id])
    task.update_attributes(:status => false)
    task.save!
    redirect_to "/associate?type=tasks"
  end

end
