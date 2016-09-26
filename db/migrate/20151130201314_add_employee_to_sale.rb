class AddEmployeeToSale < ActiveRecord::Migration
  def change
    add_column :sales, :user_id, :integer
    add_column :sales, :employee_id, :integer
  end
end
