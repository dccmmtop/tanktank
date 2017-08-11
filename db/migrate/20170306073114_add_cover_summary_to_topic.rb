class AddCoverSummaryToTopic < ActiveRecord::Migration[5.0]
  def change
    add_column :topics, :cover, :string
    add_column :topics, :summary, :string
  end
end
