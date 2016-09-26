class Purchaseorder < ActiveRecord::Base
	 has_many :items
	 belongs_to :user
	 belongs_to :store_configuration

	 has_many  :purchaseorder_item



end
