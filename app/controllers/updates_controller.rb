class UpdatesController < ApplicationController
  include ApplicationHelper
  def create
    @update = current_user.updates.build(update_params)
    tasks = get_task_id(params["task-hidden-id"])
    if @update.save
      flash.now[:success] = "Your update received" 
      tasks.each do |task|
        @update.tasks << task
      end
    else
      flash[:error] = "Some error occured."
    end
      redirect_to associate_path
  end	
  
  private
    def update_params
	    params.require(:update).permit(:content)
    end
end