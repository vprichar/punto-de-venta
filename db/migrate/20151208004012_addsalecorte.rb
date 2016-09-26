class Addsalecorte < ActiveRecord::Migration
  def change
  	  add_column :sales, :cut, :boolean
  end
end



