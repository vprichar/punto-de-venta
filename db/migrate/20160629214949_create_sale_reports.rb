class CreateSaleReports < ActiveRecord::Migration
  def change
    create_table :sale_reports do |t|
          t.string :name 
          t.integer :store_configuration_id
          t.date :initial_date
          t.date :final_date
          t.integer :total_sales_number
          t.decimal :total_cash
          t.timestamps
    end
  end
end
