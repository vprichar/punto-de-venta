class AddItemPurchaseOrder < ActiveRecord::Migration
  def change
  	add_column :items , :purchaseorder_id, :integer
  end
end
