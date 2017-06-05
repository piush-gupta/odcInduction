class NotificationMailer < ActionMailer::Base

   default from: "\"ODC Induction\" <kumar.piush@tcs.com>"
   def new_update_email(mentor,mentee,update)
    @mentee = mentee
    @mentor = mentor
    @update = update
    @url = 'localhost:3000/ODCInduction'
    mail(to: mentor.email, subject: 'New update') do |format|
     format.html
    end
  end

  def new_comment_email(user,commenter)
    @commenter = commenter
    @receiver = user
    @url = 'localhost:3000/ODCInduction'
    mail(to: user.email,:from => "\"ODC Induction\" <kumar.piush@tcs.com>", subject: 'New comment') do |format|
     format.html
    end
  end

  def new_task_email(mentee,mentor,task)
    @mentee = mentee
    @mentor = mentor
    @task = task
    @url = 'localhost:3000/ODCInduction'
    mail(to: mentee.email,:from => "\"ODC Induction\" <kumar.piush@tcs.com>", subject: 'New task assigned.') do |format|
     format.html
    end
  end
end