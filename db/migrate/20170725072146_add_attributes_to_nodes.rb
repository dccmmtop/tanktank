class AddAttributesToNodes < ActiveRecord::Migration[5.0]
  def change
    add_column :nodes,:access_level,:integer,default: 0,null:false
    add_column :nodes,:tag,:string
    add_column :nodes,:audit,:integer ,default:0,null:false
  end
end
