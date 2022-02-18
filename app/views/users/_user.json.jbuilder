json.extract! user, :id, :login, :password_digest, :total_score, :created_at, :updated_at
json.url user_url(user, format: :json)
