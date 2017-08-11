class AddUnivDegrTitleMajorIsstuToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :university, :string
    add_column :users, :degree, :string
    add_column :users, :title, :string
    add_column :users, :is_student, :boolean
    add_column :users, :major, :string
  end
end
