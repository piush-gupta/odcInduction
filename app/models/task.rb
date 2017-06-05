class Task < ActiveRecord::Base
	before_save :set_default_deadline
	has_and_belongs_to_many :updates
	default_scope -> { order('created_at DESC') }
	validates :title, :details, presence: true
	
	protected
	def set_default_deadline
		self.deadline = (Date.today + 7.days) unless self.deadline
	end
end
