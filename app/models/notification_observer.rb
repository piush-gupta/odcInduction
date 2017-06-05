class NotificationObserver < ActiveRecord::Observer
   include Users::AdminsHelper 
   observe :comment, :update, :task
   
  def after_create(update)
    mentee = get_user(update.user_id)
    mentor = mentee.mentors.first
    NotificationMailer.new_update_email(mentor).deliver
  end

  def after_create(comment)
  	receiver = get_receiver(comment)
  	NotificationMailer.new_comment_email(receiver).deliver
  end 

  def after_create(task)
    mentee = get_user(task.user_id)
    mentor = mentee.mentors.first
    NotificationMailer.new_task_email(mentee).deliver
  end

  def get_receiver(comment)
  	user = get_user(comment.user_id)
  	unless user.mentors.empty?
  		user.mentors.first
  	else
        user = get_user_by_update_id(comment.update_id)
    end
  end
end