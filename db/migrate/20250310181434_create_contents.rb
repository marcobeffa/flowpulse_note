class CreateContents < ActiveRecord::Migration[8.0]
  def change
    create_table :contents do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title
      t.string :description
      t.text :body
      t.datetime :publication_date
      t.integer :visibility
      t.boolean :published
      t.integer :stato

      t.timestamps
    end
  end
end
