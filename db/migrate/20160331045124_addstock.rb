class Addstock < ActiveRecord::Migration
  def change
  	add_column    :store_configurations , :token, :integer
  end
end
