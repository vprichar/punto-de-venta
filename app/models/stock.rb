class Stock < ActiveRecord::Base
	belongs_to :store_configuration
	belongs_to :item
    #validates :item_id, :presence => true
    #validates :store_configuration_id, :presence => true
   # validates :quantity, :presence => true
   # validates :rank, :presence => true




end



