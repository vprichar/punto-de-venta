class PurchaseorderItem < ActiveRecord::Base
	 belongs_to :purchaseorder
	 belongs_to :item

	 
end
