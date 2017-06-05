module ApplicationHelper
	
	def get_user(user_id)
		User.find_by(id: user_id)
	end
	
	def avatar_url(user)
		gravatar_id = Digest::MD5::hexdigest(user.email).downcase
		if gravatar_id
			return "http://gravatar.com/avatar/#{gravatar_id}?s=200"
		else
			return 0
		end
	end

	def get_task_id(list)
		list = list.sub(",","").split(",").uniq.map{ |l| l.to_i }
		tasks = Task.find(list)
	end

	def hash_tag(update_id,user_id)
		update = Update.find(update_id)
		con = update.content
		tasks = update.tasks.where(:update_id == update.id )
		#Task.all.select{|t| t.user_id == user_id}
		tasks.each do |t|
      temp = "#" + t.title
			if con.downcase.include?(temp.downcase)
			 hash = "<text class='highlight'>#{temp}</text>"
			 con = con.gsub("#{temp}","</text><a href='/ODCInduction/associate?type=tasks#{t.id}' class='highlight' id=#{t.id}>#{temp}</a><text>")
			end
		end
		return "<text>#{con}</text>"
	end

	def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end
end
