class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.string :title
      t.string :slug
      t.text :body
      t.references :user, foreign_key: true, null: false
      t.references :account, foreign_key: true, null: false
      t.integer :question_id

      t.timestamps
    end
  end
end
