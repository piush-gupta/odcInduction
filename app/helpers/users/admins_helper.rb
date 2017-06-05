module Users::AdminsHelper
  
  def get_mentees
	  User.all.select { |user| user.associate == 'F' }
  end
  
  def get_associates
    User.all.select { |user| user.has_role? :associate }
  end


  def get_mentors
    User.all.select { |user| user.associate == 'M' }
  end
  
  def get_user(user_id)
    User.find_by(id: user_id)    
  end
  
  def get_user_by_update_id(update_id)
    user_id = Update.find_by(id: update_id).user_id
    get_user(user_id)
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