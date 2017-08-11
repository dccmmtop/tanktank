class AddRecommendationToTopics < ActiveRecord::Migration[5.0]
  def change
    add_column :topics, :recommendation, :integer, default: 0
  end
end
