class CreateEmployee < ActiveRecord::Migration
	def change
		create_table :employees do |t|
			t.string :name
			t.string :rfc
			t.string :address
			t.integer :phone
			t.string :email
			t.boolean :published
			 t.timestamps
		end
	end
end
