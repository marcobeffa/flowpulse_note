json.extract! content, :id, :user_id, :title, :image, :description, :body, :publication_date, :visibility, :published, :stato, :created_at, :updated_at
json.url content_url(content, format: :json)
