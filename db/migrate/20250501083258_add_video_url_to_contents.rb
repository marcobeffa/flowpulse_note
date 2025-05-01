class AddVideoUrlToContents < ActiveRecord::Migration[8.0]
  def change
    add_column :contents, :video_url, :text
  end
end
