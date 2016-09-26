class CreateCashOut < ActiveRecord::Migration
  def change
    create_table :cash_outs do |t|
    	t.integer :user_id
    	t.decimal :total_price
    	t.integer :total_sales
		t.timestamps
    end
  end
end
