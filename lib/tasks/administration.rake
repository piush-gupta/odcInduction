namespace :administration do
  desc "TODO"
  task update_reminder: :environment do
  	user_emails = User.joins(:roles).where("roles.name = 'associate' AND associate = 'F'").map(&:email)
    cc_user_emails = User.joins(:roles).where("roles.name = 'admin'").map(&:email)
    UserMailer.update_reminder(user_emails,cc_user_emails).deliver
  end

  task submit_report: :environment do
  	superadmin_emails = User.joins(:roles).where("roles.name = 'superadmin'").map(&:email)
  	UserMailer.mentees_updates_email(superadmin_emails).deliver
  end

  task settask_reminder: :environment do
    mentor_emails = User.joins(:roles).where("roles.name = 'associate' AND associate = 'M'").map(&:email)
    UserMailer.settask_reminder(mentor_emails).deliver
  end

  task monthly_report_and_feedback: :environment do
    mentors = User.joins(:roles).where("roles.name = 'associate' AND associate = 'M'")
    previous_month = (Date.today.beginning_of_month - 1.days).beginning_of_month
    mentors.each do |mentor|
      mentor.mentees.each do |mentee|
        updates = Update.get_previous_month_updates(mentee,Date.today)
        token = Feedback.create_with_token(mentee,previous_month)
        feedback_urls = get_feedback_urls(token)
        UserMailer.monthly_report_and_feedback(mentor.email,mentee,updates,feedback_urls).deliver
      end 
    end
  end

  def get_feedback_urls(token)
    ratings = Rating.all
    urls = []
    url_prefix = ROOT_URL
    ratings.each_with_index do |rating,index| 
      urls[index] = { :url => url_prefix + "/feedback/#{rating.name}/#{token}" , :text => rating.name }
    end
    urls
  end

end