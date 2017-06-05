class Comment < ActiveRecord::Base
	belongs_to :update
	belongs_to :user
	validates :user_id, :content, :update_id, presence: true
end
