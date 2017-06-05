class Users::RegistrationsController <  Devise::RegistrationsController
	
	def create
		params[:user][:password] = 'Password@12'
		params[:user][:password_confirmation] = 'Password@12'
		params[:user][:associate] = 'F'
		params[:user][:first_login_token] = User.new.create_token(params[:user][:email])
    user = User.new(params_sanitize) 
    if user.save
    	flash[:success] = "You have successfully Signed Up.! Follow the instructions sent on your email to login."
    	redirect_to :root
    else
	    super
    end
	end

	def new
		super
	end

	def index
		super
	end

	def edit
		super
	end

	def update
		super
	end

	def destroy
		super
	end

	private
		def params_sanitize
			params.require(:user).permit(:email ,:name ,:emp_id ,:phn_no ,:card_no ,:location ,:address ,:experience ,:associate ,:password ,:password_confirmation ,:first_login_token )
		end

end