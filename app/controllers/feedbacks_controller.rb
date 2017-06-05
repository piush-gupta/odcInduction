class FeedbacksController < ApplicationController

	def feedback
    if !params[:token]
      if params[:remark]
        @message = "Remark saved."
      else
        @message = "You have either already submitted the feedback or clicked on an invalid link."
      end
    else
      feedback = Feedback.where(["token = ?",params[:token]]).first
      if feedback.present?
        rating = Rating.where(["name = ?",params[:rating]]).first
        feedback.rating = rating
        feedback.token = nil
        if feedback.save!
        	@feedback = feedback
          @message = "Your feedback for #{feedback.user.name.humanize} for #{feedback.month.strftime("%B %Y")} is recorded"
        end
      else
        @message = "You have either already submitted the feedback or clicked on an invalid link."
      end
    end
  end

  def update
  	remark = params[:remark]
  	feedback = Feedback.find(params[:id])
  	feedback.remark = remark
  	feedback.save
  	@message = "Feedback saved successfully"
  	redirect_to get_feedback_path(:remark=>true)
  end

end
