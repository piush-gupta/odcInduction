class Users::AdminsController <  ApplicationController
	include Users::AdminsHelper
  before_filter :authenticate_user!
	authorize_resource class: User
	
	def admin_home
		@users = User.all
		@roles = Role.all

    @columns = [:email,:name, :password,:emp_id,:phn_no,:card_no,:location,:address,:technology,:experience,:associate]
    respond_to do |format|
      format.html
      format.csv { render text: @users.to_csv }
      format.xls
      format.xlsx
    end
  end

  def tag_mentor
  	@users = User.all
  end

  def tag_mentor_update
  	mentee = User.find_by(id: params[:mentee_id])
  	mentor = User.find_by(email: params[:email])
  	mentee.mentors.clear
  	mentee.mentors << mentor unless mentor.nil? 
  	redirect_to tag_mentor_path
  end

  def untag_mentor
    mentee = User.find_by(id: params[:mentee_id])
    mentee.mentors.clear
    redirect_to tag_mentor_path
  end

  def change_role
    authorize! :change_role, @user
    @users = User.all
    @roles = Role.all
  end
  
  def edit_role
  	user = User.find_by(id: params[:user_id])
  	role = Role.find_by(id: params[:role_id])
  	user.roles.clear
  	user.roles << role
  	redirect_to change_role_path
  end

  def edit_tag
    user = User.find_by(id: params[:user_id])
    associate_tag_value = params[:associate_tag] == 'Mentor' ? 'M' : 'F'
    user.update_attributes(:associate => associate_tag_value)
    user.save
    redirect_to view_associates_path
  end

  def import_users
    if User.import_users(params[:file])
      flash[:success] = "Users uploaded"
    else
      flash[:error] = "Mismatch in column names. Make sure all columns are present"
    end
    redirect_to admin_path
  end
  
  def new_user
    @user = User.new
    @roles = Role.all
  end

  def create_user
    parameters = user_params.to_hash.merge!(:password => 'Password@12', :password_confirmation => 'Password@12')
    if params[:user][:associate]
      parameters[:associate] = params[:user][:associate] == 'Mentor' ? 'M' : 'F'
    end
    @user = User.new(parameters)   
    @user.first_login_token = @user.create_token(@user.email) 
    @user.roles.clear
    role = Role.find_by(id: params[:role_id])
    @user.roles << role
    if @user.save
      redirect_to view_associates_path, :notice => 'User created'
    else
      @roles = Role.all
      render 'new_user'
    end
  end

  def edit_users
  end

  def destroy_user
    user = User.find_by(id: params[:user_id])
    user.delete
    flash.now[:success] = "User deleted"
    redirect_to admin_path
  end

  def view_mentees_updates
    #@mentees = get_mentees
    mentees = User.get_defaulters((Date.today.monday-7.days),(Date.today.monday-2.days))
    @regulars = mentees['regulars']
    @defaulters = mentees['defaulters']
    respond_to do |format|
      format.html
      format.xlsx
    end
  end
  def archives
    
  end
  def view_mentors 
    @mentors = get_mentors
  end

  def view_associates
    @associates = get_associates
  end

  def email_updates
    email_add = params[:email]
    UserMailer.mentees_updates_email(email_add).deliver
    flash[:success] = "Successfully emailed"
    redirect_to mentees_updates_path 
  end

  private
    def user_params
      params.require(:user).permit(:email ,:name ,:emp_id ,:phn_no ,:card_no ,:location ,:address ,:experience ,:associate ,:password ,:password_confirmation ,:first_login_token, :technology )
    end
end