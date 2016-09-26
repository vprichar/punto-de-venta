class AddStockSale < ActiveRecord::Migration
  def change
  	add_column :sales, :stock_id, :integer
  end
end
