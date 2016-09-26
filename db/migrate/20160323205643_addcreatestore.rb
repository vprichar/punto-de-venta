class Addcreatestore < ActiveRecord::Migration
  def change
  	add_column    :store_configurations , :name, :string
  end
end
