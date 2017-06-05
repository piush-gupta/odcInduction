class Update < ActiveRecord::Base
	#belongs_to :users
	default_scope -> { order('created_at DESC') }
	validates :user_id, :content, presence: true
	has_and_belongs_to_many :tasks
	has_many :comments , :dependent => :destroy 

	def self.get_specific_month_updates(mentee,month)
		month_start = month.beginning_of_month
		month_end = month_start.end_of_month
		month_updates = mentee.updates.where(:created_at => month_start..month_end)
	end
	def self.get_previous_month_updates(mentee,today)
    previous_month_start = (today.beginning_of_month - 1.days).beginning_of_month
    previous_month_end = previous_month_start.end_of_month
    previous_month_updates = mentee.updates.where(:created_at => previous_month_start..previous_month_end)
	end
  def self.get_previous_week_updates(mentee,today)
  	week_start = today.monday - 7.days
		week_end = today.monday - 2.days
		previous_week_updates = mentee.updates.where(:created_at => week_start..week_end)
  end
end
