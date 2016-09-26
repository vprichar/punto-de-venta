class StoreConfiguration < ActiveRecord::Base
	has_many  :sale
	has_many :stock
	has_many :purchaseorder
	has_many :user
	
	  


end
