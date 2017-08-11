json.extract! message, :id, :sender, :receiver, :title, :content, :type, :created_at, :updated_at
json.url message_url(message, format: :json)