class CreatePurchaseorders < ActiveRecord::Migration
  def change
    create_table :purchaseorders do |t|
      t.string :item_id
      t.string :store_configuration_id
      t.string :user_id
      t.string :committed
      t.string :stock_id

      t.timestamps
    end
  end
end
