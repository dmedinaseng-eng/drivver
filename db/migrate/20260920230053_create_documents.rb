class CreateDocuments < ActiveRecord::Migration[8.1]
  def change
    create_table :documents, id: :uuid do |t|
      t.references :organization, null: false, foreign_key: true, type: :uuid
      t.string :title
      t.text :file_url
      t.boolean :is_public
      t.boolean :read_only_image

      t.timestamps
    end
    add_index :documents, :title
  end
end
