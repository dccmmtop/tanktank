class AddCommentToPassage < ActiveRecord::Migration[5.0]
  def change
    add_column :passages, :comment, :text
  end
end
