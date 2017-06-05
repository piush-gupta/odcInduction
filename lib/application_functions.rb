module ApplicationFunctions
	def get_feedback_urls(token)
		ratings = Rating.all
		urls = []
		url_prefix = 'http://localhost:3000'
		ratings.each { |rating| urls << url_prefix + "/#{rating.name}/#{token}" }
		urls
	end
end