class CreateFeedbacks < ActiveRecord::Migration
  def change
    create_table :feedbacks do |t|
      t.text :remark
      t.string :token
      t.date :month
      t.references :user, index: true
      t.references :rating, index: true

      t.timestamps
    end
  end
end
