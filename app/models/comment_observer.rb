class CommentObserver < ActiveRecord::Observer
   include Users::AdminsHelper 
   #observe :comment, :update
   
  # def after_create(update)
  #   mentee = get_user(update.user_id)
  #   mentor = mentee.mentors.first
  #   NotificationMailer.new_update_email(mentor).deliver
  # end

  def after_create(comment)
    commenter = get_user(comment.user_id)
  	receiver = get_receiver(commenter,comment)
  	NotificationMailer.new_comment_email(receiver,commenter).deliver
  end 

  def get_receiver(user,comment)
  	#user = get_user(comment.user_id)
  	unless user.mentors.empty?
  		user.mentors.first
  	else
      user = get_user_by_update_id(comment.update_id)
    end
  end
end