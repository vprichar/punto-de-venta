class CreatePurchaseorderItems < ActiveRecord::Migration
  def change
    create_table :purchaseorder_items do |t|
      t.integer :item_id
      t.integer :purchaseorder_id
      t.integer :quantity

      t.timestamps
    end
  end
end
