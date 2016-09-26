class ItemStock < ActiveRecord::Migration
  def change
  	 create_table :stocks do |t|
      t.integer :quantity
      t.integer :rank
      t.integer :store_configuration_id
      t.integer :item_id
      t.integer :token

      t.timestamps
    end
  end
end
