require 'digest/md5'
class Feedback < ActiveRecord::Base
  belongs_to :user
  belongs_to :rating

  # Validations
  # To make sure only one feedback exists per user per month
  validates :user_id, uniqueness: { scope: :month }

  def self.create_with_token(mentee,previous_month)
  	raw_data = mentee.name.to_s + previous_month.to_s + SecureRandom.hex.to_s
  	token = Digest::MD5.hexdigest(raw_data)
  	parameters = { month: previous_month, user_id: mentee.id, token: token }
  	create!(parameters)
  	token
  end
end
