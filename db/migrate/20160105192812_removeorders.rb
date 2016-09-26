class Removeorders < ActiveRecord::Migration
  def change
  	  	remove_column :purchaseorders, :item_id	  
        remove_column :purchaseorders, :stock_id	
  	  	remove_column :purchaseorders, :committed
  	  	add_column    :purchaseorders , :committed, :boolean


       
  end
end
