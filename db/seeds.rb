# Create roles
Role.create(name: 'associate') unless Role.find_by(:name => 'associate').present?
Role.create(name: 'admin') unless Role.find_by(:name => 'admin').present?
Role.create(name: 'superadmin') unless Role.find_by(:name => 'superadmin').present?

# Create a superadmin user
unless User.find_by(:email=>'Vaibhav_Kohli@external.mckinsey.com').present?
	User.create(email: 'Vaibhav_Kohli@external.mckinsey.com', password: 'vaibhav12', name: 'Vaibhav Kohli', emp_id: 123456, card_no: 123456)
	User.first.roles.clear
	User.first.roles << Role.find_by(:name=>'superadmin')
end

# Create ratings
ratings = ["Poor","Below Average","Average","Good","Excellent"]
ratings.each do |rating|
	Rating.create!(:name=>rating) unless Rating.find_by(:name=>rating).present?
end
