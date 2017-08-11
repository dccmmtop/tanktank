class UpdateRecommendationToTopics < ActiveRecord::Migration[5.0]
  def change
    remove_column :topics, :recommendation
    add_column :topics, :recommendation, :boolean, default: false
    add_index :topics, :recommendation
  end
end
