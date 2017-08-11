class AddSourceDateToTopic < ActiveRecord::Migration[5.0]
  def change
    add_column :topics, :source_date, :string
  end
end
