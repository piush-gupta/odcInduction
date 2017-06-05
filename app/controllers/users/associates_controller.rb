class Users::AssociatesController <  ApplicationController
	before_filter :authenticate_user!, :except => [:change_pwd, :update]
	
	def associate_home
		@comment = current_user.comments.build
		if current_user.mentors.empty? && current_user.mentees.empty?
			   
		elsif current_user.mentees.empty?
			mentee_home
		else
			mentor_home
		end
	end
	
	def mentee_home
		@update = Update.new(user_id: current_user)
		@previous_updates = current_user.updates
		@previous_tasks = current_user.tasks
		render 'mentee_home'
	end

	def mentor_home
		render 'mentor_home'
	end

	def change_pwd
		token = params[:token]
		@user = User.find_by(:first_login_token => token)
	end

	def update
		user = User.find(params[:id])
		if params[:password] == params[:confirm_password]
			user.password = params[:password]
			if user.save
				user.update_attributes(:first_login_token => nil)
				user.save
				redirect_to new_user_session_path, :notice => "Password changed successfully"
			else
				error_message = ""
				user.errors.full_messages.each { |message| error_message += message.to_s + ". " }
				flash[:alert] = error_message
				redirect_to change_pwd_path(:token => user.first_login_token)
			end
		else
			flash[:alert] = "Passwords do not match."
			redirect_to change_pwd_path(:token => user.first_login_token)
		end
	end
end
