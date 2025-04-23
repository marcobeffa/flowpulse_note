class AddImageToContent < ActiveRecord::Migration[8.0]
  def change
    add_column :contents, :image, :text
  end
end
