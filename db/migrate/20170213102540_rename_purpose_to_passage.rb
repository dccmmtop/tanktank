class RenamePurposeToPassage < ActiveRecord::Migration[5.0]
  def change
    rename_column :passages, :purpose, :title
  end
end
