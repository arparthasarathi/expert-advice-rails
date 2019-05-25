class AddEditedAtToPost < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :edited_at, :datetime, default: -> { 'CURRENT_TIMESTAMP' }
  end
end
