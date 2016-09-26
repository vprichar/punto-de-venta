class Item < ActiveRecord::Base
	attr_reader :item_name
	has_many   :line_items
	belongs_to :item_category
     has_many  :stocks
    belongs_to :purchaseorder
     has_many :purchaseorder_item

	validates :sku, :presence => true, :uniqueness => true
	validates :name, :presence => true
	validates :price, :presence => true
	validates :stock_amount, :presence => true

	default_scope :order => 'sku ASC'
    
    def nulo 
      nu =  Item.find_by(item_category: nil)
      nu.each do |item|
        item.item_category = 1 
        item.save

      end

    end 
    #ryg
     # metodos autocomplete


	  def item_name
	   tem = ItemCategory.find_by(id: item_category_id)
	   if tem == nil 
	   	tem =  "General"
	   else 
	   	tem.name 
	   end 

	     # self.item_category_id
	  end

	  def  nombrecom
	  	nombre  = self.name[0,10]
	  	descripción = self.description

	  	nombre.to_s+" "+description.to_s+""

	  end

	  def  nombre_completo
	  	self.name.to_s+" "+self.description.to_s+""
	  end






	  


end
