class UpdateSlugUniqueness < ActiveRecord::Migration[8.0]
  def change
    remove_index :contents, :slug if index_exists?(:contents, :slug)
    add_index :contents, [ :slug, :user_id ], unique: true
  end
end
