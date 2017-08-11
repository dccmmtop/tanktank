class Event < ApplicationRecord
  include ActionView::Helpers::SanitizeHelper
  include ApplicationHelper
  
  before_save :markdown_description
  belongs_to :user
  
  validates :name, :address, :date, :contact, presence: true
  private
    def markdown_description
      if self.description_changed?
        self.description_html = sanitize_markdown(Homeland::Markdown.call(description))
      end
    end
end
