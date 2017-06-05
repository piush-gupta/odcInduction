# Create roles
Role.create(name: 'associate') unless Role.find_by(:name => 'associate').present?
Role.create(name: 'admin') unless Role.find_by(:name => 'admin').present?
Role.create(name: 'superadmin') unless Role.find_by(:name => 'superadmin').present?

# Create a superadmin user
unless User.find_by(:email=>'kumar.piush@tcs.com').present?
	a = User.create(email: 'kumar.piush@tcs.com', password: 'test1234', name: 'Piush Kumar', emp_id: 123456, card_no: 123456)
	a.roles.clear
	a.roles << Role.find_by(:name=>'superadmin')
end

# Create ratings
ratings = ["Poor","Below Average","Average","Good","Excellent"]
ratings.each do |rating|
	Rating.create!(:name=>rating) unless Rating.find_by(:name=>rating).present?
end
