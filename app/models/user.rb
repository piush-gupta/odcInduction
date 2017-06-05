require 'iconv'
class User < ActiveRecord::Base
  acts_as_xlsx :columns => [:email,:name,:emp_id,:phn_no,:card_no,:location,:address,:technology,:experience,:associate]

  has_and_belongs_to_many :roles
  has_many :tasks
  has_many :feedbacks
  has_and_belongs_to_many :mentors, class_name: "User", foreign_key: "mentee_id", join_table: "mentees_mentors", association_foreign_key: "mentor_id"
  has_and_belongs_to_many :mentees, class_name: "User", foreign_key: "mentor_id", join_table: "mentees_mentors", association_foreign_key: "mentee_id"
  
  has_many :updates
  has_many :comments, :dependent => :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :validatable
  
  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>", :show => "200x200>" } #, :default_url => "missing.jpg"

  after_commit :assign_default_role, on: :create

  validates :emp_id, :card_no, :name, presence: true
  validates_length_of :emp_id, :is => 6, :too_short => "Enter valid 6 digit Employee ID", :too_long => "Enter valid 6 digit Employee ID" 
  validates_length_of :card_no, :is => 6, :too_short => "Enter valid 6 digit Card No", :too_long => "Enter valid 6 digit Card No" 
  validates_uniqueness_of :emp_id, :message => "Employee ID already exits"
  validates_uniqueness_of :card_no, :message => "Card No already exits"
  
  def assign_default_role
    Role.create(name: associate) if Role.find_by(name: 'associate').nil?
    self.roles << Role.find_by(name: 'associate') if self.roles.empty?
    #self.save! 
  end

  def has_role?(role_sym)
    roles.any? { |r| r.name.underscore.to_sym == role_sym }
  end  

  def self.import_users(file)
    spreadsheet = Roo::Excelx.new(file.path, nil, :ignore)
    headers = spreadsheet.row(1)
    columns = ["email","password","name","emp_id","phn_no","card_no","location","address","technology","experience","associate"]
    valid = (columns & headers).count == columns.count ? true : false
    if valid
      (2..spreadsheet.last_row).each do |i|
        row = Hash[[headers, spreadsheet.row(i)].transpose]
        attrs = row.to_hash
        user = where(["email = ?","#{attrs['email']}"]).first || new
        user.attributes = attrs
        user.phn_no = user.phn_no.to_i
        user.first_login_token = user.create_token(user.email)
        user.save!
      end
      true
    else
      false
    end
  end
  def self.to_csv(options = {})
    columns = [:email,:name,:emp_id,:phn_no,:card_no,:location,:address,:technology,:experience,:associate]
    CSV.generate(options) do |csv|
      csv << columns
    end
  end
  def self.get_defaulters(week_start,week_end)
    mentees = User.joins(:roles).where("roles.name = 'associate' AND associate = 'F'")
    defaulters = mentees.select { |mentee| mentee.updates.empty? || ((week_start..week_end).to_a & mentee.updates.map{|update| update.created_at.to_date }.uniq).count == 0 }
    regulars = mentees.select { |mentee| mentee.updates.any? && ((week_start..week_end).to_a & mentee.updates.map{|update| update.created_at.to_date }.uniq).count > 0 }
    return {'defaulters'=>defaulters,'regulars'=>regulars}
  end

  def create_token(user_email)
    begin
      raw_data = user_email + Time.now.to_s + SecureRandom.hex.to_s
      token = Digest::MD5.hexdigest(raw_data)
    end while User.find_by(:first_login_token => token) != nil
    token
  end
end
