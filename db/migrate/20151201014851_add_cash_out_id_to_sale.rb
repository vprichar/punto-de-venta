class AddCashOutIdToSale < ActiveRecord::Migration
  def change
    add_column :sales, :cash_out_id, :integer
  end
end
