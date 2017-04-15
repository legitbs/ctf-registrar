json.extract! upload, :id, :user_id, :challenge_id, :file, :created_at, :updated_at
json.url upload_url(upload, format: :json)
