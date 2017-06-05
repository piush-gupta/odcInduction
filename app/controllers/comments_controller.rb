class CommentsController < ApplicationController
  include Users::AdminsHelper
  def create
    update = Update.find_by(id: params[:update_id])
      @comment = update.comments.build(content: params[:comment].require(:content), user: current_user)
      if @comment.save
        flash.now[:success] = "Comment saved" 
      else
        flash[:error] = "error"
      end	
      @comment = current_user.comments.build
      @mentee = get_user_by_update_id(params[:update_id])
      @previous_updates = @mentee.updates
      respond_to do |format|
        format.html { redirect_to associate_path }
        format.js
      end
    end
    
  def destroy
    comment = Comment.find_by(id: params[:id])
    comment.delete
    @mentee = get_user_by_update_id(params[:update_id])
    @previous_updates = @mentee.updates
    @comment = current_user.comments.build
    respond_to do |format|
      format.html { redirect_to associate_path }
      format.js
    end
  end
end