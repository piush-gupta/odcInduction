class UserMailer < ActionMailer::Base
  before_filter :set_url
  default from: "\"ODC Induction\" <kumar.piush@tcs.com>"
  include Users::AdminsHelper
  helper :updates

  def welcome_email(user)
  	@user = user
    @login_url = @url + '/change_pwd/' + user.first_login_token.to_s
    mail(to: user.email, subject: 'Welcome to ODCInduction') do |format|
      format.html #{ render layout: 'my_layout' }
      #format.text
    end
  end

  def mentees_updates_email(email)
    mentees = User.get_defaulters
    @regulars = mentees['regulars']
    @defaulters = mentees['defaulters']
    mail(to: email, subject: 'ODCInduction Updates Report') do |format|
      format.html
    end
  end

  def update_reminder(user_emails,cc_user_emails)
    mail(:to => user_emails,:cc => cc_user_emails, :subject => "ODC Induction - Reminder")
  end

  def settask_reminder(mentor_emails)
    mail(:to => mentor_emails, :subject => "ODC Induction - Reminder")
  end

  def monthly_report_and_feedback(mentor_email,mentee,updates,feedback_urls)
    @updates = updates
    @feedback_urls = feedback_urls
    @mentee = mentee
    mail(:to=>mentor_email, :subject => "ODC Induction - Mentee Report")
  end

  private
    def set_url
      @url = ROOT_URL
      @navigator_url = NAV_URL
    end
end
