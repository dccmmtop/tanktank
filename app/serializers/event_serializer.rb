class EventSerializer < ActiveModel::Serializer
  attributes :id, :name, :date, :address, :description, :description_html, :contact, :user_id
end
