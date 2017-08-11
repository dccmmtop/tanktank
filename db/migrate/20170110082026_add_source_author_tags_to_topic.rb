class AddSourceAuthorTagsToTopic < ActiveRecord::Migration[5.0]
  def change
    add_column :topics, :source, :string
    add_column :topics, :author, :string
    add_column :topics, :tags, :string
    
    add_index :topics, :tags
  end
  
  
end
