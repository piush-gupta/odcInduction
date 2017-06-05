module UpdatesHelper
	def get_previous_week_updates(mentee,today)
		previous_week_updates = Update.get_previous_week_updates(mentee,today)	
	end
	def get_previous_month_updates(mentee,today)
		# Call Update model method
	end
end