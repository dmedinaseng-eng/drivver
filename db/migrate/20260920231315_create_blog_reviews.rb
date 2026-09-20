class CreateBlogReviews < ActiveRecord::Migration[8.1]
  def change
    create_table :blog_reviews, id: :uuid do |t|
      t.references :blog_post, null: false, foreign_key: true, type: :uuid
      t.references :user, null: false, foreign_key: true, type: :uuid
      t.integer :rating
      t.text :comment

      t.timestamps
    end
  end
end
