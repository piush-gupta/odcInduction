class CreateMenteesMentorsJoinTable < ActiveRecord::Migration
  def change
  	create_join_table :mentees, :mentors do |t|
      # t.index [:role_id, :user_id]
       t.index [:mentor_id, :mentee_id]
    end
  end
end
