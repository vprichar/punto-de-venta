class AddsconfigSale < ActiveRecord::Migration
  def change
  	add_column :sales, :store_configuration_id, :integer
  end
end
