class TaskObserver < ActiveRecord::Observer
	include Users::AdminsHelper
	def after_create(task)
		mentee = get_user(task.user_id)
		mentor = mentee.mentors.first
		@task = task
		NotificationMailer.new_task_email(mentee,mentor,@task).deliver
	end
end