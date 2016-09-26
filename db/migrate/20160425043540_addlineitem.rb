class Addlineitem < ActiveRecord::Migration
  def change
  	add_column :line_items, :discount, :decimal  ,precision: 8, scale: 2
  end
end
