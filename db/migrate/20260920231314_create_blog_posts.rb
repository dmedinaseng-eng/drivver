class CreateBlogPosts < ActiveRecord::Migration[8.1]
  def change
    create_table :blog_posts, id: :uuid do |t|
      t.references :organization, null: false, foreign_key: true, type: :uuid
      t.references :author, null: false, foreign_key: { to_table: :users }, type: :uuid
      t.string :title
      t.string :slug
      t.text :content
      t.string :meta_title
      t.text :meta_description
      t.jsonb :schema_json
      t.string :status

      t.timestamps
    end
    add_index :blog_posts, :slug, unique: true
    add_index :blog_posts, :status
  end
end
